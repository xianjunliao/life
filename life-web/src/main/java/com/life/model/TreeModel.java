package com.life.model;

import java.io.Serializable;

public class TreeModel implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3954750771635837547L;
	private String id;//
	private String text;//
	private String iconcls;//
	private String checked;//
	private String state;//
	private String attributes;//
	private String pid;//
	private String createTime;//
	private String updateTime;//
	private String userCode;//
	private String url;//
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getIconcls() {
		return iconcls;
	}
	public void setIconcls(String iconcls) {
		this.iconcls = iconcls;
	}
	public String getChecked() {
		return checked;
	}
	public void setChecked(String checked) {
		this.checked = checked;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getAttributes() {
		return attributes;
	}
	public void setAttributes(String attributes) {
		this.attributes = attributes;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	@Override
	public String toString() {
		return "TreeModel [id=" + id + ", text=" + text + ", iconcls=" + iconcls + ", checked=" + checked + ", state=" + state + ", attributes=" + attributes + ", pid=" + pid + ", createTime=" + createTime + ", updateTime=" + updateTime + ", userCode=" + userCode + ", url=" + url + "]";
	}
	
}
