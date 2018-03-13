package com.life.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;

import com.alibaba.fastjson.JSONObject;

public class HttpRequestUtil {

	public static String ak = "OGIRGE5TgoQsU8lLdkYjBrlLtCSMm1UL";
	public static String url = "http://api.map.baidu.com/geocoder/v2/?output=json&pois=1&ak=OGIRGE5TgoQsU8lLdkYjBrlLtCSMm1UL";

	/**
	 * 发起http请求并获取结果
	 * 
	 * @param requestUrl
	 *            请求地址
	 * @param requestMethod
	 *            请求方式（GET、POST）
	 * @param outputStr
	 *            提交的数据
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
	 */
	public static JSONObject httpRequest(String requestUrl, String requestMethod, String longitude, String latitude) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		InputStream inputStream = null;
		try {
			String location = latitude + "," + longitude;
			requestUrl = requestUrl + "&location=" + location;
			System.out.println(requestUrl);
			URL url = new URL(requestUrl);
			HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();
			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);
			if ("GET".equalsIgnoreCase(requestMethod)) {
				httpUrlConn.connect();
			}
			// 将返回的输入流转换成字符串
			inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			jsonObject = JSONObject.parseObject(buffer.toString());
		} catch (ConnectException ce) {
			ce.printStackTrace();
			System.out.println("Weixin server connection timed out");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("http request error:{}");
		} finally {
			try {
				if (inputStream != null) {
					inputStream.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return jsonObject;
	}

	
	/**
	 * 发起http请求并获取结果
	 * 
	 * @param requestUrl
	 *            请求地址
	 * @param requestMethod
	 *            请求方式（GET、POST）
	 * @param outputStr
	 *            提交的数据
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
	 */
	public static JSONObject httpRequestShanbei(String requestUrl, String requestMethod,String paramName) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		InputStream inputStream = null;
		try {
			requestUrl = requestUrl + "?"+paramName;
			URL url = new URL(requestUrl);
			HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();
			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);
			if ("GET".equalsIgnoreCase(requestMethod)) {
				httpUrlConn.connect();
			}
			// 将返回的输入流转换成字符串
			inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			jsonObject = JSONObject.parseObject(buffer.toString());
		} catch (ConnectException ce) {
			ce.printStackTrace();
			System.out.println("Weixin server connection timed out");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("http request error:{}");
		} finally {
			try {
				if (inputStream != null) {
					inputStream.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return jsonObject;
	}
	/**
	 * 
	 * 根据经度 纬度 获取地址信息
	 * 
	 * @param longitude
	 *            经度
	 * @param latitude
	 *            纬度
	 * @return
	 */
	public static String getAddress(String longitude, String latitude) {

		JSONObject httpRequest = httpRequest(url, "GET", longitude, latitude);
		JSONObject x = (JSONObject) httpRequest.get("result");
		if (x == null) {
			return longitude + "," + latitude;
		}
		Object object = x.get("formatted_address");
		if (object == null) {
			return longitude + "," + latitude;
		}
		return object.toString();
	}

	/**
	 * 根据经度 纬度 获取地址信息
	 * 
	 * @param longitude
	 *            经度
	 * @param latitude
	 *            纬度
	 * @param key
	 *            country(国家) province(省份) city(城市) district(区镇) adcode(区域编码)
	 * @return
	 */
	public static String getAddress(String longitude, String latitude, String key) {
		JSONObject httpRequest = httpRequest(url, "GET", longitude, latitude);
		JSONObject x = (JSONObject) httpRequest.get("result");
		if (null == x) {
			return longitude + "," + latitude;
		}
		JSONObject object = (JSONObject) x.get("addressComponent");
		if (null == object) {
			return longitude + "," + latitude;
		}
		return (String) object.get(key);
	}

	/**
	 * 
	 * 根据经度 纬度 获取地址信息 只显示城市省份区域信息
	 * 
	 * @param longitude
	 *            经度
	 * @param latitude
	 *            纬度
	 * @return
	 */
	public static String getAddressCPD(String longitude, String latitude) {
		String province = getAddress(longitude, latitude, "province");
		String city = getAddress(longitude, latitude, "city");
		String district = getAddress(longitude, latitude, "district");
		return province + city + district;
	}

	public static void main(String[] args) {
		JSONObject httpRequest = HttpRequestUtil.httpRequest(HttpRequestUtil.url, "GET", "114.06476593017578", "22.566972732543945");
		System.out.println(httpRequest);
		JSONObject x = (JSONObject) httpRequest.get("result");
		System.out.println(x);
		JSONObject x2 = (JSONObject) x.get("addressComponent");
		System.out.println(x2.get("country"));
		System.out.println(x2.get("province"));
		System.out.println(x2.get("city"));
		System.out.println(x2.get("district"));
		System.out.println(x2.get("adcode"));

		String address = HttpRequestUtil.getAddress("114.06476593017578", "22.566972732543945");
		System.out.println(address);
		
		String loginInfoModel="114.06476593017578,22.566972732543945";
		String[] split = loginInfoModel.split(",");
		if(split.length>1){
			address = HttpRequestUtil.getAddress(split[0], split[1])+"b";
		}
		System.out.println("b"+address);
	}
}
