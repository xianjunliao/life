package com.life.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import com.mchange.v1.util.ArrayUtils;


/**
 * 字符工具类
 * 
 * @author zouxx
 * @version 1.0.0
 */
public class StringUtil {
	/**
	 * 字符是否不为空
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNotBlank(String str) {
		if (null != str && !"".equals(str.trim())) {
			return true;
		}
		return false;
	}

	/**
	 * <p>
	 * Description: 字符串为空
	 * </p>
	 * 
	 * @author maosheng.liang
	 * @param str
	 *            验证信息
	 * @return boolean
	 * @date 2017年6月20日
	 */
	public static boolean isBlank(String str) {
		return !isNotBlank(str);
	}

	/**
	 * 格式化带"{n}"的字符串
	 * 
	 * @param formatStr
	 *            格式化带"{n}"的字符串；n为正整数且数字连续，从0开始
	 * @param value
	 *            替换对应的{n}
	 * @return
	 */
	public static String format(String formatStr, String... value) {
		for (int i = 0; i < value.length; i++) {
			formatStr = formatStr.replaceFirst("\\{" + i + "\\}", value[i]);
		}
		return formatStr;
	}

	/**
	 * 检查引用类型是否为空；为空返回false
	 * 
	 * @param obj
	 * @return
	 */
	public static boolean isNotBlankObj(Object obj) {
		if (obj instanceof String) {
			if (null != obj && !"".equals(((String) obj).trim())) {
				return true;
			}
			return false;
		} else {
			if (null != obj) {
				return true;
			}
			return false;
		}
	}

	/**
	 * 检查多个字符串都不为空; 都不为空时返回true;
	 * 
	 * @param strArr
	 * @return
	 */
	public static boolean isAllNotBlank(String... strArr) {
		boolean b = true;
		for (String str : strArr) {
			b = isNotBlank(str);
			if (b == false)
				break;
		}
		return b;
	}

	public static String upperCase(String str, Locale locale) {
		if (str == null) {
			return null;
		}
		return str.toUpperCase(locale);
	}

	public static String lowerCase(String str) {
		if (str == null) {
			return null;
		}
		return str.toLowerCase();
	}

	

	/**
	 * 将单词组合成一个字符串后按字典排序
	 * 
	 * @param strArr
	 *            字符串数组
	 * @return 按字典排序后组合字符串
	 */
	public static String dictionarySort(String... strArr) {
		if (!isAllNotBlank(strArr))
			return null;

		String str = "";
		for (String s : strArr) {
			str += s;
		}
		char[] cArr = str.toCharArray();
		Arrays.sort(cArr);
		// System.out.println("字典排序==>"+String.valueOf(cArr));
		return String.valueOf(cArr);
	}

	/**
	 * 将单词按字典中的顺序排序，再组合成一个字符串
	 * 
	 * @param strArr
	 *            字符串数组
	 * @return
	 */
	public static String dictWordSort(String... strArr) {
		if (!isAllNotBlank(strArr))
			return null;
		Arrays.sort(strArr);
		StringBuffer buffer = new StringBuffer();
		for (String s : strArr) {
			buffer.append(s);
		}
		return buffer.toString();
	}

	public static void main(String[] args) {
		System.out.println(StringUtil.format("aaa{0}，bbb{1}", "AAA", "BBB"));
		System.out.println(StringUtil.isBlank(null));
		System.out.println("字母排序：" + dictionarySort(new String[] { "C1707070001", "132131333", "7896" }));
		System.out.println("单词排序：" + dictWordSort(new String[] { "C1707070001", "132131333", "7896" }));
	}
}
