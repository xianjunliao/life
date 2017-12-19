package com.life.util;

import org.apache.commons.lang.StringUtils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class EmojiFilterUtils {
    /**
     * * 将emoji表情替换成* * *
     *
     * @param source *
     * @return 过滤后的字符串
     */
    public static String filterEmoji(String source) {
        if (StringUtils.isNotBlank(source)) {
            return source.replaceAll("[\ud800\udc00-\udbff\udfff\ud800-\udfff]", "*");
        } else {
            return source;
        }
    }

    public static String removeNonBmpUnicode(String source) {
        if (StringUtils.isNotBlank(source)) {
            return source.replaceAll("[^\u0000-\uFFFF]", "*");
        } else {
            return source;
        }
    }

    public static void main(String[] arg) {
        try {
            String text = "This is a smiley \uD83C\uDFA6 face\uD860\uDD5D \uD860\uDE07 \uD860\uDEE2 \uD863\uDCCA \uD863\uDCCD \uD863\uDCD2 \uD867\uDD98 ";


            //	 Pattern pattern = Pattern.compile("[\ud83c\udc00-\ud83c\udfff]|[\ud83d\udc00-\ud83d\udfff]|[\u2600-\u27ff]",Pattern.UNICODE_CASE | Pattern.CASE_INSENSITIVE);
            Pattern pattern = Pattern.compile("[\ud800\udc00-\udbff\udfff\ud800-\udfff]", Pattern.UNICODE_CASE | Pattern.CASE_INSENSITIVE);

            Matcher matcher = pattern.matcher(text);

            while (matcher.find()) {

                System.out.println(matcher.group(0));


            }

            String as = removeNonBmpUnicode(text);
            System.out.println("as=" + as);
            String a = filterEmoji(text);
            text = text.replaceAll("[\ud800\udc00-\udbff\udfff\ud800-\udfff]", "?");

            System.out.println(a);
            /*System.out.println(text);
            System.out.println(text.length());
			System.out
					.println(text
							.replaceAll(
									"[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]",
									"*"));
			System.out.println(filterEmoji(text));*/
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
