/*
 * Copyright (c) 2019 Aman Nougrahiya, V Krishna Nandivada, IIT Madras.
 * This file is a part of the project IMOP, licensed under the MIT license.
 * See LICENSE.md for the full text of the license.
 * 
 * The above notice shall be included in all copies or substantial
 * portions of this file.
 */
package imop.ast.info;

import imop.ast.node.external.*;
import imop.lib.util.Misc;

import java.util.HashSet;
import java.util.Set;

public class OmpLastPrivateClauseInfo extends OmpClauseInfo {

	public OmpLastPrivateClauseInfo(Node owner) {
		super(owner);
	}

	@Override
	public Set<String> getListedNames() {
		OmpLastPrivateClause clause = (OmpLastPrivateClause) this.getNode();
		return new HashSet<>(Misc.obtainVarNames(clause.getF2()));
	}

	@Override
	public VariableList getVariableList() {
		OmpLastPrivateClause clause = (OmpLastPrivateClause) this.getNode();
		return clause.getF2();
	}
}