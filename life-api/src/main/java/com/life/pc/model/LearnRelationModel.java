package com.life.pc.model;

public class LearnRelationModel implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -762749840816391153L;
	private String learnid;//学习主表（learn_english）id
	private String wordid;//英文表(learn_english_words)id
	private String usercode;//用户编码
	private String interpertayionid;//释义表（learn_english_interpretayion）id
    public String getLearnid() {
        return learnid;
    }

    public void setLearnid(String learnid) {
        this.learnid = learnid == null ? null : learnid.trim();
    }

    public String getWordid() {
        return wordid;
    }

    public void setWordid(String wordid) {
        this.wordid = wordid == null ? null : wordid.trim();
    }

    public String getUsercode() {
        return usercode;
    }

    public void setUsercode(String usercode) {
        this.usercode = usercode == null ? null : usercode.trim();
    }

	public String getInterpertayionid() {
		return interpertayionid;
	}

	public void setInterpertayionid(String interpertayionid) {
		this.interpertayionid = interpertayionid;
	}

	@Override
	public String toString() {
		return "LearnRelationModel [learnid=" + learnid + ", wordid=" + wordid + ", usercode=" + usercode + ", interpertayionid=" + interpertayionid + "]";
	}
    
}