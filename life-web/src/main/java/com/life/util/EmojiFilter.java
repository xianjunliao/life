package com.life.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;


public class EmojiFilter {
    /**
     * 检测是否有emoji字符
     *
     * @param source
     * @return 一旦含有就抛出
     */
    public static boolean containsEmoji(String source) {
        if (StringUtils.isBlank(source)) {
            return false;
        }


        int len = source.length();

        for (int i = 0; i < len; i++) {
            char codePoint = source.charAt(i);

            if (isEmojiCharacter(codePoint)) {
                //do nothing，判断到了这里表明，确认有表情字符 20.
                return true;
            }
        }

        return false;
    }
    private static boolean isEmojiCharacter(char codePoint) {
        return (codePoint == 0x0) ||
                (codePoint == 0x9) ||
                (codePoint == 0xA) ||
                (codePoint == 0xD) ||
                ((codePoint >= 0x20) && (codePoint <= 0xD7FF)) ||
                ((codePoint >= 0xE000) && (codePoint <= 0xFFFD)) ||
                ((codePoint >= 0x10000) && (codePoint <= 0x10FFFF));
    }
    
    /**
     * 过滤emoji 或者 其他非文字类型的字符
     *
     * @param source
     * @return
     */
    public static String filterEmoji(String source) {

        if (!containsEmoji(source)) {
            return source;//如果不包含，直接返回 46.
        }
        //到这里铁定包含 48.
        StringBuilder buf = null;

        int len = source.length();

        for (int i = 0; i < len; i++) {
            char codePoint = source.charAt(i);

            if (isEmojiCharacter(codePoint)) {
                if (buf == null) {
                    buf = new StringBuilder(source.length());
                }

                buf.append(codePoint);
            } else {
            }
        }

        if (buf == null) {
            return source;//如果没有找到 emoji表情，则返回源字符串 67.
        } else {
            if (buf.length() == len) {//这里的意义在于尽可能少的toString，因为会重新生成字符串 69.
                buf = null;
                return source;
            } else {
                return buf.toString();
            }
        }

    }

    /*	 public static String removeNonBmpUnicode(String str) {
               if (str == null) {
                   return null;
                }
                 str = str.replaceAll("[^\\u0000-\\uFFFF]", "?");
               return str;
              }*/
    public static String removeNonBmpUnicode(String source) {
        if (StringUtils.isNotBlank(source)) {
            return source.replaceAll("[^\u0000-\uFFFF]", "*");
        } else {
            return source;
        }
    }
    /**
     * 过滤乱码及表情 只保留字母数字中文符号
     * @param str
     * @return
     */
    public static String filter(String str) {
    	if(null==str||str.equals("")){
    		return "";
    	}
    	str=str.trim();
    	String str2="";
    	String reg = "[^\u4e00-\u9fa5]";  
    	String regEx="[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]"; 
    	if(str != null && !"".equals(str)){
	    	for(int i=0;i<str.length();i++){
		    	if(str.charAt(i)>=48 && str.charAt(i)<=57){
			    	str2+=str.charAt(i);
			    }else if((str.charAt(i)<='z'&&str.charAt(i)>='a')||(str.charAt(i)<='Z'&&str.charAt(i)>='A')){
		    		str2+=str.charAt(i);
				}else if(regEx.indexOf(String.valueOf(str.charAt(i)))>=0){
		    		str2+=str.charAt(i);
		    	}else if(!String.valueOf(str.charAt(i)).replaceAll(reg, "").equals("")){
		    		str2+=String.valueOf(str.charAt(i)).replaceAll(reg, "");
		    	}
		    }
	    }
		return str2;
    }
    
}
