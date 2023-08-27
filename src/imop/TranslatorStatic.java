package imop;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.Set;
import java.util.stream.Collectors;
import imop.ast.node.external.ArrayInitializer;
import imop.ast.node.external.BreakStatement;
import imop.ast.node.external.CompoundStatement;
import imop.ast.node.external.Declaration;
import imop.ast.node.external.DoStatement;
import imop.ast.node.external.ElementsOfTranslation;
import imop.ast.node.external.Expression;
import imop.ast.node.external.ExternalDeclaration;
import imop.ast.node.external.ForConstruct;
import imop.ast.node.external.ForStatement;
import imop.ast.node.external.FunctionDefinition;
import imop.ast.node.external.IfStatement;
import imop.ast.node.external.Initializer;
import imop.ast.node.external.Node;
import imop.ast.node.external.NodeOptional;
import imop.ast.node.external.ParallelConstruct;
import imop.ast.node.external.ParameterDeclaration;
import imop.ast.node.external.ReturnStatement;
import imop.ast.node.external.ScheduleKind;
import imop.ast.node.external.SingleConstruct;
import imop.ast.node.external.Statement;
import imop.ast.node.external.SwitchStatement;
import imop.ast.node.external.TranslationUnit;
import imop.ast.node.external.UniqueForClauseSchedule;
import imop.ast.node.external.WhileStatement;
import imop.ast.node.internal.CallStatement;
import imop.ast.node.internal.DummyFlushDirective;
import imop.ast.node.internal.PostCallNode;
import imop.ast.node.internal.SimplePrimaryExpression;
import imop.lib.analysis.Assignment;
import imop.lib.analysis.flowanalysis.Cell;
import imop.lib.analysis.flowanalysis.FreeVariable;
import imop.lib.analysis.flowanalysis.Symbol;
import imop.lib.analysis.typeSystem.ArrayType;
import imop.lib.analysis.typeSystem.FunctionType;
import imop.lib.analysis.typeSystem.Type;
import imop.lib.builder.Builder;
import imop.lib.cfg.CFGLinkFinder;
import imop.lib.cfg.link.node.CompoundElementLink;
import imop.lib.transform.simplify.Normalization;
import imop.lib.transform.updater.InsertImmediatePredecessor;
import imop.lib.transform.updater.InsertImmediateSuccessor;
import imop.lib.transform.updater.NodeRemover;
import imop.lib.transform.updater.NodeReplacer;
import imop.lib.util.CellSet;
import imop.lib.util.Misc;
import imop.parser.FrontEnd;
import imop.parser.Program;

public class TranslatorStatic {
	HashMap<String, FunctionDefinition> analyzedFunctions = new HashMap<>();
	HashMap<ForConstruct, String> closureEnvironmentMap = new HashMap<ForConstruct, String>();
	static String closureVarName = null;
	static String waitClosureVarName = null;
	static ArrayList<String> UDFs = new ArrayList<>();
	HashMap<String, String> functionEnvironments = new HashMap<>();
	List<FunctionDefinition> toBeDeletedFunctions = new ArrayList<>();
	List<FunctionDefinition> envCreatedFunctions = new ArrayList<>();
	static HashMap<String, String> internalEnvironmentTagNameMapper = new HashMap<>();
	static HashMap<String, String> internalEnvironmentVarNameMapper = new HashMap<>();
	HashMap<String, String> internalEnvironmentHeaderMapper = new HashMap<>();
	static HashMap<String, String> internalEnvironmentCastMapper = new HashMap<>();
	static String internalEnvironmentFCTagName;
	static String internalEnvironmentFCVarName;
	static String internalEnvironmentFCCast;
	ArrayList<String> masterEnvironmentFields = new ArrayList<>();
	HashSet<String> translatedFunctions = new HashSet<>();
	String returnTypeName = null;
	Queue<FunctionDefinition> workList = new LinkedList<>();
	HashSet<FunctionDefinition> madeEnvironments = new HashSet<>();
	HashMap<String,String> functionNameMapper = new HashMap<>();
	HashSet<String> internalEnvironmentDeclarations = new HashSet<>();


	void addCallStatement(CallStatement callStmt) {
		List<FunctionDefinition> calledDefinitions = callStmt.getInfo().getCalledDefinitions();
		String functionName = callStmt.getInfo().getFunctionDesignator().toString();
		if(calledDefinitions.isEmpty()) {
			return;
		}else if(functionName.startsWith("mWaitAll")) {
			return;
		}else if(internalEnvironmentTagNameMapper.containsKey(functionName)){
			return;
		}else {
			FunctionDefinition calledDefinition = callStmt.getInfo().getCalledDefinitions().get(0);
			CompoundStatement calledDefinitionBody = calledDefinition.getInfo().getCFGInfo().getBody();
			List<Node> calledDefinitionBodyElements = calledDefinitionBody.getInfo().getCFGInfo().getElementList();
			boolean createEnvironment = true;
			if(calledDefinitionBodyElements.size()==1){
				Node calledDefinitionBodyElement = calledDefinitionBodyElements.get(0);
				String calledDefinitionBodyElementString = calledDefinitionBodyElement.toString();
				if(calledDefinitionBodyElementString.equals(";")) {
					createEnvironment = false;
					Statement replaceStatement = FrontEnd.parseAndNormalize(";",Statement.class);
					NodeReplacer.replaceNodes(callStmt, replaceStatement);
					removeFunction(calledDefinition);
				}
			}
			if(createEnvironment) {
				String internalEnvironmentVarName = Builder.getNewTempName("internal_v");
				String internalEnvironmentTagName = Builder.getNewTempName("internal_t");
				String internalEnvironmentHeader = "struct "+internalEnvironmentTagName; 
				String internalEnvironmentCast = "struct "+internalEnvironmentTagName+" *";
				internalEnvironmentTagNameMapper.put(functionName,internalEnvironmentTagName);
				internalEnvironmentVarNameMapper.put(functionName,internalEnvironmentVarName);
				internalEnvironmentHeaderMapper.put(functionName,internalEnvironmentHeader);
				internalEnvironmentCastMapper.put(functionName,internalEnvironmentCast);
				masterEnvironmentFields.add(internalEnvironmentHeader+" *"+internalEnvironmentVarName+";");
			}
		}
		FunctionDefinition functionDefinition = calledDefinitions.get(0);
		CompoundStatement compoundStatement = functionDefinition.getInfo().getCFGInfo().getBody();
		for(CallStatement callStatement: Misc.getInheritedEnclosee(compoundStatement, CallStatement.class)) {
			addCallStatement(callStatement);
		}
	}
	void captureNamesAndDeclareMasterEnvironment(ForConstruct forConstruct) {
		CompoundStatement compoundStatement = (CompoundStatement) forConstruct.getInfo().getCFGInfo().getBody();
		for(CallStatement callStatement: Misc.getInheritedEnclosee(compoundStatement,CallStatement.class)) {
			addCallStatement(callStatement);
		}
		//Build Master Environment Structure
		String masterEnvironmentStructure = "struct master_env{\n" + String.join("\n", masterEnvironmentFields)+"\n};";
		Builder.addDeclarationToGlobals(MUWOmpConverterStatic.indexFunction(Program.getRoot().getInfo().getMainFunction()), 
										FrontEnd.parseAndNormalize(masterEnvironmentStructure,Declaration.class));
	}

	static void removeFunction(FunctionDefinition functionDefinition) {
		TranslationUnit root = Program.getRoot();
		List<Node> nodes = root.getF0().getNodes();
		String functionToDelete = functionDefinition.getInfo().getFunctionName();
		for (int i = 0; i < nodes.size(); i++) {
			Node node = nodes.get(i);
			ElementsOfTranslation element = (ElementsOfTranslation) node;
			Node node1 = element.getF0().getChoice();
			if (node1 instanceof ExternalDeclaration) {
				Node node2 = ((ExternalDeclaration) node1).getF0().getChoice();
				if (node2 instanceof Declaration) {
					Declaration decl = (Declaration) node2;
					List<String> decls = decl.getInfo().getIDNameList();
					if (decls.size() == 1) {
						String declStr = decls.get(0);
						if (declStr.equals(functionToDelete)) {
							Builder.removeDeclarationFromGlobals(decl);
						}
					}
				} else if (node2 instanceof FunctionDefinition) {
					FunctionDefinition func = (FunctionDefinition) node2;
					if (func.getInfo().getFunctionName().equals(functionToDelete)) {
						root.getF0().removeNode(node);
					}
				}
			}
		}
	}

	public static String buildContinuationString() {
//		String continuation = "if(" + waitClosureVarName + "==0){\n" + closureVarName + "->typeClosure = NORMAL;\n"
//				+ closureVarName + "->fptr(" + closureVarName + ");\n" + "}\n" + "else{\n" + closureVarName
//				+ "->typeClosure = WAIT;\n" + closureVarName + "->waitClosure = " + waitClosureVarName + ";\n"
//				+ "enqueueClosure(globalWorklist," + closureVarName + ");\n" + "}\n";
		String continuation = "if(" + waitClosureVarName + "==0){\n"
				+ closureVarName + "->typeClosure = NORMAL;\n"
				+ closureVarName + "->fptr(" + closureVarName + ");\n"
				+ "}\nelse{\n" + closureVarName + "->typeClosure=WAIT;\n" + closureVarName + "->waitClosure = " + waitClosureVarName + ";\n"
				+ closureVarName + "->waitClosure->waitFunction("+closureVarName+");\n}\n";
				
		return continuation;
	}

	public FunctionDefinition createClosureFunction(CompoundStatement compoundStatement, String functionName) {
		String functionHeader = "void " + functionName + "(struct Clsr *" + closureVarName + ")";
		String functionSignature = functionHeader + ";";
		// Adding Declaration
		Builder.addDeclarationToGlobals(MUWOmpConverterStatic.indexFunction(Program.getRoot().getInfo().getMainFunction()),
				FrontEnd.parseAndNormalize(functionSignature, Declaration.class));
		String functionBody = compoundStatement.toString();
		FunctionDefinition functionDefinitionNode = FrontEnd.parseAndNormalize(functionHeader + functionBody,
				FunctionDefinition.class);
		Builder.addFunctionToGlobal(functionDefinitionNode);
		functionDefinitionNode.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
		return functionDefinitionNode;
	}

