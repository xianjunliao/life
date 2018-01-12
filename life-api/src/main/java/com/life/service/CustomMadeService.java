package com.life.service;

import java.util.List;

import com.life.model.CustomMadeModel;

public interface CustomMadeService {
	
	public List<CustomMadeModel> getListsByCode(String code);

	public void add(CustomMadeModel codeFilesModel);

	public void update(CustomMadeModel codeFilesModel);
}
