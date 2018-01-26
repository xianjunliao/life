package com.life.pc.service.impl;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.life.common.file.FileUtils;
import com.life.common.time.DateUtil;
import com.life.pc.dao.FileUserDao;
import com.life.pc.model.FileUserModel;
import com.life.pc.service.FileUserService;

@Service("fileUserService")
public class FileUserServiceImpl implements FileUserService {

	@Autowired
	private FileUserDao fileUserDao;

	@Override
	public void save(MultipartFile file, FileUserModel fileUserModel) {
		try {
			String filePath = "D:/life_files/";
			String filesUpload_stream = FileUtils.FilesUpload_stream(file, filePath, fileUserModel.getUploadUser(), fileUserModel.getFileType(), fileUserModel.getFileName().replace(",", " and "));
			fileUserModel.setFilePath(filesUpload_stream);
			fileUserDao.save(fileUserModel);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<FileUserModel> getFilesByUserCode(String userCode) {
		return fileUserDao.getFilesByUserCode(userCode);
	}

	@Override
	public Long getMaxSortNo(String userCode) {
		return fileUserDao.getMaxSortNo(userCode);
	}

	@Override
	public List<FileUserModel> getFileTypes() {
		return fileUserDao.getFileTypes();
	}

	@Override
	public FileUserModel getFileById(String id) {
		return fileUserDao.getFileById(id);
	}

	@Override
	public List<FileUserModel> getFilesByTypeAndUserCode(String userCode, String fileType) {
		return fileUserDao.getFilesByTypeAndUserCode(userCode, fileType);
	}

	@Override
	public List<FileUserModel> getSumGroupTypeByUserCode(String userCode) {
		return fileUserDao.getSumGroupTypeByUserCode(userCode);
	}

	@Override
	public long getFileByName(String userCode, String fileName) {
		return fileUserDao.getFileByName(userCode, fileName);
	}

	@Override
	public void delete(String id) {
		try {
			FileUserModel fileUserModel = fileUserDao.getFileById(id);
			FileUtils.deletePath(fileUserModel.getFilePath());
			fileUserDao.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void update(String id, String fileName) {
		fileUserDao.update(id, fileName);

	}

	public static void main(String[] args) {
		try {
			HttpClient client = new HttpClient();
			PostMethod post = new PostMethod("http://gbk.api.smschinese.cn");
			String abc = DateUtil.getNow();
			String asc = "www.liaoxianjun.com";
			post.addRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=gbk");// 在头文件中设置转码
			NameValuePair[] data = { new NameValuePair("Uid", "Stephen201703"), new NameValuePair("Key", "ce9725de206d3502408a"), new NameValuePair("smsMob", "18665378624"), new NameValuePair("smsText", abc+"你有备忘未处理,请登录"+asc+"网站查看未处理的备忘录") };
			post.setRequestBody(data);
			client.executeMethod(post);
			Header[] headers = post.getResponseHeaders();
			int statusCode = post.getStatusCode();
			System.out.println("statusCode:" + statusCode);
			for (Header h : headers) {
				System.out.println(h.toString());
			}
			String result = new String(post.getResponseBodyAsString().getBytes("gbk"));
			System.out.println(result); // 打印返回消息状态

			post.releaseConnection();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (HttpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
