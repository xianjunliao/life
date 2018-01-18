package com.life.wx.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.life.common.ResponseMessage;
import com.life.wx.model.LoginInfoModel;
import com.life.wx.service.LoginInfoService;

@Controller
@RequestMapping("wx/login")
public class LoginInfoController {

	@Autowired
	private LoginInfoService loginInfoService;

	@ResponseBody
	@RequestMapping("/save")
	public ResponseMessage<LoginInfoModel> save(LoginInfoModel loginInfoModel, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LoginInfoModel> outMSG = new ResponseMessage<>();
		try {
			loginInfoModel.setLoginresult("200");
			loginInfoModel.setLoginmessages("保存登录信息成功");
			outMSG.setCode("200");
			outMSG.setMessage("保存登录信息成功");
			outMSG.setData(loginInfoModel);
		} catch (Exception e) {
			loginInfoModel.setLoginresult("209");
			loginInfoModel.setLoginmessages(e.getMessage());
			outMSG.setCode("209");
			outMSG.setMessage("保存失败");
			outMSG.setData(loginInfoModel);
		} finally {
			loginInfoService.save(loginInfoModel);
		}
		return outMSG;
	}

}
