package com.life.wx.model;

public class LoginInfoModel implements java.io.Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4708187229727540514L;
	private String signature;// 微信唯一码
	private String nickname;// 微信昵称
	private String loginresult;// 登陆结果
	private String logintime;// 登陆时间
	private String loginaddress;// 登陆地址
	private String loginmessages;// 登陆信息
	private String brand;// 登陆时所用手机品牌
	private String model;// 登陆时所用手机型号
	private String version;// 微信版本
	private String language;// 微信设置的语言
	private String system;// 操作系统版本号
	private String avatarurl;// 登陆时的微信头像
	
	
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getLoginresult() {
		return loginresult;
	}
	public void setLoginresult(String loginresult) {
		this.loginresult = loginresult;
	}
	public String getLogintime() {
		return logintime;
	}
	public void setLogintime(String logintime) {
		this.logintime = logintime;
	}
	public String getLoginaddress() {
		return loginaddress;
	}
	public void setLoginaddress(String loginaddress) {
		this.loginaddress = loginaddress;
	}
	public String getLoginmessages() {
		return loginmessages;
	}
	public void setLoginmessages(String loginmessages) {
		this.loginmessages = loginmessages;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getSystem() {
		return system;
	}
	public void setSystem(String system) {
		this.system = system;
	}
	public String getAvatarurl() {
		return avatarurl;
	}
	public void setAvatarurl(String avatarurl) {
		this.avatarurl = avatarurl;
	}
	@Override
	public String toString() {
		return "LoginInfoModel [signature=" + signature + ", nickname=" + nickname + ", loginresult=" + loginresult + ", logintime=" + logintime + ", loginaddress=" + loginaddress + ", loginmessages=" + loginmessages + ", brand=" + brand + ", model=" + model + ", version=" + version + ", language=" + language
				+ ", system=" + system + ", avatarurl=" + avatarurl + "]";
	}

}
