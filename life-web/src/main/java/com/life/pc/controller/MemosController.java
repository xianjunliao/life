package com.life.pc.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.life.common.ResponseMessage;
import com.life.common.Util;
import com.life.common.time.DateUtil;
import com.life.pc.common.WebUtils;
import com.life.pc.model.LifeUserModel;
import com.life.pc.model.MemosModel;
import com.life.pc.service.MemosService;

@Controller
@RequestMapping("memos")
public class MemosController {

	@Autowired
	private MemosService memosService;
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "/";

	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, ModelMap model, HttpServletRequest request) throws ServletException, IOException {

		return FTL_DIR + pageName + ".jsp";
	}

	@ResponseBody
	@RequestMapping("/save")
	public ResponseMessage<LifeUserModel> save(MemosModel memosModel, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LifeUserModel> outMSG = new ResponseMessage<>();
		try {
			String userCode = WebUtils.getUserCode(request);
			memosModel.setUsercode(userCode);
			memosModel.setId(Util.getUUId16());
			String sendtime = memosModel.getSendtime();
			Date parse = DateUtil.parse(sendtime);
			String sendStr = DateUtil.formatDate(parse, DateUtil.YYYYMMDDHH);
			String nowStr = DateUtil.formatDate(new Date(), DateUtil.YYYYMMDDHH);
			Date parse1 = DateUtil.parse(sendStr, DateUtil.YYYYMMDDHH);
			Date parse2 = DateUtil.parse(nowStr, DateUtil.YYYYMMDDHH);
			if (parse1.getTime() <= parse2.getTime()) {
				outMSG.setCode("201");
				outMSG.setMessage("过去的就让它过去吧！");
				return outMSG;
			}
			memosModel.setSendtime(DateUtil.formatDate(parse));
			memosModel.setCreatetime(DateUtil.getNow());
			memosModel.setExecuteresult("0");
			memosService.save(memosModel);
			outMSG.setCode("200");
			outMSG.setMessage("新增成功！");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("新增失败！");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/getMemos" }, method = { RequestMethod.POST })
	@ResponseBody
	public List<MemosModel> getMemos(HttpServletRequest request) throws ServletException, IOException {
		List<MemosModel> memosModels = null;
		try {
			String userCode = WebUtils.getUserCode(request);
			memosModels = memosService.selectByUserCode(userCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memosModels;
	}

	@RequestMapping(path = { "/getCount" }, method = { RequestMethod.POST })
	@ResponseBody
	public Long getCount(HttpServletRequest request) throws ServletException, IOException {
		Long selectCount = 0l;
		try {
			String userCode = WebUtils.getUserCode(request);
			selectCount = memosService.selectCount(userCode);
		} catch (Exception e) {
			e.printStackTrace();
			selectCount = 0l;
		}
		return selectCount;
	}
}
