package com.life.pc.controller;

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
import com.life.pc.model.FileUserModel;
import com.life.pc.model.LifeUserModel;
import com.life.pc.service.FileUserService;

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
			String userCode = lifeUserModel.getUsercode();
			Long maxSortNo = fileUserService.getMaxSortNo(userCode);
			long oldFiles = fileUserService.getFileByName(userCode, file.getOriginalFilename());
			if (oldFiles > 0) {
				originalFilename = originalFilename + "_" + id;
				message = "上传成功，服务器中已存在此文件，系统自动更改了文件名称为："+originalFilename+"。";
			}
			fileUserModel.setFileName(originalFilename);
			fileUserModel.setFileUrl(request.getScheme() + "://" + request.getServerName() + request.getContextPath() + "/" + "file/download?id=" + id);
			fileUserModel.setFileType(file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1));
			fileUserModel.setContentType(file.getContentType());
			fileUserModel.setFileOriginalFilename(file.getOriginalFilename().replace(",", " and "));
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
		String userCode = attribute.getUsercode();
		if (Str.isEmpty(type)) {
			files = fileUserService.getFilesByUserCode(userCode);
		} else {
			files = fileUserService.getFilesByTypeAndUserCode(userCode, type);
		}
		return files;
	}

	@RequestMapping(path = { "/download" }, method = { RequestMethod.GET })
	public void fileDownload(String id, HttpServletResponse response, HttpServletRequest request) throws ServletException, IOException {
		FileUserModel fileById = fileUserService.getFileById(id);
		FileUtils.FilesDownload_stream(request, response, fileById.getFileName(), fileById.getFilePath(), fileById.getContentType());
	}

	@RequestMapping(path = { "/getSumGroupTypeByUserCode" }, method = { RequestMethod.POST })
	@ResponseBody
	public List<FileUserModel> getSumGroupTypeByUserCode(HttpServletRequest request) throws ServletException, IOException {
		List<FileUserModel> sumGroupTypeByUserCode = null;
		try {
			LifeUserModel attribute = (LifeUserModel) request.getSession().getAttribute("lifeUserModel");
			sumGroupTypeByUserCode = fileUserService.getSumGroupTypeByUserCode(attribute.getUsercode());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sumGroupTypeByUserCode;
	}

	@RequestMapping(path = { "/delete" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<FileUserModel> deleteFile(String id, HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<FileUserModel> outMSG = new ResponseMessage<>();
		try {
			fileUserService.delete(id);
			outMSG.setCode("200");
			outMSG.setMessage("删除成功");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("删除失败");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/update" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<FileUserModel> updateFileName(String id, String fileName, HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<FileUserModel> outMSG = new ResponseMessage<>();
		try {
			fileUserService.update(id, fileName);
			outMSG.setCode("200");
			outMSG.setMessage("修改成功");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("修改失败");
		}
		return outMSG;
	}
}
