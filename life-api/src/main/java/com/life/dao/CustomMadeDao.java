package com.life.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.model.CustomMadeModel;

public interface CustomMadeDao {

	public List<CustomMadeModel> getListsByCode(@Param("code") String code);

	public void add(CustomMadeModel codeFilesModel);

	public void update(CustomMadeModel codeFilesModel);
}
