/*
 * Copyright (c) 2019 Aman Nougrahiya, V Krishna Nandivada, IIT Madras.
 * This file is a part of the project IMOP, licensed under the MIT license.
 * See LICENSE.md for the full text of the license.
 * 
 * The above notice shall be included in all copies or substantial
 * portions of this file.
 */
package imop.baseVisitor;

import imop.ast.node.external.*;
import imop.ast.node.internal.*;

/**
 * Provides default methods which visit each node in the tree in depth-first
 * order. Your visitors may extend this class.
 */
public class GJNoArguDepthFirstProcess<R> extends GJNoArguDepthFirst<R> {
	//
	// Auto class visitors--probably don't need to be overridden.
	//

	public R initProcess(Node n) {
		return null;
	}

	public R endProcess(Node n) {
		return null;
	}

	@Override
	public R visit(NodeList n) {
		R _ret = null;
		initProcess(n);
		for (Node e : n.getNodes()) {
			_ret = e.accept(this);
		}
		endProcess(n);
		return _ret;
	}

	@Override
	public R visit(NodeListOptional n) {
		R _ret = null;
		initProcess(n);
		if (n.present()) {
			for (Node e : n.getNodes()) {
				_ret = e.accept(this);
			}
		}
		endProcess(n);
		return _ret;
	}

	@Override
	public R visit(NodeOptional n) {
		R _ret = null;
		initProcess(n);
		if (n.present()) {
			_ret = n.getNode().accept(this);
		}
		endProcess(n);
		return _ret;
	}

	@Override
	public R visit(NodeSequence n) {
		R _ret = null;
		initProcess(n);
		for (Node e : n.getNodes()) {
			_ret = e.accept(this);
		}
		endProcess(n);
		return _ret;
	}

	@Override
	public R visit(NodeChoice n) {
		R _ret = null;
		initProcess(n);
		_ret = n.getChoice().accept(this);
		endProcess(n);
		return _ret;
	}

	@Override
	public R visit(NodeToken n) {
		initProcess(n);
		endProcess(n);
		return null;
	}

	//
	// User-generated visitor methods below
	//

