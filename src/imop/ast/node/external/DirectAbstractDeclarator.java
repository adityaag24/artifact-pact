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
 * f0 ::= AbstractDimensionOrParameter()
 * f1 ::= DimensionOrParameterList()
 */
public class DirectAbstractDeclarator extends Node {
	{
		classId = 857;
	}

	public DirectAbstractDeclarator() {
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 6242965057790234595L;
	private AbstractDimensionOrParameter f0;
	private DimensionOrParameterList f1;

	public DirectAbstractDeclarator(AbstractDimensionOrParameter n0, DimensionOrParameterList n1) {
		n0.setParent(this);
		n1.setParent(this);
		setF0(n0);
		setF1(n1);
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

	public AbstractDimensionOrParameter getF0() {
		return f0;
	}

	public void setF0(AbstractDimensionOrParameter f0) {
		f0.setParent(this);
		this.f0 = f0;
	}

	public DimensionOrParameterList getF1() {
		return f1;
	}

	public void setF1(DimensionOrParameterList f1) {
		f1.setParent(this);
		this.f1 = f1;
	}
}