package com.life.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.life.model.LifeUserModel;
import com.life.service.LifeUserService;

@Controller
@RequestMapping("entrance")
public class EntranceController {

	@Autowired
	private LifeUserService lifeUserService;

	@ResponseBody
	@RequestMapping("enterCode")
	public LifeUserModel enterCode(String code) throws Exception {
		LifeUserModel lifeUserModel = lifeUserService.checkEnterCode(code);
		return lifeUserModel;
	}
}
