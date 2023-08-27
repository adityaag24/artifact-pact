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

/**
 * Grammar production:
 * f0 ::= <IDENTIFIER>
 * f1 ::= "-="
 * f2 ::= Expression()
 */
public class ShortAssignMinus extends OmpForReinitExpression {
	{
		classId = 62663;
	}

	public ShortAssignMinus() {
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 352201972665899103L;
	private NodeToken f0;
	private NodeToken f1;
	private Expression f2;

	public ShortAssignMinus(NodeToken n0, NodeToken n1, Expression n2) {
		n0.setParent(this);
		n1.setParent(this);
		n2.setParent(this);
		setF0(n0);
		setF1(n1);
		setF2(n2);
	}

	public ShortAssignMinus(NodeToken n0, Expression n1) {
		n0.setParent(this);
		n1.setParent(this);
		setF0(n0);
		setF1(new NodeToken("-="));
		getF1().setParent(this);
		setF2(n1);
	}

	@Override
	public boolean isCFGNode() {
		return false;
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
}
