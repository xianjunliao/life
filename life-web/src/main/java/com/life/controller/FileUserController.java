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
@RequestMapping("file")
public class FileUserController {

	@Autowired
	private FileUserService fileUserService;
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "file/";

	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, ModelMap model, HttpServletRequest request)
			throws ServletException, IOException {
		try {
			Long maxSortNo = fileUserService.getMaxSortNo();
			// LifeUserModel attribute = (LifeUserModel)
			// request.getSession().getAttribute("lifeUserModel");
			if (maxSortNo == null) {
				maxSortNo = 1L;
			}
			List<FileUserModel> fileTypes = fileUserService.getFileTypes();
			// List<FileUserModel> sumGroupTypeByUserCode =
			// fileUserService.getSumGroupTypeByUserCode(attribute.getUserCode());
			model.put("sortNo", maxSortNo);
			model.put("fileTypes", fileTypes);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return FTL_DIR + pageName + ".jsp";
	}

	@RequestMapping(path = { "add/uploadFile" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<FileUserModel> uploadFile(@RequestParam("file") MultipartFile file,
			HttpServletResponse response, HttpServletRequest request) {
		ResponseMessage<FileUserModel> outMSG = null;
		try {
			FileUserModel fileUserModel = new FileUserModel();
			String fileName = request.getParameter("fileName");
			String originalFilename = file.getOriginalFilename().substring(0,
					file.getOriginalFilename().lastIndexOf("."));
			String newType = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."))
					.replace(".", "");
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
			fileUserModel.setFileSize(Util.getM((double) file.getSize()) + "M");
			fileUserModel.setId(Util.getUUId16());
			fileUserModel.setUploadTime(DateUtil.getNow());
			fileUserModel.setUploadUser(attribute.getUserCode());
			fileUserModel.setSortNo(sortNo);
			fileUserService.save(file, fileUserModel);
			outMSG = new ResponseMessage<>();
			outMSG.setData(fileUserModel);
			outMSG.setCode("200");
			outMSG.setMessage("上传成功！");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return outMSG;
	}
	@RequestMapping(path = { "/getFiles" }, method = { RequestMethod.POST })
	@ResponseBody
	public List<FileUserModel> getFiles(String type, HttpServletResponse response, HttpServletRequest request) {
		List<FileUserModel> files = null;
		try {
			LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
			String userCode = attribute.getUserCode();
			if (Str.isEmpty(type)) {
				files = fileUserService.getFilesByUserCode(userCode);
			} else {
				files = fileUserService.getFilesByTypeAndUserCode(userCode, type);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return files;
	}
	
	
	@RequestMapping(path = { "/fileDownload" }, method = { RequestMethod.GET })
	public void fileDownload(String id, HttpServletResponse response, HttpServletRequest request) {
		FileUserModel fileById = fileUserService.getFileById(id);
		FileUtils.FilesDownload_stream(request, response, fileById.getFilePath());
	}

	@RequestMapping(path = { "/getSumGroupTypeByUserCode" }, method = { RequestMethod.POST })
	@ResponseBody
	public List<FileUserModel> getSumGroupTypeByUserCode(HttpServletRequest request) {
		List<FileUserModel> sumGroupTypeByUserCode = null;
		try {
			LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
			sumGroupTypeByUserCode = fileUserService.getSumGroupTypeByUserCode(attribute.getUserCode());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sumGroupTypeByUserCode;
	}
}
