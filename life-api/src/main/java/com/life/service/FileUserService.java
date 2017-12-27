package com.life.service;

import java.util.List;

import com.life.model.FileUserModel;

public interface FileUserService {
	
	public void save(FileUserModel fileUserModel);

	public List<FileUserModel> getFilesByUserCode(String userCode);
}
