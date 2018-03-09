package com.life.pc.model;

public class LearnParamModel implements java.io.Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 420746318309881657L;
	private String partOfSpeech;//词性
    private String wordType;
    private String wordInterpretayion;
    private String word;
    private String usercode;
    private String timeClass;
	public String getPartOfSpeech() {
		return partOfSpeech;
	}
	public void setPartOfSpeech(String partOfSpeech) {
		this.partOfSpeech = partOfSpeech;
	}
	public String getWordType() {
		return wordType;
	}
	public void setWordType(String wordType) {
		this.wordType = wordType;
	}
	public String getWordInterpretayion() {
		return wordInterpretayion;
	}
	public void setWordInterpretayion(String wordInterpretayion) {
		this.wordInterpretayion = wordInterpretayion;
	}
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public String getUsercode() {
		return usercode;
	}
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	
	public String getTimeClass() {
		return timeClass;
	}
	public void setTimeClass(String timeClass) {
		this.timeClass = timeClass;
	}
	@Override
	public String toString() {
		return "LearnParamModel [partOfSpeech=" + partOfSpeech + ", wordType=" + wordType + ", wordInterpretayion=" + wordInterpretayion + ", word=" + word + ", usercode=" + usercode + ", timeClass=" + timeClass + "]";
	}

}
