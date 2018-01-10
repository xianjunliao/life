package com.life.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.life.model.FileUserModel;

public interface FileUserService {
	
	public void save(MultipartFile file,FileUserModel fileUserModel);

	public List<FileUserModel> getFilesByUserCode(String userCode);
	
	public Long getMaxSortNo(String userCode);
	
	public List<FileUserModel> getFileTypes();
	
	public FileUserModel getFileById(String id);
	
	public List<FileUserModel> getFilesByTypeAndUserCode(String userCode,String fileType);
	
	public List<FileUserModel> getSumGroupTypeByUserCode(String userCode);
	
	public FileUserModel getFileByName(String userCode,String fileName);
	
	public void delete(String id);
	
	public void update(String id);
}
