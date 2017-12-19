package com.life.common.excel;

import java.io.Serializable;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonView;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel("Excel文件 信息，Created by XHZ on 2017/10/16")
public class ExcelFile implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4483721059331189002L;

	@JsonView(ExcelView.Public.class)
	@ApiModelProperty(value = "excel文件名", required = true, example = "放款表")
	@Length(max = 40)
	private String fileName;

	@JsonView(ExcelView.Public.class)
	@ApiModelProperty(value = "excel文件路径", required = true)
	@Length(max = 255)
	private String fileDir;

	@JsonView(ExcelView.Public.class)
	@ApiModelProperty(value = "excel中每个表的表名", example = "放款明细",notes = "即每个sheet的名称，也是表的标题")
	private List<ExcelSheet> sheets;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public List<ExcelSheet> getSheets() {
		return sheets;
	}

	public void setSheets(List<ExcelSheet> sheets) {
		this.sheets = sheets;
	}

	public String getFileDir() {
		return fileDir;
	}

	public void setFileDir(String fileDir) {
		this.fileDir = fileDir;
	}
}

