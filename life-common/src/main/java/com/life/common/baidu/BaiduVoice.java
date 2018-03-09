package com.life.common.baidu;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import com.baidu.aip.speech.AipSpeech;
import com.baidu.aip.speech.TtsResponse;
import com.baidu.aip.util.Util;

/**
 * 百度语音
 * 
 * @author xianjun.liao
 *
 */
public class BaiduVoice {
	// 设置APPID/AK/SK
	private static final String APP_ID = "10717766";
	private static final String API_KEY = "OGIRGE5TgoQsU8lLdkYjBrlLtCSMm1UL";
	private static final String SECRET_KEY = "UuxhlRXI5Ro6facm6x6yic4EAXfF7b6v";

	public static Map<String, String> getBaiduVoice(String id,String text, String usercode, String type) {
		Map<String, String> voiceInfo=new HashMap<>();
		AipSpeech client = new AipSpeech(APP_ID, API_KEY, SECRET_KEY);
		client.setConnectionTimeoutInMillis(2000);
		client.setSocketTimeoutInMillis(60000);
		HashMap<String, Object> options = new HashMap<String, Object>();
		options.put("spd", "4");
		options.put("pit", "5");
		options.put("per", "4");
		TtsResponse res = client.synthesis(text, "zh", 1, options);
		byte[] data = res.getData();
		JSONObject res1 = res.getResult();
		String fileName = id;
		String os = System.getProperty("os.name");
		String pathName = "D:/life/files/" + usercode + "/baidu/voice/";
		if (os.toLowerCase().startsWith("win")) {
			pathName = "D:/life/files/" + usercode + "/baidu/voice/";
		} else {
			pathName = "/usr/life/files/" + usercode + "/baidu/voice/";
		}
		fileName = fileName + ".mp3";
		String path = pathName + fileName;
		voiceInfo.put("fileName", fileName);
		voiceInfo.put("path", path);
		File file = new File(pathName);
		if (!file.exists()) {
			file.mkdirs();
		}
		if (data != null) {
			try {
				Util.writeBytesToFileSystem(data, path);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if (res1 != null) {
			System.out.println(res1.toString(2));
		}
		return voiceInfo;
	}

	public static String replaceFilesStr(String text) {
		if (text.contains("?")) {
			text = text.replace("?", "");
		}
		if (text.contains("？")) {
			text = text.replace("？", "");
		}
		if (text.contains("\\")) {
			text = text.replace("\\", "");
		}if (text.contains("/")) {
			text = text.replace("/", "");
		}
		if (text.contains(":")) {
			text = text.replace(":", "");
		}
		if (text.contains("：")) {
			text = text.replace("：", "");
		}
		if (text.contains("*")) {
			text = text.replace("*", "");
		}
		if (text.contains("\"")) {
			text = text.replace("\"", "");
		}
		if (text.contains("<")) {
			text = text.replace("<", "");
		}
		if (text.contains(">")) {
			text = text.replace(">", "");
		}
		if (text.contains("|")) {
			text = text.replace("|", "");
		}
		if (text.contains(",")) {
			text = text.replace(",", " ");
		}
		if (text.contains("，")) {
			text = text.replace("，", " ");
		}
		if (text.contains(".")) {
			text = text.replace(".", " ");
		}
		if (text.contains("。")) {
			text = text.replace("。", " ");
		}
		return text;
	}

	public static void main(String[] args) {
		String replaceFilesStr = replaceFilesStr("Annihilation");
		System.out.println(replaceFilesStr);
	}
}