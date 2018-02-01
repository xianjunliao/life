package com.life.pc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.life.pc.dao.LifeUserDao;
import com.life.pc.model.LifeUserModel;
import com.life.pc.service.LifeUserService;

@Service("lifeUserService")
public class LifeUserServiceImpl implements LifeUserService {

	@Resource(name = "lifeUserDao")
	private LifeUserDao lifeUserDao;

	@Override
	public LifeUserModel checkEnterCode(String code) {
		return lifeUserDao.checkEnterCode(code);
	}

	@Override
	public List<LifeUserModel> getAll() {
		return lifeUserDao.getAll();
	}

	@Override
	public void add(LifeUserModel lifeUserModel) {
		lifeUserDao.save(lifeUserModel);
	}


	@Override
	public void update(LifeUserModel lifeUserModel) {
		lifeUserDao.update(lifeUserModel);
	}

	@Override
	public LifeUserModel checkEnterName(String name) {
		
		return lifeUserDao.checkEnterName(name);
	}

	@Override
	public LifeUserModel checkEnterNameAndPassword(String name, String password) {
		return lifeUserDao.checkEnterNameAndPassword(name, password);
	}
}