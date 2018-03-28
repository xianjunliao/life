package com.life.pc.service;

import java.util.List;

import com.life.pc.model.TreeModel;

public interface TreeService {
	List<TreeModel> getTree(TreeModel treeModel);
	
	List<TreeModel> getTreeByText(TreeModel treeModel);
	
	List<TreeModel> getChildNode2(TreeModel treeModel);
	
	TreeModel geTreeModelByid(String id);
	
	List<TreeModel> getTreesByLevel(String userCode,String level,String pid);
	
	void addTree(TreeModel treeModel);
	
	long getMaxSortNo(String userCode,String level);
	
	void delete(TreeModel treeModel);
	
	void update(TreeModel treeModel);
	
	List<TreeModel> getTreeByPid(String userCode, String pid);
	
	List<TreeModel> getTreeByUserCode(String userCode);
	
	List<TreeModel> getTrees(String userCode,boolean isHot);
}
