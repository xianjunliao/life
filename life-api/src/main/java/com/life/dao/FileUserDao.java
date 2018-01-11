package com.life.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.model.FileUserModel;

public interface FileUserDao {

	public void save(FileUserModel fileUserModel);

	public List<FileUserModel> getFilesByUserCode(@Param("userCode") String userCode);

	public Long getMaxSortNo(@Param("userCode") String userCode);

	public List<FileUserModel> getFileTypes();

	public FileUserModel getFileById(@Param("id") String id);

	public List<FileUserModel> getFilesByTypeAndUserCode(@Param("userCode") String userCode, @Param("fileType") String fileType);

	public List<FileUserModel> getSumGroupTypeByUserCode(@Param("userCode") String userCode);

	public FileUserModel getFileByName(@Param("userCode") String userCode, @Param("fileOriginalFilename") String fileOriginalFilename);

	public void delete(@Param("id")String id);

	public void update(@Param("id")String id,@Param("fileName") String fileName);
}
