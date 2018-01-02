package com.life.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.life.common.file.FileUtils;
import com.life.dao.FileUserDao;
import com.life.model.FileUserModel;
import com.life.service.FileUserService;

@Service("fileUserService")
public class FileUserServiceImpl implements FileUserService {

	@Autowired
	private FileUserDao fileUserDao;

	@Override
	public void save(MultipartFile file, FileUserModel fileUserModel) {
		String filePath = "D:/life_files/";
		String fileType = fileUserModel.getFileType().replace(".", "");
		String filesUpload_stream = FileUtils.FilesUpload_stream(file, filePath,fileUserModel.getUploadUser(), fileType);
		fileUserModel.setFilePath(filesUpload_stream);
		fileUserModel.setFileUrl(filesUpload_stream);
		fileUserDao.save(fileUserModel);
	}

	@Override
	public List<FileUserModel> getFilesByUserCode(String userCode) {
		return fileUserDao.getFilesByUserCode(userCode);
	}

	@Override
	public Long getMaxSortNo() {
		return fileUserDao.getMaxSortNo();
	}

	@Override
	public List<FileUserModel> getFileTypes() {
		return fileUserDao.getFileTypes();
	}

	@Override
	public FileUserModel getFileById(String id) {
		return fileUserDao.getFileById(id);
	}

	@Override
	public List<FileUserModel> getFilesByTypeAndUserCode(String userCode, String fileType) {
		return fileUserDao.getFilesByTypeAndUserCode(userCode, fileType);
	}

	@Override
	public List<FileUserModel> getSumGroupTypeByUserCode(String userCode) {
		return fileUserDao.getSumGroupTypeByUserCode(userCode);
	}

}
