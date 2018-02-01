package com.life.pc.model;

import java.io.Serializable;

public class LifeUserModel implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2655175296386923307L;
	private String usercode;// 编号
	private String createtime;// 创建时间
	private String userrole;// 用户角色
	private String updatetime;// 修改时间
	private String phoneno;// 手机号码
	private String emailaddress;// 邮箱地址
	private String defaultplayaddress;// 默认播放地址
	private String selfintroduction;// 自我介绍
	private String username;// 用户名称
	private String headaddress;// 头像地址
	private String password;// 密码
	private String regStep;//注册步骤

	public String getUsercode() {
		return usercode;
	}

	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getUserrole() {
		return userrole;
	}

	public void setUserrole(String userrole) {
		this.userrole = userrole;
	}

	public String getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}

	public String getPhoneno() {
		return phoneno;
	}

	public void setPhoneno(String phoneno) {
		this.phoneno = phoneno;
	}

	public String getEmailaddress() {
		return emailaddress;
	}

	public void setEmailaddress(String emailaddress) {
		this.emailaddress = emailaddress;
	}

	public String getDefaultplayaddress() {
		return defaultplayaddress;
	}

	public void setDefaultplayaddress(String defaultplayaddress) {
		this.defaultplayaddress = defaultplayaddress;
	}

	public String getSelfintroduction() {
		return selfintroduction;
	}

	public void setSelfintroduction(String selfintroduction) {
		this.selfintroduction = selfintroduction;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getHeadaddress() {
		return headaddress;
	}

	public void setHeadaddress(String headaddress) {
		this.headaddress = headaddress;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRegStep() {
		return regStep;
	}

	public void setRegStep(String regStep) {
		this.regStep = regStep;
	}

	@Override
	public String toString() {
		return "LifeUserModel [usercode=" + usercode + ", createtime=" + createtime + ", userrole=" + userrole + ", updatetime=" + updatetime + ", phoneno=" + phoneno + ", emailaddress=" + emailaddress + ", defaultplayaddress=" + defaultplayaddress + ", selfintroduction=" + selfintroduction + ", username=" + username
				+ ", headaddress=" + headaddress + ", password=" + password + ", regStep=" + regStep + "]";
	}

}
