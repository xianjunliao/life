package com.life.pc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.life.pc.model.FinanceFixedModel;
import com.life.pc.model.FinanceRecordsModel;
import com.life.pc.model.InParamModel;
import com.life.pc.model.SumModel;
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

	@RequestMapping(path = { "/getList" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<List<FinanceRecordsModel>> getList(InParamModel model, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<List<FinanceRecordsModel>> outMSG = new ResponseMessage<>();
		try {
			String userCode = WebUtils.getUserCode(request);
			model.setUsercode(userCode);
			List<FinanceRecordsModel> list = financeService.getList(model);
			outMSG.setData(list);
			outMSG.setCode("200");
		} catch (Exception e) {
			e.printStackTrace();
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/getListFixed" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<List<FinanceFixedModel>> getListFixed(HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<List<FinanceFixedModel>> outMSG = new ResponseMessage<>();
		try {
			String userCode = WebUtils.getUserCode(request);

			List<FinanceFixedModel> list = financeService.getList(userCode);
			outMSG.setData(list);
			outMSG.setCode("200");
		} catch (Exception e) {
			e.printStackTrace();
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/getRow" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<FinanceRecordsModel> getRow(String id, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<FinanceRecordsModel> outMSG = new ResponseMessage<>();
		try {
			FinanceRecordsModel row = financeService.getRow(id);
			outMSG.setData(row);
			outMSG.setCode("200");
		} catch (Exception e) {
			e.printStackTrace();
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/getRowFixed" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<FinanceFixedModel> getRowFixed(String id, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<FinanceFixedModel> outMSG = new ResponseMessage<>();
		try {
			FinanceFixedModel row = financeService.getRowFiexd(id);
			outMSG.setData(row);
			outMSG.setCode("200");
		} catch (Exception e) {
			e.printStackTrace();
			outMSG.setCode("209");
		}
		return outMSG;
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

	@RequestMapping(path = { "/addFixed" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<String> addFixed(FinanceFixedModel financeFixedModel, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<String> outMSG = new ResponseMessage<>();
		try {
			String userCode = WebUtils.getUserCode(request);
			financeFixedModel.setUsercode(userCode);
			financeService.addFiexd(financeFixedModel);
			outMSG.setCode("200");
		} catch (Exception e) {
			e.printStackTrace();
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/delete" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<String> delete(String id, String type, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<String> outMSG = new ResponseMessage<>();
		try {
			financeService.delete(id, type);
			outMSG.setCode("200");
		} catch (Exception e) {
			e.printStackTrace();
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/getSum" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<List<SumModel>> getSum(InParamModel model, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<List<SumModel>> outMSG = new ResponseMessage<>();
		try {
			String userCode = WebUtils.getUserCode(request);
			model.setUsercode(userCode);
			List<SumModel> sum = financeService.getSum(model);
			outMSG.setData(sum);
			outMSG.setCode("200");
		} catch (Exception e) {
			e.printStackTrace();
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/getDaySum" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<List<SumModel>> getDaySum(InParamModel model, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<List<SumModel>> outMSG = new ResponseMessage<>();
		try {
			Map<String, Double> map = new HashMap<>();
			String userCode = WebUtils.getUserCode(request);
			model.setUsercode(userCode);
			List<SumModel> sum = financeService.getDaySum(model);
			for (SumModel sumModel : sum) {
				map.put(sumModel.getName(), sumModel.getValue());
			}
			outMSG.setData(sum);
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
			financeService.updateRecord(financeRecordsModel);
			outMSG.setCode("200");
		} catch (Exception e) {
			e.printStackTrace();
			outMSG.setCode("209");
		}
		return outMSG;
	}
}
