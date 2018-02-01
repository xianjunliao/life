package com.life.pc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.pc.model.LifeUserModel;

public interface LifeUserDao {

	public LifeUserModel checkEnterCode(@Param("code") String code);
	
	public LifeUserModel checkEnterName(@Param("name") String name);
	
	public LifeUserModel checkEnterNameAndPassword(@Param("name") String name,@Param("password") String password);
	
	List<LifeUserModel> getAll();

	void save(LifeUserModel lifeUserModel);

	void update(LifeUserModel lifeUserModel);

}
