package com.life.common.baidu;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.life.common.baidu.translate.TransApi;
/**
 * 百度翻译
 * @author xianjun.liao
 *
 */
public class BaiduTranslate {

	private static final String APP_ID = "20170328000043593";
	private static final String SECURITY_KEY = "CQl3H8LS8lRclKNW3GmO";

	public static String getBaiduTranslateEn(String text) {
		TransApi api = new TransApi(APP_ID, SECURITY_KEY);
		String transResult = api.getTransResult(text, "auto", "en");
		JSONObject jsonObject = JSONObject.parseObject(transResult);
		JSONArray x = (JSONArray) jsonObject.get("trans_result");
		String string = x.getString(0);
		JSONObject jsonObject1 = JSONObject.parseObject(string);
		String x2 = (String) jsonObject1.get("dst");
		return x2;
	}
	public static String getBaiduTranslateZh(String text) {
		TransApi api = new TransApi(APP_ID, SECURITY_KEY);
		String transResult = api.getTransResult(text, "auto", "zh");
		JSONObject jsonObject = JSONObject.parseObject(transResult);
		JSONArray x = (JSONArray) jsonObject.get("trans_result");
		String string = x.getString(0);
		JSONObject jsonObject1 = JSONObject.parseObject(string);
		String x2 = (String) jsonObject1.get("dst");
		return x2;
	}
	public static void main(String[] args) {
//		String baiduTranslate = getBaiduTranslateEn("当政府就是不肯听取反对意见时，你该怎么做呢?");
//		BaiduVoice.getBaiduVoice(baiduTranslate, "1111", "danci_");
		String baiduTranslateZh = getBaiduTranslateEn("Annihilation");
		BaiduVoice.getBaiduVoice(baiduTranslateZh, "1111", "zh_");
		System.out.println(baiduTranslateZh);
	}

}