	/**
	 * f0 ::= ( ElementsOfTranslation() )+
	 */
	@Override
	public R visit(TranslationUnit n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ExternalDeclaration()
	 * | UnknownCpp()
	 * | UnknownPragma()
	 */
	@Override
	public R visit(ElementsOfTranslation n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= Declaration()
	 * | FunctionDefinition()
	 * | DeclareReductionDirective()
	 * | ThreadPrivateDirective()
	 */
	@Override
	public R visit(ExternalDeclaration n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( DeclarationSpecifiers() )?
	 * f1 ::= Declarator()
	 * f2 ::= ( DeclarationList() )?
	 * f3 ::= CompoundStatement()
	 */
	@Override
	public R visit(FunctionDefinition n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= DeclarationSpecifiers()
	 * f1 ::= ( InitDeclaratorList() )?
	 * f2 ::= ";"
	 */
	@Override
	public R visit(Declaration n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( Declaration() )+
	 */
	@Override
	public R visit(DeclarationList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( ADeclarationSpecifier() )+
	 */
	@Override
	public R visit(DeclarationSpecifiers n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= StorageClassSpecifier()
	 * | TypeSpecifier()
	 * | TypeQualifier()
	 */
	@Override
	public R visit(ADeclarationSpecifier n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <AUTO>
	 * | <REGISTER>
	 * | <STATIC>
	 * | <EXTERN>
	 * | <TYPEDEF>
	 */
	@Override
	public R visit(StorageClassSpecifier n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( <VOID> | <CHAR> | <SHORT> | <INT> | <LONG> | <FLOAT> | <DOUBLE>
	 * |
	 * <SIGNED> | <UNSIGNED> | StructOrUnionSpecifier() | EnumSpecifier() |
	 * TypedefName() )
	 */
	@Override
	public R visit(TypeSpecifier n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <RESTRICT>
	 * | <CONST>
	 * | <VOLATILE>
	 * | <INLINE>
	 * | <CCONST>
	 * | <CINLINED>
	 * | <CINLINED2>
	 * | <CSIGNED>
	 * | <CSIGNED2>
	 */
	@Override
	public R visit(TypeQualifier n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * 
	 * f0 ::= ( StructOrUnionSpecifierWithList() |
	 * StructOrUnionSpecifierWithId()
	 * )
	 */
	@Override
	public R visit(StructOrUnionSpecifier n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= StructOrUnion()
	 * f1 ::= ( <IDENTIFIER> )?
	 * f2 ::= "{"
	 * f3 ::= StructDeclarationList()
	 * f4 ::= "}"
	 */
	@Override
	public R visit(StructOrUnionSpecifierWithList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= StructOrUnion()
	 * f1 ::= <IDENTIFIER>
	 */
	@Override
	public R visit(StructOrUnionSpecifierWithId n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <STRUCT>
	 * | <UNION>
	 */
	@Override
	public R visit(StructOrUnion n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( StructDeclaration() )+
	 */
	@Override
	public R visit(StructDeclarationList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= InitDeclarator()
	 * f1 ::= ( "," InitDeclarator() )*
	 */
	@Override
	public R visit(InitDeclaratorList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= Declarator()
	 * f1 ::= ( "=" Initializer() )?
	 */
	@Override
	public R visit(InitDeclarator n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= SpecifierQualifierList()
	 * f1 ::= StructDeclaratorList()
	 * f2 ::= ";"
	 */
	@Override
	public R visit(StructDeclaration n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( ASpecifierQualifier() )+
	 */
	@Override
	public R visit(SpecifierQualifierList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= TypeSpecifier()
	 * | TypeQualifier()
	 */
	@Override
	public R visit(ASpecifierQualifier n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= StructDeclarator()
	 * f1 ::= ( "," StructDeclarator() )*
	 */
	@Override
	public R visit(StructDeclaratorList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= StructDeclaratorWithDeclarator()
	 * | StructDeclaratorWithBitField()
	 */
	@Override
	public R visit(StructDeclarator n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= Declarator()
	 * f1 ::= ( ":" ConstantExpression() )?
	 */
	@Override
	public R visit(StructDeclaratorWithDeclarator n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ":"
	 * f1 ::= ConstantExpression()
	 */
	@Override
	public R visit(StructDeclaratorWithBitField n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= EnumSpecifierWithList()
	 * | EnumSpecifierWithId()
	 */
	@Override
	public R visit(EnumSpecifier n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <ENUM>
	 * f1 ::= ( <IDENTIFIER> )?
	 * f2 ::= "{"
	 * f3 ::= EnumeratorList()
	 * f4 ::= "}"
	 */
	@Override
	public R visit(EnumSpecifierWithList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <ENUM>
	 * f1 ::= <IDENTIFIER>
	 */
	@Override
	public R visit(EnumSpecifierWithId n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= Enumerator()
	 * f1 ::= ( "," Enumerator() )*
	 */
	@Override
	public R visit(EnumeratorList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= ( "=" ConstantExpression() )?
	 */
	@Override
	public R visit(Enumerator n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( Pointer() )?
	 * f1 ::= DirectDeclarator()
	 */
	@Override
	public R visit(Declarator n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= IdentifierOrDeclarator()
	 * f1 ::= DeclaratorOpList()
	 */
	@Override
	public R visit(DirectDeclarator n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( ADeclaratorOp() )*
	 */
	@Override
	public R visit(DeclaratorOpList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= DimensionSize()
	 * | ParameterTypeListClosed()
	 * | OldParameterListClosed()
	 */
	@Override
	public R visit(ADeclaratorOp n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "["
	 * f1 ::= ( ConstantExpression() )?
	 * f2 ::= "]"
	 */
	@Override
	public R visit(DimensionSize n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "("
	 * f1 ::= ( ParameterTypeList() )?
	 * f2 ::= ")"
	 */
	@Override
	public R visit(ParameterTypeListClosed n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "("
	 * f1 ::= ( OldParameterList() )?
	 * f2 ::= ")"
	 */
	@Override
	public R visit(OldParameterListClosed n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * | "(" Declarator() ")"
	 */
	@Override
	public R visit(IdentifierOrDeclarator n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( "*" | "^" )
	 * f1 ::= ( TypeQualifierList() )?
	 * f2 ::= ( Pointer() )?
	 */
	@Override
	public R visit(Pointer n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( TypeQualifier() )+
	 */
	@Override
	public R visit(TypeQualifierList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ParameterList()
	 * f1 ::= ( "," "..." )?
	 */
	@Override
	public R visit(ParameterTypeList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ParameterDeclaration()
	 * f1 ::= ( "," ParameterDeclaration() )*
	 */
	@Override
	public R visit(ParameterList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= DeclarationSpecifiers()
	 * f1 ::= ParameterAbstraction()
	 */
	@Override
	public R visit(ParameterDeclaration n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= Declarator()
	 * | AbstractOptionalDeclarator()
	 */
	@Override
	public R visit(ParameterAbstraction n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( AbstractDeclarator() )?
	 */
	@Override
	public R visit(AbstractOptionalDeclarator n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= ( "," <IDENTIFIER> )*
	 */
	@Override
	public R visit(OldParameterList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= AssignmentExpression()
	 * | ArrayInitializer()
	 */
	@Override
	public R visit(Initializer n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "{"
	 * f1 ::= InitializerList()
	 * f2 ::= ( "," )?
	 * f3 ::= "}"
	 */
	@Override
	public R visit(ArrayInitializer n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= Initializer()
	 * f1 ::= ( "," Initializer() )*
	 */
	@Override
	public R visit(InitializerList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= SpecifierQualifierList()
	 * f1 ::= ( AbstractDeclarator() )?
	 */
	@Override
	public R visit(TypeName n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= AbstractDeclaratorWithPointer()
	 * | DirectAbstractDeclarator()
	 */
	@Override
	public R visit(AbstractDeclarator n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= Pointer()
	 * f1 ::= ( DirectAbstractDeclarator() )?
	 */
	@Override
	public R visit(AbstractDeclaratorWithPointer n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= AbstractDimensionOrParameter()
	 * f1 ::= DimensionOrParameterList()
	 */
	@Override
	public R visit(DirectAbstractDeclarator n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= AbstractDeclaratorClosed()
	 * | DimensionSize()
	 * | ParameterTypeListClosed()
	 */
	@Override
	public R visit(AbstractDimensionOrParameter n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "("
	 * f1 ::= AbstractDeclarator()
	 * f2 ::= ")"
	 */
	@Override
	public R visit(AbstractDeclaratorClosed n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( ADimensionOrParameter() )*
	 */
	@Override
	public R visit(DimensionOrParameterList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= DimensionSize()
	 * | ParameterTypeListClosed()
	 */
	@Override
	public R visit(ADimensionOrParameter n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 */
	@Override
	public R visit(TypedefName n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( LabeledStatement() | ExpressionStatement() | CompoundStatement()
	 * | SelectionStatement() | IterationStatement() | JumpStatement() |
	 * UnknownPragma() | OmpConstruct() | OmpDirective() | UnknownCpp() )
	 */
	@Override
	public R visit(Statement n) {
		R _ret = null;
		initProcess(n);
		n.getStmtF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "#"
	 * f1 ::= <UNKNOWN_CPP>
	 */
	@Override
	public R visit(UnknownCpp n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <OMP_CR>
	 * | <OMP_NL>
	 */
	@Override
	public R visit(OmpEol n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ParallelConstruct()
	 * | ForConstruct()
	 * | SectionsConstruct()
	 * | SingleConstruct()
	 * | ParallelForConstruct()
	 * | ParallelSectionsConstruct()
	 * | TaskConstruct()
	 * | MasterConstruct()
	 * | CriticalConstruct()
	 * | AtomicConstruct()
	 * | OrderedConstruct()
	 */
	@Override
	public R visit(OmpConstruct n) {
		R _ret = null;
		initProcess(n);
		n.getOmpConsF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= BarrierDirective()
	 * | TaskwaitDirective()
	 * | TaskyieldDirective()
	 * | FlushDirective()
	 */
	@Override
	public R visit(OmpDirective n) {
		R _ret = null;
		initProcess(n);
		n.getOmpDirF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= ParallelDirective()
	 * f2 ::= Statement()
	 */
	@Override
	public R visit(ParallelConstruct n) {
		R _ret = null;
		initProcess(n);
		n.getParConsF0().accept(this);
		n.getParConsF1().accept(this);
		n.getParConsF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "#"
	 * f1 ::= <PRAGMA>
	 * f2 ::= <OMP>
	 */
	@Override
	public R visit(OmpPragma n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "#"
	 * f1 ::= <PRAGMA>
	 * f2 ::= <UNKNOWN_CPP>
	 */
	@Override
	public R visit(UnknownPragma n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <PARALLEL>
	 * f1 ::= UniqueParallelOrDataClauseList()
	 * f2 ::= OmpEol()
	 */
	@Override
	public R visit(ParallelDirective n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( AUniqueParallelOrDataClause() )*
	 */
	@Override
	public R visit(UniqueParallelOrDataClauseList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= UniqueParallelClause()
	 * | DataClause()
	 */
	@Override
	public R visit(AUniqueParallelOrDataClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= IfClause()
	 * | NumThreadsClause()
	 */
	@Override
	public R visit(UniqueParallelClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IF>
	 * f1 ::= "("
	 * f2 ::= Expression()
	 * f3 ::= ")"
	 */
	@Override
	public R visit(IfClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <NUM_THREADS>
	 * f1 ::= "("
	 * f2 ::= Expression()
	 * f3 ::= ")"
	 */
	@Override
	public R visit(NumThreadsClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPrivateClause()
	 * | OmpFirstPrivateClause()
	 * | OmpLastPrivateClause()
	 * | OmpSharedClause()
	 * | OmpCopyinClause()
	 * | OmpDfltSharedClause()
	 * | OmpDfltNoneClause()
	 * | OmpReductionClause()
	 */
	@Override
	public R visit(DataClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <PRIVATE>
	 * f1 ::= "("
	 * f2 ::= VariableList()
	 * f3 ::= ")"
	 */
	@Override
	public R visit(OmpPrivateClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <FIRSTPRIVATE>
	 * f1 ::= "("
	 * f2 ::= VariableList()
	 * f3 ::= ")"
	 */
	@Override
	public R visit(OmpFirstPrivateClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <LASTPRIVATE>
	 * f1 ::= "("
	 * f2 ::= VariableList()
	 * f3 ::= ")"
	 */
	@Override
	public R visit(OmpLastPrivateClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <SHARED>
	 * f1 ::= "("
	 * f2 ::= VariableList()
	 * f3 ::= ")"
	 */
	@Override
	public R visit(OmpSharedClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <COPYIN>
	 * f1 ::= "("
	 * f2 ::= VariableList()
	 * f3 ::= ")"
	 */
	@Override
	public R visit(OmpCopyinClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <DFLT>
	 * f1 ::= "("
	 * f2 ::= <SHARED>
	 * f3 ::= ")"
	 */
	@Override
	public R visit(OmpDfltSharedClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <DFLT>
	 * f1 ::= "("
	 * f2 ::= <NONE>
	 * f3 ::= ")"
	 */
	@Override
	public R visit(OmpDfltNoneClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <REDUCTION>
	 * f1 ::= "("
	 * f2 ::= ReductionOp()
	 * f3 ::= ":"
	 * f4 ::= VariableList()
	 * f5 ::= ")"
	 */
	@Override
	public R visit(OmpReductionClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		n.getF5().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= ForDirective()
	 * f2 ::= OmpForHeader()
	 * f3 ::= Statement()
	 */
	@Override
	public R visit(ForConstruct n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <FOR>
	 * f1 ::= UniqueForOrDataOrNowaitClauseList()
	 * f2 ::= OmpEol()
	 */
	@Override
	public R visit(ForDirective n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( AUniqueForOrDataOrNowaitClause() )*
	 */
	@Override
	public R visit(UniqueForOrDataOrNowaitClauseList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= UniqueForClause()
	 * | DataClause()
	 * | NowaitClause()
	 */
	@Override
	public R visit(AUniqueForOrDataOrNowaitClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <NOWAIT>
	 */
	@Override
	public R visit(NowaitClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <ORDERED>
	 * | UniqueForClauseSchedule()
	 * | UniqueForCollapse()
	 */
	@Override
	public R visit(UniqueForClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <COLLAPSE>
	 * f1 ::= "("
	 * f2 ::= Expression()
	 * f3 ::= ")"
	 */
	@Override
	public R visit(UniqueForCollapse n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <SCHEDULE>
	 * f1 ::= "("
	 * f2 ::= ScheduleKind()
	 * f3 ::= ( "," Expression() )?
	 * f4 ::= ")"
	 */
	@Override
	public R visit(UniqueForClauseSchedule n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <STATIC>
	 * | <DYNAMIC>
	 * | <GUIDED>
	 * | <RUNTIME>
	 */
	@Override
	public R visit(ScheduleKind n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <FOR>
	 * f1 ::= "("
	 * f2 ::= OmpForInitExpression()
	 * f3 ::= ";"
	 * f4 ::= OmpForCondition()
	 * f5 ::= ";"
	 * f6 ::= OmpForReinitExpression()
	 * f7 ::= ")"
	 */
	@Override
	public R visit(OmpForHeader n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		n.getF5().accept(this);
		n.getF6().accept(this);
		n.getF7().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= "="
	 * f2 ::= Expression()
	 */
	@Override
	public R visit(OmpForInitExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpForLTCondition()
	 * | OmpForLECondition()
	 * | OmpForGTCondition()
	 * | OmpForGECondition()
	 */
	@Override
	public R visit(OmpForCondition n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= "<"
	 * f2 ::= Expression()
	 */
	@Override
	public R visit(OmpForLTCondition n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= "<="
	 * f2 ::= Expression()
	 */
	@Override
	public R visit(OmpForLECondition n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= ">"
	 * f2 ::= Expression()
	 */
	@Override
	public R visit(OmpForGTCondition n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= ">="
	 * f2 ::= Expression()
	 */
	@Override
	public R visit(OmpForGECondition n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= PostIncrementId()
	 * | PostDecrementId()
	 * | PreIncrementId()
	 * | PreDecrementId()
	 * | ShortAssignPlus()
	 * | ShortAssignMinus()
	 * | OmpForAdditive()
	 * | OmpForSubtractive()
	 * | OmpForMultiplicative()
	 */
	@Override
	public R visit(OmpForReinitExpression n) {
		R _ret = null;
		initProcess(n);
		n.getOmpForReinitF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= "++"
	 */
	@Override
	public R visit(PostIncrementId n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= "--"
	 */
	@Override
	public R visit(PostDecrementId n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "++"
	 * f1 ::= <IDENTIFIER>
	 */
	@Override
	public R visit(PreIncrementId n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "--"
	 * f1 ::= <IDENTIFIER>
	 */
	@Override
	public R visit(PreDecrementId n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= "+="
	 * f2 ::= Expression()
	 */
	@Override
	public R visit(ShortAssignPlus n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= "-="
	 * f2 ::= Expression()
	 */
	@Override
	public R visit(ShortAssignMinus n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= "="
	 * f2 ::= <IDENTIFIER>
	 * f3 ::= "+"
	 * f4 ::= AdditiveExpression()
	 */
	@Override
	public R visit(OmpForAdditive n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= "="
	 * f2 ::= <IDENTIFIER>
	 * f3 ::= "-"
	 * f4 ::= AdditiveExpression()
	 */
	@Override
	public R visit(OmpForSubtractive n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= "="
	 * f2 ::= MultiplicativeExpression()
	 * f3 ::= "+"
	 * f4 ::= <IDENTIFIER>
	 */
	@Override
	public R visit(OmpForMultiplicative n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <SECTIONS>
	 * f2 ::= NowaitDataClauseList()
	 * f3 ::= OmpEol()
	 * f4 ::= SectionsScope()
	 */
	@Override
	public R visit(SectionsConstruct n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( ANowaitDataClause() )*
	 */
	@Override
	public R visit(NowaitDataClauseList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= NowaitClause()
	 * | DataClause()
	 */
	@Override
	public R visit(ANowaitDataClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "{"
	 * f1 ::= ( Statement() )?
	 * f2 ::= ( ASection() )*
	 * f3 ::= "}"
	 */
	@Override
	public R visit(SectionsScope n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <SECTION>
	 * f2 ::= OmpEol()
	 * f3 ::= Statement()
	 */
	@Override
	public R visit(ASection n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <SINGLE>
	 * f2 ::= SingleClauseList()
	 * f3 ::= OmpEol()
	 * f4 ::= Statement()
	 */
	@Override
	public R visit(SingleConstruct n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( ASingleClause() )*
	 */
	@Override
	public R visit(SingleClauseList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= NowaitClause()
	 * | DataClause()
	 * | OmpCopyPrivateClause()
	 */
	@Override
	public R visit(ASingleClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <COPYPRIVATE>
	 * f1 ::= "("
	 * f2 ::= VariableList()
	 * f3 ::= ")"
	 */
	@Override
	public R visit(OmpCopyPrivateClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <TASK>
	 * f2 ::= ( TaskClause() )*
	 * f3 ::= OmpEol()
	 * f4 ::= Statement()
	 */
	@Override
	public R visit(TaskConstruct n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= DataClause()
	 * | UniqueTaskClause()
	 */
	@Override
	public R visit(TaskClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= IfClause()
	 * | FinalClause()
	 * | UntiedClause()
	 * | MergeableClause()
	 */
	@Override
	public R visit(UniqueTaskClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <FINAL>
	 * f1 ::= "("
	 * f2 ::= Expression()
	 * f3 ::= ")"
	 */
	@Override
	public R visit(FinalClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <UNTIED>
	 */
	@Override
	public R visit(UntiedClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <MERGEABLE>
	 */
	@Override
	public R visit(MergeableClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <PARALLEL>
	 * f2 ::= <FOR>
	 * f3 ::= UniqueParallelOrUniqueForOrDataClauseList()
	 * f4 ::= OmpEol()
	 * f5 ::= OmpForHeader()
	 * f6 ::= Statement()
	 */
	@Override
	public R visit(ParallelForConstruct n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		n.getF5().accept(this);
		n.getF6().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( AUniqueParallelOrUniqueForOrDataClause() )*
	 */
	@Override
	public R visit(UniqueParallelOrUniqueForOrDataClauseList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= UniqueParallelClause()
	 * | UniqueForClause()
	 * | DataClause()
	 */
	@Override
	public R visit(AUniqueParallelOrUniqueForOrDataClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <PARALLEL>
	 * f2 ::= <SECTIONS>
	 * f3 ::= UniqueParallelOrDataClauseList()
	 * f4 ::= OmpEol()
	 * f5 ::= SectionsScope()
	 */
	@Override
	public R visit(ParallelSectionsConstruct n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		n.getF5().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <MASTER>
	 * f2 ::= OmpEol()
	 * f3 ::= Statement()
	 */
	@Override
	public R visit(MasterConstruct n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <CRITICAL>
	 * f2 ::= ( RegionPhrase() )?
	 * f3 ::= OmpEol()
	 * f4 ::= Statement()
	 */
	@Override
	public R visit(CriticalConstruct n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "("
	 * f1 ::= <IDENTIFIER>
	 * f2 ::= ")"
	 */
	@Override
	public R visit(RegionPhrase n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <ATOMIC>
	 * f2 ::= ( AtomicClause() )?
	 * f3 ::= OmpEol()
	 * f4 ::= ExpressionStatement()
	 */
	@Override
	public R visit(AtomicConstruct n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <READ>
	 * | <WRITE>
	 * | <UPDATE>
	 * | <CAPTURE>
	 */
	@Override
	public R visit(AtomicClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <FLUSH>
	 * f2 ::= ( FlushVars() )?
	 * f3 ::= OmpEol()
	 */
	@Override
	public R visit(FlushDirective n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "("
	 * f1 ::= VariableList()
	 * f2 ::= ")"
	 */
	@Override
	public R visit(FlushVars n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <ORDERED>
	 * f2 ::= OmpEol()
	 * f3 ::= Statement()
	 */
	@Override
	public R visit(OrderedConstruct n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <BARRIER>
	 * f2 ::= OmpEol()
	 */
	@Override
	public R visit(BarrierDirective n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <TASKWAIT>
	 * f2 ::= OmpEol()
	 */
	@Override
	public R visit(TaskwaitDirective n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <TASKYIELD>
	 * f2 ::= OmpEol()
	 */
	@Override
	public R visit(TaskyieldDirective n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <THREADPRIVATE>
	 * f2 ::= "("
	 * f3 ::= VariableList()
	 * f4 ::= ")"
	 * f5 ::= OmpEol()
	 */
	@Override
	public R visit(ThreadPrivateDirective n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		n.getF5().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= OmpPragma()
	 * f1 ::= <DECLARE>
	 * f2 ::= <REDUCTION>
	 * f3 ::= "("
	 * f4 ::= ReductionOp()
	 * f5 ::= ":"
	 * f6 ::= ReductionTypeList()
	 * f7 ::= ":"
	 * f8 ::= Expression()
	 * f9 ::= ")"
	 * f10 ::= ( InitializerClause() )?
	 * f11 ::= OmpEol()
	 */
	@Override
	public R visit(DeclareReductionDirective n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		n.getF5().accept(this);
		n.getF6().accept(this);
		n.getF7().accept(this);
		n.getF8().accept(this);
		n.getF9().accept(this);
		n.getF10().accept(this);
		n.getF11().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( TypeSpecifier() )*
	 */
	@Override
	public R visit(ReductionTypeList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= AssignInitializerClause()
	 * | ArgumentInitializerClause()
	 */
	@Override
	public R visit(InitializerClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <INITIALIZER>
	 * f1 ::= "("
	 * f2 ::= <IDENTIFIER>
	 * f3 ::= "="
	 * f4 ::= Initializer()
	 * f5 ::= ")"
	 */
	@Override
	public R visit(AssignInitializerClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		n.getF5().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <INITIALIZER>
	 * f1 ::= "("
	 * f2 ::= <IDENTIFIER>
	 * f3 ::= "("
	 * f4 ::= ExpressionList()
	 * f5 ::= ")"
	 * f6 ::= ")"
	 */
	@Override
	public R visit(ArgumentInitializerClause n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		n.getF5().accept(this);
		n.getF6().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * | "+"
	 * | "*"
	 * | "-"
	 * | "&"
	 * | "^"
	 * | "|"
	 * | "||"
	 * | "&&"
	 */
	@Override
	public R visit(ReductionOp n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= ( "," <IDENTIFIER> )*
	 */
	@Override
	public R visit(VariableList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= SimpleLabeledStatement()
	 * | CaseLabeledStatement()
	 * | DefaultLabeledStatement()
	 */
	@Override
	public R visit(LabeledStatement n) {
		R _ret = null;
		initProcess(n);
		n.getLabStmtF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * f1 ::= ":"
	 * f2 ::= Statement()
	 */
	@Override
	public R visit(SimpleLabeledStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <CASE>
	 * f1 ::= ConstantExpression()
	 * f2 ::= ":"
	 * f3 ::= Statement()
	 */
	@Override
	public R visit(CaseLabeledStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <DFLT>
	 * f1 ::= ":"
	 * f2 ::= Statement()
	 */
	@Override
	public R visit(DefaultLabeledStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( Expression() )?
	 * f1 ::= ";"
	 */
	@Override
	public R visit(ExpressionStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "{"
	 * f1 ::= ( CompoundStatementElement() )*
	 * f2 ::= "}"
	 */
	@Override
	public R visit(CompoundStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= Declaration()
	 * | Statement()
	 */
	@Override
	public R visit(CompoundStatementElement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= IfStatement()
	 * | SwitchStatement()
	 */
	@Override
	public R visit(SelectionStatement n) {
		R _ret = null;
		initProcess(n);
		n.getSelStmtF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IF>
	 * f1 ::= "("
	 * f2 ::= Expression()
	 * f3 ::= ")"
	 * f4 ::= Statement()
	 * f5 ::= ( <ELSE> Statement() )?
	 */
	@Override
	public R visit(IfStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		n.getF5().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <SWITCH>
	 * f1 ::= "("
	 * f2 ::= Expression()
	 * f3 ::= ")"
	 * f4 ::= Statement()
	 */
	@Override
	public R visit(SwitchStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= WhileStatement()
	 * | DoStatement()
	 * | ForStatement()
	 */
	@Override
	public R visit(IterationStatement n) {
		R _ret = null;
		initProcess(n);
		n.getItStmtF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <WHILE>
	 * f1 ::= "("
	 * f2 ::= Expression()
	 * f3 ::= ")"
	 * f4 ::= Statement()
	 */
	@Override
	public R visit(WhileStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <DO>
	 * f1 ::= Statement()
	 * f2 ::= <WHILE>
	 * f3 ::= "("
	 * f4 ::= Expression()
	 * f5 ::= ")"
	 * f6 ::= ";"
	 */
	@Override
	public R visit(DoStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		n.getF5().accept(this);
		n.getF6().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <FOR>
	 * f1 ::= "("
	 * f2 ::= ( Expression() )?
	 * f3 ::= ";"
	 * f4 ::= ( Expression() )?
	 * f5 ::= ";"
	 * f6 ::= ( Expression() )?
	 * f7 ::= ")"
	 * f8 ::= Statement()
	 */
	@Override
	public R visit(ForStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		n.getF4().accept(this);
		n.getF5().accept(this);
		n.getF6().accept(this);
		n.getF7().accept(this);
		n.getF8().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= GotoStatement()
	 * | ContinueStatement()
	 * | BreakStatement()
	 * | ReturnStatement()
	 */
	@Override
	public R visit(JumpStatement n) {
		R _ret = null;
		initProcess(n);
		n.getJumpStmtF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <GOTO>
	 * f1 ::= <IDENTIFIER>
	 * f2 ::= ";"
	 */
	@Override
	public R visit(GotoStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <CONTINUE>
	 * f1 ::= ";"
	 */
	@Override
	public R visit(ContinueStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <BREAK>
	 * f1 ::= ";"
	 */
	@Override
	public R visit(BreakStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <RETURN>
	 * f1 ::= ( Expression() )?
	 * f2 ::= ";"
	 */
	@Override
	public R visit(ReturnStatement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= AssignmentExpression()
	 * f1 ::= ( "," AssignmentExpression() )*
	 */
	@Override
	public R visit(Expression n) {
		R _ret = null;
		initProcess(n);
		n.getExpF0().accept(this);
		n.getExpF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= NonConditionalExpression()
	 * | ConditionalExpression()
	 */
	@Override
	public R visit(AssignmentExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= UnaryExpression()
	 * f1 ::= AssignmentOperator()
	 * f2 ::= AssignmentExpression()
	 */
	@Override
	public R visit(NonConditionalExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "="
	 * | "*="
	 * | "/="
	 * | "%="
	 * | "+="
	 * | "-="
	 * | "<<="
	 * | ">>="
	 * | "&="
	 * | "^="
	 * | "|="
	 */
	@Override
	public R visit(AssignmentOperator n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= LogicalORExpression()
	 * f1 ::= ( "?" Expression() ":" ConditionalExpression() )?
	 */
	@Override
	public R visit(ConditionalExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ConditionalExpression()
	 */
	@Override
	public R visit(ConstantExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= LogicalANDExpression()
	 * f1 ::= ( "||" LogicalORExpression() )?
	 */
	@Override
	public R visit(LogicalORExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= InclusiveORExpression()
	 * f1 ::= ( "&&" LogicalANDExpression() )?
	 */
	@Override
	public R visit(LogicalANDExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ExclusiveORExpression()
	 * f1 ::= ( "|" InclusiveORExpression() )?
	 */
	@Override
	public R visit(InclusiveORExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ANDExpression()
	 * f1 ::= ( "^" ExclusiveORExpression() )?
	 */
	@Override
	public R visit(ExclusiveORExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= EqualityExpression()
	 * f1 ::= ( "&" ANDExpression() )?
	 */
	@Override
	public R visit(ANDExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= RelationalExpression()
	 * f1 ::= ( EqualOptionalExpression() )?
	 */
	@Override
	public R visit(EqualityExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= EqualExpression()
	 * | NonEqualExpression()
	 */
	@Override
	public R visit(EqualOptionalExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "=="
	 * f1 ::= EqualityExpression()
	 */
	@Override
	public R visit(EqualExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "!="
	 * f1 ::= EqualityExpression()
	 */
	@Override
	public R visit(NonEqualExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ShiftExpression()
	 * f1 ::= ( RelationalOptionalExpression() )?
	 */
	@Override
	public R visit(RelationalExpression n) {
		R _ret = null;
		initProcess(n);
		n.getRelExpF0().accept(this);
		n.getRelExpF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= RelationalLTExpression()
	 * | RelationalGTExpression()
	 * | RelationalLEExpression()
	 * | RelationalGEExpression()
	 */
	@Override
	public R visit(RelationalOptionalExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "<"
	 * f1 ::= RelationalExpression()
	 */
	@Override
	public R visit(RelationalLTExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ">"
	 * f1 ::= RelationalExpression()
	 */
	@Override
	public R visit(RelationalGTExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "<="
	 * f1 ::= RelationalExpression()
	 */
	@Override
	public R visit(RelationalLEExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ">="
	 * f1 ::= RelationalExpression()
	 */
	@Override
	public R visit(RelationalGEExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= AdditiveExpression()
	 * f1 ::= ( ShiftOptionalExpression() )?
	 */
	@Override
	public R visit(ShiftExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ShiftLeftExpression()
	 * | ShiftRightExpression()
	 */
	@Override
	public R visit(ShiftOptionalExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ">>"
	 * f1 ::= ShiftExpression()
	 */
	@Override
	public R visit(ShiftLeftExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "<<"
	 * f1 ::= ShiftExpression()
	 */
	@Override
	public R visit(ShiftRightExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= MultiplicativeExpression()
	 * f1 ::= ( AdditiveOptionalExpression() )?
	 */
	@Override
	public R visit(AdditiveExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= AdditivePlusExpression()
	 * | AdditiveMinusExpression()
	 */
	@Override
	public R visit(AdditiveOptionalExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "+"
	 * f1 ::= AdditiveExpression()
	 */
	@Override
	public R visit(AdditivePlusExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "-"
	 * f1 ::= AdditiveExpression()
	 */
	@Override
	public R visit(AdditiveMinusExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= CastExpression()
	 * f1 ::= ( MultiplicativeOptionalExpression() )?
	 */
	@Override
	public R visit(MultiplicativeExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= MultiplicativeMultiExpression()
	 * | MultiplicativeDivExpression()
	 * | MultiplicativeModExpression()
	 */
	@Override
	public R visit(MultiplicativeOptionalExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "*"
	 * f1 ::= MultiplicativeExpression()
	 */
	@Override
	public R visit(MultiplicativeMultiExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "/"
	 * f1 ::= MultiplicativeExpression()
	 */
	@Override
	public R visit(MultiplicativeDivExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "%"
	 * f1 ::= MultiplicativeExpression()
	 */
	@Override
	public R visit(MultiplicativeModExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= CastExpressionTyped()
	 * | UnaryExpression()
	 */
	@Override
	public R visit(CastExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "("
	 * f1 ::= TypeName()
	 * f2 ::= ")"
	 * f3 ::= CastExpression()
	 */
	@Override
	public R visit(CastExpressionTyped n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= UnaryExpressionPreIncrement()
	 * | UnaryExpressionPreDecrement()
	 * | UnarySizeofExpression()
	 * | UnaryCastExpression()
	 * | PostfixExpression()
	 */
	@Override
	public R visit(UnaryExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "++"
	 * f1 ::= UnaryExpression()
	 */
	@Override
	public R visit(UnaryExpressionPreIncrement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "--"
	 * f1 ::= UnaryExpression()
	 */
	@Override
	public R visit(UnaryExpressionPreDecrement n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= UnaryOperator()
	 * f1 ::= CastExpression()
	 */
	@Override
	public R visit(UnaryCastExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= SizeofTypeName()
	 * | SizeofUnaryExpression()
	 */
	@Override
	public R visit(UnarySizeofExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <SIZEOF>
	 * f1 ::= UnaryExpression()
	 */
	@Override
	public R visit(SizeofUnaryExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <SIZEOF>
	 * f1 ::= "("
	 * f2 ::= TypeName()
	 * f3 ::= ")"
	 */
	@Override
	public R visit(SizeofTypeName n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		n.getF3().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "&"
	 * | "*"
	 * | "+"
	 * | "-"
	 * | "~"
	 * | "!"
	 */
	@Override
	public R visit(UnaryOperator n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= PrimaryExpression()
	 * f1 ::= PostfixOperationsList()
	 */
	@Override
	public R visit(PostfixExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= ( APostfixOperation() )*
	 */
	@Override
	public R visit(PostfixOperationsList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= BracketExpression()
	 * | ArgumentList()
	 * | DotId()
	 * | ArrowId()
	 * | PlusPlus()
	 * | MinusMinus()
	 */
	@Override
	public R visit(APostfixOperation n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "++"
	 */
	@Override
	public R visit(PlusPlus n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "--"
	 */
	@Override
	public R visit(MinusMinus n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "["
	 * f1 ::= Expression()
	 * f2 ::= "]"
	 */
	@Override
	public R visit(BracketExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "("
	 * f1 ::= ( ExpressionList() )?
	 * f2 ::= ")"
	 */
	@Override
	public R visit(ArgumentList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "."
	 * f1 ::= <IDENTIFIER>
	 */
	@Override
	public R visit(DotId n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "->"
	 * f1 ::= <IDENTIFIER>
	 */
	@Override
	public R visit(ArrowId n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <IDENTIFIER>
	 * | Constant()
	 * | ExpressionClosed()
	 */
	@Override
	public R visit(PrimaryExpression n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= "("
	 * f1 ::= Expression()
	 * f2 ::= ")"
	 */
	@Override
	public R visit(ExpressionClosed n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		n.getF2().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= AssignmentExpression()
	 * f1 ::= ( "," AssignmentExpression() )*
	 */
	@Override
	public R visit(ExpressionList n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		n.getF1().accept(this);
		endProcess(n);
		return _ret;
	}

	/**
	 * f0 ::= <INTEGER_LITERAL>
	 * | <FLOATING_POINT_LITERAL>
	 * | <CHARACTER_LITERAL>
	 * | ( <STRING_LITERAL> )+
	 */
	@Override
	public R visit(Constant n) {
		R _ret = null;
		initProcess(n);
		n.getF0().accept(this);
		endProcess(n);
		return _ret;
	}

	@Override
	public R visit(CallStatement n) {
		R _ret = null;
		initProcess(n);
		n.getPreCallNode().accept(this);
		n.getPostCallNode().accept(this);
		endProcess(n);
		return _ret;
	}

	@Override
	public R visit(PreCallNode n) {
		R _ret = null;
		initProcess(n);
		for (SimplePrimaryExpression arg : n.getArgumentList()) {
			arg.accept(this);
		}
		endProcess(n);
		return _ret;
	}

	@Override
	public R visit(PostCallNode n) {
		R _ret = null;
		initProcess(n);
		if (n.hasReturnReceiver()) {
			n.getReturnReceiver().accept(this);
		}
		endProcess(n);
		return _ret;
	}

	@Override
	public R visit(SimplePrimaryExpression n) {
		R _ret = null;
		initProcess(n);
		if (n.isAConstant()) {
			n.getConstant().accept(this);
		} else if (n.isAnIdentifier()) {
			n.getIdentifier().accept(this);
		}
		endProcess(n);
		return _ret;
	}

	@Override
	public R visit(BeginNode n) {
		R _ret = null;
		initProcess(n);
		endProcess(n);
		return _ret;
	}

	@Override
	public R visit(EndNode n) {
		R _ret = null;
		initProcess(n);
		endProcess(n);
		return _ret;
	}
}