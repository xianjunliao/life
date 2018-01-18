package com.life.wx.model;

public class UserInfoModel implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7974385089023116503L;
	private String nickname;// 微信昵称
	private String avatarurl;// 头像地址
	private String gender;// 性别 (1 男 0 女)
	private String province;// 省份
	private String city;// 城市
	private String country;// 国家
	private String signature;// 微信唯一码
	private String createtime;// 创建时间
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getAvatarurl() {
		return avatarurl;
	}
	public void setAvatarurl(String avatarurl) {
		this.avatarurl = avatarurl;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	@Override
	public String toString() {
		return "UserInfoModel [nickname=" + nickname + ", avatarurl=" + avatarurl + ", gender=" + gender + ", province=" + province + ", city=" + city + ", country=" + country + ", signature=" + signature + ", createtime=" + createtime + "]";
	}
}
