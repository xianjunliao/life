package com.life.pc.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.life.common.ResponseMessage;
import com.life.pc.common.WebUtils;
import com.life.pc.model.FinanceRecordsModel;
import com.life.pc.service.FinanceService;

@Controller
@RequestMapping("finance")
public class FinanceController {

	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "finance/";

	@Autowired
	private FinanceService financeService;

	@RequestMapping("/main")
	public String finance(ModelMap model, HttpServletRequest request) throws ServletException, IOException {
		try {

		} catch (Exception e) {
			return "error/500.jsp";
		}
		return FTL_DIR + "finance_main.jsp";
	}

	@RequestMapping(path = { "/addRecord" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<String> addRecord(FinanceRecordsModel financeRecordsModel, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<String> outMSG = new ResponseMessage<>();
		try {
			String userCode = WebUtils.getUserCode(request);
			financeRecordsModel.setUsercode(userCode);
			financeService.addRecord(financeRecordsModel);
			outMSG.setCode("200");
		} catch (Exception e) {
			e.printStackTrace();
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/updateRecord" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<String> updateRecord(FinanceRecordsModel financeRecordsModel, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<String> outMSG = new ResponseMessage<>();
		try {
			String userCode = WebUtils.getUserCode(request);
			financeRecordsModel.setUsercode(userCode);
			financeService.updateRecord(financeRecordsModel);
			outMSG.setCode("200");
		} catch (Exception e) {
			e.printStackTrace();
			outMSG.setCode("209");
		}
		return outMSG;
	}
}