	private void translateFunction(FunctionDefinition functionDefinition) {
		String functionName = functionDefinition.getInfo().getFunctionName();
		CompoundStatement functionDefinitionBody = functionDefinition.getInfo().getCFGInfo().getBody();
		ArrayList<String> chunk = new ArrayList<>();
		List<Node> functionDefinitionBodyElements = functionDefinitionBody.getInfo().getCFGInfo().getElementList();
		for (int i = functionDefinitionBodyElements.size() - 1; i >= 0; i--) {
			Node element = functionDefinitionBodyElements.get(i);
			if (element instanceof Declaration) {
				chunk.add(0, element.toString());
			} else {
				if (element instanceof CallStatement) {
					chunk = processCallStatement(functionName, chunk, element);
				} else if (element instanceof IfStatement) {
					IfStatement ifStatement = (IfStatement) element;
					boolean analysisRequired = analyseIfStatement(ifStatement);
					if(analysisRequired) {
						CompoundStatement thenBody = (CompoundStatement) ifStatement.getInfo().getCFGInfo().getThenBody();
						CompoundStatement elseBody = (CompoundStatement) ifStatement.getInfo().getCFGInfo().getElseBody();
						if(elseBody!=null) {
							List<Node> thenBodyElements = thenBody.getInfo().getCFGInfo().getElementList();
							List<Node> elseBodyElements = elseBody.getInfo().getCFGInfo().getElementList();
							ArrayList<String> newThenBodyList = new ArrayList<>();
							ArrayList<String> newElseBodyList = new ArrayList<>();
							boolean elseBodyRequiredReplacement = true;
							if(elseBodyElements.size() == 1) {
								if(elseBodyElements.get(0).toString().equals(";")) {
									Statement statement = (Statement)elseBodyElements.get(0);
									chunkEmptyAdd(functionName,newElseBodyList);
									elseBodyRequiredReplacement = false;
								}
							}
							int j;
							for (j = 0; j < thenBodyElements.size() - 1; j++) {
								newThenBodyList.add(thenBodyElements.get(j).toString());
							}
							CallStatement thenBodyCallStatement = (CallStatement) thenBodyElements.get(j);
							String continuationFunctionBody = null;
							if (!chunk.isEmpty()) {
								continuationFunctionBody = "{\n" + String.join("\n", chunk) + "}\n";
							}
							if(elseBodyRequiredReplacement) {
								for (j = 0; j < elseBodyElements.size() - 1; j++) {
									newElseBodyList.add(elseBodyElements.get(j).toString());
								}
								CallStatement elseBodyCallStatement = (CallStatement) elseBodyElements.get(j);
								newElseBodyList
								.addAll(processIfStatement(functionName, continuationFunctionBody, elseBodyCallStatement));
							}
							newThenBodyList
									.addAll(processIfStatement(functionName, continuationFunctionBody, thenBodyCallStatement));
							String newThenBody = "{\n" + String.join("\n", newThenBodyList) + "}\n";
							String newElseBody = "{\n" + String.join("\n", newElseBodyList) + "}\n";
							CompoundStatement newThenBodyNode = FrontEnd.parseAndNormalize(newThenBody,
									CompoundStatement.class);
							CompoundStatement newElseBodyNode = FrontEnd.parseAndNormalize(newElseBody,
									CompoundStatement.class);
							ifStatement.getInfo().getCFGInfo().setThenBody(newThenBodyNode);
							ifStatement.getInfo().getCFGInfo().setElseBody(newElseBodyNode);
							chunk = new ArrayList<>();
							chunk.add(0, element.toString());
						}else {
							chunk.add(0, element.toString());
						}
					}else {
						chunk.add(0,element.toString());
					}
				}else if(element instanceof SwitchStatement){
					SwitchStatement switchStatement = (SwitchStatement)element;
					if(!chunk.isEmpty()) {
						String continuationFunctionBodyString = "{\n"+String.join("\n", chunk)+"}\n";
						CompoundStatement continuationFunctionBody = FrontEnd.parseAndNormalize(continuationFunctionBodyString, CompoundStatement.class);
						FunctionDefinition continuationFunction = createClosureFunction(continuationFunctionBody, Builder.getNewTempName("clsr"));
						continuationFunction.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
						String continuationFunctionName = continuationFunction.getInfo().getFunctionName();
						for(Statement statement: switchStatement.getInfo().getRelevantCFGStatements()) {
							String lhs, rhs;
							CompoundStatement compoundStatement = (CompoundStatement)statement;
							List<Node> elements = compoundStatement.getInfo().getCFGInfo().getElementList();
							int size = elements.size();
							CallStatement caseCallStatement = null;
							if(elements.get(size-1) instanceof ReturnStatement) {
								caseCallStatement = (CallStatement)elements.get(size-2);
							}else {
								caseCallStatement = (CallStatement)elements.get(size-1);
							}
							String functionCalledName = caseCallStatement.getInfo().getFunctionDesignator().toString();
							String calledFunctionEnvironmentVarName = internalEnvironmentVarNameMapper.get(functionCalledName);
							lhs = closureVarName+"->environment->"+calledFunctionEnvironmentVarName+"->continuation";
							rhs = "&"+continuationFunctionName+";";
							String closureFunctionAssignment = lhs + " = " + rhs;
							Statement closureFunctionAssignmentNode = FrontEnd.parseAndNormalize(closureFunctionAssignment,Statement.class);
							InsertImmediatePredecessor.insert(caseCallStatement, closureFunctionAssignmentNode);
							if (!translatedFunctions.contains(functionCalledName)) {
								FunctionDefinition calledDefinition = caseCallStatement.getInfo().getCalledDefinitions().get(0);
								translatedFunctions.add(functionCalledName);
								workList.add(calledDefinition);
							}
						}
						chunk = new ArrayList<>();
					}else {
						String callerFunctionEnvironmentVarName = internalEnvironmentVarNameMapper.get(functionName);
						for(Statement statement: switchStatement.getInfo().getRelevantCFGStatements()) {
							String lhs, rhs;
							CompoundStatement compoundStatement = (CompoundStatement)statement;
							List<Node> elements = compoundStatement.getInfo().getCFGInfo().getElementList();
							int size = elements.size();
							CallStatement caseCallStatement = null;
							if(elements.get(size-1) instanceof ReturnStatement) {
								caseCallStatement = (CallStatement)elements.get(size-2);
							}else {
								caseCallStatement = (CallStatement)elements.get(size-1);
							}
							String functionCalledName = caseCallStatement.getInfo().getFunctionDesignator().toString();
							String calledFunctionEnvironmentVarName = internalEnvironmentVarNameMapper.get(functionCalledName);
							lhs = closureVarName + "->environment->"+calledFunctionEnvironmentVarName+"->continuation";
							rhs = closureVarName + "->environment->"+callerFunctionEnvironmentVarName+"->continuation;";
							String closureFunctionAssignment = lhs + " = " + rhs;
							Statement closureFunctionAssignmentNode = FrontEnd.parseAndNormalize(closureFunctionAssignment,Statement.class);
							InsertImmediatePredecessor.insert(caseCallStatement, closureFunctionAssignmentNode);
							if (!translatedFunctions.contains(functionCalledName)) {
								FunctionDefinition calledDefinition = caseCallStatement.getInfo().getCalledDefinitions().get(0);
								translatedFunctions.add(functionCalledName);
								workList.add(calledDefinition);
							}
						}
					}
					chunk.add(0,element.toString());
				}else {
					if (chunk.isEmpty()) {
						chunkEmptyAdd(functionName, chunk);
					}
					chunk.add(0, element.toString());
				}
			}
		}
		String newFunctionBody = "{\n" + String.join("\n", chunk) + "}\n";
		CompoundStatement newFunctionCompoundStatement = FrontEnd.parseAndNormalize(newFunctionBody,
				CompoundStatement.class);
		if (!translatedFunctions.contains(functionName)) {
			translatedFunctions.add(functionName);
		}
		functionDefinition.getInfo().getCFGInfo().setBody(newFunctionCompoundStatement);
	}

	public static boolean checkBreakStatement(CompoundStatement compoundStatement) {
		for(BreakStatement breakStatement:Misc.getInheritedEnclosee(compoundStatement, BreakStatement.class)) {
			return true;
		}
		return false;
	}

	public static String convertCaseBodyToFunction(String functionBody,ArrayList<String> formalParameterList, ArrayList<String> actualParameterList) {
		String functionName = Builder.getNewTempName("case");
		String formalParameters = String.join(",", formalParameterList);
		String actualParameters = String.join(",", actualParameterList);
		String functionHeader = "void "+functionName + "("+formalParameters+")";
		String functionSignature = functionHeader + ";";
		String functionDefinitionString = functionHeader + functionBody;
		Builder.addDeclarationToGlobals(MUWOmpConverterStatic.indexFunction(Program.getRoot().getInfo().getMainFunction()),
				FrontEnd.parseAndNormalize(functionSignature,Declaration.class));
		FunctionDefinition functionDefinitionNode = FrontEnd.parseAndNormalize(functionDefinitionString,FunctionDefinition.class);
		Builder.addFunctionToGlobal(functionDefinitionNode);
		String callStatement = functionName+"("+actualParameters+");";
		return callStatement;
	}

	public static SwitchStatement convertSwitchStatementToFunction(SwitchStatement switchStatement,ArrayList<String> caseHeaders, ArrayList<CompoundStatement> caseCompoundStatements) {
		String newSwitchStatement = "switch("+switchStatement.getInfo().getCFGInfo().getPredicate().toString()+"){\n";
		CompoundStatement switchStatementBody = (CompoundStatement)switchStatement.getInfo().getCFGInfo().getBody();
		CellSet usedCells = switchStatementBody.getInfo().getUsedCells();
		CellSet exclusiveCells = switchStatementBody.getInfo().getAllCellsAtNodeExclusively();
		CellSet intersectionCells = Misc.setIntersection(usedCells, exclusiveCells);
		ArrayList<Symbol> usedSymbols = new ArrayList<>();
		for(Cell intersectionCell:intersectionCells) {
			if(intersectionCell instanceof Symbol) {
				Symbol symbol = (Symbol)intersectionCell;
				if(symbol.getDefiningScope() instanceof TranslationUnit) {
					continue;
				}
				if(symbol.getType() instanceof FunctionType) {
					continue;
				}
				usedSymbols.add(symbol);
			}
		}
		ArrayList<String> formalParameterList = new ArrayList<>();
		ArrayList<String> actualParameterList = new ArrayList<>();
		for(Symbol symbol: usedSymbols) {
			Declaration declaration = (Declaration) symbol.getDeclaringNode();
			Declaration toBePutDeclaration = null;
			if(declaration.getInfo().hasInitializer()) {
				toBePutDeclaration = symbol.getType().getExactDeclarationWithoutInit(symbol.getName());
			}else {
				toBePutDeclaration = symbol.getType().getDeclaration(symbol.getName());
			}
			String toBePutDeclarationString = toBePutDeclaration.toString();
			String formalParameter = toBePutDeclarationString.substring(0,toBePutDeclarationString.lastIndexOf(";"));
			formalParameterList.add(formalParameter);
			actualParameterList.add(symbol.getName());
		}
		for(int i=0;i<caseHeaders.size();i++) {
			String caseHeader = caseHeaders.get(i);
			newSwitchStatement += caseHeader + "{\n";
			CompoundStatement caseCompoundStatement = caseCompoundStatements.get(i);
			List<Node> caseCompoundStatementElements = caseCompoundStatement.getInfo().getCFGInfo().getElementList();
			boolean containsBreak = checkBreakStatement(caseCompoundStatement);
			if(containsBreak) {
				String functionBodyCaseStatement = "{\n"+caseCompoundStatementElements.subList(0, caseCompoundStatementElements.size()-1).stream().map(Node::toString).collect(Collectors.joining("\n"))+"}\n";
				String callStatement = convertCaseBodyToFunction(functionBodyCaseStatement,formalParameterList,actualParameterList);
				newSwitchStatement += callStatement;
				newSwitchStatement += "return;\n}";
			}else {
				String functionBodyCaseStatement = "{\n"+caseCompoundStatementElements.stream().map(Node::toString).collect(Collectors.joining("\n"))+"}\n";
				String callStatement = convertCaseBodyToFunction(functionBodyCaseStatement,formalParameterList,actualParameterList);
				newSwitchStatement += callStatement;
				newSwitchStatement += "\n}";
			}
		}
		newSwitchStatement += "\n}\n";
		SwitchStatement newSwitchStatementNode = FrontEnd.parseAndNormalize(newSwitchStatement,SwitchStatement.class);
		return newSwitchStatementNode;
	}

