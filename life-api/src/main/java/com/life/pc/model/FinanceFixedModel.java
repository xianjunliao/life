package com.life.pc.model;

public class FinanceFixedModel {
    private String id;

    private String usercode;

    private String fixedname;

    private String fixedmoney;

    private String createtime;

    private String updatetime;

    private String fixedtype;

    private String fixedmode;

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

    public String getFixedname() {
        return fixedname;
    }

    public void setFixedname(String fixedname) {
        this.fixedname = fixedname == null ? null : fixedname.trim();
    }

    public String getFixedmoney() {
        return fixedmoney;
    }

    public void setFixedmoney(String fixedmoney) {
        this.fixedmoney = fixedmoney == null ? null : fixedmoney.trim();
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

    public String getFixedtype() {
        return fixedtype;
    }

    public void setFixedtype(String fixedtype) {
        this.fixedtype = fixedtype == null ? null : fixedtype.trim();
    }

    public String getFixedmode() {
        return fixedmode;
    }

    public void setFixedmode(String fixedmode) {
        this.fixedmode = fixedmode == null ? null : fixedmode.trim();
    }
}