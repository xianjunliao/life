package com.life.service;

import java.util.List;

import com.life.model.LifeUserModel;

public interface LifeUserService {

	public LifeUserModel checkEnterCode(String code);
	
	List<LifeUserModel> getAll();
	
	void add(LifeUserModel lifeUserModel);
	
}