	public static SwitchStatement handleSwitchStatement(SwitchStatement switchStatement) {
		ArrayList<String> caseHeaders = new ArrayList<>();
		ArrayList<CompoundStatement> cases = extractIndividualCaseStatements(switchStatement,caseHeaders);
		SwitchStatement newSwitchStatement = convertSwitchStatementToFunction(switchStatement,caseHeaders,cases);
		return newSwitchStatement;
	}

	private static ArrayList<CompoundStatement> extractIndividualCaseStatements(SwitchStatement switchStatement,ArrayList<String> caseHeaders) {
		ArrayList<CompoundStatement> caseCompoundStatements = new ArrayList<>();
		List<Statement> switchStatementCaseHeader = switchStatement.getInfo().getRelevantCFGStatements();
		CompoundStatement switchStatementBody = (CompoundStatement)switchStatement.getInfo().getCFGInfo().getBody();
		List<Node> switchStatementBodyElements = switchStatementBody.getInfo().getCFGInfo().getElementList();
		int i = 0;
		for(i = 0;i < switchStatementCaseHeader.size()-1;i++) {
			int i0 = switchStatementBodyElements.indexOf(switchStatementCaseHeader.get(i));
			int i1 = switchStatementBodyElements.indexOf(switchStatementCaseHeader.get(i+1));
			List<Node> caseStatements = switchStatementBodyElements.subList(i0, i1);
			String caseCompoundStatementString = caseStatements.stream().map(Node::toString).collect(Collectors.joining("\n"));
			int indexLastColon = caseCompoundStatementString.lastIndexOf(":");
			String caseHeader = caseCompoundStatementString.substring(0,indexLastColon + 1);
			caseHeaders.add(caseHeader);
			caseCompoundStatementString = "{\n" + caseCompoundStatementString.substring(indexLastColon + 1) + "\n}";
			CompoundStatement caseCompoundStatementNode = FrontEnd.parseAndNormalize(caseCompoundStatementString,CompoundStatement.class);
			caseCompoundStatements.add(caseCompoundStatementNode);
		}
		int idxLastCase = switchStatementBodyElements.indexOf(switchStatementCaseHeader.get(i));
		List<Node> caseStatements = switchStatementBodyElements.subList(idxLastCase, switchStatementBodyElements.size());
		String caseCompoundStatementString = caseStatements.stream().map(Node::toString).collect(Collectors.joining("\n"));
		int indexLastColon = caseCompoundStatementString.lastIndexOf(":");
		String caseHeader = caseCompoundStatementString.substring(0,indexLastColon + 1);
		caseHeaders.add(caseHeader);
		caseCompoundStatementString = "{\n" + caseCompoundStatementString.substring(indexLastColon + 1) + "\n}";
		CompoundStatement caseCompoundStatementNode = FrontEnd.parseAndNormalize(caseCompoundStatementString,CompoundStatement.class);
		caseCompoundStatements.add(caseCompoundStatementNode);
		return caseCompoundStatements;
	}
	private ArrayList<String> processCallStatement(String functionName, ArrayList<String> chunk, Node element) {
		CallStatement callStatement = (CallStatement) element;
		List<FunctionDefinition> calledDefinitions = callStatement.getInfo().getCalledDefinitions();
		String functionCalledName = callStatement.getInfo().getFunctionDesignator().toString();
		if (calledDefinitions.isEmpty()) {
			if (chunk.isEmpty()) {
				chunkEmptyAdd(functionName, chunk);
			}
			chunk.add(0, element.toString());
		} else {
			boolean chunkFound = false;
			FunctionDefinition continuationFunction = null;
			String continuationFunctionBodyString = null;
			if (!chunk.isEmpty()) {
				chunkFound = true;
				continuationFunctionBodyString = "{\n" + String.join("\n", chunk) + "}\n";
				chunk = new ArrayList<>();
			}
			FunctionDefinition calledDefinition = calledDefinitions.get(0);
			if (chunkFound) {
				CompoundStatement continuationFunctionBody = FrontEnd.parseAndNormalize(continuationFunctionBodyString,
						CompoundStatement.class);
				continuationFunction = createClosureFunction(continuationFunctionBody, Builder.getNewTempName("clsr"));
				continuationFunction.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
				String continuationFunctionName = continuationFunction.getInfo().getFunctionName();
				if (functionCalledName.startsWith("mWaitAll")) {
					String assignClosureFunction = closureVarName + "->fptr = &" + continuationFunctionName + ";";
					chunk.add(0, element.toString());
					chunk.add(0, assignClosureFunction);
				} else {
					String functionEnvironmentVarName = internalEnvironmentVarNameMapper.get(functionCalledName);
					String assignClosureFunction = closureVarName+"->environment->"+functionEnvironmentVarName+"->continuation = &"+continuationFunctionName+";";
					chunk.add(0, element.toString());
					chunk.add(0, assignClosureFunction);
					if (!translatedFunctions.contains(functionCalledName)) {
						translatedFunctions.add(functionCalledName);
						workList.add(calledDefinition);
					}
				}
			} else {
				String callerFunctionEnvironmentVarName = internalEnvironmentVarNameMapper.get(functionName);
				String calledFunctionEnvironmentVarName;
				String lhs, rhs;
				if (functionCalledName.startsWith("mWaitAll")) {
					calledFunctionEnvironmentVarName = internalEnvironmentVarNameMapper.get(functionName);
					lhs = closureVarName + "->fptr";
					rhs = closureVarName+"->environment->"+calledFunctionEnvironmentVarName+"->continuation";
				} else {
					calledFunctionEnvironmentVarName = internalEnvironmentVarNameMapper.get(functionCalledName);
					lhs = closureVarName + "->environment->"+calledFunctionEnvironmentVarName+"->continuation";
					rhs = closureVarName + "->environment->"+callerFunctionEnvironmentVarName+"->continuation;";
					if (!translatedFunctions.contains(functionCalledName)) {
						translatedFunctions.add(functionCalledName);
						workList.add(calledDefinition);
					}
				}
				chunk.add(0, element.toString());
				chunk.add(0, lhs + "=" + rhs);
			}
		}
		return chunk;
	}

	private void chunkEmptyAdd(String functionName, ArrayList<String> chunk) {
		String functionEnvironmentVarName = internalEnvironmentVarNameMapper.get(functionName);
		String functionAssignment = closureVarName + "->fptr = "+closureVarName+"->environment->"+functionEnvironmentVarName+"->continuation;";
		String callContinuation = closureVarName + "->fptr(" + closureVarName + ");";
		chunk.add(0, callContinuation);
		chunk.add(0, functionAssignment);
	}

	private ArrayList<String> processIfStatement(String functionName, String chunk, Node element) {
		CallStatement callStatement = (CallStatement) element;
		ArrayList<String> newChunk = new ArrayList<>();
		List<FunctionDefinition> calledDefinitions = callStatement.getInfo().getCalledDefinitions();
		String functionCalledName = callStatement.getInfo().getFunctionDesignator().toString();
		boolean chunkFound = false;
		FunctionDefinition continuationFunction = null;
		if (chunk != null) {
			chunkFound = true;
		}
		FunctionDefinition calledDefinition = calledDefinitions.get(0);
		if (chunkFound) {
			CompoundStatement continuationFunctionBody = FrontEnd.parseAndNormalize(chunk, CompoundStatement.class);
			continuationFunction = createClosureFunction(continuationFunctionBody, Builder.getNewTempName("clsr"));
			continuationFunction.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
			String continuationFunctionName = continuationFunction.getInfo().getFunctionName();
			String functionEnvironmentVarName = internalEnvironmentVarNameMapper.get(functionCalledName);
			String assignClosureFunction = closureVarName+"->environment->"+functionEnvironmentVarName+"->continuation = &"
					+ ""+continuationFunctionName+";";
			newChunk.add(0, element.toString());
			newChunk.add(0, assignClosureFunction);
		} else {
			String callerFunctionEnvironmentVarName = internalEnvironmentVarNameMapper.get(functionName);
			String calledFunctionEnvironmentVarName = internalEnvironmentVarNameMapper.get(functionCalledName);
			String lhs = closureVarName+"->environment->"+calledFunctionEnvironmentVarName+"->continuation";
			String rhs = closureVarName+"->environment->"+callerFunctionEnvironmentVarName+"->continuation;";
			String assignClosureFunction = lhs + "=" + rhs;
			newChunk.add(0, element.toString());
			newChunk.add(0, assignClosureFunction);
		}
		workList.add(calledDefinition);
		return newChunk;
	}

	private void beginTranslation() {
		while (!workList.isEmpty()) {
			FunctionDefinition functionDefinition = workList.poll();
			translateFunction(functionDefinition);
		}
	}

	public void translateForConstruct(ForConstruct forConstruct, String loopVariable,
			FunctionDefinition initialFunction) {
		makeEnvironment(initialFunction);
		workList.add(initialFunction);
		for (FunctionDefinition function : envCreatedFunctions) {
			removeFunction(function);
		}
		beginTranslation();
		for (FunctionDefinition function : toBeDeletedFunctions) {
			removeFunction(function);
		}
	}

