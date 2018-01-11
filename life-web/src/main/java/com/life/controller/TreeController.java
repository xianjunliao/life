package com.life.controller;

import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.life.common.ResponseMessage;
import com.life.common.Str;
import com.life.common.Util;
import com.life.common.time.DateUtil;
import com.life.common.util.RSSUtil;
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
	@RequestMapping("panentTree")
	public List<TreeModel> panentTree(TreeModel treeModel, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		treeModel.setUserCode(attribute.getUserCode());
		treeModel.setPid("0");
		List<TreeModel> tree = treeService.getTree(treeModel);
		return tree;
	}

	@ResponseBody
	@RequestMapping("getChildNode")
	public List<TreeModel> getMenuTree(TreeModel treeModel, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		treeModel.setUserCode(attribute.getUserCode());
		List<TreeModel> tree = treeService.getChildNode2(treeModel);
		return tree;
	}

	@ResponseBody
	@RequestMapping("getUrlData")
	public String getUrlData(String url, HttpServletRequest request, HttpServletResponse response) {
		String json = RSSUtil.xmlToJson(url);
		return json;
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
	public String page(@PathVariable("pageName") String pageName, @ModelAttribute("params") TreeModel params, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
			model.put("code", attribute);
			String level = params.getLevel();
			String levelL = Long.valueOf(level) > 0 ? (Long.valueOf(level) - 1) + "" : Long.valueOf(level).toString();
			List<TreeModel> treesByLevel = new ArrayList<>();
			String id = Long.valueOf(level) == 2 ? "0" : params.getId();
			TreeModel treeModel = treeService.geTreeModelByid(params.getId());
			if (treeModel != null) {
				String userCode = attribute.getUserCode();
				treesByLevel = treeService.getTreesByLevel(userCode, levelL, id);
				List<TreeModel> updateModels = treeService.getTreesByLevel(userCode, levelL, params.getPid());
				List<TreeModel> all1trees = treeService.getTreesByLevel(userCode, "1", null);
				model.put("text", treeModel.getText());
				model.put("uTrees", updateModels);
				model.put("all1trees", all1trees);
			}
			model.put("level", params.getLevel());
			model.put("trees", treesByLevel);
			model.put("id", params.getId());
			model.put("pid", params.getPid());
			model.put("treeModel", treeModel);
		} catch (Exception e) {
			return "error/500.jsp";
		}
		return FTL_DIR + pageName + ".jsp";
	}

	@RequestMapping("/save")
	@ResponseBody
	public ResponseMessage<TreeModel> save(TreeModel treeModel, HttpServletRequest request, HttpServletResponse response) {
		ResponseMessage<TreeModel> responseMessage = new ResponseMessage<>();
		try {
			responseMessage = new ResponseMessage<>();
			String level = treeModel.getLevel();
			LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
			long maxSortNo = treeService.getMaxSortNo(attribute.getUserCode(), level);
			treeModel.setSortNo(String.valueOf(maxSortNo));
			treeModel.setUserCode(attribute.getUserCode());
			treeModel.setId(Util.getUUId16());
			if (Str.isEmpty(treeModel.getPid())) {
				treeModel.setPid("0");
			}
			treeModel.setStatus("0");
			treeModel.setCreateTime(DateUtil.getNow());
			treeService.addTree(treeModel);
			responseMessage.setCode("200");
			responseMessage.setMessage("新增成功");
		} catch (Exception e) {
			responseMessage.setCode("500");
			responseMessage.setMessage("新增失败");
		}
		return responseMessage;
	}

	@RequestMapping(path = { "/delete" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<TreeModel> deleteTree(String id, HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<TreeModel> outMSG = new ResponseMessage<>();
		try {
			outMSG.setCode("200");
			outMSG.setMessage("删除成功");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("删除失败");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/update" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<TreeModel> updateTree(TreeModel treeModel, HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<TreeModel> outMSG = new ResponseMessage<>();
		try {
			treeModel.setUpdateTime(DateUtil.getNow());
			treeService.update(treeModel);
			outMSG.setCode("200");
			outMSG.setMessage("修改成功");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("修改失败");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/getTreeByPid" }, method = { RequestMethod.POST })
	@ResponseBody
	public List<TreeModel> getTreeByPid(String pid, HttpServletRequest request) throws ServletException, IOException {
		LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		List<TreeModel> treesByLevel = treeService.getTreeByPid(attribute.getUserCode(), pid);
		return treesByLevel;
	}
}
