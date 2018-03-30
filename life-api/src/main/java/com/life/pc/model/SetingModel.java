package com.life.pc.model;

public class SetingModel {
    private String id;

    private String usercode;

    private String setingoption;

    private String setingvalue;

    private String fatheroption;

    private String createtime;

    private String updatetime;
    
    private String isUse;

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

    public String getSetingoption() {
        return setingoption;
    }

    public void setSetingoption(String setingoption) {
        this.setingoption = setingoption == null ? null : setingoption.trim();
    }

    public String getSetingvalue() {
        return setingvalue;
    }

    public void setSetingvalue(String setingvalue) {
        this.setingvalue = setingvalue == null ? null : setingvalue.trim();
    }

    public String getFatheroption() {
        return fatheroption;
    }

    public void setFatheroption(String fatheroption) {
        this.fatheroption = fatheroption == null ? null : fatheroption.trim();
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }

    public String getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(String updatetime) {
        this.updatetime = updatetime == null ? null : updatetime.trim();
    }

	public String getIsUse() {
		return isUse;
	}

	public void setIsUse(String isUse) {
		this.isUse = isUse;
	}

	@Override
	public String toString() {
		return "SetingModel [id=" + id + ", usercode=" + usercode + ", setingoption=" + setingoption + ", setingvalue=" + setingvalue + ", fatheroption=" + fatheroption + ", createtime=" + createtime + ", updatetime=" + updatetime + ", isUse=" + isUse + "]";
	}
    
}