package imop;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Set;
import java.util.stream.Collectors;

import imop.ast.info.DataSharingAttribute;
import imop.ast.node.external.ArrayInitializer;
import imop.ast.node.external.AssignmentExpression;
import imop.ast.node.external.BreakStatement;
import imop.ast.node.external.CompoundStatement;
import imop.ast.node.external.ContinueStatement;
import imop.ast.node.external.Declaration;
import imop.ast.node.external.ElementsOfTranslation;
import imop.ast.node.external.Expression;
import imop.ast.node.external.ExternalDeclaration;
import imop.ast.node.external.ForConstruct;
import imop.ast.node.external.ForDirective;
import imop.ast.node.external.ForStatement;
import imop.ast.node.external.FunctionDefinition;
import imop.ast.node.external.IfStatement;
import imop.ast.node.external.Initializer;
import imop.ast.node.external.InitializerList;
import imop.ast.node.external.Node;
import imop.ast.node.external.NodeChoice;
import imop.ast.node.external.NodeListOptional;
import imop.ast.node.external.NodeSequence;
import imop.ast.node.external.OmpForCondition;
import imop.ast.node.external.OmpForGECondition;
import imop.ast.node.external.OmpForGTCondition;
import imop.ast.node.external.OmpForHeader;
import imop.ast.node.external.OmpForInitExpression;
import imop.ast.node.external.OmpForLECondition;
import imop.ast.node.external.OmpForLTCondition;
import imop.ast.node.external.OmpForReinitExpression;
import imop.ast.node.external.ParallelConstruct;
import imop.ast.node.external.ParameterDeclaration;
import imop.ast.node.external.SingleConstruct;
import imop.ast.node.external.Statement;
import imop.ast.node.external.TranslationUnit;
import imop.ast.node.external.UniqueForOrDataOrNowaitClauseList;
import imop.ast.node.internal.CallStatement;
import imop.ast.node.internal.DummyFlushDirective;
import imop.ast.node.internal.SimplePrimaryExpression;
import imop.lib.analysis.flowanalysis.Cell;
import imop.lib.analysis.flowanalysis.Symbol;
import imop.lib.analysis.typeSystem.ArrayType;
import imop.lib.analysis.typeSystem.Type;
import imop.lib.builder.Builder;
import imop.lib.cfg.CFGLinkFinder;
import imop.lib.cfg.info.ForStatementCFGInfo;
import imop.lib.cfg.link.node.CFGLink;
import imop.lib.cfg.link.node.CompoundElementLink;
import imop.lib.cfg.link.node.IfThenBodyLink;
import imop.lib.transform.BasicTransform;
import imop.lib.transform.simplify.Normalization;
import imop.lib.transform.updater.InsertImmediatePredecessor;
import imop.lib.transform.updater.InsertImmediateSuccessor;
import imop.lib.transform.updater.NodeRemover;
import imop.lib.transform.updater.NodeReplacer;
import imop.lib.util.CellSet;
import imop.lib.util.Misc;
import imop.lib.util.OmpForOutliner;
import imop.parser.FrontEnd;
import imop.parser.Program;

public class MUWOmpConverter {
	public static HashMap<ForConstruct, String> forConstructMapper = new HashMap<>();
	static HashMap<String,Integer> reductionVariablePosition = new HashMap<>(); 
	static HashMap<String,Symbol> reductionVariables = new HashMap<>();
	static HashMap<String,String> reductionVariableNameMapper = new HashMap<>();
	static HashMap<String,String> reductionVariableTypeMapper = new HashMap<>();
	static HashMap<String,String> reductionFunctionInitialValueMapper = new HashMap<>();
	static HashMap<String,String> reductionVariableReducedMapper = new HashMap<>();
	static HashMap<String,String> reductionFunctionMapper = new HashMap<>();
	static HashMap<ParallelConstruct, ArrayList<String>> initializersMapper = new HashMap<>();
	static Map<ParallelConstruct, String> privateEnvClsrDeclMap = new HashMap<>();
	static Declaration privateClsrDeclarationNode = null;
	static String privateEnvClosureName = Builder.getNewTempName("envp_c");
	public static int structCounter = 0;
	static String nIterationsVarName = null;
	Set<FunctionDefinition> reductionFunctions = new HashSet<>();	
	Map<ForConstruct, String> forConstructTagMap = new HashMap<>();
	Map<ForConstruct, String> forConstructVarMap = new HashMap<>();
	Map<ParallelConstruct, String> sharedVarMap = new HashMap<>();
	Map<ParallelConstruct, String> sharedTagMap = new HashMap<>();
	Map<ParallelConstruct, String> privateVarMap = new HashMap<>();
	Map<ParallelConstruct, String> privateTagMap = new HashMap<>();
	Map<ParallelConstruct, Boolean> hasShared = new HashMap<>();
	Map<ParallelConstruct, Boolean> hasPrivate = new HashMap<>();
	HashMap<Node, String> initializerMap = new HashMap<>();
	HashMap<Node, String> declaratorMap = new HashMap<>();
	Map<ParallelConstruct, HashMap<String, String>> renameMapper = new HashMap<>();

	Statement serialForLoopToRecursion(ParallelConstruct parCons, ForStatement forStmt, boolean hasInit, String structTagName, String structVarName) {
		String functionDefinition = "";
		HashMap<String,Node> forStatementInfo = nodeExtractionHandler(forStmt, "s_for", false);
		Node nodeRenamed = forStatementInfo.get("node");
		ForStatement forStatementRenamed = FrontEnd.parseAndNormalize(nodeRenamed.toString(),ForStatement.class);
		Declaration declaration = null;
		if(forStatementInfo.containsKey("name"))
			declaration = (Declaration)forStatementInfo.get("name");
		String fName = Builder.getNewTempName("f");
		ForStatementCFGInfo forStmtCFGInfo = forStatementRenamed.getInfo().getCFGInfo();
		String stepExpr = forStmtCFGInfo.getStepExpression().toString();
		String termExpr = forStmtCFGInfo.getTerminationExpression().toString();
		String bodyRecursion = "\n{\n";
		if (hasInit) {
			String initExpr = forStmtCFGInfo.getInitExpression().toString();
			bodyRecursion = bodyRecursion + "if(bitSet){\n" + initExpr + ";\nbitSet = 0;\n}\n";
		}
		bodyRecursion = bodyRecursion + "if (" + termExpr + ")\n";
		String functionSignature = "void " + fName + "(int bitSet";
		String callStatement = fName + "(";
		String recursiveCallStatement = fName + "(0";
		if (hasInit) {
			callStatement = callStatement + "1";
		} else {
			callStatement = callStatement + "0";
		}
		if(declaration!=null) {
			callStatement = callStatement + ", "+declaration.getInfo().getDeclaredName()+");";
			recursiveCallStatement = recursiveCallStatement + ", "+declaration.getInfo().getDeclaredName()+");";
			functionSignature = functionSignature + ", "+declaration.getF0().toString() + " "+ declaration.getF1().toString()+")";
		}else {
			callStatement = callStatement + ");";
			recursiveCallStatement = recursiveCallStatement + ");";
			functionSignature = functionSignature + ")";
		}
		Statement returnStmt = FrontEnd.parseAndNormalize("return;", Statement.class);
		Statement recCallStmt = FrontEnd.parseAndNormalize("{\n" + stepExpr + ";\n" + recursiveCallStatement + "\n}\n",
				Statement.class);
		for (BreakStatement breakStmt : Misc.getInheritedEnclosee(forStmtCFGInfo.getBody(), BreakStatement.class)) {
			NodeReplacer.replaceNodes(breakStmt, returnStmt);
		}
		for (ContinueStatement continueStmt : Misc.getInheritedEnclosee(forStmtCFGInfo.getBody(),
				ContinueStatement.class)) {
			NodeReplacer.replaceNodes(continueStmt, recCallStmt);
		}
		bodyRecursion = bodyRecursion + forStmtCFGInfo.getBody().toString() + "\n" + "else{\nreturn;\n}\n" + stepExpr
				+ ";\n";
		bodyRecursion = bodyRecursion + recursiveCallStatement + "\n}\n";
		functionDefinition = functionSignature + bodyRecursion;
		Declaration functionSignatureDecl = FrontEnd.parseAndNormalize(functionSignature + ";", Declaration.class);
		FunctionDefinition functionDef = FrontEnd.parseAndNormalize(functionDefinition, FunctionDefinition.class);
		Statement callStmt = FrontEnd.parseAndNormalize(callStatement, Statement.class);
		Builder.addDeclarationToGlobals(structCounter++, functionSignatureDecl);
		Builder.addFunctionToGlobal(functionDef);
		return callStmt;
	}

	void Step1() {
		for (ParallelConstruct parallelConstruct : Misc.getInheritedEnclosee(Program.getRoot(),
				ParallelConstruct.class)) {
			for (ForConstruct forConstruct : Misc.getInheritedPostOrderEnclosee(parallelConstruct,
					ForConstruct.class)) {
				String tagName = forConstructTagMap.get(forConstruct);
				String varName = forConstructVarMap.get(forConstruct);
				for (ForStatement forStatement : Misc.getInheritedPostOrderEnclosee(forConstruct, ForStatement.class)) {
					Boolean hasInit = false;
					if (forStatement.getInfo().getCFGInfo().hasInitExpression()) {
						hasInit = true;
					}
					Statement callStatement = serialForLoopToRecursion(parallelConstruct, forStatement, hasInit, tagName, varName);
					NodeReplacer.replaceNodes(forStatement, callStatement);
				}
			}
		}
	}

