package com.life.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.model.FileUserModel;

public interface FileUserDao {

	public void save(FileUserModel fileUserModel);
	
	public List<FileUserModel> getFilesByUserCode(@Param("userCode")String userCode);
	
	public Long getMaxSortNo();
	
	public List<FileUserModel> getFileTypes();
	
	public FileUserModel getFileById(@Param("id")String id); 
	
	public List<FileUserModel> getFilesByTypeAndUserCode(@Param("userCode")String userCode,@Param("fileType")String fileType);
	
	public List<FileUserModel> getSumGroupTypeByUserCode(@Param("userCode")String userCode);
}
