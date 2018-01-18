package com.life.wx.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.life.common.time.DateUtil;
import com.life.wx.dao.UserInfoDao;
import com.life.wx.model.UserInfoModel;
import com.life.wx.service.UserInfoService;

/**
 * 微信用户信息 servic实现类
 * 
 * @author xianjun.liao
 *
 */
@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {

	@Autowired
	public UserInfoDao userInfoDao;
	
	@Override
	public void save(UserInfoModel userInfoModel) {
		userInfoModel.setCreatetime(DateUtil.getNow());
		userInfoDao.save(userInfoModel);
	}

	@Override
	public void update(UserInfoModel userInfoModel) {
		userInfoDao.update(userInfoModel);
	}

	@Override
	public UserInfoModel getUserInfoBySignature(String signature) {
		UserInfoModel userInfoModel = userInfoDao.getUserInfoBySignature(signature);
		return userInfoModel;
	}

}