	HashMap<String,Node> nodeExtractionHandler(Node node, String prefix, boolean forConstructHandle) {
		HashMap<String,Node> info = new HashMap<>();
		CompoundStatement nodeBody = (CompoundStatement) node.getInfo().getCFGInfo().getBody();
		// Step 1: Get All Cells Accessible in the Body
		CellSet accessibleCells = nodeBody.getInfo().getAllCellsAtNode();
		// Step 2: Get All Cells Accessed in the Body
		CellSet accessedCells = nodeBody.getInfo().getAccesses();
		// Step 3: Take Intersection
		CellSet intersection = Misc.setIntersection(accessibleCells, accessedCells);
		String structTagName = Builder.getNewTempName(prefix);
		String structVarName = Builder.getNewTempName(prefix + "_v");
		ArrayList<String> namesDeclaration = new ArrayList<String>();
		ArrayList<String> initializers = new ArrayList<String>();
		ArrayList<String> restorers = new ArrayList<String>();
		HashMap<String, String> renameMapper = new HashMap<String, String>();
		// Step 5: Go through each cell in intersection
		for (Cell intersectedCell : intersection) {
			if (intersectedCell instanceof Symbol) {
				Symbol symb = (Symbol) intersectedCell;
				// Step 5a: Globals (Ignored)
				if (symb.getDefiningScope() instanceof TranslationUnit) {
					continue;
				}
				if (symb.getType() instanceof ArrayType) {
					Declaration decl = (Declaration) symb.getDeclaringNode();
					String declaration = symb.getType().getExactDeclarationWithoutInit(symb.getName()).toString();
					namesDeclaration.add(declaration);
					ArrayType dAType = (ArrayType) symb.getType();
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
					String restore = "";
					if (decl.getInfo().hasInitializer()) {
						ArrayInitializer arrayInit = (ArrayInitializer) (decl.getInfo().getInitializer()).getF0()
								.getChoice();
						Queue<String> data = new LinkedList<String>();
						processInitializer(arrayInit, data);
						for (int itr1 = 0; itr1 < nElements; itr1++) {
							String index = generateIndex(dimSize, idx);
							String definer = "(" + structVarName + "->" + symb.getName() + ")" + index + "="
									+ data.poll();
							initializer = initializer + definer + ";\n";
						}
						String index = "";
						for (int itr1 = 0; itr1 < dim; itr1++) {
							String iteratorVariable = Builder.getNewTempName("itr");
							String iteratorVariableDecl = "int " + iteratorVariable + ";";
							String iteratorSize = dimSize.get(itr1).toString();
							String forHeader = "for(" + iteratorVariable + "=0;" + iteratorVariable + "<"
									+ iteratorSize + ";" + iteratorVariable + "++){\n";
							index = index + "[" + iteratorVariable + "]";
							restore = restore + iteratorVariableDecl + "\n";
							restore = restore + forHeader + "\n";
						}
						restore = restore + symb.getName() + index + " = " + "(" + structVarName + "->"
								+ symb.getName() + ")" + index + ";\n";
						for (int itr1 = 0; itr1 < dim; itr1++) {
							restore = restore + "}\n";
						}
					} else {
						String index = "";
						for (int itr1 = 0; itr1 < dim; itr1++) {
							String iteratorVariable = Builder.getNewTempName("itr");
							String iteratorVariableDecl = "int " + iteratorVariable + ";";
							String iteratorSize = dimSize.get(itr1).toString();
							String forHeader = "for(" + iteratorVariable + "=0;" + iteratorVariable + "<"
									+ iteratorSize + ";" + iteratorVariable + "++){\n";
							index = index + "[" + iteratorVariable + "]";
							initializer = initializer + iteratorVariableDecl + "\n";
							initializer = initializer + forHeader + "\n";
							restore = restore + iteratorVariableDecl + "\n";
							restore = restore + forHeader + "\n";
						}
						initializer = initializer + "(" + structVarName + "->" + symb.getName() + ")" + index + "="
								+ symb.getName() + index + ";\n";
						restore = restore + symb.getName() + index + " = " + "(" + structVarName + "->"
								+ symb.getName() + ")" + index + ";\n";
						for (int itr1 = 0; itr1 < dim; itr1++) {
							initializer = initializer + "}\n";
							restore = restore + "}\n";
						}
					}
					initializers.add(initializer);
					restorers.add(restore);
				} else {
					Declaration declShared = symb.getType().getExactDeclarationWithoutInit(symb.getName());
					namesDeclaration.add(declShared.toString() + "\n");
					String initializer = structVarName + "->" + symb.getName() + "=" + symb.getName() + ";";
					String restore = symb.getName() + "=" + structVarName + "->" + symb.getName() + ";";
					initializers.add(initializer);
					restorers.add(restore);
				}
				renameMapper.put(symb.getName(), "(" + structVarName + "->" + symb.getName() + ")");
			} else {
				continue;
			}
		}
		Node renamedNode = null;
		if(forConstructHandle) {
			ForConstruct forConstruct = (ForConstruct)node;
			OmpForHeader ompForHeader = forConstruct.getF2();
			OmpForInitExpression ompForInitExpression = ompForHeader.getF2();
			OmpForReinitExpression ompForReinitExpression = ompForHeader.getF6();
			OmpForCondition ompForCondition = ompForHeader.getF4();
			ForDirective forDirective = forConstruct.getF1();
			UniqueForOrDataOrNowaitClauseList uniqueFor = forDirective.getF1();
			Set<Cell> vars = new HashSet<>();
			vars.addAll(ompForInitExpression.getInfo().getSymbolAccesses());
			vars.addAll(ompForReinitExpression.getInfo().getSymbolAccesses());
			vars.addAll(ompForCondition.getInfo().getSymbolAccesses());
			vars.addAll(uniqueFor.getInfo().getSymbolAccesses());
			Map<String,String> tempMap = new HashMap<>();
			for(Cell cell : vars) {
				String name = ((Symbol)cell).getName();
				if(renameMapper.containsKey(name)) {
					tempMap.put(name, renameMapper.get(name));
					renameMapper.remove(name);
				}
			}
			renamedNode = myObtainRenamedNode(node,renameMapper);
			for(String cell : tempMap.keySet()) {
				renameMapper.put(cell, tempMap.get(cell));
			}
		}else {
			renamedNode = myObtainRenamedNode(node, renameMapper);
		}
		if(!namesDeclaration.isEmpty()) {
			String structEnvSignatureString = "struct " + structTagName;
			structEnvSignatureString = structEnvSignatureString + "{\n" + String.join("\n",namesDeclaration)+"};\n";
			String structObjectDeclarationString = "struct " + structTagName + " *" + structVarName+";";
			Declaration structObjectDeclarationNode = FrontEnd.parseAndNormalize(structObjectDeclarationString,Declaration.class);
			info.put("name", structObjectDeclarationNode);
			InsertImmediatePredecessor.insert(node,structObjectDeclarationNode);
			Declaration structEnvDeclaration = FrontEnd.parseAndNormalize(structEnvSignatureString,Declaration.class);
			Builder.addDeclarationToGlobals(structCounter,structEnvDeclaration);
			structCounter++;
			String voidPtrTempName = Builder.getNewTempName("env_"+prefix);
			String voidPtrCreate = "void *" + voidPtrTempName + ";";
			InsertImmediatePredecessor.insert(node,FrontEnd.parseAndNormalize(voidPtrCreate,Declaration.class));
			String tempSize = Builder.getNewTempName("tempSize");
			String sizeOfMalloc = "int "+tempSize+" = sizeof(struct " + structTagName + ");";
			InsertImmediatePredecessor.insert(node,FrontEnd.parseAndNormalize(sizeOfMalloc,Declaration.class));
			String structAllocation = voidPtrTempName + "=" + "malloc("+tempSize+");";
			InsertImmediatePredecessor.insert(node,FrontEnd.parseAndNormalize(structAllocation,Statement.class));
			String assignAllocStmt = structVarName + "=" + "(struct " + structTagName + " *)"+ voidPtrTempName + ";";
			InsertImmediatePredecessor.insert(node,FrontEnd.parseAndNormalize(assignAllocStmt,Statement.class));
			if(!initializers.isEmpty()) {
				InsertImmediatePredecessor.insert(node,FrontEnd.parseAndNormalize("{\n"+String.join("\n", initializers)+"}\n",Statement.class));
			}
			if(!restorers.isEmpty()) {
				InsertImmediateSuccessor.insert(node, FrontEnd.parseAndNormalize("{\n"+String.join("\n", restorers)+"}\n",Statement.class));
			}
			if(node instanceof ForConstruct) {
				forConstructTagMap.put((ForConstruct)node, structTagName);
				forConstructVarMap.put((ForConstruct)node, structVarName);
			}
		}
		info.put("node", renamedNode);
		return info;
	}

	void Step2() {
		for (ForConstruct forConstruct : Misc.getInheritedPostOrderEnclosee(Program.getRoot(), ForConstruct.class)) {
			String loopVariable = forConstruct.getInfo().getCFGInfo().getInitExpression().getF0().getTokenImage();
			ParallelConstruct enclosingParConstruct = getEnclosingNodeFromCalledPaths(forConstruct,
					ParallelConstruct.class);
			if (enclosingParConstruct == null) {
				continue;
			}
			String functionBody = "";
			String structSharedTagName = sharedTagMap.get(enclosingParConstruct);
			String structSharedVarName = sharedVarMap.get(enclosingParConstruct);
			String structPrivateTagName = privateTagMap.get(enclosingParConstruct);
			String structPrivateVarName = privateVarMap.get(enclosingParConstruct);
			Boolean sharedIsEmpty = hasShared.get(enclosingParConstruct);
			Boolean privateIsEmpty = hasPrivate.get(enclosingParConstruct);
			String functionName = Builder.getNewTempName("f");
			String callStatement = functionName + "(" + loopVariable;
			String functionSignature = "void " + functionName + " (int " + loopVariable;
			if (!sharedIsEmpty && privateIsEmpty) {
				functionSignature = functionSignature + ",struct " + structSharedTagName + " *" + structSharedVarName;
				callStatement += "," + structSharedVarName;
			}
			if (sharedIsEmpty && !privateIsEmpty) {
				functionSignature = functionSignature + ",struct " + structPrivateTagName + " *" + structPrivateVarName;
				callStatement += "," + structPrivateVarName;
			}
			if (!sharedIsEmpty && !privateIsEmpty) {
				functionSignature = functionSignature + ",struct " + structSharedTagName + " *" + structSharedVarName
						+ ",struct " + structPrivateTagName + " *" + structPrivateVarName;
				callStatement += "," + structSharedVarName + "," + structPrivateVarName;
			}
			String objDeclaration = OmpForOutliner.outliner(forConstruct);
			String forBody = "";
			if (objDeclaration != null) {
				forBody = forBody + objDeclaration + "\n";
			}
			String structTagName = null;
			String structVarName = null;
			if (OmpForOutliner.structEnvTagMap.containsKey(forConstruct)) {
				structTagName = OmpForOutliner.structEnvTagMap.get(forConstruct);
				structVarName = OmpForOutliner.structEnvVarMap.get(forConstruct);
				functionSignature = functionSignature + ",struct " + structTagName + " *" + structVarName + ")";
				callStatement += "," + structVarName + ");";
			} else {
				functionSignature = functionSignature + ")";
				callStatement = callStatement + ");";
			}
			functionBody = functionBody + forConstruct.getInfo().getCFGInfo().getBody() + "\n";
			String functionDefinition = functionSignature + forBody + functionBody;
			FunctionDefinition funcDef = FrontEnd.parseAndNormalize(functionDefinition, FunctionDefinition.class);
			Declaration funcSignature = FrontEnd.parseAndNormalize(functionSignature + ";\n", Declaration.class);
			Builder.addDeclarationToGlobals(structCounter++, funcSignature);
			Builder.addFunctionToGlobal(funcDef);
			Statement callStmt = FrontEnd.parseAndNormalize("{\n" + callStatement + "\n}\n", Statement.class);
			forConstruct.getInfo().getCFGInfo().mySetBody(callStmt);
		}
	}

