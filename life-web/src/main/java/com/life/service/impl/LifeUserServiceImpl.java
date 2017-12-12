package com.life.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.life.dao.LifeUserDao;
import com.life.model.LifeUserModel;
import com.life.service.LifeUserService;

@Service("lifeUserService")
public class LifeUserServiceImpl implements LifeUserService {

	@Resource(name="lifeUserDao")
	private LifeUserDao lifeUserDao;
	@Override
	public LifeUserModel checkEnterCode(String code) {
		return lifeUserDao.checkEnterCode(code);
	}

}
