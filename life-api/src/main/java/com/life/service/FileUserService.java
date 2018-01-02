package com.life.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.life.model.FileUserModel;

public interface FileUserService {
	
	public void save(MultipartFile file,FileUserModel fileUserModel);

	public List<FileUserModel> getFilesByUserCode(String userCode);
	
	public Long getMaxSortNo();
	
	public List<FileUserModel> getFileTypes();
}