	void Step3() {
		for (ParallelConstruct parallelConstruct : Misc.getInheritedEnclosee(Program.getRoot(),
				ParallelConstruct.class)) {
			String functionName = Builder.getNewTempName("par");
			String functionSignature = "void " + functionName + "(";
			String callStatement = functionName + "(";
			Boolean sharedIsEmpty = hasShared.get(parallelConstruct);
			if (sharedIsEmpty) {
				functionSignature += ")";
				callStatement += ");";
			} else {
				String sharedTagName = sharedTagMap.get(parallelConstruct);
				String sharedVarName = sharedVarMap.get(parallelConstruct);
				functionSignature += "struct " + sharedTagName + " *" + sharedVarName + ")";
				callStatement += sharedVarName + ");";
			}
			String functionBody = parallelConstruct.getInfo().getCFGInfo().getBody().toString();
			String functionDefinition = functionSignature + functionBody;
			Declaration functionSignatureNode = FrontEnd.parseAndNormalize(functionSignature + ";", Declaration.class);
			FunctionDefinition functionDefinitionNode = FrontEnd.parseAndNormalize(functionDefinition,
					FunctionDefinition.class);
			Statement callStatementNode = FrontEnd.parseAndNormalize(callStatement, Statement.class);
			Builder.addDeclarationToGlobals(structCounter++, functionSignatureNode);
			Builder.addFunctionToGlobal(functionDefinitionNode);
			parallelConstruct.getInfo().getCFGInfo().mySetBody(callStatementNode);
		}
	}

	void setupParConstructEnvironment(ParallelConstruct parallelConstruct) {
		String sharedTagName = Builder.getNewTempName("ENV_SHARED");
		String sharedVarName = Builder.getNewTempName("env_s");
		String privateTagName = Builder.getNewTempName("ENV_PRIVATE");
		String privateVarName = Builder.getNewTempName("env_p");
		privateVarMap.put(parallelConstruct, privateVarName);
		sharedVarMap.put(parallelConstruct, sharedVarName);
		privateTagMap.put(parallelConstruct, privateTagName);
		sharedTagMap.put(parallelConstruct, sharedTagName);
		Boolean privateVarsAbsent = false;
		Boolean sharedVarsAbsent = false;
		CompoundStatement parallelConstructBody = (CompoundStatement) parallelConstruct.getInfo().getCFGInfo()
				.getBody();
		FunctionDefinition enclosingFunctionDefinition = Misc.getEnclosingFunction(parallelConstructBody);
		structCounter = indexFunction(enclosingFunctionDefinition);
		CellSet accessedCells = parallelConstructBody.getInfo().getAccesses();
		CellSet accessibleCells = parallelConstructBody.getInfo().getAllCellsAtNode();
		CellSet intersectionCells = Misc.setIntersection(accessedCells, accessibleCells);
//		CellSet exclusiveCells = parallelConstructBody.getInfo().getAllCellsAtNodeExclusively();
//		CellSet usedCells = parallelConstructBody.getInfo().getUsedCells();
//		CellSet intersectionCells = Misc.setIntersection(exclusiveCells, usedCells);
		Set<String> namesDeclarationShared = new HashSet<>();
		Set<String> namesDeclarationPrivate = new HashSet<>();
		ArrayList<String> initializersShared = new ArrayList<String>();
		ArrayList<String> initializersPrivate = new ArrayList<String>();
		String privateClsrDeclaration = "struct "+privateTagName + "*"+privateEnvClosureName+";";
		privateEnvClsrDeclMap.put(parallelConstruct, privateClsrDeclaration);
		String voidPtrTempName = Builder.getNewTempName("envp_t");
		String voidPtrCreate = "void *" + voidPtrTempName + ";";
		String tempSize = Builder.getNewTempName("tempSize");
		String sizeOfMalloc = "int "+tempSize+" = sizeof(struct " + privateTagName + ");";
		String structAllocation = voidPtrTempName + "=" + "malloc("+tempSize+");";
		String assignAllocStmt = privateEnvClosureName + "=" + "(struct " + privateTagName + " *)" + voidPtrTempName + ";";
		initializersPrivate.add(voidPtrCreate);
		initializersPrivate.add(sizeOfMalloc);
		initializersPrivate.add(structAllocation);
		initializersPrivate.add(assignAllocStmt);
		ArrayList<String> restoreInitializers = new ArrayList<String>();
		ArrayList<Declaration> toBeDeletedDeclarations = new ArrayList<Declaration>();
		HashMap<String,String> renameMapperForConstruct = new HashMap<>();
		for (Cell accessedCell : intersectionCells) {
			if (accessedCell instanceof Symbol) {
				Symbol symb = (Symbol) accessedCell;
				if (symb.getDefiningScope() instanceof TranslationUnit) {
					continue;
				}
				if (parallelConstructBody.getInfo().getSharingAttribute(accessedCell) == DataSharingAttribute.SHARED) {
					if (symb.getType() instanceof ArrayType) {
						Declaration decl = (Declaration) symb.getDeclaringNode();
						String declaration = symb.getType().getExactDeclarationWithoutInit(symb.getName()).toString();
						namesDeclarationShared.add(declaration);
						ArrayType dAType = (ArrayType) symb.getType();
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
							System.err.println(aType.getArraySize().toString());
							int dSize = Integer.parseInt(aType.getArraySize().toString());
							dimSize.add(dSize);
							type = ((ArrayType) type).getElementType();
							nElements *= dSize;
							idx.add(0);
						}
						String initializer = "";
						String restore = "";
						if (decl.getInfo().hasInitializer()) {
							ArrayInitializer arrayInit = (ArrayInitializer) (decl.getInfo().getInitializer()).getF0()
									.getChoice();
							Queue<String> data = new LinkedList<String>();
							processInitializer(arrayInit, data);
							for (int itr1 = 0; itr1 < nElements; itr1++) {
								String index = generateIndex(dimSize, idx);
								String definer = "(" + sharedVarName + "->" + symb.getName() + ")" + index + "="
										+ data.poll();
								initializer = initializer + definer + ";\n";
							}
							String index = "";
							for (int itr1 = 0; itr1 < dim; itr1++) {
								String iteratorVariable = Builder.getNewTempName("itr");
								String iteratorVariableDecl = "int " + iteratorVariable + ";";
								String iteratorSize = dimSize.get(itr1).toString();
								String forHeader = "for(" + iteratorVariable + "=0;" + iteratorVariable + "<"
										+ iteratorSize + ";" + iteratorVariable + "++){\n";
								index = index + "[" + iteratorVariable + "]";
								restore = restore + iteratorVariableDecl + "\n";
								restore = restore + forHeader + "\n";
							}
							restore = restore + symb.getName() + index + " = " + "(" + sharedVarName + "->"
									+ symb.getName() + ")" + index + ";\n";
							for (int itr1 = 0; itr1 < dim; itr1++) {
								restore = restore + "}\n";
							}
						} else {
							String index = "";
							for (int itr1 = 0; itr1 < dim; itr1++) {
								String iteratorVariable = Builder.getNewTempName("itr");
								String iteratorVariableDecl = "int " + iteratorVariable + ";";
								String iteratorSize = dimSize.get(itr1).toString();
								String forHeader = "for(" + iteratorVariable + "=0;" + iteratorVariable + "<"
										+ iteratorSize + ";" + iteratorVariable + "++){\n";
								index = index + "[" + iteratorVariable + "]";
								initializer = initializer + iteratorVariableDecl + "\n";
								initializer = initializer + forHeader + "\n";
								restore = restore + iteratorVariableDecl + "\n";
								restore = restore + forHeader + "\n";
							}
							initializer = initializer + "(" + sharedVarName + "->" + symb.getName() + ")" + index + "="
									+ symb.getName() + index + ";\n";
							restore = restore + symb.getName() + index + " = " + "(" + sharedVarName + "->"
									+ symb.getName() + ")" + index + ";\n";
							for (int itr1 = 0; itr1 < dim; itr1++) {
								initializer = initializer + "}\n";
								restore = restore + "}\n";
							}
						}
						initializersShared.add(initializer);
						restoreInitializers.add(restore);
					} else {
						Declaration declShared = symb.getType().getDeclaration(symb.getName());
						namesDeclarationShared.add(declShared.toString() + "\n");
						String initializer = sharedVarName + "->" + symb.getName() + "=" + symb.getName() + ";";
						String restore = symb.getName() + "=" + sharedVarName + "->" + symb.getName() + ";";
						initializersShared.add(initializer);
						restoreInitializers.add(restore);
					}
					if (renameMapper.containsKey(parallelConstruct)) {
						HashMap<String, String> renamer = renameMapper.get(parallelConstruct);
						renamer.put(symb.getName(), "(" + sharedVarName + "->" + symb.getName() + ")");
						renameMapper.put(parallelConstruct, renamer);
					} else {
						HashMap<String, String> renamer = new HashMap<String, String>();
						renamer.put(symb.getName(), "(" + sharedVarName + "->" + symb.getName() + ")");
						renameMapper.put(parallelConstruct, renamer);
					}
					renameMapperForConstruct.put(symb.getName(),"("+sharedVarName+"->"+symb.getName()+")");
				} else if (parallelConstructBody.getInfo()
						.getSharingAttribute(accessedCell) == DataSharingAttribute.PRIVATE) {
					if (symb.getType() instanceof ArrayType) {
						Declaration declaringNode = (Declaration) symb.getDeclaringNode();
						String declaration = symb.getType().getExactDeclarationWithoutInit(symb.getName()).toString();
						namesDeclarationPrivate.add(declaration);
						ArrayType dAType = (ArrayType) symb.getType();
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
						if (declaringNode.getInfo().hasInitializer()) {
							ArrayInitializer arrayInit = (ArrayInitializer) (declaringNode.getInfo().getInitializer()).getF0()
									.getChoice();
							Queue<String> data = new LinkedList<String>();
							processInitializer(arrayInit, data);
							for (int itr1 = 0; itr1 < nElements; itr1++) {
								String index = generateIndex(dimSize, idx);
								String definer = "(" + privateVarName + "->" + symb.getName() + ")" + index + "="
										+ data.poll();
								initializer = definer + ";\n";
								InsertImmediateSuccessor.insert(declaringNode, FrontEnd.parseAndNormalize(initializer,Statement.class));
							}
						}
						String index = "";
						String initializerPrivate = "";
						for (int itr1 = 0; itr1 < dim; itr1++) {
							String iteratorVariable = Builder.getNewTempName("itr");
							String iteratorVariableDecl = "int " + iteratorVariable + ";";
							String iteratorSize = dimSize.get(itr1).toString();
							String forHeader = "for(" + iteratorVariable + "=0;" + iteratorVariable + "<"
									+ iteratorSize + ";" + iteratorVariable + "++){\n";
							index = index + "[" + iteratorVariable + "]";
							initializerPrivate = initializerPrivate + iteratorVariableDecl + "\n";
							initializerPrivate = initializerPrivate + forHeader + "\n";
						}
						initializerPrivate = initializerPrivate + "(" + privateEnvClosureName + "->" + symb.getName() + ")" + index + "="
								+ "(" + privateVarName + "->" + symb.getName() + ")" + index + ";\n";
						for (int itr1 = 0; itr1 < dim; itr1++) {
							initializerPrivate = initializerPrivate + "}\n";
						}
						initializersPrivate.add(initializerPrivate);
					} else {
						Declaration declPrivate = symb.getType().getDeclaration(symb.getName());
						namesDeclarationPrivate.add(declPrivate.toString()+"\n");
						Declaration declaringNode = (Declaration)symb.getDeclaringNode();
						if (declaringNode.getInfo().hasInitializer()) {
							String initializer = privateVarName + "->" + symb.getName() + "=" + declaringNode.getInfo().getInitializer() + ";";
							Statement statement = FrontEnd.parseAndNormalize(initializer,Statement.class);
							if(renameMapper.containsKey(parallelConstruct)) {
								Statement renamedStatement = (Statement) myObtainRenamedNode(statement, renameMapper.get(parallelConstruct));								
								InsertImmediateSuccessor.insert(declaringNode,renamedStatement);
							}else {
								InsertImmediateSuccessor.insert(declaringNode, statement);
							}
						}
						initializersPrivate.add(privateEnvClosureName+"->" + symb.getName() + "=(" + privateVarName+"->" + symb.getName()+");");
					}
					if (renameMapper.containsKey(parallelConstruct)) {
						HashMap<String, String> renamer = renameMapper.get(parallelConstruct);
						renamer.put(symb.getName(), "(" + privateVarName + "->" + symb.getName() + ")");
						renameMapper.put(parallelConstruct, renamer);
					} else {
						HashMap<String, String> renamer = new HashMap<String, String>();
						renamer.put(symb.getName(), "(" + privateVarName + "->" + symb.getName() + ")");
						renameMapper.put(parallelConstruct, renamer);
					}
					renameMapperForConstruct.put(symb.getName(),"("+privateEnvClosureName+"->"+symb.getName()+")");
				}
			}
		}
		initializersMapper.put(parallelConstruct, initializersPrivate);
		String structEnvShared = "struct " + sharedTagName;
		String structEnvPrivate = "struct " + privateTagName;
		String structObjDeclStrShared = structEnvShared + " *" + sharedVarName + ";";
		String structObjDeclStrPrivate = structEnvPrivate + " *" + privateVarName + ";";
		structEnvShared = structEnvShared + "{\n";
		structEnvPrivate = structEnvPrivate + "{\n";
		// Generating Final Structure Definitions
		if (!namesDeclarationShared.isEmpty()) {
			structEnvShared = structEnvShared + String.join("", namesDeclarationShared) + "};";
			Declaration environmentDeclarationShared = FrontEnd.parseAndNormalize(structEnvShared, Declaration.class);
			Builder.addDeclarationToGlobals(structCounter++, environmentDeclarationShared);
			voidPtrTempName = Builder.getNewTempName("env_s");
			voidPtrCreate = "void *" + voidPtrTempName + ";";
			tempSize = Builder.getNewTempName("tempSize");
			sizeOfMalloc = "int "+tempSize+" = sizeof(struct " + sharedTagName + ");";
			structAllocation = voidPtrTempName + "=" + "malloc("+tempSize+");";
			assignAllocStmt = sharedVarName + "=" + "(struct " + sharedTagName + " *)" + voidPtrTempName + ";";
			String initializers = "{" + String.join("\n", initializersShared) + "}";
			Statement initializer = FrontEnd.parseAndNormalize(initializers, Statement.class);
			// Add Restored
			String restore = "{" + String.join("\n", restoreInitializers) + "}";
			Statement restorer = FrontEnd.parseAndNormalize(restore, Statement.class);
//					simplifyMalloc(structSharedTagName, structSharedVarName, enclosingStmtParConst, parConstruct,structSharedObjDeclaration);
			InsertImmediateSuccessor.insert(parallelConstruct, restorer);
			InsertImmediatePredecessor.insert(parallelConstruct,
					FrontEnd.parseAndNormalize(structObjDeclStrShared, Declaration.class));
			InsertImmediatePredecessor.insert(parallelConstruct,
					FrontEnd.parseAndNormalize(voidPtrCreate, Declaration.class));
			InsertImmediatePredecessor.insert(parallelConstruct,
					FrontEnd.parseAndNormalize(sizeOfMalloc, Declaration.class));
			InsertImmediatePredecessor.insert(parallelConstruct,
					FrontEnd.parseAndNormalize(structAllocation, Statement.class));
			InsertImmediatePredecessor.insert(parallelConstruct,
					FrontEnd.parseAndNormalize(assignAllocStmt, Statement.class));
			InsertImmediatePredecessor.insert(parallelConstruct, initializer);
		} else {
			sharedVarsAbsent = true;
		}
		HashMap<String, String> renamer = renameMapper.get(parallelConstruct);