	private FunctionDefinition buildEnvironmentForFunction(String callerFunctionName, CallStatement callStatement,
			ArrayList<String> newBody) {
		FunctionDefinition functionDefinition = callStatement.getInfo().getCalledDefinitions().get(0);
		ArrayList<String> internalEnvironmentDeclarations = new ArrayList<>();
		HashMap<String, String> renameMapper = new HashMap<>();
		Type functionReturnType = functionDefinition.getInfo().getReturnType();
		String functionReturnTypeString = functionReturnType.toString();
		String functionName = functionDefinition.getInfo().getFunctionName();
		String internalEnvironmentTagName = internalEnvironmentTagNameMapper.get(functionName);
		String internalEnvironmentVarName = internalEnvironmentVarNameMapper.get(functionName);
		String internalEnvironmentHeader = internalEnvironmentHeaderMapper.get(functionName);
		String internalEnvironmentCast = internalEnvironmentCastMapper.get(functionName);
		String newFunctionName = Builder.getNewTempName(functionName);
		if(functionNameMapper.containsKey(functionName)) {
			newFunctionName = functionNameMapper.get(functionName);
		}else {
			functionNameMapper.put(functionName, newFunctionName);
			internalEnvironmentTagNameMapper.put(newFunctionName,internalEnvironmentTagName);
			internalEnvironmentVarNameMapper.put(newFunctionName,internalEnvironmentVarName);
			internalEnvironmentHeaderMapper.put(newFunctionName,internalEnvironmentHeader);
			internalEnvironmentCastMapper.put(newFunctionName,internalEnvironmentCast);
		}
		if (!functionReturnTypeString.trim().equals("void")) {
			ArrayList<String> formalParameterList = new ArrayList<>();
			CompoundStatement functionBody = functionDefinition.getInfo().getCFGInfo().getBody();
			for (ReturnStatement returnStatement : Misc.getInheritedEnclosee(functionBody, ReturnStatement.class)) {
				if (returnStatement.getF1().present()) {
					Expression expression = (Expression) returnStatement.getF1().getNode();
					String assignmentStatement = "*" + returnTypeName + "=" + expression + ";";
					NodeReplacer.replaceNodes(returnStatement,
							FrontEnd.parseAndNormalize(assignmentStatement, Statement.class));
				}
			}
			for (ParameterDeclaration formalParameterDeclaration : functionDefinition.getInfo().getCFGInfo()
					.getParameterDeclarationList()) {
				formalParameterList.add(formalParameterDeclaration.toString());
			}
			formalParameterList.add(functionReturnTypeString.trim() + "*" + returnTypeName);
			String formalParameters = String.join(",", formalParameterList);
			String newFunctionDefinition = functionReturnTypeString + functionDefinition.getInfo().getFunctionName()
					+ "(" + formalParameters + ")\n" + functionDefinition.getInfo().getCFGInfo().getBody() + "\n";
			Declaration newFunctionSignatureNode = FrontEnd.parseAndNormalize(
					"void " + functionDefinition.getInfo().getFunctionName() + "(" + formalParameters + ");",
					Declaration.class);
			removeFunction(functionDefinition);
			functionDefinition = FrontEnd.parseAndNormalize(newFunctionDefinition, FunctionDefinition.class);
			Builder.addDeclarationToGlobals(
					MUWOmpConverterStatic.indexFunction(Program.getRoot().getInfo().getMainFunction()),
					newFunctionSignatureNode);
			Builder.addFunctionToGlobal(functionDefinition);
		}
		List<SimplePrimaryExpression> actualArguments = callStatement.getInfo().getArgumentList();
		ArrayList<String> actualArgumentList = new ArrayList<>();
		boolean closureVarPresent = false;
		for (SimplePrimaryExpression actualArgument : actualArguments) {
			String actualArgumentName = actualArgument.toString();
			if (actualArgumentName.equals(closureVarName)) {
				closureVarPresent = true;
			}
			actualArgumentList.add(actualArgumentName);
		}
		if (!closureVarPresent) {
			actualArgumentList.add(closureVarName);
		}
		String actualParameters = String.join(",", actualArgumentList);
		String callStatementNew = newFunctionName + "(" + actualParameters + ");";
		newBody.add(callStatementNew);
		if (!analyzedFunctions.containsKey(newFunctionName)) {
			ArrayList<String> statements = new ArrayList<>();
			statements.addAll(addFormalParameters(functionDefinition, internalEnvironmentVarName,
					internalEnvironmentCast, renameMapper, internalEnvironmentDeclarations, callStatement));
			statements.addAll(renameStatements(functionDefinition.getInfo().getCFGInfo().getBody(),
					internalEnvironmentVarName, internalEnvironmentDeclarations, internalEnvironmentHeader, renameMapper));
			CompoundStatement newFunctionBody = FrontEnd
					.parseAndNormalize("{\n" + String.join("\n", statements) + "}\n", CompoundStatement.class);
			List<ParameterDeclaration> formalParameterDeclarations = functionDefinition.getInfo().getCFGInfo()
					.getParameterDeclarationList();
			ArrayList<String> formalParameterList = new ArrayList<>();
			boolean closureVarPresentFormal = false;
			for (ParameterDeclaration formalParameterDeclaration : formalParameterDeclarations) {
				String formalParameterDeclarationSymbolName = formalParameterDeclaration.getInfo().getDeclaredSymbol()
						.getName();
				if (formalParameterDeclarationSymbolName.equals(closureVarName)) {
					closureVarPresentFormal = true;
				}
				formalParameterList.add(formalParameterDeclaration.toString());
			}
			if (!closureVarPresentFormal) {
				formalParameterList.add("struct Clsr *" + closureVarName);
			}
			String formalParameters = String.join(",", formalParameterList);
			String functionDefinitionString = "void " + newFunctionName + "(" + formalParameters + ")"
					+ newFunctionBody.toString();
			String functionSignatureString = "void " + newFunctionName + "(" + formalParameters + ");";
			Declaration functionSignatureNode = FrontEnd.parseAndNormalize(functionSignatureString, Declaration.class);
			FunctionDefinition functionDefinitionNode = FrontEnd.parseAndNormalize(functionDefinitionString,
					FunctionDefinition.class);
			envCreatedFunctions.add(functionDefinition);
			Builder.addDeclarationToGlobals(
					MUWOmpConverterStatic.indexFunction(Program.getRoot().getInfo().getMainFunction()),
					functionSignatureNode);
			Builder.addFunctionToGlobal(functionDefinitionNode);
			functionDefinitionNode.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
			analyzedFunctions.put(newFunctionName, functionDefinitionNode);
			return functionDefinitionNode;
		} else {
			return analyzedFunctions.get(newFunctionName);
		}
	}

	private ArrayList<String> addFormalParameters(FunctionDefinition functionDefinition,
			String internalEnvironmentVarName, String internalEnvironmentCast, HashMap<String, String> renameMapper,
			ArrayList<String> internalEnvironmentDeclarations, CallStatement callStatement) {
		functionDefinition.getInfo().populateSymbolTable();
		List<ParameterDeclaration> formalParameterDeclarations = functionDefinition.getInfo().getCFGInfo()
				.getParameterDeclarationList();
		internalEnvironmentDeclarations.add("void (*continuation)(struct Clsr *);");
		ArrayList<String> initializers = new ArrayList<>();
		for (int i = 0; i < formalParameterDeclarations.size(); i++) {
			ParameterDeclaration formalParameterDeclaration = formalParameterDeclarations.get(i);
			Symbol symbol = formalParameterDeclaration.getInfo().getDeclaredSymbol();
			if (symbol == null)
				continue;
			internalEnvironmentDeclarations.add(formalParameterDeclaration.toString() + ";");
			String oldName = symbol.getName();
			String newName = closureVarName+"->environment->"+internalEnvironmentVarName+"->"+symbol.getName();
			renameMapper.put(oldName, newName);
			String lhs = closureVarName+"->environment->"+internalEnvironmentVarName+"->"+symbol.getName();
			String rhs = symbol.getName() + ";";
			initializers.add(lhs + "=" + rhs);
		}
		return initializers;
	}

	private void makeEnvironment(FunctionDefinition functionDefinition) {
		if(madeEnvironments.contains(functionDefinition)) {
			return;
		}else {
			madeEnvironments.add(functionDefinition);
		}
		CompoundStatement functionDefinitionBody = functionDefinition.getInfo().getCFGInfo().getBody();
		List<Node> elements = functionDefinitionBody.getInfo().getCFGInfo().getElementList();
		String functionName = functionDefinition.getInfo().getFunctionName();
		ArrayList<String> newBody = new ArrayList<>();
		for (Node element : elements) {
			if (element instanceof CallStatement) {
				CallStatement callStatement = (CallStatement) element;
				String functionCalledName = callStatement.getInfo().getFunctionDesignator().toString();
				List<FunctionDefinition> calledDefinitions = callStatement.getInfo().getCalledDefinitions();
				if (functionCalledName.startsWith("mWaitAll")
						|| calledDefinitions.isEmpty()) {
					newBody.add(element.toString());
				} else {
					FunctionDefinition newFunction = buildEnvironmentForFunction(functionName, callStatement, newBody);
					makeEnvironment(newFunction);
				}
			} else if (element instanceof IfStatement) {
				IfStatement ifStatement = (IfStatement) element;
				boolean environmentRequired = analyseIfStatement(ifStatement);
				if(environmentRequired) {
					CompoundStatement thenBody = (CompoundStatement) ifStatement.getInfo().getCFGInfo().getThenBody();
					CompoundStatement elseBody = (CompoundStatement) ifStatement.getInfo().getCFGInfo().getElseBody();
					if(elseBody == null) {
						newBody.add(element.toString());
						continue;
					}
					List<Node> thenBodyElements = thenBody.getInfo().getCFGInfo().getElementList();
					List<Node> elseBodyElements = elseBody.getInfo().getCFGInfo().getElementList();
					ArrayList<String> newThenBodyList = new ArrayList<>();
					ArrayList<String> newElseBodyList = new ArrayList<>();
					boolean elseBodyEnvironmentRequired = true;
					if(elseBodyElements.size()==1) {
						if(elseBodyElements.get(0).toString().equals(";")) {
						elseBodyEnvironmentRequired = false;
						}
					}
					int i;
					for (i = 0; i < thenBodyElements.size() - 1; i++) {
						newThenBodyList.add(thenBodyElements.get(i).toString());
					}
					CallStatement thenBodyCallStatement = (CallStatement) thenBodyElements.get(i);
					if(elseBodyEnvironmentRequired) {
						for (i = 0; i < elseBodyElements.size() - 1; i++) {
							newElseBodyList.add(elseBodyElements.get(i).toString());
						}
						CallStatement elseBodyCallStatement = (CallStatement) elseBodyElements.get(i);
						String elseBodyFunctionName = elseBodyCallStatement.getInfo().getFunctionDesignator().toString();
						FunctionDefinition elseBodyFunction = buildEnvironmentForFunction(elseBodyFunctionName,
								elseBodyCallStatement, newElseBodyList);
						String newElseBodyString = "{\n" + String.join("\n", newElseBodyList) + "}\n";
						CompoundStatement newElseBodyNode = FrontEnd.parseAndNormalize(newElseBodyString,
								CompoundStatement.class);
						ifStatement.getInfo().getCFGInfo().setElseBody(newElseBodyNode);
						makeEnvironment(elseBodyFunction);
					}
					String thenBodyFunctionName = thenBodyCallStatement.getInfo().getFunctionDesignator().toString();
					FunctionDefinition thenBodyFunction = buildEnvironmentForFunction(thenBodyFunctionName,
							thenBodyCallStatement, newThenBodyList);
					String newThenBodyString = "{\n" + String.join("\n", newThenBodyList) + "}\n";
					CompoundStatement newThenBodyNode = FrontEnd.parseAndNormalize(newThenBodyString,
							CompoundStatement.class);
					ifStatement.getInfo().getCFGInfo().setThenBody(newThenBodyNode);
					newBody.add(element.toString());
					makeEnvironment(thenBodyFunction);
				}else {
					newBody.add(element.toString());
				}
			} else if (element instanceof SwitchStatement){
				SwitchStatement switchStatement = (SwitchStatement)element;
				String newSwitchStatementString = "switch("+switchStatement.getInfo().getCFGInfo().getPredicate().toString() + "){\n";
				ArrayList<String> caseHeaders = new ArrayList<>();
				ArrayList<CompoundStatement> caseStatements = extractIndividualCaseStatements(switchStatement,caseHeaders);
				for(int i = 0;i<caseStatements.size();i++) {
					CompoundStatement caseStatement = caseStatements.get(i);
					newSwitchStatementString += caseHeaders.get(i) + "{\n";
					List<Node> caseStatementElements = caseStatement.getInfo().getCFGInfo().getElementList();
					ArrayList<String> caseStatementList = new ArrayList<>();
					int sizeCaseStatementElements = caseStatementElements.size();
					CallStatement caseCallStatement = null;
					if(caseStatementElements.get(sizeCaseStatementElements-1) instanceof ReturnStatement) {
						caseCallStatement = (CallStatement) caseStatementElements.get(sizeCaseStatementElements - 2);
					}else {
						caseCallStatement = (CallStatement) caseStatementElements.get(sizeCaseStatementElements - 1);
					}
					boolean containsReturnStatement = false;
					for(Node caseStatementElement:caseStatementElements) {
						if(caseStatementElement instanceof ReturnStatement){
							containsReturnStatement = true;
							continue;
						}
						if(caseStatementElement.equals(caseCallStatement)) {
							continue;
						}
						caseStatementList.add(caseStatementElement.toString());
					}
					String callerFunctionName = caseCallStatement.getInfo().getFunctionDesignator().toString();
					FunctionDefinition caseBodyFunction = buildEnvironmentForFunction(callerFunctionName,caseCallStatement,caseStatementList);
					if(containsReturnStatement) {
						caseStatementList.add("return;");
					}
					newSwitchStatementString += String.join("\n", caseStatementList)+"\n}\n";
					makeEnvironment(caseBodyFunction);
				}
				newSwitchStatementString += "}\n";
				newBody.add(newSwitchStatementString);
			} else {
				newBody.add(element.toString());
			}
		}
		CompoundStatement newFunctionBody = FrontEnd.parseAndNormalize("{\n" + String.join("\n", newBody) + "}\n",
				CompoundStatement.class);
		functionDefinition.getInfo().getCFGInfo().setBody(newFunctionBody);
	}

