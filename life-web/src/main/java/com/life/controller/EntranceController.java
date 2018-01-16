package com.life.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
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

import com.life.common.MD5;
import com.life.common.ResponseMessage;
import com.life.common.Util;
import com.life.common.time.DateUtil;
import com.life.common.util.DESUtil;
import com.life.model.LifeUserModel;
import com.life.model.TreeModel;
import com.life.service.LifeUserService;
import com.life.service.TreeService;

@Controller
// @RequestMapping("entrance")
public class EntranceController {

	@Resource(name = "lifeUserService")
	private LifeUserService lifeUserService;

	@Autowired
	private TreeService treeService;
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "/";

	@ResponseBody
	@RequestMapping("enterCode")
	public LifeUserModel enterCode(String code, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LifeUserModel lifeUserModel = lifeUserService.checkEnterCode(code);
		request.getSession().setAttribute("lifeUserModel", lifeUserModel);
		request.getSession().setMaxInactiveInterval(7200);
		return lifeUserModel;
	}

	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, @ModelAttribute("params") LifeUserModel params, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		if (pageName.contains("test")) {
			return "error/" + pageName + ".jsp";
		}
		if (pageName.equals("PCIndex") || pageName.equals("MOBIndex")) {

			return FTL_DIR + pageName + ".jsp";
		} else {

			if (null == attribute || null == params) {
				return "error/500.jsp";
			}
		}
		TreeModel pTreeModel = new TreeModel();
		String userCode = attribute.getUserCode();
		pTreeModel.setUserCode(userCode);
		pTreeModel.setPid("0");
		List<TreeModel> pTree = treeService.getTree(pTreeModel);
		model.put("data", pTree);
		if (pTree.size() > 0) {
			model.put("initText", pTree.get(0).getText());
		}
		return FTL_DIR + pageName + ".jsp";

	}

	@ResponseBody
	@RequestMapping("/enter")
	public ResponseMessage<LifeUserModel> enter(String code, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LifeUserModel> outMSG = new ResponseMessage<>();
		try {
			code = DESUtil.encryptDES(code);
			LifeUserModel lifeUserModel = lifeUserService.checkEnterCode(code);
			if (lifeUserModel == null) {
				outMSG.setCode("202");
				outMSG.setMessage("输入的编码不存在，请点击右下角按钮新增编码！");
			} else {
				request.getSession().setAttribute("lifeUserModel", lifeUserModel);
				request.getSession().setMaxInactiveInterval(3600);
				outMSG.setCode("200");
				outMSG.setMessage("验证成功！");
			}
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("验证失败！");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("/exit")
	public ResponseMessage<LifeUserModel> exit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LifeUserModel> outMSG = new ResponseMessage<>();
		try {
			request.getSession().removeAttribute("lifeUserModel");
			outMSG.setCode("200");
			outMSG.setMessage("退出成功！");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("退出失败！");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("/add")
	public ResponseMessage<LifeUserModel> addCode(String code, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LifeUserModel> outMSG = new ResponseMessage<>();
		try {
			code = DESUtil.encryptDES(code);
			LifeUserModel lifeUserModel = lifeUserService.checkEnterCode(code);
			if (lifeUserModel != null) {
				outMSG.setCode("202");
				outMSG.setMessage("该编码已存在！");
			} else {
				LifeUserModel newUser = new LifeUserModel();
				newUser.setUserCode(code);
				newUser.setCreateTime(DateUtil.getNow());
				lifeUserService.add(newUser);
				outMSG.setCode("200");
				outMSG.setMessage("新增成功！");
			}

		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("新增失败！");
		}
		return outMSG;
	}
	@RequestMapping("/test")
	public String test(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return "error/test.jsp";
	}

	@ResponseBody
	@RequestMapping("/getAll")
	public List<LifeUserModel> getAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<LifeUserModel> all = lifeUserService.getAll();
		return all;
	}
}
