package com.life.pc.model;

public class LearnEnglishModel {
	private String id;//
	private String usercode;// 用户编号
	private String wordtype;// 词语类型
	private String en;// 英文
	private String zh;// 中文
	private String filepath;// 文件地址
	private String filename;// 文件名称
	private String createtime;// 创建时间
    private String externalLinks;//外部链接
    private String externalLinks2;//外部链接
    private String externalLinks3;//外部链接
    private String note;//笔记
    
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getUsercode() {
		return usercode;
	}

	public void setUsercode(String usercode) {
		this.usercode = usercode == null ? null : usercode.trim();
	}

	public String getWordtype() {
		return wordtype;
	}

	public void setWordtype(String wordtype) {
		this.wordtype = wordtype == null ? null : wordtype.trim();
	}

	public String getEn() {
		return en;
	}

	public void setEn(String en) {
		this.en = en == null ? null : en.trim();
	}

	public String getZh() {
		return zh;
	}

	public void setZh(String zh) {
		this.zh = zh == null ? null : zh.trim();
	}

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath == null ? null : filepath.trim();
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename == null ? null : filename.trim();
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getExternalLinks() {
		return externalLinks;
	}

	public void setExternalLinks(String externalLinks) {
		this.externalLinks = externalLinks;
	}

	public String getExternalLinks2() {
		return externalLinks2;
	}

	public void setExternalLinks2(String externalLinks2) {
		this.externalLinks2 = externalLinks2;
	}

	public String getExternalLinks3() {
		return externalLinks3;
	}

	public void setExternalLinks3(String externalLinks3) {
		this.externalLinks3 = externalLinks3;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	@Override
	public String toString() {
		return "LearnEnglishModel [id=" + id + ", usercode=" + usercode + ", wordtype=" + wordtype + ", en=" + en + ", zh=" + zh + ", filepath=" + filepath + ", filename=" + filename + ", createtime=" + createtime + ", externalLinks=" + externalLinks + ", externalLinks2=" + externalLinks2 + ", externalLinks3="
				+ externalLinks3 + ", note=" + note + "]";
	}

}