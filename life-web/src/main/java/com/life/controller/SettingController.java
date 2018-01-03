package com.life.controller;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.life.common.ResponseMessage;
import com.life.common.Str;
import com.life.common.StringUtil;
import com.life.common.Util;
import com.life.common.file.FileUtil;
import com.life.common.file.FileUtils;
import com.life.common.time.DateUtil;
import com.life.model.FileUserModel;
import com.life.model.LifeUserModel;
import com.life.service.FileUserService;

@Controller
@RequestMapping("setting")
public class SettingController {

	@Autowired
	private FileUserService fileUserService;
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "setting/";

	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, ModelMap model, HttpServletRequest request)
			throws ServletException, IOException {
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}
		return FTL_DIR + pageName + ".jsp";
	}

	
}
