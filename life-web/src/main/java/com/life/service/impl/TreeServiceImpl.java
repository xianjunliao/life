package com.life.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.life.dao.TreeDao;
import com.life.model.TreeModel;
import com.life.service.TreeService;

@Service("treeService")
public class TreeServiceImpl implements TreeService {

	@Autowired
	private TreeDao treeDao;

	@Override
	public List<TreeModel> getTree(TreeModel treeModel) {
		return treeDao.getTree(treeModel);
	}

	@Override
	public List<TreeModel> getTreeByText(TreeModel treeModel) {
		List<TreeModel> treeByText = treeDao.getTreeByText(treeModel);
		return treeByText;
	}

	@Override
	public List<TreeModel> getChildNode2(TreeModel treeModel) {
		List<TreeModel> treeByText = treeDao.getTreeByText(treeModel);
		List<TreeModel> treeNew = new ArrayList<>();
		List<TreeModel> treeNew2 = new ArrayList<>();
		for (TreeModel treeModel2 : treeByText) {
			treeModel.setPid(treeModel2.getId());
			List<TreeModel> tree = treeDao.getTree(treeModel);
			treeNew.addAll(tree);
		}
		for (TreeModel treeModel2 : treeNew) {
			TreeModel treeModel3 = new TreeModel();
			treeModel3.setPid(treeModel2.getId());
			treeModel3.setUserCode(treeModel.getUserCode());
			List<TreeModel> tree = treeDao.getTree(treeModel3);
			treeModel2.setChildren(tree);
			treeNew2.add(treeModel2);
		}
		return treeNew;
	}

}
