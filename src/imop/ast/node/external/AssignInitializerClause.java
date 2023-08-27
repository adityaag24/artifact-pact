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
 * f0 ::= <INITIALIZER>
 * f1 ::= "("
 * f2 ::= <IDENTIFIER>
 * f3 ::= "="
 * f4 ::= Initializer()
 * f5 ::= ")"
 */
public class AssignInitializerClause extends Node {
	{
		classId = 83;
	}

	public AssignInitializerClause() {
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = -4979340891451169332L;
	private NodeToken f0;
	private NodeToken f1;
	private NodeToken f2;
	private NodeToken f3;
	private Initializer f4;
	private NodeToken f5;

	public AssignInitializerClause(NodeToken n0, NodeToken n1, NodeToken n2, NodeToken n3, Initializer n4,
			NodeToken n5) {
		n0.setParent(this);
		n1.setParent(this);
		n2.setParent(this);
		n3.setParent(this);
		n4.setParent(this);
		n5.setParent(this);
		setF0(n0);
		setF1(n1);
		setF2(n2);
		setF3(n3);
		setF4(n4);
		setF5(n5);
	}

	public AssignInitializerClause(NodeToken n0, Initializer n1) {
		n0.setParent(this);
		n1.setParent(this);
		setF0(new NodeToken("initializer"));
		getF0().setParent(this);
		setF1(new NodeToken("("));
		getF1().setParent(this);
		setF2(n0);
		setF3(new NodeToken("="));
		getF3().setParent(this);
		setF4(n1);
		setF5(new NodeToken(")"));
		getF5().setParent(this);
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

	public NodeToken getF2() {
		return f2;
	}

	public void setF2(NodeToken f2) {
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

	public Initializer getF4() {
		return f4;
	}

	public void setF4(Initializer f4) {
		f4.setParent(this);
		this.f4 = f4;
	}

	public NodeToken getF5() {
		return f5;
	}

	public void setF5(NodeToken f5) {
		f5.setParent(this);
		this.f5 = f5;
	}
}