	public void translate() {

		returnTypeName = Builder.getNewTempName("return");
		for (FunctionDefinition functionDefinition : Misc.getInheritedEnclosee(Program.getRoot(),
				FunctionDefinition.class)) {
			functionDefinition.getInfo().populateSymbolTable();
			String functionName = functionDefinition.getInfo().getFunctionName();
			if (UDFs.contains(functionName)) {
				continue;
			}
			if (functionName.startsWith("mWaitAll")) {
				continue;
			}
			for(WhileStatement whileStatement: Misc.getInheritedPostOrderEnclosee(functionDefinition, WhileStatement.class)) {
				wrapWhileStatement(functionDefinition,whileStatement);
			}
			functionDefinition.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
		}
		for(FunctionDefinition functionDefinition:Misc.getInheritedEnclosee(Program.getRoot(),	FunctionDefinition.class)){
			functionDefinition.getInfo().populateSymbolTable();
			String functionName = functionDefinition.getInfo().getFunctionName();
			if (UDFs.contains(functionName)) {
				continue;
			}
			if (functionName.startsWith("mWaitAll")) {
				continue;
			}
			for(ForStatement forStatement: Misc.getInheritedPostOrderEnclosee(functionDefinition, ForStatement.class)) {
				wrapForStatement(functionDefinition,forStatement);
			}
			functionDefinition.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
		}
		for(FunctionDefinition functionDefinition:Misc.getInheritedEnclosee(Program.getRoot(),	FunctionDefinition.class)){
			functionDefinition.getInfo().populateSymbolTable();
			String functionName = functionDefinition.getInfo().getFunctionName();
			if (UDFs.contains(functionName)) {
				continue;
			}
			if (functionName.startsWith("mWaitAll")) {
				continue;
			}
			for(DoStatement doStatement: Misc.getInheritedPostOrderEnclosee(functionDefinition, DoStatement.class)) {
				wrapDoStatement(doStatement);
			}
			functionDefinition.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
		}
		for(FunctionDefinition functionDefinition:Misc.getInheritedEnclosee(Program.getRoot(),	FunctionDefinition.class)){
			functionDefinition.getInfo().populateSymbolTable();
			String functionName = functionDefinition.getInfo().getFunctionName();
			if (UDFs.contains(functionName)) {
				continue;
			}
			if (functionName.startsWith("mWaitAll")) {
				continue;
			}
			for(SwitchStatement switchStatement: Misc.getInheritedPostOrderEnclosee(functionDefinition, SwitchStatement.class)) {
				wrapSwitchStatement(switchStatement);
			}
			functionDefinition.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
		}
		for(FunctionDefinition functionDefinition:Misc.getInheritedEnclosee(Program.getRoot(),	FunctionDefinition.class)){
			String functionName = functionDefinition.getInfo().getFunctionName();
			functionDefinition.getInfo().populateSymbolTable();
			if (UDFs.contains(functionName)) {
				continue;
			}
			if (functionName.startsWith("mWaitAll")) {
				continue;
			}
			for (IfStatement ifStatement : Misc.getInheritedPostOrderEnclosee(functionDefinition, IfStatement.class)) {
				wrapIfStatement(functionDefinition,ifStatement);
			}
			functionDefinition.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
		}
		for(FunctionDefinition functionDefinition: Misc.getInheritedEnclosee(Program.getRoot(), FunctionDefinition.class)) {
			String functionName = functionDefinition.getInfo().getFunctionName();
			functionDefinition.getInfo().populateSymbolTable();
			if(UDFs.contains(functionName)) {
				continue;
			}
			if(functionName.startsWith("mWaitAll")) {
				continue;
			}
			for (ForConstruct forConstruct : Misc.getInheritedEnclosee(functionDefinition, ForConstruct.class)) {
				String loopVariable = forConstruct.getInfo().getCFGInfo().getInitExpression().getF0().getTokenImage();
				internalEnvironmentFCTagName = Builder.getNewTempName("internal_tf");
				internalEnvironmentFCVarName = Builder.getNewTempName("internal_vf");
				String internalEnvironmentFCHeader = "struct "+internalEnvironmentFCTagName+" *"+internalEnvironmentFCVarName+";";
				internalEnvironmentFCCast = "struct "+internalEnvironmentFCTagName+" *";
				masterEnvironmentFields.add(internalEnvironmentFCHeader);
				captureNamesAndDeclareMasterEnvironment(forConstruct);
				ParallelConstruct enclosingParallelConstruct = MUWOmpConverterStatic.getEnclosingNodeFromCalledPaths(forConstruct,
						ParallelConstruct.class);
				FunctionDefinition functionDefinition1 = convertOmpForBodyToFunction(forConstruct);
				internalEnvironmentVarNameMapper.put(functionDefinition1.getInfo().getFunctionName(), internalEnvironmentFCVarName);
				internalEnvironmentTagNameMapper.put(functionDefinition1.getInfo().getFunctionName(), internalEnvironmentFCTagName);
				internalEnvironmentHeaderMapper.put(functionDefinition1.getInfo().getFunctionName(), internalEnvironmentFCHeader);
				if (enclosingParallelConstruct != null) {
					ArrayList<String> privateAllocations = MUWOmpConverterStatic.initializersMapper
							.get(enclosingParallelConstruct);
					CompoundStatement privateAllocationNode = FrontEnd.parseAndNormalize(
							"{\n" + String.join("\n", privateAllocations) + "}\n", CompoundStatement.class);
					CompoundStatement forConstructBody = (CompoundStatement) forConstruct.getInfo().getCFGInfo().getBody();
					forConstructBody.getInfo().getCFGInfo().addStatement(0, privateAllocationNode);
					NodeRemover.removeNode(MUWOmpConverterStatic.privateClsrDeclarationNode);
					forConstructBody.getInfo().getCFGInfo().addElement(0, FrontEnd.parseAndNormalize(
							MUWOmpConverterStatic.privateEnvClsrDeclMap.get(enclosingParallelConstruct), Declaration.class));
					forConstructBody.getInfo().removeExtraScopes();
				}
				translateForConstruct(forConstruct, loopVariable, functionDefinition1);
			}
		}
	}

	private boolean analyseForStatement(ForStatement forStatement) {
		CompoundStatement forStatementBody = (CompoundStatement)forStatement.getInfo().getCFGInfo().getBody();
		for(CallStatement callStatement:Misc.getInheritedEnclosee(forStatementBody, CallStatement.class)) {
			if(!(callStatement.getInfo().getCalledDefinitions().isEmpty())) {
				return true;
			}
		}
		return false;
	}

	private boolean analyseWhileStatement(WhileStatement whileStatement) {
		CompoundStatement whileStatementBody = (CompoundStatement)whileStatement.getInfo().getCFGInfo().getBody();
		for(CallStatement callStatement:Misc.getInheritedEnclosee(whileStatementBody, CallStatement.class)) {
			if(!(callStatement.getInfo().getCalledDefinitions().isEmpty())) {
				return true;
			}
		}
		return false;
	}

	private boolean analyseDoWhileStatement(DoStatement doStatement) {
		CompoundStatement doStatementBody = (CompoundStatement)doStatement.getInfo().getCFGInfo().getBody();
		for(CallStatement callStatement:Misc.getInheritedEnclosee(doStatementBody, CallStatement.class)) {
			if(!(callStatement.getInfo().getCalledDefinitions().isEmpty())) {
				return true;
			}
		}
		return false;
	}

	private void wrapForStatement(FunctionDefinition functionDefinition,ForStatement forStatement) {
		// TODO Auto-generated method stub

		boolean shouldBeConverted = analyseForStatement(forStatement);
		if(shouldBeConverted) {
			Expression forInitExpression = forStatement.getInfo().getCFGInfo().getInitExpression();
			Expression forConditionExpression = forStatement.getInfo().getCFGInfo().getTerminationExpression();
			Expression forStepExpression = forStatement.getInfo().getCFGInfo().getStepExpression();
			Statement returnStatement = FrontEnd.parseAndNormalize("return;",Statement.class);
			CompoundStatement forStatementBody = (CompoundStatement) forStatement.getInfo().getCFGInfo().getBody();
			for(BreakStatement breakStatement: Misc.getInheritedEnclosee(forStatementBody, BreakStatement.class)) {
				NodeReplacer.replaceNodes(breakStatement,returnStatement);
			}
			ArrayList<String> formalParameterList = new ArrayList<>();
			ArrayList<String> actualParameterList = new ArrayList<>();
			ArrayList<Symbol> symbolsAccessed = new ArrayList<>();
			if(!functionDefinition.getInfo().getFunctionName().equals("main")) {
				HashMap<String,Symbol> symbolTable = functionDefinition.getInfo().getSymbolTable();
				for(String symbolName: symbolTable.keySet()) {
					symbolsAccessed.add(symbolTable.get(symbolName));
				}
			}else {
				CellSet usedCells = forStatementBody.getInfo().getUsedCells();
				CellSet exclusiveCells = forStatementBody.getInfo().getAllCellsAtNodeExclusively();
				CellSet intersectionCells = Misc.setIntersection(usedCells, exclusiveCells);
				for(Cell intersectionCell:intersectionCells) {
					if(intersectionCell instanceof Symbol) {
						Symbol symbol = (Symbol)intersectionCell;
						if(symbol.getDefiningScope() instanceof TranslationUnit) {
							continue;
						}
						if(symbol.getType() instanceof FunctionType) {
							continue;
						}
						symbolsAccessed.add(symbol);
					}
				}
			}
			for(Symbol symbol: symbolsAccessed) {
				Declaration declaration = (Declaration) symbol.getDeclaringNode();
				Declaration toBePutDeclaration = null;
				if(declaration.getInfo().hasInitializer()) {
					toBePutDeclaration = symbol.getType().getExactDeclarationWithoutInit(symbol.getName());
				}else {
					toBePutDeclaration = symbol.getType().getDeclaration(symbol.getName());
				}
				String toBePutDeclarationString = toBePutDeclaration.toString();
				String formalParameter = toBePutDeclarationString.substring(0,toBePutDeclarationString.lastIndexOf(";"));
				formalParameterList.add(formalParameter);
				actualParameterList.add(symbol.getName());
			}
			String condExpression = "";
			String stepExpression = "";
			if(forInitExpression!=null) {
				InsertImmediatePredecessor.insert(forStatement, forInitExpression);
			}
			if(forConditionExpression!=null) {
				condExpression = forConditionExpression.toString();
			}
			if(forStepExpression!=null) {
				stepExpression = forStepExpression.toString();
			}
			String functionName = Builder.getNewTempName("for");
			String formalParameters = String.join(",", formalParameterList);
			String actualParameters = String.join(",", actualParameterList);
			String callStatement = functionName + "("+actualParameters+");";
			String functionHeader = "void "+functionName+"("+formalParameters+")";
			String functionSignature = functionHeader + ";";
			String functionBody = "";
			if(forConditionExpression!=null) {
				functionBody = "{\n"
						+ "if("+condExpression+"){\n"+forStatementBody.toString();
				if(forStepExpression!=null) {
					functionBody += stepExpression+";\n";
				}
				functionBody += callStatement+"}\n}\n";
			}else {
				functionBody = "{\n"
						+ forStatementBody.toString();
				if(forStepExpression!=null) {
					functionBody += stepExpression+";\n";
				}
				functionBody += callStatement + "}\n";
			}
			String functionDefinitionString = functionHeader + functionBody;
			Declaration functionSignatureNode = FrontEnd.parseAndNormalize(functionSignature,Declaration.class);
			FunctionDefinition functionDefinitionNode = FrontEnd.parseAndNormalize(functionDefinitionString,FunctionDefinition.class);
			Statement callStatementNode = FrontEnd.parseAndNormalize(callStatement,Statement.class);
			Builder.addDeclarationToGlobals(MUWOmpConverterStatic.indexFunction(Program.getRoot().getInfo().getMainFunction()),functionSignatureNode);
			Builder.addFunctionToGlobal(functionDefinitionNode);
			functionDefinitionNode.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
			NodeReplacer.replaceNodes(forStatement,callStatementNode);
			functionDefinitionNode.getInfo().populateSymbolTable();
		}
	}

