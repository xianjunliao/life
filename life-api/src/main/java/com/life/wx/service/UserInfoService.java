package com.life.wx.service;

import com.life.wx.model.UserInfoModel;

/**
 * 微信用户信息 service
 * 
 * @author xianjun.liao
 *
 */
public interface UserInfoService {
	/**
	 * 保存微信用户信息
	 * 
	 * @param userInfoModel
	 */
	public void save(UserInfoModel userInfoModel);

	/**
	 * 修改微信用户信息
	 * 
	 * @param userInfoModel
	 */
	public void update(UserInfoModel userInfoModel);

	/**
	 * 根据微信唯一码查询微信用户信息
	 * 
	 * @param signature
	 * @return
	 */
	public UserInfoModel getUserInfoBySignature(String signature);
}
