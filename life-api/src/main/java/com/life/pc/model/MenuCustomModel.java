package com.life.pc.model;

public class MenuCustomModel {
    private String id;

    private String usercode;

    private String menuurl;

    private String menustatus;

    private String menuname;

    private String createtime;

    private String updatetime;

    private String menuorder;
    
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

    public String getMenuurl() {
        return menuurl;
    }

    public void setMenuurl(String menuurl) {
        this.menuurl = menuurl == null ? null : menuurl.trim();
    }

    public String getMenustatus() {
        return menustatus;
    }

    public void setMenustatus(String menustatus) {
        this.menustatus = menustatus == null ? null : menustatus.trim();
    }

    public String getMenuname() {
        return menuname;
    }

    public void setMenuname(String menuname) {
        this.menuname = menuname == null ? null : menuname.trim();
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

	public String getMenuorder() {
		return menuorder;
	}

	public void setMenuorder(String menuorder) {
		this.menuorder = menuorder;
	}

	@Override
	public String toString() {
		return "MenuCustomModel [id=" + id + ", usercode=" + usercode + ", menuurl=" + menuurl + ", menustatus="
				+ menustatus + ", menuname=" + menuname + ", createtime=" + createtime + ", updatetime=" + updatetime
				+ ", menuorder=" + menuorder + "]";
	}
    
}