package com.life.pc.model;

public class InParamModel {

	private String usercode;
	
	private String beginday;

	private String endday;

	private String pageNumber;

	private String pageSize;

	private String total;
	
	private String order;
	
	private String queryType;

	public String getUsercode() {
		return usercode;
	}

	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}

	public String getBeginday() {
		return beginday;
	}

	public void setBeginday(String beginday) {
		this.beginday = beginday;
	}

	public String getEndday() {
		return endday;
	}

	public void setEndday(String endday) {
		this.endday = endday;
	}

	public String getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(String pageNumber) {
		this.pageNumber = pageNumber;
	}

	public String getPageSize() {
		return pageSize;
	}

	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}
	
	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getQueryType() {
		return queryType;
	}

	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}

	@Override
	public String toString() {
		return "InParamModel [usercode=" + usercode + ", beginday=" + beginday + ", endday=" + endday + ", pageNumber="
				+ pageNumber + ", pageSize=" + pageSize + ", total=" + total + ", order=" + order + ", queryType="
				+ queryType + "]";
	}

}
