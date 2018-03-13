package com.life.common.shanbei;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.life.common.util.HttpRequestUtil;

public class WordUtils {

	private static String WORD_URL = "https://api.shanbay.com/bdc/search/";
//	private static String EXAPMPLE_URL = "https://api.shanbay.com/bdc/example/?vocabulary_id={id}&type={type}";

	public static Map<String, String> getWordMap(String word) {
		Map<String, String> map = new HashMap<>();
		JSONObject httpRequest = HttpRequestUtil.httpRequestShanbei(WORD_URL, "GET", "word="+word);
		JSONObject object = (JSONObject) httpRequest.get("data");
		JSONObject pronunciations = (JSONObject) object.get("pronunciations");
		System.out.println(object);
		String audio = (String) object.get("audio");
		String definition = (String) object.get("definition");
		String uk_audio = (String) object.get("uk_audio");
		String uk = (String) pronunciations.get("uk");
		String us = (String) pronunciations.get("us");
		map.put("usAudio", audio);
		map.put("ukAudio", uk_audio);
		map.put("definition", definition);
		map.put("ukPronunciations", "[" + uk + "]");
		map.put("usPronunciations", "[" + us + "]");
		return map;
	}
	

	public static void main(String[] args) {
	Map<String, String> wordMap = getWordMap("I have a dog.");
		System.out.println(wordMap);
	}
}
