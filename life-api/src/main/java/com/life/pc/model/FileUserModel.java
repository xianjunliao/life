package com.life.pc.model;

public class FileUserModel implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9144439193167915969L;
	private String id;// 文件id
	private String fileName;// 文件别名
	private String fileOriginalFilename;// 文件名称
	private String fileType;// 文件后缀
	private String filePath;// 文件上传的路径
	private String fileUrl;// 文件的访问url
	private String fileSize;// 文件大小
	private String uploadTime;// 上传时间
	private String uploadUser;// 上传用户
	private String sortNo;// 排序号
	private String contentType;// 文件类型
	private String fileSum;// 总文件大小
	private String isShare;// 是否分享 默认不分享

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileUrl() {
		return fileUrl;
	}

	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}

	public String getUploadUser() {
		return uploadUser;
	}

	public void setUploadUser(String uploadUser) {
		this.uploadUser = uploadUser;
	}

	public String getSortNo() {
		return sortNo;
	}

	public void setSortNo(String sortNo) {
		this.sortNo = sortNo;
	}

	public String getFileOriginalFilename() {
		return fileOriginalFilename;
	}

	public void setFileOriginalFilename(String fileOriginalFilename) {
		this.fileOriginalFilename = fileOriginalFilename;
	}

	public String getFileSum() {
		return fileSum;
	}

	public void setFileSum(String fileSum) {
		this.fileSum = fileSum;
	}

	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	public String getIsShare() {
		return isShare;
	}

	public void setIsShare(String isShare) {
		this.isShare = isShare;
	}

	@Override
	public String toString() {
		return "FileUserModel [id=" + id + ", fileName=" + fileName + ", fileOriginalFilename=" + fileOriginalFilename + ", fileType=" + fileType + ", filePath=" + filePath + ", fileUrl=" + fileUrl + ", fileSize=" + fileSize + ", uploadTime=" + uploadTime + ", uploadUser=" + uploadUser + ", sortNo=" + sortNo
				+ ", contentType=" + contentType + ", fileSum=" + fileSum + ", isShare=" + isShare + "]";
	}

}
