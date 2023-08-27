/*
 * Copyright (c) 2019 Aman Nougrahiya, V Krishna Nandivada, IIT Madras.
 * This file is Object  part of the project IMOP, licensed under the MIT license.
 * See LICENSE.md for the full text of the license.
 * 
 * The above notice shall be included in all copies or substantial
 * portions of this file.
 */
package imop.baseVisitor.cfgTraversals;

import java.util.List;

import imop.ast.node.external.*;
import imop.ast.node.internal.*;
import imop.baseVisitor.GJDepthFirstProcess;

/**
 * Provides default methods for processing all the CFG nodes. Traversal shall be
 * defined as per the requirements. Note: This visitor is just for convenience
 * in handling all the CFGs.
 */
public class TranslatorVisitor extends GJDepthFirstCFG<List<Node>, Object> {
	@Override
	public List<Node> initProcess(Node n, Object argu) {
		return null;
	}

	@Override
	public List<Node> endProcess(Node n, Object argu) {
		return null;
	}

	/**
	 * @deprecated
	 * @param n
	 * @param argu
	 * @return
	 */
	@Deprecated
	public List<Node> processCalls(Node n, Object argu) {
		return null;
	}

	/**
	 * Special Node
	 */
	@Override
	public List<Node> visit(BeginNode n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * Special Node
	 */
	@Override
	public List<Node> visit(EndNode n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= ( DeclarationSpecifiers() )? f1 ::= Declarator() f2 ::= (
	 * DeclarationList() )? f3 ::= CompoundStatement()
	 */
	@Override
	public List<Node> visit(FunctionDefinition n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= DeclarationSpecifiers() f1 ::= ( InitDeclaratorList() )? f2 ::= ";"
	 */
	@Override
	public List<Node> visit(Declaration n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= DeclarationSpecifiers() f1 ::= ParameterAbstraction()
	 */
	@Override
	public List<Node> visit(ParameterDeclaration n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= "#" f1 ::= <UNKNOWN_CPP>
	 */
	@Override
	public List<Node> visit(UnknownCpp n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= ParallelDirective() f2 ::= Statement()
	 */
	@Override
	public List<Node> visit(ParallelConstruct n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= "#" f1 ::= <PRAGMA> f2 ::= <UNKNOWN_CPP>
	 */
	@Override
	public List<Node> visit(UnknownPragma n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= <IF> f1 ::= "(" f2 ::= Expression() f3 ::= ")"
	 */
	@Override
	public List<Node> visit(IfClause n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= <NUM_THREADS> f1 ::= "(" f2 ::= Expression() f3 ::= ")"
	 */
	@Override
	public List<Node> visit(NumThreadsClause n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= ForDirective() f2 ::= OmpForHeader() f3 ::=
	 * Statement()
	 */
	@Override
	public List<Node> visit(ForConstruct n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER> f1 ::= "=" f2 ::= Expression()
	 */
	@Override
	public List<Node> visit(OmpForInitExpression n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpForLTCondition() | OmpForLECondition() | OmpForGTCondition() |
	 * OmpForGECondition()
	 */
	@Override
	public List<Node> visit(OmpForCondition n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= PostIncrementId() | PostDecrementId() | PreIncrementId() |
	 * PreDecrementId() | ShortAssignPlus() | ShortAssignMinus() | OmpForAdditive()
	 * | OmpForSubtractive() | OmpForMultiplicative()
	 */
	@Override
	public List<Node> visit(OmpForReinitExpression n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= <SECTIONS> f2 ::= NowaitDataClauseList() f3 ::=
	 * OmpEol() f4 ::= SectionsScope()
	 */
	@Override
	public List<Node> visit(SectionsConstruct n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= <SINGLE> f2 ::= SingleClauseList() f3 ::= OmpEol()
	 * f4 ::= Statement()
	 */
	@Override
	public List<Node> visit(SingleConstruct n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= <TASK> f2 ::= ( TaskClause() )* f3 ::= OmpEol() f4
	 * ::= Statement()
	 */
	@Override
	public List<Node> visit(TaskConstruct n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= <FINAL> f1 ::= "(" f2 ::= Expression() f3 ::= ")"
	 */
	@Override
	public List<Node> visit(FinalClause n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= <PARALLEL> f2 ::= <FOR> f3 ::=
	 * UniqueParallelOrUniqueForOrDataClauseList() f4 ::= OmpEol() f5 ::=
	 * OmpForHeader() f6 ::= Statement()
	 */
	@Override
	public List<Node> visit(ParallelForConstruct n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= <PARALLEL> f2 ::= <SECTIONS> f3 ::=
	 * UniqueParallelOrDataClauseList() f4 ::= OmpEol() f5 ::= SectionsScope()
	 */
	@Override
	public List<Node> visit(ParallelSectionsConstruct n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= <MASTER> f2 ::= OmpEol() f3 ::= Statement()
	 */
	@Override
	public List<Node> visit(MasterConstruct n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= <CRITICAL> f2 ::= ( RegionPhrase() )? f3 ::=
	 * OmpEol() f4 ::= Statement()
	 */
	@Override
	public List<Node> visit(CriticalConstruct n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= <ATOMIC> f2 ::= ( AtomicClause() )? f3 ::= OmpEol()
	 * f4 ::= ExpressionStatement()
	 */
	@Override
	public List<Node> visit(AtomicConstruct n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= <FLUSH> f2 ::= ( FlushVars() )? f3 ::= OmpEol()
	 */
	@Override
	public List<Node> visit(FlushDirective n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= <ORDERED> f2 ::= OmpEol() f3 ::= Statement()
	 */
	@Override
	public List<Node> visit(OrderedConstruct n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= <BARRIER> f2 ::= OmpEol()
	 */
	@Override
	public List<Node> visit(BarrierDirective n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= <TASKWAIT> f2 ::= OmpEol()
	 */
	@Override
	public List<Node> visit(TaskwaitDirective n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma() f1 ::= <TASKYIELD> f2 ::= OmpEol()
	 */
	@Override
	public List<Node> visit(TaskyieldDirective n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= ( Expression() )? f1 ::= ";"
	 */
	@Override
	public List<Node> visit(ExpressionStatement n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= "{" f1 ::= ( CompoundStatementElement() )* f2 ::= "}"
	 */
	@Override
	public List<Node> visit(CompoundStatement n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= <IF> f1 ::= "(" f2 ::= Expression() f3 ::= ")" f4 ::= Statement() f5
	 * ::= ( <ELSE> Statement() )?
	 */
	@Override
	public List<Node> visit(IfStatement n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= <SWITCH> f1 ::= "(" f2 ::= Expression() f3 ::= ")" f4 ::= Statement()
	 */
	@Override
	public List<Node> visit(SwitchStatement n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= <WHILE> f1 ::= "(" f2 ::= Expression() f3 ::= ")" f4 ::= Statement()
	 */
	@Override
	public List<Node> visit(WhileStatement n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= <DO> f1 ::= Statement() f2 ::= <WHILE> f3 ::= "(" f4 ::= Expression()
	 * f5 ::= ")" f6 ::= ";"
	 */
	@Override
	public List<Node> visit(DoStatement n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= <FOR> f1 ::= "(" f2 ::= ( Expression() )? f3 ::= ";" f4 ::= (
	 * Expression() )? f5 ::= ";" f6 ::= ( Expression() )? f7 ::= ")" f8 ::=
	 * Statement()
	 */
	@Override
	public List<Node> visit(ForStatement n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= <GOTO> f1 ::= <IDENTIFIER> f2 ::= ";"
	 */
	@Override
	public List<Node> visit(GotoStatement n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= <CONTINUE> f1 ::= ";"
	 */
	@Override
	public List<Node> visit(ContinueStatement n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= <BREAK> f1 ::= ";"
	 */
	@Override
	public List<Node> visit(BreakStatement n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= <RETURN> f1 ::= ( Expression() )? f2 ::= ";"
	 */
	@Override
	public List<Node> visit(ReturnStatement n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	/**
	 * f0 ::= AssignmentExpression() f1 ::= ( "," AssignmentExpression() )*
	 */
	@Override
	public List<Node> visit(Expression n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	@Override
	public List<Node> visit(DummyFlushDirective n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	@Override
	public List<Node> visit(PreCallNode n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	@Override
	public List<Node> visit(PostCallNode n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}

	@Override
	public List<Node> visit(CallStatement n, Object argu) {
		List<Node> _ret = null;
		initProcess(n, argu);
		endProcess(n, argu);
		return _ret;
	}
}
