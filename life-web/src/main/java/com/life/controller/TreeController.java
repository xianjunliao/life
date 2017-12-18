package com.life.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.life.model.LifeUserModel;
import com.life.model.TreeModel;
import com.life.service.TreeService;

@Controller
 @RequestMapping("tree")
public class TreeController {

	@Autowired
	private TreeService treeService;
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "tree/";

	@ResponseBody
	@RequestMapping("tree1")
	public List<TreeModel> enterCode(TreeModel treeModel, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		treeModel.setUserCode(attribute.getUserCode());
		List<TreeModel> tree = treeService.getTree(treeModel);
		return tree;
	}

	/**
	 * 页面跳转
	 *
	 * @param pageName
	 *            页面名称
	 * @param id
	 *            主键
	 * @param model
	 *            ModelMap
	 * @return 页面路径
	 * @throws IOException
	 * @throws ServletException
	 */
	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, @ModelAttribute("params") LifeUserModel params, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		if (null == attribute) {
			return "error/500.jsp";
		}
		model.put("code", attribute);
		return FTL_DIR + pageName + ".jsp";
	}

}