	private static void wrapIfStatement(FunctionDefinition functionDefinition,IfStatement ifStatement) {
		boolean wrapRequired = analyseIfStatement(ifStatement);
		if(wrapRequired) {
			ArrayList<Symbol> symbolsAccessed = new ArrayList<>();
			if(!functionDefinition.getInfo().getFunctionName().equals("main")) {
				HashMap<String,Symbol> symbolTable = functionDefinition.getInfo().getSymbolTable();
				for(String symbolName: symbolTable.keySet()) {
					symbolsAccessed.add(symbolTable.get(symbolName));
				}
			}else {
				CellSet exclusiveCells = ifStatement.getInfo().getAllCellsAtNodeExclusively();
				CellSet usedCells = ifStatement.getInfo().getUsedCells();
				CellSet intersectionCells = Misc.setIntersection(exclusiveCells, usedCells);
				for (Cell cell : intersectionCells) {
					if (cell instanceof Symbol) {
						Symbol symbol = (Symbol) cell;
						if (symbol.getDefiningScope() instanceof TranslationUnit) {
							continue;
						}
						symbolsAccessed.add(symbol);
					}
				}
			}
			CompoundStatement thenBody = (CompoundStatement) ifStatement.getInfo().getCFGInfo().getThenBody();
			CompoundStatement elseBody = null;
			if (ifStatement.getInfo().getCFGInfo().hasElseBody()) {
				elseBody = (CompoundStatement) ifStatement.getInfo().getCFGInfo().getElseBody();
			} else {
				elseBody = FrontEnd.parseAndNormalize("{\n;\n}", CompoundStatement.class);
				ifStatement.getInfo().getCFGInfo().setElseBody(elseBody);
			}
			convertToFunction(thenBody,symbolsAccessed);
			convertToFunction(elseBody,symbolsAccessed);
		}
	}
	private void wrapDoStatement(DoStatement doStatement) {
		// TODO Auto-generated method stub
		boolean shouldBeConverted = analyseDoWhileStatement(doStatement);
		if(shouldBeConverted) {
			Expression predicateExpression = doStatement.getInfo().getCFGInfo().getPredicate();
			CompoundStatement doWhileStatementBody = (CompoundStatement)doStatement.getInfo().getCFGInfo().getBody();
			ArrayList<String> formalParameterList = new ArrayList<>();
			ArrayList<String> actualParameterList = new ArrayList<>();
			CellSet usedCells = doWhileStatementBody.getInfo().getUsedCells();
			CellSet exclusiveCells = doWhileStatementBody.getInfo().getAllCellsAtNodeExclusively();
			CellSet intersectionCells = Misc.setIntersection(usedCells, exclusiveCells);
			ArrayList<Symbol> usedSymbols = new ArrayList<>();
			for(Cell intersectionCell:intersectionCells) {
				if(intersectionCell instanceof Symbol) {
					Symbol symbol = (Symbol)intersectionCell;
					if(symbol.getDefiningScope() instanceof TranslationUnit) {
						continue;
					}
					if(symbol.getType() instanceof FunctionType) {
						continue;
					}
					usedSymbols.add(symbol);
				}
			}
			for(Symbol symbol: usedSymbols) {
				Declaration declaration = (Declaration) symbol.getDeclaringNode();
				Declaration toBePutDeclaration = null;
				if(declaration.getInfo().hasInitializer()) {
					toBePutDeclaration = symbol.getType().getExactDeclarationWithoutInit(symbol.getName());
				}else {
					toBePutDeclaration = symbol.getType().getDeclaration(symbol.getName());
				}
				String toBePutDeclarationString = toBePutDeclaration.toString();
				String formalParameter = toBePutDeclarationString.substring(0,toBePutDeclarationString.lastIndexOf(";"));
				formalParameterList.add(formalParameter);
				actualParameterList.add(symbol.getName());
			}
			String functionName = Builder.getNewTempName("while");
			String formalParameters = String.join(",", formalParameterList);
			String actualParameters = String.join(",", actualParameterList);
			String callStatement = functionName + "("+actualParameters+");";
			String functionHeader = "void "+functionName+"("+formalParameters+")";
			String functionSignature = functionHeader + ";";
			String functionBody = "{\n"+doWhileStatementBody.toString()
			+ "if("+predicateExpression.toString()+"){\n"+callStatement+"}\n}\n";
			String functionDefinitionString = functionHeader + "{\n"+functionBody+"}\n";
			Declaration functionSignatureNode = FrontEnd.parseAndNormalize(functionSignature,Declaration.class);
			FunctionDefinition functionDefinitionNode = FrontEnd.parseAndNormalize(functionDefinitionString,FunctionDefinition.class);
			Statement callStatementNode = FrontEnd.parseAndNormalize(callStatement,Statement.class);
			Builder.addDeclarationToGlobals(MUWOmpConverterStatic.indexFunction(Program.getRoot().getInfo().getMainFunction()),functionSignatureNode);
			Builder.addFunctionToGlobal(functionDefinitionNode);
			functionDefinitionNode.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
			NodeReplacer.replaceNodes(doStatement,callStatementNode);
			functionDefinitionNode.getInfo().populateSymbolTable();
		}
	}

	private void wrapWhileStatement(FunctionDefinition functionDefinition,WhileStatement whileStatement) {
		// TODO Auto-generated method stub
		boolean shouldBeConverted = analyseWhileStatement(whileStatement);
		if(shouldBeConverted) {
			Expression predicateExpression = whileStatement.getInfo().getCFGInfo().getPredicate();
			CompoundStatement whileStatementBody = (CompoundStatement) whileStatement.getInfo().getCFGInfo().getBody();
			ArrayList<Symbol> symbolsAccessed = new ArrayList<>();
			ArrayList<String> actualParameterList = new ArrayList<>();
			ArrayList<String> formalParameterList = new ArrayList<>();
			if(!functionDefinition.getInfo().getFunctionName().equals("main")) {
				HashMap<String,Symbol> symbolTable = functionDefinition.getInfo().getSymbolTable();
				for(String symbolName: symbolTable.keySet()) {
					symbolsAccessed.add(symbolTable.get(symbolName));
				}
				CellSet usedCells = whileStatementBody.getInfo().getUsedCells();
				CellSet exclusiveCells = whileStatementBody.getInfo().getAllCellsAtNodeExclusively();
				CellSet intersectionCells = Misc.setIntersection(usedCells, exclusiveCells);
				for(Cell intersectionCell:intersectionCells) {
					if(intersectionCell instanceof Symbol) {
						Symbol symbol = (Symbol)intersectionCell;
						if(symbol.getDefiningScope() instanceof TranslationUnit) {
							continue;
						}
						if(symbol.getType() instanceof FunctionType) {
							continue;
						}
						symbolsAccessed.add(symbol);
					}
				}
			}else {
				CellSet usedCells = whileStatementBody.getInfo().getUsedCells();
				CellSet exclusiveCells = whileStatementBody.getInfo().getAllCellsAtNodeExclusively();
				CellSet intersectionCells = Misc.setIntersection(usedCells, exclusiveCells);
				for(Cell intersectionCell:intersectionCells) {
					if(intersectionCell instanceof Symbol) {
						Symbol symbol = (Symbol)intersectionCell;
						if(symbol.getDefiningScope() instanceof TranslationUnit) {
							continue;
						}
						if(symbol.getType() instanceof FunctionType) {
							continue;
						}
						symbolsAccessed.add(symbol);
					}
				}
			}
			for(Symbol symbol: symbolsAccessed) {
				Declaration declaration = (Declaration) symbol.getDeclaringNode();
				Declaration toBePutDeclaration = null;
				if(declaration.getInfo().hasInitializer()) {
					toBePutDeclaration = symbol.getType().getExactDeclarationWithoutInit(symbol.getName());
				}else {
					toBePutDeclaration = symbol.getType().getDeclaration(symbol.getName());
				}
				String toBePutDeclarationString = toBePutDeclaration.toString();
				String formalParameter = toBePutDeclarationString.substring(0,toBePutDeclarationString.lastIndexOf(";"));
				formalParameterList.add(formalParameter);
				actualParameterList.add(symbol.getName());
			}
			String functionName = Builder.getNewTempName("while");
			String formalParameters = String.join(",", formalParameterList);
			String actualParameters = String.join(",", actualParameterList);
			String callStatement = functionName + "("+actualParameters+");";
			String functionHeader = "void "+functionName+"("+formalParameters+")";
			String functionSignature = functionHeader + ";";
			String functionBody = "if("+predicateExpression.toString()+"){\n"+whileStatementBody.toString()
			+ callStatement + "}\n";
			String functionDefinitionString = functionHeader + "{\n"+functionBody+"}\n";
			Declaration functionSignatureNode = FrontEnd.parseAndNormalize(functionSignature,Declaration.class);
			FunctionDefinition functionDefinitionNode = FrontEnd.parseAndNormalize(functionDefinitionString,FunctionDefinition.class);
			Statement callStatementNode = FrontEnd.parseAndNormalize(callStatement,Statement.class);
			Builder.addDeclarationToGlobals(MUWOmpConverterStatic.indexFunction(Program.getRoot().getInfo().getMainFunction()),functionSignatureNode);
			Builder.addFunctionToGlobal(functionDefinitionNode);
			functionDefinitionNode.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
			NodeReplacer.replaceNodes(whileStatement,callStatementNode);
			functionDefinitionNode.getInfo().populateSymbolTable();
		}
	}

	private void wrapSwitchStatement(SwitchStatement switchStatement) {
		// TODO Auto-generated method stub
		SwitchStatement newSwitchStatement = handleSwitchStatement(switchStatement);
		NodeReplacer.replaceNodes(switchStatement, newSwitchStatement);
	}

