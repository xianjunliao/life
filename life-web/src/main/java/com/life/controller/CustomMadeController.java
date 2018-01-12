package com.life.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.life.model.LifeUserModel;
import com.life.service.CustomMadeService;

@Controller
@RequestMapping("customMade")
public class CustomMadeController {
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "customMade/";
	
	@Autowired
    private CustomMadeService customMadeService;
	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, ModelMap model, HttpServletRequest request) throws ServletException, IOException {
		LifeUserModel lifeUserModel = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		if (null == lifeUserModel) {
			throw new NullPointerException();
		}
		return FTL_DIR + pageName + ".jsp";
	}

}
