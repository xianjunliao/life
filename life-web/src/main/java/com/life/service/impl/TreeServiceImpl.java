package com.life.service.impl;

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

}