	private void addLocksToEnqueueOperations() {
		for (FunctionDefinition functionDefinition : Misc.getInheritedEnclosee(Program.getRoot(),
				FunctionDefinition.class)) {
			for (CallStatement callStatement : Misc.getInheritedEnclosee(functionDefinition, CallStatement.class)) {
				if (callStatement.getInfo().getFunctionDesignator() != null) {
					String calledFunctionName = callStatement.getInfo().getFunctionDesignator().toString();
					if (calledFunctionName.equals("enqueueClosure")) {
						boolean globalWL = false;
						List<SimplePrimaryExpression> actualArgumentList = callStatement.getInfo().getArgumentList();
						for(SimplePrimaryExpression actualArgument:actualArgumentList) {
							if(actualArgument.toString().equals("globalWorklist")) {
								globalWL = true;
								break;
							}
						}
						if(globalWL) {
							String lockAcquire = "while(!(omp_test_lock(lock)));";
							String lockRelease = "omp_unset_lock(lock);";
							WhileStatement lockAcquireNode = FrontEnd.parseAndNormalize(lockAcquire, WhileStatement.class);
							Statement lockReleaseNode = FrontEnd.parseAndNormalize(lockRelease, Statement.class);
							InsertImmediatePredecessor.insert(callStatement, lockAcquireNode);
							InsertImmediateSuccessor.insert(callStatement, lockReleaseNode);
						}
					}
				}
			}
		}
	}

	public static void modifyActualFormalParams(CallStatement callStatement, String tempNameSymbol, String formalParameter, Symbol reductionVariableSymbol) {
		FunctionDefinition calledDefinition = callStatement.getInfo().getCalledDefinitions().get(0);
		calledDefinition.getInfo().populateSymbolTable();
		List<ParameterDeclaration> formalParameterDeclarations = calledDefinition.getInfo().getCFGInfo().getParameterDeclarationList();
		List<SimplePrimaryExpression> actualArguments = callStatement.getInfo().getArgumentList();
		ArrayList<String> formalParameterList = new ArrayList<>();
		ArrayList<String> actualParameterList = new ArrayList<>();
		for(int i = 0;i < formalParameterDeclarations.size(); i++) {
			ParameterDeclaration formalParameterDeclaration = formalParameterDeclarations.get(i);
			Symbol formalParameterDeclarationSymbol = formalParameterDeclaration.getInfo().getDeclaredSymbol();
			String formalParameterDeclarationSymbolName = formalParameterDeclarationSymbol.getName();
			if(formalParameterDeclarationSymbolName.equals(reductionVariableSymbol.getName())){
				formalParameterList.add(formalParameterDeclarationSymbol.getType().toString().trim()+"*"+formalParameterDeclarationSymbolName);
				actualParameterList.add(tempNameSymbol);
			}else {
				formalParameterList.add(formalParameterDeclaration.toString());
				actualParameterList.add(actualArguments.get(i).toString());
			}
		}
		String actualParameters = String.join(",", actualParameterList);
		String formalParameters = String.join(",", formalParameterList);
		String functionHeader = "void "+calledDefinition.getInfo().getFunctionName()+"("+formalParameters+")";
		String functionSignature = functionHeader + ";";
		String newFunction = functionHeader+calledDefinition.getInfo().getCFGInfo().getBody().toString();
		String newCallStatement = calledDefinition.getInfo().getFunctionName() + "(" + actualParameters + ");";
		FunctionDefinition newFunctionNode = FrontEnd.parseAndNormalize(newFunction,FunctionDefinition.class);
		Statement newCallStatementNode = FrontEnd.parseAndNormalize(newCallStatement,Statement.class);
		Declaration functionSignatureNode = FrontEnd.parseAndNormalize(functionSignature,Declaration.class);
		removeFunction(calledDefinition);
		NodeReplacer.replaceNodes(callStatement, newCallStatementNode);
		Builder.addDeclarationToGlobals(MUWOmpConverterStatic.indexFunction(Program.getRoot().getInfo().getMainFunction()),functionSignatureNode);
		Builder.addFunctionToGlobal(newFunctionNode);
	}

	private static ArrayList<String> renameStatements(CompoundStatement compoundStatement,
			String internalEnvironmentVarName, ArrayList<String> internalEnvironmentDeclarations,
			String internalEnvironmentHeader, HashMap<String, String> renameMapper) {
		List<Node> elements = compoundStatement.getInfo().getCFGInfo().getElementList();
		ArrayList<String> newStatementsBody = new ArrayList<>();
		List<Declaration> declarationList = new ArrayList<>();
		for (Node element : elements) {
			if (element instanceof Declaration) {
				Declaration declaration = (Declaration) element;
				Symbol symbol = declaration.getInfo().getDeclaredSymbol();
				String oldName = symbol.getName();
				String newName = closureVarName+"->environment->"+internalEnvironmentVarName+"->"+symbol.getName();
				renameMapper.put(oldName, newName);
				if (declaration.getInfo().hasInitializer()) {
					String initializer = closureVarName+"->environment->"+internalEnvironmentVarName+"->"+symbol.getName()+
							"=" + declaration.getInfo().getInitializer() + ";";
					Statement initializerStatement = FrontEnd.parseAndNormalize(initializer, Statement.class);
					InsertImmediateSuccessor.insert(element, initializerStatement);
					internalEnvironmentDeclarations
							.add(symbol.getType().getExactDeclarationWithoutInit(symbol.getName()).toString());
				} else {
					internalEnvironmentDeclarations
							.add(symbol.getType().getExactDeclarationWithoutInit(symbol.getName()).toString());
				}
				declarationList.add(declaration);
			}
		}
		for (CallStatement callStatement : Misc.getInheritedEnclosee(compoundStatement, CallStatement.class)) {
			List<FunctionDefinition> functionsCalled = callStatement.getInfo().getCalledDefinitions();
			if (functionsCalled.isEmpty()) {
				continue;
			} else {
				FunctionDefinition functionCalled = functionsCalled.get(0);
				String functionCalledName = functionCalled.getInfo().getFunctionName();
				Type functionReturnType = functionCalled.getInfo().getReturnType();
				String functionReturnTypeName = functionReturnType.toString();
				if (functionReturnTypeName.equals("void")) {
					continue;
				} else {
					PostCallNode postCallNode = callStatement.getInfo().getCFGInfo().getPostCallNode();
					if (postCallNode.hasReturnReceiver()) {
						SimplePrimaryExpression returnReceiver = postCallNode.getReturnReceiver();
						ArrayList<String> actualParameterList = new ArrayList<>();
						for (SimplePrimaryExpression actualArgument : callStatement.getInfo().getArgumentList()) {
							actualParameterList.add(actualArgument.toString());
						}
						actualParameterList.add("&" + returnReceiver);
						String actualParameters = String.join(",", actualParameterList);
						String updatedCallStatement = functionCalledName + "(" + actualParameters + ");";
						NodeReplacer.replaceNodes(callStatement,
								FrontEnd.parseAndNormalize(updatedCallStatement, Statement.class));
					}
				}
				//Handle ReductionVariable Assignments
				if(functionCalledName.startsWith("mWaitAll")) {
					if(MUWOmpConverterStatic.reductionVariableNameMapper.containsKey(functionCalledName)) {
						String reductionSymbolNewName = MUWOmpConverterStatic.reductionVariableReducedMapper.get(functionCalledName);
						String reductionSymbolType = MUWOmpConverterStatic.reductionVariableTypeMapper.get(functionCalledName);
						String typeDeclarationString = reductionSymbolType + "*";
						String declarationString = typeDeclarationString + reductionSymbolNewName+";";
						String allocString = reductionSymbolNewName + " = ("+typeDeclarationString+")malloc(sizeof("+reductionSymbolType+"));";
						String declarationAndAllocCS = "{\n" + declarationString + "\n" + allocString + "}\n";
						CompoundStatement declarationAndAllocCSOpt = FrontEnd.simplifyExpression(declarationAndAllocCS);
						InsertImmediatePredecessor.insert(callStatement, declarationAndAllocCSOpt);
						compoundStatement.getInfo().removeExtraScopes();
						String oldName = reductionSymbolNewName;
						String newName = closureVarName + "->environment" + internalEnvironmentVarName+"->"+reductionSymbolNewName;
						internalEnvironmentDeclarations.add(typeDeclarationString + reductionSymbolNewName + ";");
						renameMapper.put(oldName,newName);
					}
				}
			}
		}
		String internalEnvironmentBuild = internalEnvironmentHeader + "{\n"
				+ String.join("\n", internalEnvironmentDeclarations) + "};\n";
		Declaration internalEnvironmentDeclaration = FrontEnd.parseAndNormalize(internalEnvironmentBuild,
				Declaration.class);
		Builder.addDeclarationToGlobals(MUWOmpConverterStatic.indexFunction(Program.getRoot().getInfo().getMainFunction()),
				internalEnvironmentDeclaration);
		List<Node> elementsForStatements = compoundStatement.getInfo().getCFGInfo().getElementList();
		for (Node elementStatement : elementsForStatements) {
			if (elementStatement instanceof Statement) {
				if(elementStatement instanceof DummyFlushDirective) {
					newStatementsBody.add(elementStatement.toString());
					continue;
				}
				Node renamedElement = MUWOmpConverterStatic.myObtainRenamedNode(elementStatement, renameMapper);
				newStatementsBody.add(renamedElement.toString());
			}else {
				Declaration declaration = (Declaration)elementStatement;
				if(!declarationList.contains(declaration)) {
					newStatementsBody.add(elementStatement.toString());
				}
			}
		}
		return newStatementsBody;
	}

	public static Node findDeclaringNode(CallStatement callStatement) {
		FunctionDefinition functionDefinition = callStatement.getInfo().getCalledDefinitions().get(0);
		CompoundStatement functionDefinitionBody = functionDefinition.getInfo().getCFGInfo().getBody();
		for(Declaration declaration:Misc.getInheritedEnclosee(functionDefinitionBody,Declaration.class)) {
			Symbol declaredSymbol = declaration.getInfo().getDeclaredSymbol();
			String declaredSymbolName = declaredSymbol.getName();
			if(declaredSymbolName.equals("redVar")) {
				return declaration;
			}
		}
		return null;
	}

	private static boolean analyseIfStatement(IfStatement ifStatement) {
		// TODO Auto-generated method stub
		for(CallStatement callStatement:Misc.getInheritedEnclosee(ifStatement, CallStatement.class)) {
			if(!(callStatement.getInfo().getCalledDefinitions().isEmpty())) {
				return true;
			}
		}
		return false;
	}

	public static String convertToFunction(CompoundStatement compoundStatement,ArrayList<Symbol> symbolsAccessed) {
		ArrayList<String> formalParameterList = new ArrayList<>();
		ArrayList<String> actualParameterList = new ArrayList<>();
		for (Symbol symbol : symbolsAccessed) {
			String name = symbol.getName();
			Type type = symbol.getType();
			Declaration parameterDeclarationNode = type.getDeclaration(name);
			String parameterDeclarationString = parameterDeclarationNode.toString();
			String formalParameter = parameterDeclarationString.substring(0,
					parameterDeclarationString.lastIndexOf(";"));
			formalParameterList.add(formalParameter);
			actualParameterList.add(name);
		}
		String functionName = Builder.getNewTempName("fun");
		String formalParameters = String.join(",", formalParameterList);
		String actualParameters = String.join(",", actualParameterList);
		String callStatement = functionName + "(" + actualParameters + ");";
		String functionHeader = "void " + functionName + "(" + formalParameters + ")";
		String functionSignature = functionHeader + ";";
		String functionBody = compoundStatement.toString();
		String functionDefinitionString = functionHeader + functionBody;
		FunctionDefinition functionDefinitionNode = FrontEnd.parseAndNormalize(functionDefinitionString,
				FunctionDefinition.class);
		Declaration functionSignatureNode = FrontEnd.parseAndNormalize(functionSignature, Declaration.class);
		Statement callStatementNode = FrontEnd.parseAndNormalize(callStatement, Statement.class);
		Builder.addDeclarationToGlobals(MUWOmpConverterStatic.indexFunction(Program.getRoot().getInfo().getMainFunction()),
				functionSignatureNode);
		Builder.addFunctionToGlobal(functionDefinitionNode);
		functionDefinitionNode.getInfo().populateSymbolTable();
		if(compoundStatement.getInfo().isConnectedToProgram()) {
			NodeReplacer.replaceNodes(compoundStatement, callStatementNode);
			return null;
		}else {
			return callStatement;
		}
	}

