package com.life.service;

import java.util.List;

import com.life.model.TreeModel;

public interface TreeService {
	List<TreeModel> getTree(TreeModel treeModel);
	
	List<TreeModel> getTreeByText(TreeModel treeModel);
	
	List<TreeModel> getChildNode2(TreeModel treeModel);
}
