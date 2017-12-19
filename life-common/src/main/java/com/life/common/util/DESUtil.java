package com.life.common.util;

import org.apache.commons.lang.StringUtils;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;



public class DESUtil {
	 private static final byte[] IV_VALUE = { 12, 24, 48, 36, 48, 60, 72, 84 };
// 	private static final String KEY = "djqh.com";
 	public static final byte[] KEY = {0X64,0X6A,0X71,0X68,0X2E,0X63,0X6F,0X6D};
 	
 	
     /**
 	 * 加密byte数组 使用默认的IV和KEY
 	 * 
 	 * @param encryptBytes 
 	 * @return 加密后的byte数组
 	 * @throws Exception
 	 */
 	public static String encryptDES(String mingwen) throws Exception{
 		IvParameterSpec zeroIv = new IvParameterSpec(IV_VALUE);
// 		SecretKeySpec key = new SecretKeySpec(KEY.getBytes("UTF-8"), "DES");
 		SecretKeySpec key = new SecretKeySpec(KEY, "DES");
 		Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
 		cipher.init(Cipher.ENCRYPT_MODE, key, zeroIv);
 		byte[] encryptedData = cipher.doFinal(mingwen.getBytes("UTF-8"));
 		return  new BASE64Encoder().encode(encryptedData);
 	}

 	/**
 	 * 解密byte数组 使用默认的IV和KEY
 	 * 
 	 * @param decryptBytes
 	 * @return 解密后的byte数组
 	 * @throws UnsupportedEncodingException 
 	 * @throws NoSuchPaddingException 
 	 * @throws NoSuchAlgorithmException 
 	 * @throws Exception
 	 */
 	public static String decryptDES(String miwen) throws Exception {
 		byte[] byteMi = new BASE64Decoder().decodeBuffer(miwen);
			IvParameterSpec zeroIv = new IvParameterSpec(IV_VALUE);
//			SecretKeySpec key = new SecretKeySpec(KEY.getBytes("UTF-8"), "DES");
			SecretKeySpec key = new SecretKeySpec(KEY, "DES");
			Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, key, zeroIv);
			byte decryptedData[] = cipher.doFinal(byteMi);
			return new String(decryptedData,"UTF-8");
 	}
 	
 	/**
 	 * 解密数据及转换参数为map
 	 * @param data
 	 * @return
 	 * @throws Exception
 	 */
 	public static Map<String, String> getDataToMap(String data) throws Exception{
 		Map<String, String> map = null;
 		if (StringUtils.isNotEmpty(data)) {
 			map = new HashMap<String, String>();
 			data = DESUtil.decryptDES(data);
 			String[] params = data.split("&");
 			for (String param : params) {
 				String[] p = param.split("=");
 				if (p.length>1) {
 					map.put(p[0], p[1]);
					}else{
						map.put(p[0], "");
					}
 			}
 		}
 		return map;
 	}
 	
 	public static String getDataToString(String data) throws Exception{
 		String a= DESUtil.decryptDES(data);
 		return a;
 	}
 	
 	public static String getDataToMiwen() throws Exception{
 		String miwen = "12345678";
 		String a= DESUtil.encryptDES(miwen);  
 		return a;
 	}
 	
	public static void main(String[] args) {
		try {
			//System.out.print(getDataToMiwen());
			String in2="8MGqF+jhOWL7xfZqyZHXOnkXDedvqKC4JDE4n+/mmmKvdswrZBq2GGQgkJUNVbQMP/72z14Kh2T+mIhY7P6LL2HWaumq33Tlcq+g29722wUqkdRap/41pvnYba5hshmOqDaDP0qv9PgX9KnkuXXufQ==";
			String in= "8MGqF jhOWL7xfZqyZHXOnkXDedvqKC4JDE4n /mmmKvdswrZBq2GGQgkJUNVbQMP/72z14Kh2T mIhY7P6LL2HWaumq33Tlcq g29722wUqkdRap/41pvnYba5hshmOqDaDP0qv9PgX9KnkuXXufQ==";
			//String in = "8MGqF+jhOWL7xfZqyZHXOnkXDedvqKC4JDE4n+/mmmKvdswrZBq2GGQgkJUNVbQMP/72z1бн:502 8MGqF jhOWL7xfZqyZHXOnkXDedvqKC4JDE4n /mmmKvdswrZBq2GGQgkJUNVbQMP/72z14Kh2T mIhY7P6LL2HWaumq33Tlcq g29722wUqkdRap/41pvnYba5hshmOqDaDP0qv9PgX9KnkuXXufQ==";
			//in =  new String(in.getBytes(), "utf-8");
			in = in.replace(" ", "+");
			//in = URLEncoder.encode(in, "utf-8"); 
			System.out.println(in);
			System.out.print(DESUtil.decryptDES(in)); 
		} catch (Exception e) {			
			e.printStackTrace();
		}
	}
}
