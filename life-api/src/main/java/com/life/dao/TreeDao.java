package com.life.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.model.TreeModel;

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
}
