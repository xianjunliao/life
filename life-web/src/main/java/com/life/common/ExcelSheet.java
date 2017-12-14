package com.life.common;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonView;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel("Excel文件表格 信息，Created by XHZ on 2017/10/16")
public class ExcelSheet implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 501679971619610784L;

	@JsonView(ExcelView.Public.class)
	@ApiModelProperty(value = "excel中每个表的表名", example = "放款明细", notes = "即每个sheet的名称")
	@Length(max = 255)
	private String sheetName;

	@JsonView(ExcelView.All.class)
	@ApiModelProperty(value = "表的标题", example = "放款明细")
	@Length(max = 255)
	private String titleName;

	@JsonView(ExcelView.All.class)
	@ApiModelProperty(value = "表头名和属性名", example = "合同号,contractStatus")
	private Map<String, String> HeaderName;

	@JsonView(ExcelView.All.class)
	@ApiModelProperty(value = "表数据", notes = "实体类等的集合")
	private List data;

	@JsonView(ExcelView.All.class)
	@ApiModelProperty(value = "表头字体", example = "Arial Unicode MS")
	@Length(max = 100)
	private String titleFontType = "Arial Unicode MS";

	@JsonView(ExcelView.All.class)
	@ApiModelProperty(value = "表头背景色", example = "C1FBEE", notes = "十六进制")
	@Length(max = 20)
	private String titleBackColor = "C1FBEE";

	@JsonView(ExcelView.All.class)
	@ApiModelProperty(value = "表头字号", example = "14")
	private short titleFontSize = 14;

	@JsonView(ExcelView.All.class)
	@ApiModelProperty(value = "添加自动筛选的列", example = "A:M")
	@Length(max = 100)
	private String address = "";

	@JsonView(ExcelView.All.class)
	@ApiModelProperty(value = "正文字体", example = "Arial Unicode MS")
	@Length(max = 100)
	private String contentFontType = "Arial Unicode MS";

	@JsonView(ExcelView.All.class)
	@ApiModelProperty(value = "正文字号", example = "12")
	private short contentFontSize = 12;

	@JsonView(ExcelView.All.class)
	@ApiModelProperty(value = "Float类型数据小数位", example = ".00")
	@Length(max = 20)
	private String floatDecimal = ".00";

	@JsonView(ExcelView.All.class)
	@ApiModelProperty(value = "Double类型数据小数位", example = ".00")
	@Length(max = 20)
	private String doubleDecimal = ".00";

	@JsonView(ExcelView.All.class)
	@ApiModelProperty(value = "设置列的公式", example = "A@+B@")
	private String[] colFormula = null;

	public String getSheetName() {
		return sheetName;
	}

	public void setSheetName(String sheetName) {
		this.sheetName = sheetName;
	}

	public String getTitleName() {
		return titleName;
	}

	public void setTitleName(String titleName) {
		this.titleName = titleName;
	}

	public Map<String, String> getHeaderName() {
		return HeaderName;
	}

	public void setHeaderName(Map<String, String> headerName) {
		HeaderName = headerName;
	}

	public List getData() {
		return data;
	}

	public void setData(List data) {
		this.data = data;
	}

	public String getTitleFontType() {
		return titleFontType;
	}

	public void setTitleFontType(String titleFontType) {
		this.titleFontType = titleFontType;
	}

	public String getTitleBackColor() {
		return titleBackColor;
	}

	public void setTitleBackColor(String titleBackColor) {
		this.titleBackColor = titleBackColor;
	}

	public short getTitleFontSize() {
		return titleFontSize;
	}

	public void setTitleFontSize(short titleFontSize) {
		this.titleFontSize = titleFontSize;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getContentFontType() {
		return contentFontType;
	}

	public void setContentFontType(String contentFontType) {
		this.contentFontType = contentFontType;
	}

	public short getContentFontSize() {
		return contentFontSize;
	}

	public void setContentFontSize(short contentFontSize) {
		this.contentFontSize = contentFontSize;
	}

	public String getFloatDecimal() {
		return floatDecimal;
	}

	public void setFloatDecimal(String floatDecimal) {
		this.floatDecimal = floatDecimal;
	}

	public String getDoubleDecimal() {
		return doubleDecimal;
	}

	public void setDoubleDecimal(String doubleDecimal) {
		this.doubleDecimal = doubleDecimal;
	}

	public String[] getColFormula() {
		return colFormula;
	}

	public void setColFormula(String[] colFormula) {
		this.colFormula = colFormula;
	}
}
