package com.life.pc.model;

public class SystemDataModel {

    private String indexes;

    private String itemNo;

    private String itemName;

    private String createtime;

    private String updatetime;
    
    private String usestatus;

	public String getIndexes() {
		return indexes;
	}

	public void setIndexes(String indexes) {
		this.indexes = indexes;
	}

	public String getItemNo() {
		return itemNo;
	}

	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
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

	
	public String getUsestatus() {
		return usestatus;
	}

	public void setUsestatus(String usestatus) {
		this.usestatus = usestatus;
	}

	@Override
	public String toString() {
		return "SystemDataModel [indexes=" + indexes + ", itemNo=" + itemNo + ", itemName=" + itemName + ", createtime=" + createtime + ", updatetime=" + updatetime + ", usestatus=" + usestatus + "]";
	}

}