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
import com.life.common.Util;
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
	public String page(@PathVariable("pageName") String pageName, ModelMap model, HttpServletRequest request) throws ServletException, IOException {
		LifeUserModel lifeUserModel = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		if (null == lifeUserModel) {
			throw new NullPointerException();
		}
		return FTL_DIR + pageName + ".jsp";
	}

	@RequestMapping(path = { "add/uploadFile" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<FileUserModel> uploadFile(@RequestParam("file") MultipartFile file, HttpServletResponse response, HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<FileUserModel> outMSG = new ResponseMessage<>();
		try {
			if (null == file || 0 == file.getSize()) {
				outMSG.setCode("201");
				outMSG.setMessage("请选择需要上传的文件！");
				return outMSG;
			}
			String message = "上传成功！";
			FileUserModel fileUserModel = new FileUserModel();
			String id = Util.getUUId16();
			String originalFilename = file.getOriginalFilename().substring(0, file.getOriginalFilename().lastIndexOf("."));

			LifeUserModel lifeUserModel = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
			String userCode = lifeUserModel.getUserCode();
			Long maxSortNo = fileUserService.getMaxSortNo(userCode);
			FileUserModel oldFileModel = fileUserService.getFileByName(userCode, originalFilename);
			if (oldFileModel != null) {
				message = "上传成功，服务器中此文件名称已存在，系统自动更改了文件名称。";
				originalFilename = originalFilename + "" + System.currentTimeMillis();
			}
			fileUserModel.setFileName(originalFilename);
			fileUserModel.setFileUrl(request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/" + "file/fileDownload?id=" + id);
			fileUserModel.setFileType(file.getContentType());
			fileUserModel.setFileOriginalFilename(file.getOriginalFilename());
			fileUserModel.setFileSize(Util.getM((double) file.getSize()) + "");
			fileUserModel.setId(id);
			fileUserModel.setUploadTime(DateUtil.getNow());
			fileUserModel.setUploadUser(userCode);
			fileUserModel.setSortNo(maxSortNo == null ? "1" : maxSortNo.toString());
			fileUserService.save(file, fileUserModel);
			outMSG.setData(fileUserModel);
			outMSG.setCode("200");
			outMSG.setMessage(message);
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("上传失败，出现未知异常！");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/getFiles" }, method = { RequestMethod.POST })
	@ResponseBody
	public List<FileUserModel> getFiles(String type, HttpServletResponse response, HttpServletRequest request) throws ServletException, IOException {
		List<FileUserModel> files = null;
		LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
		String userCode = attribute.getUserCode();
		if (Str.isEmpty(type)) {
			files = fileUserService.getFilesByUserCode(userCode);
		} else {
			files = fileUserService.getFilesByTypeAndUserCode(userCode, type);
		}
		return files;
	}

	@RequestMapping(path = { "/fileDownload" }, method = { RequestMethod.GET })
	public void fileDownload(String id, HttpServletResponse response, HttpServletRequest request) {
		FileUserModel fileById = fileUserService.getFileById(id);
		FileUtils.FilesDownload_stream(request, response, fileById.getFilePath(), fileById.getFileType());
	}

	@RequestMapping(path = { "/getSumGroupTypeByUserCode" }, method = { RequestMethod.POST })
	@ResponseBody
	public List<FileUserModel> getSumGroupTypeByUserCode(HttpServletRequest request) throws ServletException, IOException {
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
