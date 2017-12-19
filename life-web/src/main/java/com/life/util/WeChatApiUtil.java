package com.life.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.multipart.FilePart;
import org.apache.commons.httpclient.methods.multipart.MultipartRequestEntity;
import org.apache.commons.httpclient.methods.multipart.Part;
import org.apache.commons.httpclient.methods.multipart.StringPart;
import org.apache.commons.httpclient.protocol.Protocol;


/*
 * @Title:  WeChatApiUtil.java
 * @Copyright:  data Co., Ltd. Copyright 2016-2018,  All rights reserved
 * @Description:  TODO<请描述此文件是做什么的>
 * @author:  yubon
 * @data:  Jan 21, 2017 7:21:05 PM
 * @version:  V1.0
 */
public class WeChatApiUtil {
	// token 接口(GET)
	private static final String ACCESS_TOKEN = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s";
	// 素材上传(POST)
	private static final String UPLOAD_MEDIA = "http://file.api.weixin.qq.com/cgi-bin/media/upload";
	// 素材下载:不支持视频文件的下载(GET)
	private static final String DOWNLOAD_MEDIA = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=%s&media_id=%s";

	public static String getTokenUrl(String appId, String appSecret) {
		return String.format(ACCESS_TOKEN, appId, appSecret);
	}

	public static String getDownloadUrl(String token, String mediaId) {
		return String.format(DOWNLOAD_MEDIA, token, mediaId);
	}

	/**
	 * 通用接口获取Token凭证
	 * 
	 * @param appId
	 * @param appSecret
	 * @return
	 */

	/**
	 * 微信服务器素材上传
	 * 
	 * @param file
	 *            表单名称media
	 * @param token
	 *            access_token
	 * @param type
	 *            type只支持四种类型素材(video/image/voice/thumb)
	 */
	public static String uploadMedia(File file, String token, String type,String filename) {
		if (file == null || token == null || type == null) {
			return null;
		}

		if (!file.exists()) {
			// logger.info("上传文件不存在,请检查!");
			return null;
		}
		String text = "";
		String url = UPLOAD_MEDIA;
		
		PostMethod post = new PostMethod(url);
		post.setRequestHeader("Connection", "Keep-Alive");
		post.setRequestHeader("Cache-Control", "no-cache");
		FilePart media = null;
		HttpClient httpClient = new HttpClient();
		// 信任任何类型的证书
		Protocol myhttps = new Protocol("https",
				new MySSLProtocolSocketFactory(), 443);
		Protocol.registerProtocol("https", myhttps);

		try {
			//media = new FilePart("media", file);
			media =new FilePart("media",filename,file); 
			
			//media=new CustomFilePart(filename, file);
			
			Part[] parts = new Part[] { new StringPart("access_token", token),
					new StringPart("type", type), media };
			//Part[] parts = new Part[] {new CustomFilePart(file.getName(), file)};     
			MultipartRequestEntity entity = new MultipartRequestEntity(parts,
					post.getParams());
			post.setRequestEntity(entity);
			int status = httpClient.executeMethod(post);
			if (status == HttpStatus.SC_OK) {
				text = post.getResponseBodyAsString();

			} else {
				// logger.info("upload Media failure status is:" + status);
			}
		} catch (FileNotFoundException execption) {
			// logger.error(execption);
		} catch (HttpException execption) {
			// logger.error(execption);
		} catch (IOException execption) {
			// logger.error(execption);
		}
		return text;
	}

	/**
	 * 以http方式发送请求,并将请求响应内容输出到文件
	 * 
	 * @param path
	 *            请求路径
	 * @param method
	 *            请求方法
	 * @param body
	 *            请求数据
	 * @return 返回响应的存储到文件
	 */

/*	public static void main(String[] args) {
		String appid = "tesx";
		String appsecret = "xxx";

		File f = new File(
				"D:\\workspace\\qing\\WebRoot/resources/upload/images/weixinShare/2017/01/21/20170121203505476623.jpg");

		String token = access_token(appid, appsecret);
		String o = WeChatApiUtil.uploadMedia(f, token, "image");
		System.out.println(o);

		JSONObject temp = JSONObject.parseObject(o);
		String subscribe = temp.getString("media_id");
		System.out.println(subscribe);

	}*/
}
