package imop.lib.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;

import imop.MUWOmpConverter;
import imop.ast.node.external.ArrayInitializer;
import imop.ast.node.external.CompoundStatement;
import imop.ast.node.external.Declaration;
import imop.ast.node.external.ForConstruct;
import imop.ast.node.external.Node;
import imop.ast.node.external.Statement;
import imop.ast.node.external.TranslationUnit;
import imop.lib.analysis.flowanalysis.Cell;
import imop.lib.analysis.flowanalysis.Symbol;
import imop.lib.analysis.typeSystem.ArrayType;
import imop.lib.analysis.typeSystem.Type;
import imop.lib.builder.Builder;
import imop.lib.transform.updater.InsertImmediatePredecessor;
import imop.parser.FrontEnd;
import imop.parser.Program;

public class OmpForOutliner {
	public static HashMap<ForConstruct,String> structEnvTagMap = new HashMap<ForConstruct,String>();
	public static HashMap<ForConstruct,String> structEnvVarMap = new HashMap<ForConstruct,String>();
	public static String outliner(ForConstruct forConstruct) {
		String loopVariable = forConstruct.getInfo().getCFGInfo().getInitExpression().getF0().getTokenImage();
		CompoundStatement forConstructBody = (CompoundStatement)forConstruct.getInfo().getCFGInfo().getBody();

		//Step 1: Get All Cells Accessible in the Body
		CellSet accessibleCells = forConstructBody.getInfo().getAllCellsAtNode();
		System.out.println("Accessible Cells : "+accessibleCells);
		//Step 2: Get All Cells Accessed in the Body
		CellSet accessedCells = forConstructBody.getInfo().getAccesses();
		System.out.println("Accessible Cells : "+accessedCells);
		//Step 3: Take Intersection
		CellSet intersection = Misc.setIntersection(accessibleCells, accessedCells);
		System.out.println("Intersection Cells : "+intersection);
		//Step 4: Declare Structure for the Environment of For Construct
		String structTagName = Builder.getNewTempName("for");
		String structVarName = Builder.getNewTempName("for_v");
		ArrayList<String> namesDeclaration = new ArrayList<String>();
		ArrayList<String> initializers = new ArrayList<String>();
		HashMap<String,String> renameMapper = new HashMap<String,String>();
		String structEnvSignatureString = "struct "+structTagName;
		String structObjectDeclarationString = "struct "+structTagName+" *"+structVarName;
		//Step 5: Go through each cell in intersection
		for(Cell intersectedCell: intersection) {
			if(intersectedCell instanceof Symbol) {
				Symbol symb = (Symbol)intersectedCell;
				//Step 5a: Globals (Ignored)
				if(symb.getDefiningScope() instanceof TranslationUnit) {
					continue;
				}
				if(symb.getName().equals(loopVariable)) {
					continue;
				}
				if(symb.getType() instanceof ArrayType) {
					//Step 5b: Get the Declaring Node
					Declaration decl = (Declaration)symb.getDeclaringNode();
					//Step 5d: If the declared symbol contains an initializer --> Populate the initializer block
					if(decl.getInfo().hasInitializer()) {
						String declaration = symb.getType().getExactDeclarationWithoutInit(symb.getName())
								.toString();
						//Step 5c: Put it in the structure definition
						namesDeclaration.add(declaration);
						ArrayType dAType = (ArrayType) symb.getType();
						ArrayInitializer arrayInit = (ArrayInitializer) (decl.getInfo().getInitializer())
								.getF0().getChoice();
						Queue<String> data = new LinkedList<String>();
						MUWOmpConverter.processInitializer(arrayInit, data);
						int dim = 0;
						Type type = dAType;
						ArrayList<Integer> dimSize = new ArrayList<Integer>();
						int nElements = 1;
						ArrayList<Integer> idx = new ArrayList<Integer>();
						while (true) {
							if (!(type instanceof ArrayType)) {
								break;
							}
							dim++;
							ArrayType aType = (ArrayType) type;
							int dSize = Integer.parseInt(aType.getArraySize().toString());
							dimSize.add(dSize);
							type = ((ArrayType) type).getElementType();
							nElements *= dSize;
							idx.add(0);
						}
						String initializer = "";
						for (int itr1 = 0; itr1 < nElements; itr1++) {
							String index = MUWOmpConverter.generateIndex(dimSize, idx);
							String definer = "(" + structVarName + "->" + symb.getName() + ")" + index
									+ "=" + data.poll();
							initializer = initializer + definer + ";\n";
						}
						initializers.add(initializer);
					}else {
						String declaration = symb.getType().getExactDeclarationWithoutInit(symb.getName()).toString();
						namesDeclaration.add(declaration+"\n");
					}
				}else {
					//Step 5b: Get the Declaring Node
					Declaration decl = symb.getType().getDeclaration(symb.getName());
					//Step 5c: Put it in the structure definition
					namesDeclaration.add(decl.toString() + "\n");
					//Step 5d: If the declared symbol contains an initializer --> Populate the initializer block
					if(decl.getInfo().hasInitializer()) {
						String initializer = structVarName + "->" + symb.getName() + "=" + symb.getName()+ ";";
						initializers.add(initializer);
					}
				}
				renameMapper.put(symb.getName(), "(" + structVarName + "->" + symb.getName() + ")");
			}else {
				continue;
			}
		}
		Node renamedForBody = MUWOmpConverter.myObtainRenamedNode(forConstructBody,renameMapper);
//		System.out.println("-----");
//		System.out.println(renamedForBody);
//		System.out.println("-----");
//		System.out.println(forConstruct);
//		System.out.println("-----");
//		System.out.println(Program.getRoot());
		Declaration structObjDeclaration = null;
		if(!namesDeclaration.isEmpty()) {
			structEnvTagMap.put(forConstruct, structTagName);
			structEnvVarMap.put(forConstruct, structVarName);
			structEnvSignatureString = structEnvSignatureString + "{\n" + String.join("\n",namesDeclaration)+"};\n";
			Declaration structEnvDeclaration = FrontEnd.parseAndNormalize(structEnvSignatureString,Declaration.class);
			Builder.addDeclarationToGlobals(MUWOmpConverter.structCounter,structEnvDeclaration);
			MUWOmpConverter.structCounter++;
			structObjDeclaration = FrontEnd.parseAndNormalize(structObjectDeclarationString+";",Declaration.class);
			System.out.println(structEnvDeclaration);
			System.out.println(structObjDeclaration);
		}
		String ObjDeclaration = null;
		if(structObjDeclaration!=null) {
			ObjDeclaration = "{\n";
			String voidPtrTempName = Builder.getNewTempName("env_p");
			InsertImmediatePredecessor.insert(forConstruct,structObjDeclaration);
			String voidPtrCreate = "void *" + voidPtrTempName + ";";
			InsertImmediatePredecessor.insert(forConstruct,FrontEnd.parseAndNormalize(voidPtrCreate,Declaration.class));
			String sizeOfMalloc = "int tempSize = sizeof(struct " + structTagName + ");";
			InsertImmediatePredecessor.insert(forConstruct,FrontEnd.parseAndNormalize(sizeOfMalloc,Declaration.class));
			String structAllocation = voidPtrTempName + "=" + "malloc(tempSize);";
			System.out.println("Struct Allocation : "+structAllocation);
			InsertImmediatePredecessor.insert(forConstruct,FrontEnd.parseAndNormalize(structAllocation,Statement.class));
			String assignAllocStmt = structVarName + "=" + "(struct " + structTagName + " *)"
					+ voidPtrTempName + ";";
			InsertImmediatePredecessor.insert(forConstruct,FrontEnd.parseAndNormalize(assignAllocStmt,Statement.class));
			ObjDeclaration += structObjDeclaration.toString() + "\n" + voidPtrCreate + "\n"
					+ sizeOfMalloc + "\n" + structAllocation + "\n" + assignAllocStmt + "\n";
			ObjDeclaration += String.join("\n", initializers)+"}";
		}
		
		return renamedForBody + ObjDeclaration;
	}
}
