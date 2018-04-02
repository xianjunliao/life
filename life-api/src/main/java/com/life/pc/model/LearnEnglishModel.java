package com.life.pc.model;

public class LearnEnglishModel  implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2893216560342510148L;
	private String id;//
	private String usercode;// 用户编号
	private String externallinks;// 外部链接
	private String externallinks2;// 外部链接2
	private String externallinks3;// 外部链接3
	private String note;// 笔记
	private String diary;// 日记
	private String headline;// 头部标题
	private String timeclass;// 时间类（前端jsp html元素class）

	private String wordsSum; //词汇量
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUsercode() {
		return usercode;
	}

	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}


	public String getExternallinks() {
		return externallinks;
	}

	public void setExternallinks(String externallinks) {
		this.externallinks = externallinks;
	}

	public String getExternallinks2() {
		return externallinks2;
	}

	public void setExternallinks2(String externallinks2) {
		this.externallinks2 = externallinks2;
	}

	public String getExternallinks3() {
		return externallinks3;
	}

	public void setExternallinks3(String externallinks3) {
		this.externallinks3 = externallinks3;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getDiary() {
		return diary;
	}

	public void setDiary(String diary) {
		this.diary = diary;
	}

	public String getHeadline() {
		return headline;
	}

	public void setHeadline(String headline) {
		this.headline = headline;
	}

	public String getTimeclass() {
		return timeclass;
	}

	public void setTimeclass(String timeclass) {
		this.timeclass = timeclass;
	}

	public String getWordsSum() {
		return wordsSum;
	}

	public void setWordsSum(String wordsSum) {
		this.wordsSum = wordsSum;
	}

	@Override
	public String toString() {
		return "LearnEnglishModel [id=" + id + ", usercode=" + usercode + ", externallinks=" + externallinks + ", externallinks2=" + externallinks2 + ", externallinks3=" + externallinks3 + ", note=" + note + ", diary=" + diary + ", headline=" + headline + ", timeclass=" + timeclass + ", wordsSum=" + wordsSum + "]";
	}

}