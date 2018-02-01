package com.life.common.util;

import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import org.apache.shiro.codec.Base64;

public class DESUtil {
	private final static String DES = "DES";
	private final static String key="test中英文杂七烂八混搭@123654{";

	/**
	 *
	 * @param src
	 *            数据源
	 * @param key
	 *            密钥，长度必须是8的倍数
	 * @return
	 * @throws Exception
	 */
	public static byte[] decrypt(byte[] src, byte[] key) throws Exception {
		// DES算法要求有一个可信任的随机数源
		SecureRandom sr = new SecureRandom();
		// 从原始密匙数据创建一个DESKeySpec对象
		DESKeySpec dks = new DESKeySpec(key);
		// 创建一个密匙工厂，然后用它把DESKeySpec对象转换成一个SecretKey对象
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(DES);
		SecretKey securekey = keyFactory.generateSecret(dks);
		// Cipher对象实际完成解密操作
		Cipher cipher = Cipher.getInstance(DES);
		// 用密匙初始化Cipher对象
		cipher.init(Cipher.DECRYPT_MODE, securekey, sr);

		// 正式执行解密操作
		return cipher.doFinal(src);
	}

	public final static String decryptDES(String data) {
		try {
			// 这里就没走
			return new String(decrypt(String2byte(data.getBytes()), key.getBytes()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static byte[] String2byte(byte[] b) {
		if ((b.length % 2) != 0)
			throw new IllegalArgumentException("长度不是偶数");
		byte[] b2 = new byte[b.length / 2];
		for (int n = 0; n < b.length; n += 2) {
			String item = new String(b, n, 2);
			b2[n / 2] = (byte) Integer.parseInt(item, 16);
		}
		return b2;
	}

	public static String DataDecrypt(String str, byte[] key) {
		String decrypt = null;
		try {
			byte[] ret = decrypt(Base64.decode(str), key);
			decrypt = new String(ret, "UTF-8");
		} catch (Exception e) {
			System.out.print(e);
			decrypt = str;
		}
		return decrypt;

	}

	public static byte[] encrypt(byte[] src, byte[] key) throws Exception {
		// DES算法要求有一个可信任的随机数源
		SecureRandom sr = new SecureRandom();
		// 从原始密匙数据创建DESKeySpec对象
		DESKeySpec dks = new DESKeySpec(key);
		// 创建一个密匙工厂，然后用它把DESKeySpec转换成一个SecretKey对象
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(DES);
		SecretKey securekey = keyFactory.generateSecret(dks);
		// Cipher对象实际完成加密操作
		Cipher cipher = Cipher.getInstance(DES);
		// 用密匙初始化Cipher对象
		cipher.init(Cipher.ENCRYPT_MODE, securekey, sr);
		// 正式执行加密操作
		return cipher.doFinal(src);
	}

	/**
	 *
	 * @param password
	 *            密码
	 * @param key
	 *            加密字符串
	 * @return
	 */
	public final static String encryptDES(String password) {
		try {
			return byte2String(encrypt(password.getBytes(), key.getBytes()));
		} catch (Exception e) {
		}
		return null;
	}

	public static String byte2String(byte[] b) {
		String hs = "";
		String stmp = "";
		for (int n = 0; n < b.length; n++) {
			stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));
			if (stmp.length() == 1)
				hs = hs + "0" + stmp;
			else
				hs = hs + stmp;
		}
		return hs.toUpperCase();
	}

	public static String DataEncrypt(String str, byte[] key) {

		String encrypt = null;
		try {
			byte[] ret = encrypt(str.getBytes("UTF-8"), key);
			encrypt = new String(Base64.encode(ret));
		} catch (Exception e) {
			System.out.print(e);
			encrypt = str;
		}
		return encrypt;
	}

	public static void main(String[] args) {
		
		String encryptString =encryptDES("123456,78941324564879,87462456");
		System.out.println("加密后:" + encryptString);
		
		String desencryptString = decryptDES("FA8247476DA0DD670F1B6F1E78536B25EDE03B3AACD012B641A3FC861FD969D72BA4E59A594D44A9");
		System.out.println(desencryptString);
	}
	// 输出：is张三丰
}
