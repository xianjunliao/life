package com.life.pc.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.methods.multipart.StringPart;
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
import com.life.pc.common.WebUtils;
import com.life.pc.model.MusicStandModel;
import com.life.pc.service.MusicStandService;

@Controller
@RequestMapping("music")
public class MusicController {
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "music/";

	@Autowired
	private MusicStandService musicStandService;

	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, ModelMap model, HttpServletRequest request) throws ServletException, IOException {
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}
		return FTL_DIR + pageName + ".jsp";
	}

	@RequestMapping(path = { "/addScore" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<String[]> uploadFile(@RequestParam("file")MultipartFile  file, MusicStandModel musicStandModel,String nextname,String index, HttpServletResponse response, HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<String[]> outMSG = new ResponseMessage<>();
		musicStandModel.setUsercode(WebUtils.getUserCode(request));
		int insertSelective = musicStandService.insertSelective(file, musicStandModel);
		String[] data=new String[2];
		data[0]=nextname;
		data[1]=index;
		if (insertSelective == 1) {
			outMSG.setData(data);
			outMSG.setCode("200");
		} else {
			outMSG.setCode("209");
		}
		return outMSG;
	}

}
