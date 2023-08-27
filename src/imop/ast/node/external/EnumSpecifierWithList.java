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
 * f0 ::= <ENUM>
 * f1 ::= ( <IDENTIFIER> )?
 * f2 ::= "{"
 * f3 ::= EnumeratorList()
 * f4 ::= "}"
 */
public class EnumSpecifierWithList extends Node {
	{
		classId = 1489;
	}

	public EnumSpecifierWithList() {
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 1154521680784453971L;
	private NodeToken f0;
	private NodeOptional f1;
	private NodeToken f2;
	private EnumeratorList f3;
	private NodeToken f4;

	public EnumSpecifierWithList(NodeToken n0, NodeOptional n1, NodeToken n2, EnumeratorList n3, NodeToken n4) {
		n0.setParent(this);
		n1.setParent(this);
		n2.setParent(this);
		n3.setParent(this);
		n4.setParent(this);
		setF0(n0);
		setF1(n1);
		setF2(n2);
		setF3(n3);
		setF4(n4);
	}

	public EnumSpecifierWithList(NodeOptional n0, EnumeratorList n1) {
		n0.setParent(this);
		n1.setParent(this);
		setF0(new NodeToken("enum"));
		getF0().setParent(this);
		setF1(n0);
		setF2(new NodeToken("{"));
		getF2().setParent(this);
		setF3(n1);
		setF4(new NodeToken("}"));
		getF4().setParent(this);
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

	public NodeOptional getF1() {
		return f1;
	}

	public void setF1(NodeOptional f1) {
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

	public EnumeratorList getF3() {
		return f3;
	}

	public void setF3(EnumeratorList f3) {
		f3.setParent(this);
		this.f3 = f3;
	}

	public NodeToken getF4() {
		return f4;
	}

	public void setF4(NodeToken f4) {
		f4.setParent(this);
		this.f4 = f4;
	}
}