	public static ArrayList<String> generateAllocationString(String structTagName, String structVarName) {
		ArrayList<String> statements = new ArrayList<>();
		String internalEnvironmentDeclaration = "struct " + structTagName + " *" + structVarName + ";";
		String voidPtrTempName = Builder.getNewTempName("internal_env");
		String voidPtrCreate = "void *" + voidPtrTempName + ";";
		String tempSize = Builder.getNewTempName("tempSize");
		String sizeOfMalloc = "int " + tempSize + " = sizeof(struct " + structTagName + ");";
		String structAllocation = voidPtrTempName + "=" + "malloc(" + tempSize + ");";
		String assignAllocStmt = structVarName + "=" + "(struct " + structTagName + " *)" + voidPtrTempName + ";";
		statements.add(internalEnvironmentDeclaration);
		statements.add(voidPtrCreate);
		statements.add(sizeOfMalloc);
		statements.add(structAllocation);
		statements.add(assignAllocStmt);
		return statements;
	}

	public FunctionDefinition convertOmpForBodyToFunction(ForConstruct forConstruct) {
		CompoundStatement forConstructBody = (CompoundStatement) forConstruct.getInfo().getCFGInfo().getBody();
		CompoundStatement forConstructBodyOpt = Normalization.normalizeLeafNodes(forConstructBody, null);
		forConstruct.getInfo().getCFGInfo().setBody(forConstructBodyOpt);
		String loopVariable = MUWOmpConverterStatic.forConstructMapper.get(forConstruct);
		FunctionDefinition functionDefinition = convertStatementsToFunction(forConstruct, "ompfor", true,loopVariable);
		CompoundElementLink cElementLink = (CompoundElementLink) CFGLinkFinder.getCFGLinkFor(forConstruct);
		CompoundStatement enclosingCompoundStatement = (CompoundStatement) cElementLink.getEnclosingNode();
		List<Node> listOfNodes = enclosingCompoundStatement.getInfo().getCFGInfo().getElementList();
		int indexForConstruct = listOfNodes.indexOf(forConstruct);
		String threadIdInit = "int tid_ivp17 = omp_get_thread_num();";
		String leftPointerInit = "leftPointer[tid_ivp17] = "+MUWOmpConverterStatic.nIterationsVarName+"+startRange_ivp17;";
		String rightPointerInit = "rightPointer[tid_ivp17] = -1;";
		listOfNodes = enclosingCompoundStatement.getInfo().getCFGInfo().getElementList();
		indexForConstruct = listOfNodes.indexOf(forConstruct);
		InsertImmediatePredecessor.insert(forConstruct, FrontEnd.parseAndNormalize(threadIdInit, Declaration.class));
		InsertImmediatePredecessor.insert(forConstruct, FrontEnd.parseAndNormalize(leftPointerInit, Statement.class));
		InsertImmediatePredecessor.insert(forConstruct, FrontEnd.parseAndNormalize(rightPointerInit, Statement.class));
//		enclosingCompoundStatement.getInfo().getCFGInfo().addElement(indexForConstruct - 1,
//				FrontEnd.parseAndNormalize(threadIdInit, Declaration.class));
//		listOfNodes = enclosingCompoundStatement.getInfo().getCFGInfo().getElementList();
//		indexForConstruct = listOfNodes.indexOf(forConstruct);
//		enclosingCompoundStatement.getInfo().getCFGInfo().addElement(indexForConstruct - 1,
//				FrontEnd.parseAndNormalize(leftPointerInit, Statement.class));
//		listOfNodes = enclosingCompoundStatement.getInfo().getCFGInfo().getElementList();
//		indexForConstruct = listOfNodes.indexOf(forConstruct);
//		enclosingCompoundStatement.getInfo().getCFGInfo().addElement(indexForConstruct - 1,
//				FrontEnd.parseAndNormalize(rightPointerInit, Statement.class));
		listOfNodes = enclosingCompoundStatement.getInfo().getCFGInfo().getElementList();
		indexForConstruct = listOfNodes.indexOf(forConstruct);
		String schedulerCode = "executeReadyWorkList();";
		enclosingCompoundStatement.getInfo().getCFGInfo().addElement(indexForConstruct + 3,
				FrontEnd.parseAndNormalize(schedulerCode, Statement.class));
		enclosingCompoundStatement.getInfo().removeExtraScopes();
		return functionDefinition;
	}

	static FunctionDefinition convertStatementsToFunction(ForConstruct forConstruct, String functionPrefix,
			boolean isClosureCreate,String loopVariable) {
		CompoundStatement forConstructBody = (CompoundStatement) forConstruct.getInfo().getCFGInfo().getBody();
		ArrayList<String> newCompoundStatement = new ArrayList<>();
		String internalEnvironmentTagFCName = internalEnvironmentFCTagName;
		String internalEnvironmentVarFCName = internalEnvironmentFCVarName;
		String internalEnvironmentHeader = "struct " + internalEnvironmentTagFCName;
		String internalEnvironmentSignature = internalEnvironmentHeader + ";";
		Builder.addDeclarationToGlobals(0,FrontEnd.parseAndNormalize(internalEnvironmentSignature, Declaration.class));
		String internalEnvironmentFCCast = internalEnvironmentHeader + " *";
		HashMap<String, String> renameMapper = new HashMap<>();
		CellSet exclusiveCells = forConstructBody.getInfo().getAllCellsAtNodeExclusively();
		CellSet cells = forConstructBody.getInfo().getUsedCells();
		CellSet intersectionCells = Misc.setIntersection(exclusiveCells, cells);
		ArrayList<String> formalParameterList = new ArrayList<>();
		ArrayList<String> actualParameterList = new ArrayList<>();
		ArrayList<String> internalEnvironmentDeclarations = new ArrayList<>();
		internalEnvironmentDeclarations.add("void (*continuation)(struct Clsr *);");
		ArrayList<Symbol> symbolsAccessed = new ArrayList<>();
		for (Cell cell : intersectionCells) {
			if (cell instanceof Symbol) {
				Symbol symbol = (Symbol) cell;
				if (symbol.getDefiningScope() instanceof TranslationUnit) {
					continue;
				}
				symbolsAccessed.add(symbol);
			}
		}
		String functionName = Builder.getNewTempName(functionPrefix);
		String closureCreate = "struct Clsr * " + closureVarName + " = createClosure(NORMAL,&" + functionName
				+ ","+loopVariable+");";
		String closureContinuationAssignment = closureVarName+"->environment->"+internalEnvironmentFCVarName+"->continuation = &lastFunction;";
		newCompoundStatement.add(closureCreate);
		String masterEnvAlloc = closureVarName + "->environment = (struct master_env *)malloc(sizeof(struct master_env));";
		String allocStringFC = "("+internalEnvironmentFCCast+")malloc(sizeof(struct "+internalEnvironmentFCTagName+"));";
		String assignAllocStringFC = closureVarName + "->environment->"+internalEnvironmentFCVarName+"="+allocStringFC;
		String leftPointerUpdate = "if ("+loopVariable+" < leftPointer[omp_get_thread_num()]){ leftPointer[omp_get_thread_num()] = "+loopVariable+";}";
		String rightPointerUpdate = "if ("+loopVariable+" > rightPointer[omp_get_thread_num()]){ rightPointer[omp_get_thread_num()] = "+loopVariable+";}";
		String enqueueClosure = "readyWorkList["+loopVariable+"] = "+closureVarName+";";
		newCompoundStatement.add(masterEnvAlloc);
		newCompoundStatement.add(assignAllocStringFC);
		newCompoundStatement.add(closureContinuationAssignment);
		newCompoundStatement.add(leftPointerUpdate);
		newCompoundStatement.add(rightPointerUpdate);
		newCompoundStatement.add(enqueueClosure);
		for(String key: internalEnvironmentCastMapper.keySet()) {
			String internalEnvironmentCast = internalEnvironmentCastMapper.get(key);
			String internalEnvironmentTagName = internalEnvironmentTagNameMapper.get(key);
			String internalEnvironmentVarName = internalEnvironmentVarNameMapper.get(key);
			String allocString = "("+internalEnvironmentCast+")malloc(sizeof(struct "+internalEnvironmentTagName+"));";
			String assignAllocString = closureVarName + "->environment->"+internalEnvironmentVarName+"="+allocString;
			newCompoundStatement.add(assignAllocString);
		}
		for (Symbol symbol : symbolsAccessed) {
			String formalParameterDeclaration = symbol.getDeclaringNode().toString();
			formalParameterDeclaration = formalParameterDeclaration.substring(0,
					formalParameterDeclaration.lastIndexOf(';'));
			formalParameterList.add(formalParameterDeclaration);
			actualParameterList.add(symbol.getName());
			internalEnvironmentDeclarations.add(symbol.getDeclaringNode().toString());
			String oldName = symbol.getName();
			String newName = closureVarName+"->environment->"+internalEnvironmentFCVarName+"->"+symbol.getName();
			renameMapper.put(oldName, newName);
			newCompoundStatement
				.add(closureVarName+"->environment->"+internalEnvironmentFCVarName+"->"+symbol.getName()+"="+symbol.getName()+";");
		}
		ArrayList<String> newStatements = renameStatements(forConstructBody, internalEnvironmentVarFCName,
				internalEnvironmentDeclarations, internalEnvironmentHeader, renameMapper);
		String functionHeader = "void " + functionName + "(struct Clsr *" + closureVarName + ")";
		String functionSignature = functionHeader + ";";
		String functionBody = "{\n" + String.join("\n", newStatements) + "}\n";
		String functionDefinitionString = functionHeader + functionBody;
		FunctionDefinition functionDefinition = FrontEnd.parseAndNormalize(functionDefinitionString,
				FunctionDefinition.class);
		Declaration functionSignatureNode = FrontEnd.parseAndNormalize(functionSignature, Declaration.class);
		Builder.addDeclarationToGlobals(MUWOmpConverterStatic.indexFunction(Program.getRoot().getInfo().getMainFunction()),
				functionSignatureNode);
		Builder.addFunctionToGlobal(functionDefinition);
		functionDefinition.getInfo().getCFGInfo().getBody().getInfo().removeExtraScopes();
		if (forConstructBody.getInfo().isConnectedToProgram()) {
			String bodyString = "{\n" + String.join("\n", newCompoundStatement) + "}\n";
			CompoundStatement newForConstructBodyCS;
			try {
				newForConstructBodyCS = FrontEnd.simplifyExpression(bodyString);
			}catch(Exception e) {
				CompoundStatement newBodyCS= FrontEnd.parseAndNormalize(bodyString,CompoundStatement.class);
				newForConstructBodyCS = Normalization.normalizeLeafNodes(newBodyCS, null);
			}
			forConstruct.getInfo().getCFGInfo().mySetBody(newForConstructBodyCS);
		}
		return functionDefinition;
	}

}