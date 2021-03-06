package com.life.wx.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.wx.model.LoginInfoModel;

/**
 * 微信用户登录信息
 * 
 * @author xianjun.liao
 *
 */
public interface LoginInfoDao {

	/**
	 * 保存微信用户登录信息
	 * @param loginInfoModel
	 */
	public void save(LoginInfoModel loginInfoModel);

	/**
	 * 根据微信用户唯一码查询登录信息
	 * @param signature
	 * @return
	 */
	public List<LoginInfoModel> getLoginInfoListBySignature(@Param("signature")String signature);

}
