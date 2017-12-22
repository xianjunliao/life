package com.life.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.model.LifeUserModel;

public interface LifeUserDao {

	public LifeUserModel checkEnterCode(@Param("code")String code);
	List<LifeUserModel> getAll();
	
}
