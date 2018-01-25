package com.life.pc.model;

import java.util.List;

public class TreeModel implements java.io.Serializable {

	/** FIXME */
	private static final long serialVersionUID = -5936124408303973175L;

	/** id */
	private String id;
	/** text */
	private String text;
	/** 状态 */
	private String state;// open,closed
	/** 是否选中 */
	private boolean checked;
	/** 属性 */
	private Object attributes;
	/** 子节点 */
	private List<TreeModel> children;
	/** 图标 */
	private String iconCls;
	/** 父节点ID */
	private String pid;
	/** 访问路径 */
	private String url;

	private String createTime;//
	private String updateTime;//

	private String userCode;//
	private String readMode;
	private String sortNo;
	private String status;// 状态 0 启用 1 停用
	private String level;// 菜单级别
	private String isShare;// 是否分享 默认分享

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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public Object getAttributes() {
		return attributes;
	}

	public void setAttributes(Object attributes) {
		this.attributes = attributes;
	}

	public List<TreeModel> getChildren() {
		return children;
	}

	public void setChildren(List<TreeModel> children) {
		this.children = children;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
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

	public String getReadMode() {
		return readMode;
	}

	public void setReadMode(String readMode) {
		this.readMode = readMode;
	}

	public String getSortNo() {
		return sortNo;
	}

	public void setSortNo(String sortNo) {
		this.sortNo = sortNo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getIsShare() {
		return isShare;
	}

	public void setIsShare(String isShare) {
		this.isShare = isShare;
	}

	@Override
	public String toString() {
		return "TreeModel [id=" + id + ", text=" + text + ", state=" + state + ", checked=" + checked + ", attributes=" + attributes + ", children=" + children + ", iconCls=" + iconCls + ", pid=" + pid + ", url=" + url + ", createTime=" + createTime + ", updateTime=" + updateTime + ", userCode=" + userCode
				+ ", readMode=" + readMode + ", sortNo=" + sortNo + ", status=" + status + ", level=" + level + ", isShare=" + isShare + "]";
	}


}
