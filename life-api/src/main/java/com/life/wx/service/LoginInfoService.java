package com.life.wx.service;

import java.util.List;

import com.life.wx.model.LoginInfoModel;

/**
 * 微信用户登录信息 service
 * 
 * @author xianjun.liao
 *
 */
public interface LoginInfoService {
	/**
	 * 保存微信用户登录信息
	 * 
	 * @param loginInfoModel
	 */
	public void save(LoginInfoModel loginInfoModel);

	/**
	 * 根据微信用户唯一码查询登录信息
	 * 
	 * @param signature
	 * @return
	 */
	public List<LoginInfoModel> getLoginInfoListBySignature(String signature);
}
