package com.life.pc.model;

public class LearnEnglishWordsModel implements java.io.Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5885987951090662385L;
	private String id;//
	private String word;//英文
	private String addtime;//添加时间
	private String adduser;//添加用户
	private String type;//类型（词组，单词，长句子）
	private String mp3path;//语音mp3文件地址
	private String mp3url;//语音mp3url
	private String elseurl;//其他的url
	private String usPronunciation;
	private String ukPronunciation;
	private String ukAudio;
	private String usAudio;
	private String definition;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getAdduser() {
		return adduser;
	}
	public void setAdduser(String adduser) {
		this.adduser = adduser;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getMp3path() {
		return mp3path;
	}
	public void setMp3path(String mp3path) {
		this.mp3path = mp3path;
	}
	public String getMp3url() {
		return mp3url;
	}
	public void setMp3url(String mp3url) {
		this.mp3url = mp3url;
	}
	public String getElseurl() {
		return elseurl;
	}
	public void setElseurl(String elseurl) {
		this.elseurl = elseurl;
	}
	
	public String getUsPronunciation() {
		return usPronunciation;
	}
	public void setUsPronunciation(String usPronunciation) {
		this.usPronunciation = usPronunciation;
	}
	public String getUkPronunciation() {
		return ukPronunciation;
	}
	public void setUkPronunciation(String ukPronunciation) {
		this.ukPronunciation = ukPronunciation;
	}
	public String getUkAudio() {
		return ukAudio;
	}
	public void setUkAudio(String ukAudio) {
		this.ukAudio = ukAudio;
	}
	public String getUsAudio() {
		return usAudio;
	}
	public void setUsAudio(String usAudio) {
		this.usAudio = usAudio;
	}
	public String getDefinition() {
		return definition;
	}
	public void setDefinition(String definition) {
		this.definition = definition;
	}
	@Override
	public String toString() {
		return "LearnEnglishWordsModel [id=" + id + ", word=" + word + ", addtime=" + addtime + ", adduser=" + adduser + ", type=" + type + ", mp3path=" + mp3path + ", mp3url=" + mp3url + ", elseurl=" + elseurl + ", usPronunciation=" + usPronunciation + ", ukPronunciation=" + ukPronunciation + ", ukAudio=" + ukAudio
				+ ", usAudio=" + usAudio + ", definition=" + definition + "]";
	}
}