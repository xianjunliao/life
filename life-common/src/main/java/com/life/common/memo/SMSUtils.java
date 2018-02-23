package com.life.common.memo;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

import com.life.common.time.DateUtil;

public class SMSUtils {

	public static void sendShortMessage(String phoneNo, String dateTime, String url) {
		try {
			HttpClient client = new HttpClient();
			PostMethod post = new PostMethod("http://gbk.api.smschinese.cn");
			post.addRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=gbk");// 在头文件中设置转码
			NameValuePair[] data = { new NameValuePair("Uid", "Stephen201703"), new NameValuePair("Key", "ce9725de206d3502408a"), new NameValuePair("smsMob", phoneNo), new NameValuePair("smsText", dateTime + "有备忘录未处理,，请点击该链接： " + url + " 查看") };
			post.setRequestBody(data);
			client.executeMethod(post);
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

	public static void main(String[] args) {
		String abc = DateUtil.getNow();
		String asc = "www.liaoxianjun.com/memos";
		sendShortMessage("15889303913", abc,asc);
	}
}
