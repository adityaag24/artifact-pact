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
 * f0 ::= OmpPragma()
 * f1 ::= <PARALLEL>
 * f2 ::= <FOR>
 * f3 ::= UniqueParallelOrUniqueForOrDataClauseList()
 * f4 ::= OmpEol()
 * f5 ::= OmpForHeader()
 * f6 ::= Statement()
 */
public class ParallelForConstruct extends ParallelConstruct {
	{
		classId = 940953;
	}

	public ParallelForConstruct() {
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = -1740103898467896216L;
	private OmpPragma f0;
	private NodeToken f1;
	private NodeToken f2;
	private UniqueParallelOrUniqueForOrDataClauseList f3;
	private OmpEol f4;
	private OmpForHeader f5;
	private Statement f6;

	public ParallelForConstruct(OmpPragma n0, NodeToken n1, NodeToken n2, UniqueParallelOrUniqueForOrDataClauseList n3,
			OmpEol n4, OmpForHeader n5, Statement n6) {
		n0.setParent(this);
		n1.setParent(this);
		n2.setParent(this);
		n3.setParent(this);
		n4.setParent(this);
		n5.setParent(this);
		n6.setParent(this);
		setF0(n0);
		setF1(n1);
		setF2(n2);
		setF3(n3);
		setF4(n4);
		setF5(n5);
		setF6(n6);
	}

	@Override
	public boolean isCFGNode() {
		return false;
	}

	public ParallelForConstruct(OmpPragma n0, UniqueParallelOrUniqueForOrDataClauseList n1, OmpEol n2, OmpForHeader n3,
			Statement n4) {
		n0.setParent(this);
		n1.setParent(this);
		n2.setParent(this);
		n3.setParent(this);
		n4.setParent(this);
		setF0(n0);
		setF1(new NodeToken("parallel"));
		getF1().setParent(this);
		setF2(new NodeToken("for"));
		getF2().setParent(this);
		setF3(n1);
		setF4(n2);
		setF5(n3);
		setF6(n4);
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

	public OmpPragma getF0() {
		return f0;
	}

	public void setF0(OmpPragma f0) {
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

	public UniqueParallelOrUniqueForOrDataClauseList getF3() {
		return f3;
	}

	public void setF3(UniqueParallelOrUniqueForOrDataClauseList f3) {
		f3.setParent(this);
		this.f3 = f3;
	}

	public OmpEol getF4() {
		return f4;
	}

	public void setF4(OmpEol f4) {
		f4.setParent(this);
		this.f4 = f4;
	}

	public OmpForHeader getF5() {
		return f5;
	}

	public void setF5(OmpForHeader f5) {
		f5.setParent(this);
		this.f5 = f5;
	}

	public Statement getF6() {
		return f6;
	}

	public void setF6(Statement f6) {
		f6.setParent(this);
		this.f6 = f6;
	}
}