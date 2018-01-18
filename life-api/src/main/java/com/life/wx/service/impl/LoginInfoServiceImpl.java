package com.life.wx.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.life.common.time.DateUtil;
import com.life.wx.dao.LoginInfoDao;
import com.life.wx.model.LoginInfoModel;
import com.life.wx.service.LoginInfoService;

/**
 * 微信用户登录信息 service实现类
 * 
 * @author xianjun.liao
 *
 */
@Service("loginInfoService")
public class LoginInfoServiceImpl implements LoginInfoService {

	@Autowired
	private LoginInfoDao loginInfoDao;

	@Override
	public void save(LoginInfoModel loginInfoModel) {
		loginInfoModel.setLogintime(DateUtil.getNow());
		loginInfoDao.save(loginInfoModel);
	}

	@Override
	public List<LoginInfoModel> getLoginInfoListBySignature(String signature) {
		List<LoginInfoModel> loginInfoModels = loginInfoDao.getLoginInfoListBySignature(signature);
		return loginInfoModels;
	}

}
