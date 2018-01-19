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
import com.life.common.util.HttpRequestUtil;
import com.life.wx.model.UserInfoModel;
import com.life.wx.service.UserInfoService;

@Controller
@RequestMapping("wx/user")
public class UserInfoController {

	@Autowired
	private UserInfoService userInfoService;

	@ResponseBody
	@RequestMapping("/save")
	public ResponseMessage<UserInfoModel> save(UserInfoModel user, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<UserInfoModel> outMSG = new ResponseMessage<>();
		UserInfoModel userInfoModel = userInfoService.getUserInfoBySignature(user.getSignature());
		if (userInfoModel == null) {
			userInfoService.save(user);
			outMSG.setCode("200");
			outMSG.setMessage("保存成功");
			outMSG.setData(user);
		} else {
			outMSG.setCode("200");
			outMSG.setMessage("该微信用户已保存过");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("/getUserInfo")
	public ResponseMessage<UserInfoModel> getUserInfo(String signature, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<UserInfoModel> outMSG = new ResponseMessage<>();
		UserInfoModel userInfoModel = userInfoService.getUserInfoBySignature(signature);
		if (userInfoModel == null) {
			outMSG.setCode("404");
			outMSG.setMessage("根据微信唯一码查询用户信息不存在");
		} else {
			outMSG.setCode("200");
			outMSG.setMessage("查询成功");
			outMSG.setData(userInfoModel);
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("/getAddress")
	public ResponseMessage<String> getAddress(String longitude, String latitude, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<String> outMSG = new ResponseMessage<>();
		try {
			String address = HttpRequestUtil.getAddress(longitude, latitude);
			outMSG.setCode("200");
			outMSG.setMessage("获取地址成功");
			outMSG.setData(address);
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("获取地址失败");
		}
		return outMSG;
	}
}
