package com.life.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.life.dao.CustomMadeDao;
import com.life.model.CustomMadeModel;
import com.life.service.CustomMadeService;

@Service("customMadeService")
public class CustomMadeServiceImpl implements CustomMadeService {

	@Autowired
	private CustomMadeDao customMadeDao;

	@Override
	public List<CustomMadeModel> getListsByCode(String code) {
		return customMadeDao.getListsByCode(code);
	}

	@Override
	public void add(CustomMadeModel codeFilesModel) {
		customMadeDao.add(codeFilesModel);
	}

	@Override
	public void update(CustomMadeModel codeFilesModel) {
		customMadeDao.update(codeFilesModel);
	}

}
