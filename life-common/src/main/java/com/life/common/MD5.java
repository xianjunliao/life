package com.life.common;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

import com.life.common.util.Base64Util;
public class MD5 {

	public MD5() {
	}

	public static String md5(byte b[]) throws NoSuchAlgorithmException {
		MessageDigest md5 = MessageDigest.getInstance("MD5");
		md5.update(b, 0, b.length);
		return byteArrayToHexString(md5.digest());
	}

	public static String md5(String data) throws NoSuchAlgorithmException,
			UnsupportedEncodingException {
		MessageDigest md5 = MessageDigest.getInstance("MD5");
		byte b[] = data.getBytes("UTF-8");
		md5.update(b, 0, b.length);
		return byteArrayToHexString(md5.digest());
	}

	public static String md5(String data,String encoding) throws NoSuchAlgorithmException,
			UnsupportedEncodingException {
		MessageDigest md5 = MessageDigest.getInstance("MD5");
		byte b[] = data.getBytes(encoding);
		md5.update(b, 0, b.length);
		return byteArrayToHexString(md5.digest());
	}

	private static String byteArrayToHexString(byte b[]) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < b.length; i++)
			sb.append(byteToHexString(b[i]));

		return sb.toString();
	}

	private static String byteToHexString(byte b) {
		int n = b;
		if (n < 0)
			n = 256 + n;
		int d1 = n / 16;
		int d2 = n % 16;
		return hexDigits[d1] + hexDigits[d2];
	}

	private static String hexDigits[] = { "0", "1", "2", "3", "4", "5", "6",
			"7", "8", "9", "a", "b", "c", "d", "e", "f","~" ,"@#","*&^"};
	
	public static void main(String[] args) {
		try {
			String md5 = md5("free-life-stephen-201703.html");
			String base64 = Base64Util.getBase64("4C20BC520B0D0F5D");
			System.out.println(md5);
			System.out.println(base64+UUID.randomUUID());
		} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

}
