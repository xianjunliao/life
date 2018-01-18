package com.life.pc.service;

import java.util.List;

import com.life.pc.model.LifeUserModel;

public interface LifeUserService {

	public LifeUserModel checkEnterCode(String code);
	
	List<LifeUserModel> getAll();
	
	void add(LifeUserModel lifeUserModel);
	
}
