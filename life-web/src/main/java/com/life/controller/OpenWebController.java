package com.life.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.life.model.TreeModel;
import com.life.service.TreeService;



@Controller
@RequestMapping("openWeb")
public class OpenWebController {

	@Resource(name="treeService")
	private TreeService treeService;
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "open_web/";



	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, @ModelAttribute("params") TreeModel params,
			ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		TreeModel treeModel = treeService.geTreeModelByid(params.getId());
		if (null == treeModel) {
//			return "index.jsp";
		}
		model.put("treeModel", treeModel);
		return FTL_DIR + pageName + ".jsp";
	}

}
