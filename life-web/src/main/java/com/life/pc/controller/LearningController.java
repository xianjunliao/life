package com.life.pc.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.life.common.baidu.BaiduVoice;
import com.life.common.file.FileUtils;
import com.life.pc.common.WebUtils;

@Controller
@RequestMapping("learn")
public class LearningController {
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "learn/";

	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, ModelMap model, HttpServletRequest request)
			throws ServletException, IOException {
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}
		return FTL_DIR + pageName + ".jsp";
	}
	
	@RequestMapping(path = { "/getVoice" }, method = { RequestMethod.GET })
	public void getVoice(String text,String type, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String userCode = WebUtils.getUserCode(request);
			Map<String, String> baiduVoice = BaiduVoice.getBaiduVoice(text, userCode, type);
			String fileName = baiduVoice.get("fileName");
			String path = baiduVoice.get("path");
			FileUtils.FilesDownload_stream(request, response, fileName, path, "audio/mp3");
		} catch (Exception e) {
	
		}
	}
}
