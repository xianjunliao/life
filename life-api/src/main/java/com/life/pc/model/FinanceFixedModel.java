package com.life.pc.model;

public class FinanceFixedModel {
    private String id;

    private String usercode;

    private String financename;

    private Double financemoney;

    private String createtime;

    private String updatetime;

    private String financetype;

    private String financemode;

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

	public String getFinancename() {
		return financename;
	}

	public void setFinancename(String financename) {
		this.financename = financename;
	}

	public Double getFinancemoney() {
		return financemoney;
	}

	public void setFinancemoney(Double financemoney) {
		this.financemoney = financemoney;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}

	public String getFinancetype() {
		return financetype;
	}

	public void setFinancetype(String financetype) {
		this.financetype = financetype;
	}

	public String getFinancemode() {
		return financemode;
	}

	public void setFinancemode(String financemode) {
		this.financemode = financemode;
	}

	@Override
	public String toString() {
		return "FinanceFixedModel [id=" + id + ", usercode=" + usercode + ", financename=" + financename
				+ ", financemoney=" + financemoney + ", createtime=" + createtime + ", updatetime=" + updatetime
				+ ", financetype=" + financetype + ", financemode=" + financemode + "]";
	}

}