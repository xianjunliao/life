package com.life.model;

public class CustomMadeModel implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4370629274548444215L;
	private String id;//
	private String usercode;//
	private String filename;//
	private String filetype;//
	private String filesize;//
	private String createtime;//
	private String filepath;//
	private String fileurl;//
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
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFiletype() {
		return filetype;
	}
	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}
	public String getFilesize() {
		return filesize;
	}
	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public String getFileurl() {
		return fileurl;
	}
	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}
	@Override
	public String toString() {
		return "CodeFilesModel [id=" + id + ", usercode=" + usercode + ", filename=" + filename + ", filetype=" + filetype + ", filesize=" + filesize + ", createtime=" + createtime + ", filepath=" + filepath + ", fileurl=" + fileurl + "]";
	}
	
}
