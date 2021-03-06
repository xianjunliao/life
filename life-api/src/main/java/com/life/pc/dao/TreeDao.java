package com.life.pc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.pc.model.TreeModel;

public interface TreeDao {
	List<TreeModel> getTree(TreeModel treeModel);

	List<TreeModel> getTreeByText(TreeModel treeModel);

	TreeModel geTreeModelByid(String id);

	List<TreeModel> getTreesByLevel(@Param("userCode") String userCode, @Param("level") String level, @Param("pid") String pid);

	void addTree(TreeModel treeModel);

	long getMaxSortNo(@Param("userCode") String userCode, @Param("level") String level);

	void delete(TreeModel treeModel);

	void update(TreeModel treeModel);

	List<TreeModel> getTreeByPid(@Param("userCode") String userCode, @Param("pid") String pid);

	List<TreeModel> getTreeByUserCode(@Param("userCode") String userCode);

	List<TreeModel> getTrees(@Param("userCode") String userCode);
	
	List<TreeModel> getHotTrees(@Param("userCode") String userCode);
	
	List<TreeModel> getLikeTrees(@Param("userCode") String userCode);
	
	List<TreeModel> getTopTrees(@Param("userCode") String userCode);
	
}
