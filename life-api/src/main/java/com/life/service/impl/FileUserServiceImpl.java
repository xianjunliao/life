package com.life.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.life.dao.FileUserDao;
import com.life.model.FileUserModel;
import com.life.service.FileUserService;
@Service("fileUserService")
public class FileUserServiceImpl implements FileUserService {

	@Autowired
	private FileUserDao fileUserDao;
	@Override
	public void save(FileUserModel fileUserModel) {
		fileUserDao.save(fileUserModel);
	}

	@Override
	public List<FileUserModel> getFilesByUserCode(String userCode) {
		return fileUserDao.getFilesByUserCode(userCode);
	}

}
