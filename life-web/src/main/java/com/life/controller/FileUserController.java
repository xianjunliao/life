package com.life.controller;

import java.io.IOException;
import java.text.DecimalFormat;
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
import com.life.common.StringUtil;
import com.life.common.Util;
import com.life.common.time.DateUtil;
import com.life.model.FileUserModel;
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
	public String page(@PathVariable("pageName") String pageName, ModelMap model, HttpServletRequest request) throws ServletException, IOException {
		Long maxSortNo = fileUserService.getMaxSortNo();
		if (maxSortNo==null) {
			maxSortNo=1L;
		}
		List<FileUserModel> fileTypes = fileUserService.getFileTypes();
		model.put("sortNo", maxSortNo);
		model.put("fileTypes", fileTypes);
		return FTL_DIR + pageName + ".jsp";
	}

	@RequestMapping(path = { "add/uploadFile" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<FileUserModel> uploadFile(@RequestParam("file") MultipartFile file, HttpServletResponse response, HttpServletRequest request) {
		FileUserModel fileUserModel = new FileUserModel();
		String fileName = request.getParameter("fileName");
		String originalFilename=file.getOriginalFilename().substring(0, file.getOriginalFilename().lastIndexOf("."));
		String newType = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		String fileType = request.getParameter("fileType");
		String sortNo = request.getParameter("sortNo");
		LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		fileUserModel.setFileName(originalFilename);
		fileUserModel.setFileType(newType);
		if (!StringUtil.isBlank(fileName)) {
			fileUserModel.setFileName(fileName);
		}
		if (!StringUtil.isBlank(fileType)) {
			fileUserModel.setFileType(fileType);
		}
		fileUserModel.setFileOriginalFilename(originalFilename);
		DecimalFormat df = new DecimalFormat("######0.00");
		double l = file.getSize() / 1024 ;
		fileUserModel.setFileSize(df.format(l) + "KB");
		fileUserModel.setId(Util.getUUId16());
		fileUserModel.setUploadTime(DateUtil.getNow());
		fileUserModel.setUploadUser(attribute.getUserCode());
		fileUserModel.setSortNo(sortNo);
		fileUserService.save(file, fileUserModel);
		ResponseMessage<FileUserModel> outMSG = new ResponseMessage<>();
		outMSG.setData(fileUserModel);
		outMSG.setCode("200");
		outMSG.setMessage("上传成功！");
		return outMSG;
	}
}