		List<Node> nodes = parallelConstructBody.getInfo().getCFGInfo().getElementList();
		for (Node node : nodes) {
			if (node instanceof Statement && !(node instanceof DummyFlushDirective)) {
				if(node instanceof ForConstruct) {
					continue;
				}else {
					Node renamedNode = myObtainRenamedNode(node, renamer);
					NodeReplacer.replaceNodes(node, renamedNode);
					renamedNode.getInfo().removeExtraScopes();
				}
			}
		}
		if (!namesDeclarationPrivate.isEmpty()) {
			structEnvPrivate = structEnvPrivate + String.join("", namesDeclarationPrivate) + "};";
			Declaration structObjDeclPrivate = FrontEnd.parseAndNormalize(structObjDeclStrPrivate, Declaration.class);
			Declaration environmentDeclarationPrivate = FrontEnd.parseAndNormalize(structEnvPrivate, Declaration.class);
			Builder.addDeclarationToGlobals(structCounter++, environmentDeclarationPrivate);
			// Private -- Add it to the body of parallel region
			voidPtrTempName = Builder.getNewTempName("env_p");
			voidPtrCreate = "void *" + voidPtrTempName + ";";
			tempSize = Builder.getNewTempName("tempSize");
			sizeOfMalloc = "int "+tempSize+" = sizeof(struct " + privateTagName + ");";
			structAllocation = voidPtrTempName + "=" + "malloc("+tempSize+");";
			assignAllocStmt = privateVarName + "=" + "(struct " + privateTagName + " *)" + voidPtrTempName + ";";
			parallelConstructBody.getInfo().getCFGInfo().addStatement(0,
					FrontEnd.parseAndNormalize(assignAllocStmt, Statement.class));
			parallelConstructBody.getInfo().getCFGInfo().addStatement(0,
					FrontEnd.parseAndNormalize(structAllocation, Statement.class));
			parallelConstructBody.getInfo().getCFGInfo().addDeclaration(0,
					FrontEnd.parseAndNormalize(sizeOfMalloc, Declaration.class));
			parallelConstructBody.getInfo().getCFGInfo().addDeclaration(0,
					FrontEnd.parseAndNormalize(voidPtrCreate, Declaration.class));
			parallelConstructBody.getInfo().getCFGInfo().addDeclaration(0, structObjDeclPrivate);
		} else {
			privateVarsAbsent = true;
		}
		hasShared.put(parallelConstruct, sharedVarsAbsent);
		hasPrivate.put(parallelConstruct, privateVarsAbsent);	
		for(ForConstruct forConstruct: Misc.getInheritedEnclosee(parallelConstruct, ForConstruct.class)){
			//Step 1: Use existing maps to build the forConstructBody
			privateClsrDeclarationNode = FrontEnd.parseAndNormalize(privateClsrDeclaration,Declaration.class);
			InsertImmediatePredecessor.insert(forConstruct, privateClsrDeclarationNode);
			OmpForHeader ompForHeader = forConstruct.getF2();
			ArrayList<String> initializerList = new ArrayList<>();
			OmpForInitExpression ompForInitExpression = ompForHeader.getF2();
			OmpForReinitExpression ompForReinitExpression = ompForHeader.getF6();
			OmpForCondition ompForCondition = ompForHeader.getF4();
			String loopVariable = ompForInitExpression.getF0().getTokenImage();
			forConstructMapper.put(forConstruct, loopVariable);
			String initLoopVariable = privateEnvClosureName + "->" + loopVariable + "=" + loopVariable + ";";
			initializersPrivate.add(initLoopVariable);
			Set<Cell> vars = new HashSet<>();
			vars.addAll(ompForInitExpression.getInfo().getSymbolAccesses());
			vars.addAll(ompForReinitExpression.getInfo().getSymbolAccesses());
			vars.addAll(ompForCondition.getInfo().getSymbolAccesses());
			for(Cell cell : vars) {
				Symbol symbol = (Symbol)cell;
				String name = symbol.getName();
				if(symbol.getDefiningScope() instanceof TranslationUnit) {
					continue;
				}
				if(renamer.containsKey(name)) {
					if (symbol.getType() instanceof ArrayType) {
						Declaration decl = (Declaration) symbol.getDeclaringNode();
						ArrayType dAType = (ArrayType) symbol.getType();
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
						String index = "";
						for (int itr1 = 0; itr1 < dim; itr1++) {
							String iteratorVariable = Builder.getNewTempName("itr");
							String iteratorVariableDecl = "int " + iteratorVariable + ";";
							String iteratorSize = dimSize.get(itr1).toString();
							String forHeader = "for(" + iteratorVariable + "=0;" + iteratorVariable + "<"
									+ iteratorSize + ";" + iteratorVariable + "++){\n";
							index = index + "[" + iteratorVariable + "]";
							initializer = initializer + iteratorVariableDecl + "\n";
							initializer = initializer + forHeader + "\n";
						}
						initializer = initializer + symbol.getName() + index + "=(" + renamer.get(name) + ")" + index + ";\n";
						for (int itr1 = 0; itr1 < dim; itr1++) {
							initializer = initializer + "}\n";
						}
						initializerList.add(initializer);
					} else {
						String initializer = symbol.getName() + "=" + renamer.get(name) + ";";
						initializerList.add(initializer);
					}
				renamer.remove(name);
				}
			}
			if(!initializerList.isEmpty()) {
				Statement initializerNode = FrontEnd.parseAndNormalize("{\n"+String.join("\n",initializerList)+"}\n",Statement.class);
				InsertImmediatePredecessor.insert(forConstruct, initializerNode);
			}
			Statement forConstructBody = forConstruct.getInfo().getCFGInfo().getBody();
			Statement forConstructBodyRenamed = (Statement) myObtainRenamedNode(forConstructBody,renameMapperForConstruct);
			forConstruct.getInfo().getCFGInfo().setBody(forConstructBodyRenamed);
			forConstruct.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
			initializersPrivate = initializersMapper.get(parallelConstruct);
		}
		parallelConstruct.getInfo().removeExtraScopes();
		for(Declaration declaration: toBeDeletedDeclarations) {
			NodeRemover.removeNode(declaration);
		}
		populateRanges(parallelConstruct);
	}

	private void populateRanges(ParallelConstruct parallelConstruct) {
		for(ForConstruct forConstruct:Misc.getInheritedEnclosee(parallelConstruct, ForConstruct.class)) {
			OmpForHeader ompForHeader = forConstruct.getF2();
			OmpForInitExpression ompForInitExpression = ompForHeader.getF2();
			Expression initExpression = ompForInitExpression.getF2();
			OmpForCondition ompForCondition = ompForHeader.getF4();
			NodeChoice conditionChoice = ompForCondition.getF0();
			Node node = conditionChoice.getChoice();
			String startRangeExpression,endRangeExpression,nIterationsFinder;
			if(node instanceof OmpForLTCondition) {
				OmpForLTCondition ltCondition = (OmpForLTCondition)node;
				Expression conditionExpression = ltCondition.getF2();
				startRangeExpression = "startRange_ivp17="+initExpression.toString()+";";
				endRangeExpression = "endRange_ivp17=" + conditionExpression.toString()+"-1;";
			}else if(node instanceof OmpForGTCondition) {
				OmpForGTCondition gtCondition = (OmpForGTCondition)node;
				Expression conditionExpression = gtCondition.getF2();
				startRangeExpression = "startRange_ivp17="+conditionExpression.toString()+";";
				endRangeExpression = "endRange_ivp17=" + initExpression.toString()+"-1;";
			}else if(node instanceof OmpForLECondition){
				OmpForLECondition leCondition = (OmpForLECondition)node;
				Expression conditionExpression = leCondition.getF2();
				startRangeExpression = "startRange_ivp17="+initExpression.toString()+";";
				endRangeExpression = "endRange_ivp17=" + conditionExpression.toString()+";";
			}else {
				OmpForGECondition geCondition = (OmpForGECondition)node;
				Expression conditionExpression = geCondition.getF2();
				startRangeExpression = "startRange_ivp17="+conditionExpression.toString()+";";
				endRangeExpression = "endRange_ivp17=" + initExpression.toString()+";";
			}
			nIterationsFinder = nIterationsVarName + " = endRange_ivp17 - startRange_ivp17 +1;";
			String size = nIterationsVarName + " + startRange_ivp17";
			String postboxInit = "postbox_ivp17 = (struct HashTable **)malloc(("+size+")*sizeof(struct HashTable *));";
//			String commStructInit = "comm_ivp17 = (struct CommStruct *)malloc(("+size+")*("+size+")*sizeof(struct CommStruct));";
			String commStructInit = "\n";
			String singleConstructBody = "{\n" + startRangeExpression+"\n"+endRangeExpression+"\n"+nIterationsFinder+"\n"+commStructInit+"\n"+postboxInit+"\n"+"}";
			CompoundStatement singleBody = FrontEnd.simplifyExpression(singleConstructBody);
			String singleConstructInit = "#pragma omp single\n"+singleBody.toString();
			InsertImmediatePredecessor.insert(forConstruct,FrontEnd.parseAndNormalize(singleConstructInit,SingleConstruct.class));
		}
	} 
	
	/**
	 * @param forConstruct
	 * @param loopVariable
	 */
	private void wrapWaitSignal() {
		for(FunctionDefinition functionDefinition: Misc.getInheritedEnclosee(Program.getRoot(), FunctionDefinition.class)) {
			CompoundStatement functionDefinitionBody = (CompoundStatement)functionDefinition.getInfo().getCFGInfo().getBody();
			for(CallStatement callStatement: Misc.getInheritedEnclosee(functionDefinitionBody, CallStatement.class)) {
				String functionCalled = callStatement.getInfo().getFunctionDesignator().toString();
				boolean loopVariablePresent = false;
				if(functionCalled.startsWith("myWait") || functionCalled.startsWith("mySignal")) {
					//Finding the enclosing compoundstatement for the wait/signal call - for wrapper function body
					CompoundStatement wrapperFunctionBody = null;
					String functionName = null;
					if(functionCalled.startsWith("myWait")){
						functionName = Builder.getNewTempName("waitWrapper");
					}else {
						functionName = Builder.getNewTempName("signalWrapper");
					}
					CFGLink cElementLink = CFGLinkFinder.getCFGLinkFor(callStatement);
					CompoundStatement enclosingCompoundStatement = (CompoundStatement) cElementLink.getEnclosingNode(); 
					IfThenBodyLink ifElementLink = (IfThenBodyLink)CFGLinkFinder.getCFGLinkFor(enclosingCompoundStatement);
					IfStatement enclosingIfStatement = (IfStatement)ifElementLink.getEnclosingNode();
					//Add ElseBody to IfStatement
					String elseBody = "{\n" + Translator.closureVarName+"->fptr("+Translator.closureVarName+");}\n";
					enclosingIfStatement.getInfo().getCFGInfo().setElseBody(FrontEnd.parseAndNormalize(elseBody,CompoundStatement.class));
					CompoundElementLink cElementLinkOuter = (CompoundElementLink)CFGLinkFinder.getCFGLinkFor(enclosingIfStatement);
					CompoundStatement enclosingCompoundStatementOuter = (CompoundStatement)cElementLinkOuter.getEnclosingNode();
					wrapperFunctionBody = enclosingCompoundStatementOuter;					
					List<Node> toBeDeletedNodes = new ArrayList<>();
					List<Node> wrapperFunctionElements = wrapperFunctionBody.getInfo().getCFGInfo().getElementList();
					List<String> wrapperFunctionBodyList = new ArrayList<>();
					//Find the used symbols in the code.
					ArrayList<Symbol> symbolsAccessed = new ArrayList<>();
					CellSet usedCells = wrapperFunctionBody.getInfo().getUsedCells();
					CellSet exclusiveCells = wrapperFunctionBody.getInfo().getAllCellsAtNodeExclusively();
					CellSet intersectionCells = Misc.setIntersection(usedCells, exclusiveCells);
					for(Cell cell:intersectionCells) {
						if(cell instanceof Symbol) {
							Symbol symbol = (Symbol)cell;
							symbolsAccessed.add(symbol);					
						}
					}
					int indexIfStatement = wrapperFunctionElements.indexOf(enclosingIfStatement);
					//Finding the Body of the Wrapper Function
					if(functionCalled.endsWith("Red")) {
						Symbol reductionVariableSymbol = Misc.getSymbolEntry("redVar", wrapperFunctionBody);
						Node reductionVariableDeclaringNode = reductionVariableSymbol.getDeclaringNode();
						int indexReductionVariableDeclaringNode = wrapperFunctionElements.indexOf(reductionVariableDeclaringNode);
						for(int k = indexReductionVariableDeclaringNode;k <= indexIfStatement;k++) {
							toBeDeletedNodes.add(wrapperFunctionElements.get(k));
							wrapperFunctionBodyList.add(wrapperFunctionElements.get(k).toString());
						}
					}else {
						Symbol endHereSymbol = Misc.getSymbolEntry("wxyz",wrapperFunctionBody);
						Node endHereDeclaringNode = endHereSymbol.getDeclaringNode();
						int indexEndHereDeclaringNode = wrapperFunctionElements.indexOf(endHereDeclaringNode);
						for(int k = indexEndHereDeclaringNode; k <= indexIfStatement; k++) {
							toBeDeletedNodes.add(wrapperFunctionElements.get(k));
							wrapperFunctionBodyList.add(wrapperFunctionElements.get(k).toString());
						}
					}
					String loopVariable = loopVariables.get(callStatement.toString());
					ArrayList<String> formalParametersList = new ArrayList<>();
					ArrayList<String> actualParametersList = new ArrayList<>();
					Symbol identifierSymbol = null;
					Symbol reductionVariableSymbol = null;
					List<SimplePrimaryExpression> params = callStatement.getInfo().getArgumentList();
					//Handling Subset Wait/Signal Calls
					if(functionCalled.equals("myWait") || 
						functionCalled.equals("mySignalSend") || 
						functionCalled.equals("mySignal") || 
						functionCalled.equals("myWaitRed")) {
						if(functionCalled.equals("myWaitRed")) {
							SimplePrimaryExpression messageVariable = params.get(1);
							SimplePrimaryExpression reductionFunctionExpression = params.get(5);
							String reductionFunctionName = reductionFunctionExpression.toString();
							String identifier = messageVariable.getIdentifier().getTokenImage();
							identifierSymbol = Misc.getSymbolEntry(identifier, wrapperFunctionBody);
							Declaration declaringNode = (Declaration) identifierSymbol.getDeclaringNode();
							Initializer initializer = declaringNode.getInfo().getInitializer();
							AssignmentExpression initAssignExpr = (AssignmentExpression) initializer.getF0().getChoice();
							String initExprStr = initAssignExpr.toString();
							initExprStr = initExprStr.substring(initExprStr.indexOf("&")+1).trim();
							for(Symbol symbol:symbolsAccessed) {
								String symbolName = symbol.getName();
								String formalParam = null;
								String actualParam = null;
								if(symbolName.equals(initExprStr)) {
									Type symbolType = symbol.getType();
									String symbolTypeString = symbolType.toString().trim();
									String newReducerName = Builder.getNewTempName(initExprStr);
									String newReducerFormalParameter = symbolType.toString() + "*"+newReducerName;
									reductionVariableTypeMapper.put(functionName,symbolTypeString);
									reductionVariableNameMapper.put(functionName,initExprStr);
									reductionVariableReducedMapper.put(functionName,newReducerName);
									reductionFunctionMapper.put(functionName, reductionFunctionName);
									formalParam = newReducerFormalParameter;
									actualParam = newReducerName;
								}else if(symbol.getDefiningScope() instanceof TranslationUnit){
									continue;
								}else {
									Declaration declWithoutInit = symbol.getType().getExactDeclarationWithoutInit(symbol.getName());
									formalParam = declWithoutInit.toString().substring(0,declWithoutInit.toString().lastIndexOf(";"));
									actualParam = symbolName;
								}
								if(actualParam.equals(loopVariable)) {
									loopVariablePresent = true;
								}
								formalParametersList.add(formalParam);
								actualParametersList.add(actualParam);					
							}
						}else if(functionCalled.equals("mySignalSend")) {
							for(Symbol symbol:symbolsAccessed) {
								String symbolName = symbol.getName();
								Declaration declWithoutInit = symbol.getType().getExactDeclarationWithoutInit(symbol.getName());
								String formalParam = declWithoutInit.toString().substring(0,declWithoutInit.toString().lastIndexOf(";"));
								String actualParam = symbolName;
								if(actualParam.equals(loopVariable)) {
									loopVariablePresent = true;
								}
								formalParametersList.add(formalParam);
								actualParametersList.add(actualParam);		
							}
						}
					}else if(functionCalled.equals("myWaitAll") || 
							functionCalled.equals("myWaitAllRed") || 
							functionCalled.equals("mySignalAllSend") || 
							functionCalled.equals("mySignalAll") || 
							functionCalled.equals("myReduceAll")) {
						loopVariable = MUWOmpConverter.loopVariables.get(callStatement.toString());
						formalParametersList.add("int "+loopVariable);
						actualParametersList.add(loopVariable);
						identifierSymbol = null;
						if(functionCalled.equals("myWaitAllRed")) {
							SimplePrimaryExpression messageVariable = params.get(1);
							SimplePrimaryExpression reductionFunctionExpression = params.get(5);
							String reductionFunctionName = reductionFunctionExpression.toString();
							String identifier = messageVariable.getIdentifier().getTokenImage();
							identifierSymbol = Misc.getSymbolEntry(identifier, wrapperFunctionBody);
							Declaration declaringNode = (Declaration) identifierSymbol.getDeclaringNode();
							Initializer initializer = declaringNode.getInfo().getInitializer();
							AssignmentExpression initAssignExpr = (AssignmentExpression) initializer.getF0().getChoice();
							String initExprStr = initAssignExpr.toString();
							initExprStr = initExprStr.substring(initExprStr.indexOf("&")+1).trim();
							for(Symbol symbol:symbolsAccessed) {
								String symbolName = symbol.getName();
								String formalParam = null;
								String actualParam = null;
								if(symbolName.equals(initExprStr)) {
									Type symbolType = symbol.getType();
									String symbolTypeString = symbolType.toString().trim();
									String newReducerName = Builder.getNewTempName(initExprStr);
									String newReducerFormalParameter = symbolType.toString() + "*"+newReducerName;
									reductionVariableTypeMapper.put(functionName,symbolTypeString);
									reductionVariableNameMapper.put(functionName,initExprStr);
									reductionVariableReducedMapper.put(functionName,newReducerName);
									reductionFunctionMapper.put(functionName, reductionFunctionName);
									formalParam = newReducerFormalParameter;
									actualParam = newReducerName;
								} else if(symbol.getDefiningScope() instanceof TranslationUnit){
									continue;
								}else {
									Declaration declWithoutInit = symbol.getType().getExactDeclarationWithoutInit(symbol.getName());
									formalParam = declWithoutInit.toString().substring(0,declWithoutInit.toString().lastIndexOf(";"));
									actualParam = symbolName;
								}
								if(actualParam.equals(loopVariable)) {
									loopVariablePresent = true;
								}
								formalParametersList.add(formalParam);
								actualParametersList.add(actualParam);
							}
						}else if(functionCalled.equals("mySignalAllSend")) {
							
						}
					}
					if(!loopVariablePresent) {
						actualParametersList.add(loopVariable);
						formalParametersList.add("int "+loopVariable);
					}
					actualParametersList.add(Translator.closureVarName);
					formalParametersList.add("struct Clsr *"+Translator.closureVarName);
					Set<String> actualParametersSet = new LinkedHashSet<>(actualParametersList);
					Set<String> formalParametersSet = new LinkedHashSet<>(formalParametersList);
					String formalParameters = formalParametersSet.stream().map(String::toString).collect(Collectors.joining(","));
					String actualParameters = actualParametersSet.stream().map(String::toString).collect(Collectors.joining(","));
					String callStatementStr = functionName + "("+actualParameters+");";
					String wrapperFunctionBodyString = "{\n" + String.join("\n", wrapperFunctionBodyList) + "}\n";
					String functionHeader = "void "+functionName+"("+formalParameters+")";
					String functionSignature = functionHeader + ";";
					String functionBody = wrapperFunctionBodyString;
					String functionDefString = functionHeader + functionBody;
					FunctionDefinition wrapperFunctionDef = FrontEnd.parseAndNormalize(functionDefString,FunctionDefinition.class);
					Declaration wrapperFunctionSignature = FrontEnd.parseAndNormalize(functionSignature,Declaration.class);
					Builder.addDeclarationToGlobals(MUWOmpConverter.indexFunction(Program.getRoot().getInfo().getMainFunction()),wrapperFunctionSignature);
					Builder.addFunctionToGlobal(wrapperFunctionDef);
					wrapperFunctionBody.getInfo().getCFGInfo().addElement(indexIfStatement,FrontEnd.parseAndNormalize(callStatementStr,Statement.class));
					wrapperFunctionDef.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
					wrapperFunctionBody.getInfo().removeExtraScopes();
					reductionVariables.put(functionName, reductionVariableSymbol);
					for(Node node:toBeDeletedNodes) {
						NodeRemover.removeNode(node);
					}
					functionDefinitionBody.getInfo().removeExtraScopes();
				}
			}
		}
	}

	/**
	 * 
	 */
	private void replaceWaitSignalCalls() {
		for(FunctionDefinition functionDefinition:Misc.getInheritedEnclosee(Program.getRoot(), FunctionDefinition.class)) {
			CompoundStatement functionDefinitionBody = (CompoundStatement) functionDefinition.getInfo().getCFGInfo().getBody();
			for(CallStatement callStatement: Misc.getInheritedEnclosee(functionDefinitionBody,CallStatement.class)) {
				String functionCalledName = callStatement.getInfo().getFunctionDesignator().toString();
				ArrayList<String> actualParameterList = new ArrayList<>();
				if(functionCalledName.equals("myWait")) {
					String loopVariable = MUWOmpConverter.loopVariables.get(callStatement.toString());
					List<SimplePrimaryExpression> params = callStatement.getInfo().getArgumentList();
					String expression = params.get(0).toString();
					String n_iters = params.get(1).toString();
					String waitIters = params.get(2).toString();
					actualParameterList.add(loopVariable);
					actualParameterList.add("(void *)0");
					actualParameterList.add("(void *)0");
					actualParameterList.add("(void *)0");
					actualParameterList.add("(void *)0");
					actualParameterList.add("(void *)0");
					actualParameterList.add("0");
					actualParameterList.add(n_iters);
					actualParameterList.add(waitIters);
					actualParameterList.add("&"+Translator.closureVarName);
					actualParameterList.add(expression);
					String parametersOfWaitCall = "("+String.join(",", actualParameterList)+")";
					String createWaitClosureCall = "createWaitClosure"+parametersOfWaitCall+";";
					Statement waitClosureCreateNode = FrontEnd.parseAndNormalize(createWaitClosureCall, Statement.class);
					InsertImmediatePredecessor.insert(callStatement,waitClosureCreateNode);
					NodeRemover.removeNode(callStatement);
				} else if(functionCalledName.equals("mySignal")){
					String loopVariable = MUWOmpConverter.loopVariables.get(callStatement.toString());
					List<SimplePrimaryExpression> params = callStatement.getInfo().getArgumentList();
					String expression = params.get(0).toString();
					String n_iters = params.get(1).toString();
					String signalIters = params.get(2).toString();
					String signalCallStr = "mSignal(" + expression + ","+loopVariable+",0,"+ n_iters + "," + signalIters + ","+Translator.closureVarName+");";
					Statement signalCall = FrontEnd.parseAndNormalize(signalCallStr,Statement.class);
					InsertImmediatePredecessor.insert(callStatement,signalCall);
					NodeRemover.removeNode(callStatement);
				}else if(functionCalledName.equals("myWaitAll")) {
					String loopVariable = MUWOmpConverter.loopVariables.get(callStatement.toString());
					List<SimplePrimaryExpression> params = callStatement.getInfo().getArgumentList();
					String expression = params.get(0).toString();
					String startRange = "startRange_ivp17";
					String endRange = "endRange_ivp17";
					actualParameterList.add(loopVariable);
					actualParameterList.add("0");
					actualParameterList.add("0");
					actualParameterList.add("0");
					actualParameterList.add("0");
					actualParameterList.add("0");
					actualParameterList.add(startRange);
					actualParameterList.add(endRange);
					actualParameterList.add("&"+Translator.closureVarName);
					actualParameterList.add(expression);
					String parametersOfWaitCall = "("+String.join(",", actualParameterList)+")";
					String createWaitClosureCall = "createWaitClosureAll"+parametersOfWaitCall+";";
					Statement waitClosureCreateNode = FrontEnd.parseAndNormalize(createWaitClosureCall, Statement.class);
//					String continuationString = Translator.buildContinuationString();
//					InsertImmediateSuccessor.insert(callStatement,FrontEnd.parseAndNormalize(continuationString,IfStatement.class));
					InsertImmediatePredecessor.insert(callStatement,waitClosureCreateNode);
					NodeRemover.removeNode(callStatement);
				}else if(functionCalledName.equals("mySignalAll")) {
					String loopVariable = MUWOmpConverter.loopVariables.get(callStatement.toString());
					List<SimplePrimaryExpression> params = callStatement.getInfo().getArgumentList();
					String expression = params.get(0).toString();
					String startRange = "startRange_ivp17";
					String endRange = "endRange_ivp17";
					String signalCallStr = "mSignalAll(" + expression + ","+loopVariable+",0,"+ startRange + "," + endRange + ","+Translator.closureVarName+");";
					Statement signalCall = FrontEnd.parseAndNormalize(signalCallStr,Statement.class);
					InsertImmediatePredecessor.insert(callStatement,signalCall);
					NodeRemover.removeNode(callStatement);
				}else if(functionCalledName.equals("mySignalSend")) {
					String loopVariable = MUWOmpConverter.loopVariables.get(callStatement.toString());
					List<SimplePrimaryExpression> params = callStatement.getInfo().getArgumentList();
					String expression = params.get(0).toString();
					actualParameterList.add(expression);
					actualParameterList.add(loopVariable);
					if(params.get(1).isAConstant()) {
						String pointerName = handleMessageParameter(params.get(1),callStatement,functionDefinitionBody);
						actualParameterList.add(pointerName);
					}else {
						String messageParam = params.get(1).toString();
						actualParameterList.add(messageParam);
					}
					String n_iters = params.get(2).toString();
					actualParameterList.add(n_iters);
					String signalIters = params.get(3).toString();
					actualParameterList.add(signalIters);
					actualParameterList.add(Translator.closureVarName);
					String actualParameters = String.join(",", actualParameterList);
					String signalCallStr = "mSignal(" +actualParameters+ ");";
					Statement signalCall = FrontEnd.parseAndNormalize(signalCallStr,Statement.class);
					InsertImmediatePredecessor.insert(callStatement,signalCall);
					NodeRemover.removeNode(callStatement);
				}else if(functionCalledName.equals("mySignalAllSend")) {
					String loopVariable = MUWOmpConverter.loopVariables.get(callStatement.toString());
					List<SimplePrimaryExpression> params = callStatement.getInfo().getArgumentList();
					String expression = params.get(0).toString();
					actualParameterList.add(expression);
					actualParameterList.add(loopVariable);
					if(params.get(1).isAConstant()) {
						String pointerName = handleMessageParameter(params.get(1),callStatement,functionDefinitionBody);
						actualParameterList.add(pointerName);
					}else {
						String messageParam = params.get(1).toString();
						actualParameterList.add(messageParam);
					}
					String startRange = "startRange_ivp17";
					String endRange = "endRange_ivp17";
					actualParameterList.add(startRange);
					actualParameterList.add(endRange);
					actualParameterList.add(Translator.closureVarName);
					String actualParameters = String.join(",", actualParameterList);
					String signalCallStr = "mSignalAll(" + actualParameters +");";
					Statement signalCall = FrontEnd.parseAndNormalize(signalCallStr,Statement.class);
					InsertImmediatePredecessor.insert(callStatement,signalCall);
					NodeRemover.removeNode(callStatement);
				}else if(functionCalledName.equals("myWaitRed")) {
					String loopVariable = MUWOmpConverter.loopVariables.get(callStatement.toString());
					List<SimplePrimaryExpression> arguments = callStatement.getInfo().getArgumentList();
					SimplePrimaryExpression expression = arguments.get(0);
					SimplePrimaryExpression reductionVariableExpression = arguments.get(1);
					SimplePrimaryExpression nIters = arguments.get(3);
					SimplePrimaryExpression waitingIterations = arguments.get(4);
					SimplePrimaryExpression reductionFunction = arguments.get(5);
					String functionName = functionDefinition.getInfo().getFunctionName();
					String typeReductionVariableID = reductionVariableTypeMapper.get(functionName);
					String reductionFunctionRawName = reductionFunction.toString().toUpperCase();
					String reductionFunctionName;
					int indexUnderscore = reductionFunctionRawName.indexOf("_");
					if(indexUnderscore == -1) {
						reductionFunctionName = reductionFunction.toString().toUpperCase() + typeReductionVariableID.toUpperCase();
						if(reductionFunctionRawName.startsWith("ADD")) {
							reductionFunctionInitialValueMapper.put(functionName,"0");
						}else if(reductionFunctionRawName.startsWith("SUB")) {
							reductionFunctionInitialValueMapper.put(functionName,"0");
						}else {
							reductionFunctionInitialValueMapper.put(functionName,"1");
						}
					}else {
						reductionFunctionName = reductionFunctionRawName.split("_")[0];
						String initialValue = reductionFunctionRawName.split("_")[1];
						reductionFunctionInitialValueMapper.put(functionName,initialValue);
					}
					String copyFunctionName = "COPY" + typeReductionVariableID.toUpperCase();
					String allocFunctionName = "ALLOC" + typeReductionVariableID.toUpperCase();
					actualParameterList.add(loopVariable);
					actualParameterList.add(reductionFunctionName);
					actualParameterList.add(copyFunctionName);
					actualParameterList.add(allocFunctionName);
					actualParameterList.add(reductionVariableExpression.toString());
					actualParameterList.add("initialValue");
					actualParameterList.add("0");
					actualParameterList.add(nIters.toString());
					actualParameterList.add(waitingIterations.toString());
					actualParameterList.add("&"+Translator.closureVarName);
					actualParameterList.add(expression.toString());
					String parametersOfWaitCall = "("+String.join(",", actualParameterList)+")";
					String createWaitClosureCall = "createWaitClosure"+parametersOfWaitCall+";";
					Statement waitClosureCreateNode = FrontEnd.parseAndNormalize(createWaitClosureCall, Statement.class);
//					String continuationString = Translator.buildContinuationString();
//					InsertImmediateSuccessor.insert(callStatement,FrontEnd.parseAndNormalize(continuationString,IfStatement.class));
					InsertImmediatePredecessor.insert(callStatement,waitClosureCreateNode);
					NodeRemover.removeNode(callStatement);
				}else if(functionCalledName.equals("myWaitAllRed")) {
					List<SimplePrimaryExpression> arguments = callStatement.getInfo().getArgumentList();
					String loopVariable = MUWOmpConverter.loopVariables.get(callStatement.toString());
					String expression = arguments.get(0).toString();
					SimplePrimaryExpression reductionVariableExpression = arguments.get(1);
					String startRange = "startRange_ivp17";
					String endRange = "endRange_ivp17";
					SimplePrimaryExpression reductionFunction = arguments.get(5);
					String functionName = functionDefinition.getInfo().getFunctionName();
					String typeReductionVariableID = reductionVariableTypeMapper.get(functionName);
					String reductionFunctionRawName = reductionFunction.toString().toUpperCase();
					String reductionFunctionName;
					int indexUnderscore = reductionFunctionRawName.indexOf("_");
					if(indexUnderscore == -1) {
						reductionFunctionName = reductionFunctionRawName + typeReductionVariableID.toUpperCase();
						if(reductionFunctionRawName.startsWith("ADD")) {
							reductionFunctionInitialValueMapper.put(functionName,"0");
						}else if(reductionFunctionRawName.startsWith("SUB")) {
							reductionFunctionInitialValueMapper.put(functionName,"0");
						}else {
							reductionFunctionInitialValueMapper.put(functionName,"1");
						}
					}else {
						reductionFunctionName = reductionFunctionRawName.split("_")[0];
						String initialValue = reductionFunctionRawName.split("_")[1];
						reductionFunctionInitialValueMapper.put(functionName,initialValue);
					}
					String copyFunctionName = "COPY" + typeReductionVariableID.toUpperCase();
					String allocFunctionName = "ALLOC" + typeReductionVariableID.toUpperCase();
					actualParameterList.add(loopVariable);
					actualParameterList.add(reductionFunctionName);
					actualParameterList.add(copyFunctionName);
					actualParameterList.add(allocFunctionName);
					actualParameterList.add(reductionVariableExpression.toString());
					actualParameterList.add("initialValue");
					actualParameterList.add(startRange);
					actualParameterList.add(endRange);
					actualParameterList.add("&"+Translator.closureVarName);
					actualParameterList.add(expression.toString());
					String parametersOfWaitCall = "("+String.join(",", actualParameterList)+")";
					String createWaitClosureCall = "createWaitClosureAll"+parametersOfWaitCall+";";
					Statement waitClosureCreateNode = FrontEnd.parseAndNormalize(createWaitClosureCall, Statement.class);
					InsertImmediatePredecessor.insert(callStatement,waitClosureCreateNode);
					NodeRemover.removeNode(callStatement);
				}
			}
			
			functionDefinition.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
		}
	}
	
	String getTypeOfMessageParameter(SimplePrimaryExpression messageParameter) {
		try {
			int parsedInt = Integer.parseInt(messageParameter.toString());
			return "int";
		}catch(NumberFormatException exception) {
			System.out.println(messageParameter.toString()+" is not an integer.");
			double parsedDouble = Integer.parseInt(messageParameter.toString());
			return "double";
		}
	}
	
	String handleMessageParameter(SimplePrimaryExpression messageParameter,CallStatement callStatement,CompoundStatement functionDefinition) {
		String pointerName = Builder.getNewTempName("message");
		String typeOfMessageParameter = getTypeOfMessageParameter(messageParameter);
		String generatePointer = typeOfMessageParameter + " *"+pointerName+" = ("+typeOfMessageParameter+" *)malloc(sizeof("+typeOfMessageParameter+"));";
		String assignment = "*"+pointerName+"= "+messageParameter.toString()+";";
		InsertImmediatePredecessor.insert(callStatement, FrontEnd.parseAndNormalize(generatePointer,Declaration.class));
		InsertImmediatePredecessor.insert(callStatement, FrontEnd.parseAndNormalize(assignment,Statement.class));
		return pointerName;
	}
	void setupEnvironment() {
		ArrayList<String> singleConstructSetupBodyList = new ArrayList<>();
		String globalWorkListInit = "globalWorklist = createWorklistQueue();";
		String readyWorkListInit = "struct WLQueue *readyWorklist = createWorklistQueue();";
		String nThreadsVarName = Builder.getNewTempName("nThreads");
		String nThreadsDecl = "int "+nThreadsVarName+" = omp_get_num_threads();";
//        String initPostbox = "initialisePostBox(4096,4096);";
//        String clearLock = "omp_init_lock(&lock);";
		singleConstructSetupBodyList.add(globalWorkListInit);
		singleConstructSetupBodyList.add(nThreadsDecl);
//		singleConstructSetupBodyList.add(initPostbox);
//		singleConstructSetupBodyList.add(clearLock);
        String singleBodyUnOptimized = "{\n" + String.join("\n", singleConstructSetupBodyList) + "}\n";
        String singleConstructInit = "#pragma omp single\n"+singleBodyUnOptimized.toString();
        String nIterationsVarString = "int "+nIterationsVarName+";";
        Builder.addDeclarationToGlobals(0,FrontEnd.parseAndNormalize(nIterationsVarString,Declaration.class));
		wrapWaitSignal();
		replaceWaitSignalCalls();
		setupReduction();
		for (ParallelConstruct parallelConstruct : Misc.getInheritedEnclosee(Program.getRoot(),
				ParallelConstruct.class)) {
			setupParConstructEnvironment(parallelConstruct);
			CompoundStatement parallelConstructBody = (CompoundStatement)(parallelConstruct.getInfo().getCFGInfo().getBody());
			SingleConstruct singleConstructInitNode = FrontEnd.parseAndNormalize(singleConstructInit,SingleConstruct.class);
			parallelConstructBody.getInfo().getCFGInfo().addElement(0, singleConstructInitNode);
			CompoundStatement singleConstructBodyCS = (CompoundStatement) singleConstructInitNode.getInfo().getCFGInfo().getBody();
			CompoundStatement singleConstructBodyCSOpt = Normalization.normalizeLeafNodes(singleConstructBodyCS, null);
			singleConstructInitNode.getInfo().getCFGInfo().setBody(singleConstructBodyCSOpt);
			parallelConstructBody.getInfo().getCFGInfo().addElement(0, FrontEnd.parseAndNormalize(readyWorkListInit,Declaration.class));
		}
	}
	
	public void replaceFormalParameters(FunctionDefinition functionDefinition, List<ParameterDeclaration> formalParameters) {
		String functionName = functionDefinition.getInfo().getFunctionName();
		String formalParameterString = formalParameters.stream().map(ParameterDeclaration::toString).collect(Collectors.joining(","));
		String functionHeader = "void "+functionName+"("+formalParameterString+")";
		String functionSignature = functionHeader + ";";
		String functionDefinitionString = functionHeader + functionDefinition.getInfo().getCFGInfo().getBody();
		Translator.removeFunction(functionDefinition);
		Builder.addDeclarationToGlobals(indexFunction(Program.getRoot().getInfo().getMainFunction()),FrontEnd.parseAndNormalize(functionSignature,Declaration.class));
		Builder.addFunctionToGlobal(FrontEnd.parseAndNormalize(functionDefinitionString,FunctionDefinition.class));
	}
	
	public void handleCallStatement(String functionName, 
									String reductionVariableSymbolName, 
									String reductionVariableSymbolRHS, 
									String reductionFunctionName) {
		for(FunctionDefinition functionDefinition:Misc.getInheritedEnclosee(Program.getRoot(),FunctionDefinition.class)) {
			for(CallStatement callStatement:Misc.getInheritedEnclosee(functionDefinition, CallStatement.class)) {
				String functionCalledName = callStatement.getInfo().getFunctionDesignator().toString();
				if(functionCalledName.equals(functionName)) {
					FunctionDefinition calledDefinition = callStatement.getInfo().getCalledDefinitions().get(0);
					CompoundStatement calledDefinitionBody = calledDefinition.getInfo().getCFGInfo().getBody();
					List<Node> bodyElements = calledDefinitionBody.getInfo().getCFGInfo().getElementList();
					String restoreTempReductionVariable;
					if(reductionFunctionName.startsWith("SUB")) {
						restoreTempReductionVariable = reductionVariableSymbolName + " = 0 - *("+reductionVariableSymbolRHS+");";
					}else {
						restoreTempReductionVariable = reductionVariableSymbolName + " = *("+reductionVariableSymbolRHS+");";
					}
					String conditionStatements = null;
					Normalization.normalizeLeafNodes(calledDefinitionBody, null);
					for(CallStatement insideCallStatement:Misc.getInheritedEnclosee(calledDefinitionBody, CallStatement.class)) {
						String insideCallStatementName = insideCallStatement.getInfo().getFunctionDesignator().toString();
						if(insideCallStatementName.startsWith("createWaitClosure")) {
							//Getting the condition expression variable
							List<SimplePrimaryExpression> actualArguments = insideCallStatement.getInfo().getArgumentList();
							int indexWaitCall = bodyElements.indexOf(insideCallStatement);
							SimplePrimaryExpression conditionExpression;
							if(insideCallStatementName.equals("createWaitClosureAll")) {
								conditionExpression = actualArguments.get(9);
							}else {
								conditionExpression = actualArguments.get(10);
							}
							if(conditionExpression.isAnIdentifier()) {
								String identifierConditionVariable = conditionExpression.getIdentifier().getTokenImage();
								Symbol identifierConditionVariableSymbol = Misc.getSymbolEntry(identifierConditionVariable, calledDefinitionBody);
								Node identifierConditionVariableDeclaringNode = identifierConditionVariableSymbol.getDeclaringNode();
								int indexConditionVariableDeclaringNode = bodyElements.indexOf(identifierConditionVariableDeclaringNode);
								List<Node> conditionStatementList = bodyElements.subList(indexConditionVariableDeclaringNode, indexWaitCall);
								String restoreIfStatement = "if("+identifierConditionVariable+")"+restoreTempReductionVariable;
								conditionStatements = conditionStatementList.stream().map(Node::toString).collect(Collectors.joining("\n"));
								conditionStatements = "{\n" + conditionStatements + restoreIfStatement + "\n}";
							}else {
								String constant = conditionExpression.getConstant().toString();
								conditionStatements = "{\n if("+constant+")"+restoreTempReductionVariable + "\n}";
							}
							break;
						}
					}
					InsertImmediateSuccessor.insert(callStatement, FrontEnd.parseAndNormalize(conditionStatements,CompoundStatement.class));
					functionDefinition.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
				}
			}
		}
	}
	
	public CompoundStatement generateInitialValue(String typeReductionVariable,String initialValue) {
		String newInitialValueName = Builder.getNewTempName("init");
		String declareInitialValue = typeReductionVariable + "*"+newInitialValueName+";";
		String allocInitialValue = newInitialValueName + " = ("+typeReductionVariable+"*)malloc(sizeof("+typeReductionVariable+"));";
		String assignInitialValue = "*"+newInitialValueName+" = "+initialValue+";";
		String assignToInitialValue = "void *initialValue = "+newInitialValueName+";";
		String initialValueString = "{\n" + declareInitialValue + "\n" + allocInitialValue + "\n" + assignInitialValue + "\n" + assignToInitialValue + "}\n";
		CompoundStatement initialValueCS = FrontEnd.simplifyExpression(initialValueString);
		return initialValueCS;
	}
	
	public void setupReduction() {
		for(FunctionDefinition functionDefinition:Misc.getInheritedEnclosee(Program.getRoot(), FunctionDefinition.class)) {
			String functionName = functionDefinition.getInfo().getFunctionName();
			if(functionName.startsWith("waitWrapper")) {
				functionDefinition.getInfo().populateSymbolTable();
				if(reductionVariableNameMapper.containsKey(functionName)) {
					String reductionVariableOriginalSymbolName = reductionVariableNameMapper.get(functionName);
					String reductionVariableModifiedSymbolName = reductionVariableReducedMapper.get(functionName);
					String reductionVariableTypeName = reductionVariableTypeMapper.get(functionName);
					String reductionFunction = reductionFunctionMapper.get(functionName);
					String initialValue = reductionFunctionInitialValueMapper.get(functionName);
					//Replace redVar with correct parameter
					CompoundStatement functionDefinitionBody = functionDefinition.getInfo().getCFGInfo().getBody();
					Symbol reductionVariableSymbolEntry = Misc.getSymbolEntry("redVar", functionDefinitionBody);
					Declaration reductionVariableSymbolDeclaration = (Declaration)reductionVariableSymbolEntry.getDeclaringNode();
					String replaceNode = "void *redVar = "+reductionVariableModifiedSymbolName+";";
					NodeReplacer.replaceNodes(reductionVariableSymbolDeclaration, FrontEnd.parseAndNormalize(replaceNode,Declaration.class));
					//Replace InitialValue with Write CS
					CompoundStatement initialCS = generateInitialValue(reductionVariableTypeName,initialValue);
					Symbol initialValueSymbolEntry = Misc.getSymbolEntry("initialValue", functionDefinitionBody);
					Declaration initialValueSymbolDeclaration = (Declaration)initialValueSymbolEntry.getDeclaringNode();
					NodeReplacer.replaceNodes(initialValueSymbolDeclaration, initialCS);
					//Remove Scopes from Function Body
					functionDefinitionBody.getInfo().removeExtraScopes();
					//Add Post-Declaration String
					handleCallStatement(functionName, reductionVariableOriginalSymbolName, reductionVariableModifiedSymbolName,reductionFunction);
				}
			}
		}
	}

	static int indexFunction(FunctionDefinition funcDefn) {
		int i = -1;
		for (Node n : Program.getRoot().getF0().getNodes()) {
			i++;
			if (n instanceof ElementsOfTranslation) {
				ElementsOfTranslation element = (ElementsOfTranslation) n;
				Node elem1 = element.getF0().getChoice();
				if (elem1 instanceof ExternalDeclaration) {
					if (((ExternalDeclaration) elem1).getF0().getChoice() == funcDefn) {
						return i;
					}
				}
			}
		}
		return -1;
	}

	public static void processInitializer(Node node, Queue<String> data) {
		if (!(node instanceof ArrayInitializer)) {
			if (node instanceof AssignmentExpression)
				data.add(node.toString());
			return;
		}
		ArrayInitializer arrayInit = (ArrayInitializer) node;
		InitializerList initList = arrayInit.getF1();
		Node init1 = initList.getF0().getF0().getChoice();
		processInitializer(init1, data);
		NodeListOptional init2 = initList.getF1();
		if (init2.present()) {
			for (Node e : init2.getNodes()) {
				NodeSequence nSeq = (NodeSequence) e;
				Node nSeq1 = nSeq.getNodes().get(1);
				Node nSeq2 = ((Initializer) nSeq1).getF0().getChoice();
				processInitializer(nSeq2, data);
			}
		}
	}
	static HashMap<String,String> loopVariables = new HashMap<>();
	public static void populateSignalWaitCallInductionVariables() {
		for(FunctionDefinition functionDefinition: Misc.getInheritedEnclosee(Program.getRoot(),FunctionDefinition.class)) {
			for(CallStatement callStatement: Misc.getInheritedEnclosee(functionDefinition, CallStatement.class)) {
				String functionCalledName = callStatement.getInfo().getFunctionDesignator().toString();
				if(functionCalledName.equals("myWait")) {
					ForConstruct enclosingForConstruct = MUWOmpConverter.getEnclosingNodeFromCalledPaths(callStatement, ForConstruct.class);
					String loopVariable = enclosingForConstruct.getInfo().getCFGInfo().getInitExpression().getF0().getTokenImage();
					loopVariables.put(callStatement.toString(),loopVariable);
				} else if(functionCalledName.equals("mySignal")){
					ForConstruct enclosingForConstruct = MUWOmpConverter.getEnclosingNodeFromCalledPaths(callStatement, ForConstruct.class);
					String loopVariable = enclosingForConstruct.getInfo().getCFGInfo().getInitExpression().getF0().getTokenImage();
					loopVariables.put(callStatement.toString(),loopVariable);
				}else if(functionCalledName.equals("myWaitAll")) {
					ForConstruct enclosingForConstruct = MUWOmpConverter.getEnclosingNodeFromCalledPaths(callStatement, ForConstruct.class);
					String loopVariable = enclosingForConstruct.getInfo().getCFGInfo().getInitExpression().getF0().getTokenImage();
					loopVariables.put(callStatement.toString(),loopVariable);
				}else if(functionCalledName.equals("mySignalAll")) {
					ForConstruct enclosingForConstruct = MUWOmpConverter.getEnclosingNodeFromCalledPaths(callStatement, ForConstruct.class);
					String loopVariable = enclosingForConstruct.getInfo().getCFGInfo().getInitExpression().getF0().getTokenImage();
					loopVariables.put(callStatement.toString(),loopVariable);
				}else if(functionCalledName.equals("myWaitRed")) {
					ForConstruct enclosingForConstruct = MUWOmpConverter.getEnclosingNodeFromCalledPaths(callStatement, ForConstruct.class);
					String loopVariable = enclosingForConstruct.getInfo().getCFGInfo().getInitExpression().getF0().getTokenImage();
					loopVariables.put(callStatement.toString(),loopVariable);
				}else if(functionCalledName.equals("mySignalSend")) {
					ForConstruct enclosingForConstruct = MUWOmpConverter.getEnclosingNodeFromCalledPaths(callStatement, ForConstruct.class);
					String loopVariable = enclosingForConstruct.getInfo().getCFGInfo().getInitExpression().getF0().getTokenImage();
					loopVariables.put(callStatement.toString(),loopVariable);
				}else if(functionCalledName.equals("myWaitAllRed")) {
					ForConstruct enclosingForConstruct = MUWOmpConverter.getEnclosingNodeFromCalledPaths(callStatement, ForConstruct.class);
					String loopVariable = enclosingForConstruct.getInfo().getCFGInfo().getInitExpression().getF0().getTokenImage();
					loopVariables.put(callStatement.toString(),loopVariable);
				}else if(functionCalledName.equals("mySignalAllSend")) {
					ForConstruct enclosingForConstruct = MUWOmpConverter.getEnclosingNodeFromCalledPaths(callStatement, ForConstruct.class);
					String loopVariable = enclosingForConstruct.getInfo().getCFGInfo().getInitExpression().getF0().getTokenImage();
					loopVariables.put(callStatement.toString(),loopVariable);
				}else if(functionCalledName.equals("myReduceAll")) {
					ForConstruct enclosingForConstruct = MUWOmpConverter.getEnclosingNodeFromCalledPaths(callStatement, ForConstruct.class);
					String loopVariable = enclosingForConstruct.getInfo().getCFGInfo().getInitExpression().getF0().getTokenImage();
					loopVariables.put(callStatement.toString(), loopVariable);
				}
			}
		}
	}

	public static String generateIndex(ArrayList<Integer> dims, ArrayList<Integer> indices) {
		String index = "";
		// Create Index
		for (int i = 0; i < indices.size(); i++) {
			index = index + "[" + indices.get(i) + "]";
		}
		// Update Index
		for (int i = indices.size() - 1; i >= 0; i--) {
			int idx = indices.get(i);
			int mDim = dims.get(i);
			if (idx == mDim - 1) {
				idx = (idx + 1) % mDim;
				indices.set(i, idx);
				continue;
			} else {
				idx = (idx + 1) % mDim;
				indices.set(i, idx);
				break;
			}
		}
		return index;
	}

	public static Node myObtainRenamedNode(Node node, HashMap<String, String> renameMapper) {
		Node unit = BasicTransform.myObtainRenamedNode(node, renameMapper);
		return unit;
	}

	@SuppressWarnings("unchecked")
	public static <T extends Node> T getEnclosingNodeFromCalledPaths(Node node, Class<T> className) {
		for (Node n : node.getInfo().getCFGNestingNonLeafNodes()) {
			if (n.getClass() == className) {
				return (T) n;
			}
		}
		return null;
	}
}