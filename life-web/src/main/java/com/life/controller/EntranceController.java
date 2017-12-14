package com.life.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
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
import com.life.service.LifeUserService;
import com.life.util.StringUtil;

@Controller
@RequestMapping("entrance")
public class EntranceController {

	@Autowired
	private LifeUserService lifeUserService;
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "/";

	@ResponseBody
	@RequestMapping("enterCode")
	public LifeUserModel enterCode(String code, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		LifeUserModel lifeUserModel = lifeUserService.checkEnterCode(code);
		request.getSession().setAttribute("lifeUserModel", lifeUserModel);
		request.getSession().setMaxInactiveInterval(3600);
		return lifeUserModel;
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
	public String page(@PathVariable("pageName") String pageName, @ModelAttribute("params") LifeUserModel params,
			ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		if (null == attribute) {
			return "error/500.jsp";
		}
		model.put("code", attribute);
		return FTL_DIR + pageName + ".jsp";
	}
	
}
