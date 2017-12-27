package com.life.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.life.model.LifeUserModel;
import com.life.service.FileUserService;

@Controller
@RequestMapping("file")
public class FileUserController {

	@Autowired
	private FileUserService fileUserService;
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "file/";

	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, @ModelAttribute("params") LifeUserModel params, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		if (null == attribute) {
			return "error/500.jsp";
		}
		model.put("code", attribute);
		return FTL_DIR + pageName + ".jsp";
	}
	/**
	 * @MethodName addProduct <br/>
	 * @Description 产品新增 <br/>
	 * @author Wei Zhang
	 * @version 2017年11月17日 下午3:29:55
	 * 
	 * @param image
	 * @param productInfo 产品信息
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(path = { "/uploadFile" }, method = { RequestMethod.POST })
	@ResponseBody
	public String uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
		
		//转化入参
		SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		
		return "";
	}
}
