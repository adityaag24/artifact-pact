/*
 * Copyright (c) 2019 Aman Nougrahiya, V Krishna Nandivada, IIT Madras.
 * This file is a part of the project IMOP, licensed under the MIT license.
 * See LICENSE.md for the full text of the license.
 * 
 * The above notice shall be included in all copies or substantial
 * portions of this file.
 */
//
// Generated by JTB 1.3.2
//

package imop.ast.node.external;

import imop.ast.info.cfgNodeInfo.FinalClauseInfo;
import imop.ast.node.internal.*;
import imop.parser.CParserConstants;

/**
 * Grammar production:
 * f0 ::= <FINAL>
 * f1 ::= "("
 * f2 ::= Expression()
 * f3 ::= ")"
 */
public class FinalClause extends OmpClause {
	{
		classId *= 461;
	}

	public FinalClause() {
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 2152817517670320936L;
	private NodeToken f0;
	private NodeToken f1;
	private Expression f2;
	private NodeToken f3;

	public FinalClause(NodeToken n0, NodeToken n1, Expression n2, NodeToken n3) {
		n0.setParent(this);
		n1.setParent(this);
		n2.setParent(this);
		n3.setParent(this);
		setF0(n0);
		setF1(n1);
		setF2(n2);
		setF3(n3);
	}

	public FinalClause(Expression n0) {
		n0.setParent(this);
		setF0(new NodeToken("final", CParserConstants.FINAL, -1, -1, -1, -1));
		getF0().setParent(this);
		setF1(new NodeToken("("));
		getF1().setParent(this);
		setF2(n0);
		setF3(new NodeToken(")"));
		getF3().setParent(this);
	}

	@Override
	public boolean isKnownCFGNode() {
		return true;
	}

	@Override
	public boolean isKnownCFGLeafNode() {
		return true;
	}

	@Override
	public FinalClauseInfo getInfo() {
		if (info == null) {
			info = new FinalClauseInfo(this);
		}
		return (FinalClauseInfo) info;
	}

	@Override
	public void accept(imop.baseVisitor.Visitor v) {
		v.visit(this);
	}

	@Override
	public <R, A> R accept(imop.baseVisitor.GJVisitor<R, A> v, A argu) {
		return v.visit(this, argu);
	}

	@Override
	public <R> R accept(imop.baseVisitor.GJNoArguVisitor<R> v) {
		return v.visit(this);
	}

	@Override
	public <A> void accept(imop.baseVisitor.GJVoidVisitor<A> v, A argu) {
		v.visit(this, argu);
	}

	public NodeToken getF0() {
		return f0;
	}

	public void setF0(NodeToken f0) {
		f0.setParent(this);
		this.f0 = f0;
	}

	public NodeToken getF1() {
		return f1;
	}

	public void setF1(NodeToken f1) {
		f1.setParent(this);
		this.f1 = f1;
	}

	public Expression getF2() {
		return f2;
	}

	public void setF2(Expression f2) {
		f2.setParent(this);
		this.f2 = f2;
	}

	public NodeToken getF3() {
		return f3;
	}

	public void setF3(NodeToken f3) {
		f3.setParent(this);
		this.f3 = f3;
	}
}
