package com.life.pc.controller;

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

import com.alibaba.fastjson.JSONArray;
import com.life.common.ResponseMessage;
import com.life.common.Str;
import com.life.common.Util;
import com.life.common.time.DateUtil;
import com.life.common.util.RSSUtil;
import com.life.pc.common.WebUtils;
import com.life.pc.model.LifeUserModel;
import com.life.pc.model.TreeModel;
import com.life.pc.service.TreeService;

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
	public JSONArray panentTree(TreeModel treeModel, HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONArray jsonArray = new JSONArray();
		LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		treeModel.setUserCode(attribute.getUsercode());
		treeModel.setPid("0");
		List<TreeModel> tree = treeService.getTree(treeModel);
		jsonArray.addAll(tree);
		return jsonArray;
	}

	@ResponseBody
	@RequestMapping("getChildNode")
	public List<TreeModel> getMenuTree(TreeModel treeModel, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		treeModel.setUserCode(attribute.getUsercode());
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
			String userCode = attribute.getUsercode();
			model.put("code", userCode);
			String level = params.getLevel();
			List<TreeModel> treesByLevel = new ArrayList<>();
			String pid = params.getPid();
			if (!Str.isEmpty(level)) {
				String levelL = Long.valueOf(level) > 0 ? (Long.valueOf(level) - 1) + "" : Long.valueOf(level).toString();
				TreeModel treeModel = treeService.geTreeModelByid(params.getId());
				if (treeModel != null) {
					String id = Long.valueOf(level) == 2 ? "0" : treeModel.getPid();
					treesByLevel = treeService.getTreesByLevel(userCode, levelL, id);
					if (treesByLevel == null || treesByLevel.size() == 0) {
						treesByLevel = treeService.getTreesByLevel(userCode, levelL, null);
					}
					List<TreeModel> updateModels = treeService.getTreesByLevel(userCode, levelL, pid);
					List<TreeModel> all1trees = treeService.getTreesByLevel(userCode, "1", null);
					model.put("uTrees", updateModels);
					model.put("all1trees", all1trees);
				}
				model.put("trees", treesByLevel);
				model.put("treeModel", treeModel);
			}
			if (!Str.isEmpty(pid) && !pid.equals("0")) {
				TreeModel treeByPid = treeService.geTreeModelByid(pid);
				model.put("text", treeByPid.getText());
			}
			model.put("isTwoLevel", treesByLevel.size());
			model.put("level", params.getLevel());
			model.put("id", params.getId());
			model.put("pid", pid);
		} catch (Exception e) {

			e.printStackTrace();
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
			if (level.equals("1")) {
				treeModel.setIconCls("life-1");
			} else if (level.equals("2")) {
				treeModel.setIconCls("tree-listen");
			} else if (level.equals("3")) {
				treeModel.setIconCls("tree-life3");
			}
			LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
			long maxSortNo = treeService.getMaxSortNo(attribute.getUsercode(), level);
			treeModel.setSortNo(String.valueOf(maxSortNo));
			treeModel.setUserCode(attribute.getUsercode());
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

	@RequestMapping(path = { "/visits" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<TreeModel> visits(String id, HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<TreeModel> outMSG = new ResponseMessage<>();
		try {
			TreeModel treeModel = treeService.geTreeModelByid(id);
			Integer clickCount = treeModel.getClickCount()==null?0:Integer.valueOf(treeModel.getClickCount()) ;
			int i = clickCount + 1;
			treeModel.setClickCount(String.valueOf(i));
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

	@RequestMapping(path = { "/delete" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<TreeModel> deleteTree(TreeModel treeModel, HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<TreeModel> outMSG = new ResponseMessage<>();
		try {
			LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
			List<TreeModel> treeByPid = treeService.getTreeByPid(attribute.getUsercode(), treeModel.getId());
			for (TreeModel treeModel2 : treeByPid) {
				treeService.delete(treeModel2);
			}
			treeService.delete(treeModel);
			outMSG.setCode("200");
			outMSG.setMessage("删除成功");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("删除成功");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/getTreeByPid" }, method = { RequestMethod.POST })
	@ResponseBody
	public List<TreeModel> getTreeByPid(String pid, HttpServletRequest request) throws ServletException, IOException {
		LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		List<TreeModel> treesByLevel = treeService.getTreeByPid(attribute.getUsercode(), pid);
		return treesByLevel;
	}

	@RequestMapping("/getAllUri")
	public String getAllUri(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<TreeModel> trees = treeService.getTrees(WebUtils.getUserCode(request),false);
		List<TreeModel> hotTrees = treeService.getTrees(WebUtils.getUserCode(request),true);
		model.put("urls", trees);
		model.put("hotTrees", hotTrees);
		return FTL_DIR + "allUri.jsp";
	}
}
