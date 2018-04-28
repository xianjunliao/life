package com.life.pc.model;

public class FinanceRecordsModel {
    private String id;

    private String usercode;

    private String financename;

    private String financetype;

    private Double financemoney;

    private String financetime;

    private String financeyear;

    private String financemonth;

    private String financeday;

    private String financeweek;

    private String financequarter;

    private String financeremarks;

    private String financemode;

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

    public String getFinancename() {
        return financename;
    }

    public void setFinancename(String financename) {
        this.financename = financename == null ? null : financename.trim();
    }

    public String getFinancetype() {
        return financetype;
    }

    public void setFinancetype(String financetype) {
        this.financetype = financetype == null ? null : financetype.trim();
    }

    public Double getFinancemoney() {
        return financemoney;
    }

    public void setFinancemoney(Double financemoney) {
        this.financemoney = financemoney == null ? 0.00 :financemoney;
    }

    public String getFinancetime() {
        return financetime;
    }

    public void setFinancetime(String financetime) {
        this.financetime = financetime == null ? null : financetime.trim();
    }

    public String getFinanceyear() {
        return financeyear;
    }

    public void setFinanceyear(String financeyear) {
        this.financeyear = financeyear == null ? null : financeyear.trim();
    }

    public String getFinancemonth() {
        return financemonth;
    }

    public void setFinancemonth(String financemonth) {
        this.financemonth = financemonth == null ? null : financemonth.trim();
    }

    public String getFinanceday() {
        return financeday;
    }

    public void setFinanceday(String financeday) {
        this.financeday = financeday == null ? null : financeday.trim();
    }

    public String getFinanceweek() {
        return financeweek;
    }

    public void setFinanceweek(String financeweek) {
        this.financeweek = financeweek == null ? null : financeweek.trim();
    }

    public String getFinancequarter() {
        return financequarter;
    }

    public void setFinancequarter(String financequarter) {
        this.financequarter = financequarter == null ? null : financequarter.trim();
    }

    public String getFinanceremarks() {
        return financeremarks;
    }

    public void setFinanceremarks(String financeremarks) {
        this.financeremarks = financeremarks == null ? null : financeremarks.trim();
    }

    public String getFinancemode() {
        return financemode;
    }

    public void setFinancemode(String financemode) {
        this.financemode = financemode == null ? null : financemode.trim();
    }
}