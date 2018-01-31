package com.life.pc.controller;

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
import com.life.common.time.DateUtil;
import com.life.common.util.DESUtil;
import com.life.pc.common.WebUtils;
import com.life.pc.model.LifeUserModel;
import com.life.pc.model.TreeModel;
import com.life.pc.service.LifeUserService;
import com.life.pc.service.TreeService;

@Controller
// @RequestMapping("entrance")
public class LifeUserController {

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
		code = DESUtil.encryptDES(code);
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
		if (pageName.equals("PCIndex") || pageName.equals("MOBIndex") || pageName.equals("myMeun")) {

			return FTL_DIR + pageName + ".jsp";
		} else {

			if (null == attribute || null == params) {
				return "error/500.jsp";
			}
		}
		TreeModel pTreeModel = new TreeModel();
		String userCode = attribute.getUsercode();
		pTreeModel.setUserCode(userCode);
		pTreeModel.setPid("0");
		List<TreeModel> pTree = treeService.getTree(pTreeModel);
		model.put("data", pTree);
		if (pTree.size() > 0) {
			model.put("initText", pTree.get(0).getText());
		}
		return FTL_DIR + pageName + ".jsp";

	}

	@RequestMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return FTL_DIR + "user/login.jsp";
	}

	@RequestMapping("/register")
	public String register(LifeUserModel params, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return FTL_DIR + "user/register.jsp";
	}

	@RequestMapping("/register2")
	public String register2(String step, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String[] user = DESUtil.decryptDES(step).split(":");
			model.put("usercode", DESUtil.encryptDES(user[0]));
			model.put("username", user[1]);
			model.put("password", DESUtil.encryptDES(user[2]));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return FTL_DIR + "user/register2.jsp";
	}

	@RequestMapping("/fullLogin")
	public String fullLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return FTL_DIR + "user/fullLogin.jsp";
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
				outMSG.setMessage("输入的身份编码不存在，请注册！");
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
	@RequestMapping("user/getDES")
	public String getDES(String str, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			str = DESUtil.encryptDES(str);
		} catch (Exception e) {
		}
		return str;
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
				outMSG.setMessage("该身份编码已存在，请直接登录！");
			} else {
				LifeUserModel newUser = new LifeUserModel();
				newUser.setUsercode(code);
				newUser.setCreatetime(DateUtil.getNow());
				lifeUserService.add(newUser);
				TreeModel defalutTreeLevel1 = WebUtils.getDefalutTreeLevel1(code);
				TreeModel defalutTreeLevel2 = WebUtils.getDefalutTreeLevel2(code, defalutTreeLevel1.getId(), request);
				treeService.addTree(defalutTreeLevel1);
				treeService.addTree(defalutTreeLevel2);
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

	@ResponseBody
	@RequestMapping("user/addFull")
	public ResponseMessage<LifeUserModel> addFullInfo(LifeUserModel lifeUserModel, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LifeUserModel> outMSG = new ResponseMessage<>();
		String usercode = lifeUserModel.getUsercode();
		try {
			usercode = DESUtil.encryptDES(usercode);
			LifeUserModel checkEnterCode = lifeUserService.checkEnterCode(usercode);
			if (checkEnterCode != null) {
				outMSG.setCode("202");
				outMSG.setMessage("该身份编码已经在！");
			} else {
				lifeUserModel.setCreatetime(DateUtil.getNow());
				lifeUserModel.setUsercode(usercode);
				lifeUserModel.setPassword(MD5.md5(lifeUserModel.getPassword()));
				lifeUserService.add(lifeUserModel);
				TreeModel defalutTreeLevel1 = WebUtils.getDefalutTreeLevel1(usercode);
				TreeModel defalutTreeLevel2 = WebUtils.getDefalutTreeLevel2(usercode, defalutTreeLevel1.getId(), request);
				treeService.addTree(defalutTreeLevel1);
				treeService.addTree(defalutTreeLevel2);
				outMSG.setCode("200");
				outMSG.setData(lifeUserModel);
				outMSG.setMessage("注册成功！");
			}
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("注册失败，请重试！");
		}

		return outMSG;
	}

}
