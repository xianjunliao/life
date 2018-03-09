package com.life.pc.model;

public class LearnEnglishInterpretayionModel implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1532970536759766027L;
	private String id;//id
	private String wordtype;//词性
	private String wordinterpretation;//释义
	private String wordid;//英文表（learn_english_words）id

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getWordtype() {
        return wordtype;
    }

    public void setWordtype(String wordtype) {
        this.wordtype = wordtype == null ? null : wordtype.trim();
    }

    public String getWordinterpretation() {
        return wordinterpretation;
    }

    public String getWordid() {
		return wordid;
	}

	public void setWordid(String wordid) {
		this.wordid = wordid;
	}

	public void setWordinterpretation(String wordinterpretation) {
        this.wordinterpretation = wordinterpretation == null ? null : wordinterpretation.trim();
    }

	@Override
	public String toString() {
		return "LearnEnglishInterpretayionModel [id=" + id + ", wordtype=" + wordtype + ", wordinterpretation=" + wordinterpretation + ", wordid=" + wordid + "]";
	}
	
}