package com.life.pc.service;

import java.util.List;

import com.life.pc.model.LifeUserModel;

public interface LifeUserService {

	public LifeUserModel checkEnterCode(String code);

	public LifeUserModel checkEnterName(String name);

	public LifeUserModel checkEnterNameAndPassword(String name, String password);

	List<LifeUserModel> getAll();

	void add(LifeUserModel lifeUserModel);

	void update(LifeUserModel lifeUserModel);
}
