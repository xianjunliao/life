package com.life.pc.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("mobile")
public class MobileController {

	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "mobile/";

	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, ModelMap model, HttpServletRequest request) throws ServletException, IOException {
		try {

		} catch (Exception e) {
			return "error/500.jsp";
		}
		return FTL_DIR + pageName + ".jsp";
	}

}
