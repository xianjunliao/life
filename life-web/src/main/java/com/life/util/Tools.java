package com.life.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

/**
 * 工具类处理
 * @author Andy
 */
public class Tools
{
    public static String encode(byte[] bytes) {     
        String result = "";
        try { 
            MessageDigest digester = MessageDigest.getInstance("MD5");
            // get encoded byte array.
            byte[] encodeBytes = digester.digest(bytes);
            // Converts encoded byte array to Hex String.
            StringBuilder sb = new StringBuilder();

            for (byte b : encodeBytes) {
                int num = b & 0xff;
                String hex = Integer.toHexString(num);
                if (hex.length() == 1) {
                    sb.append(0);
                }
                sb.append(hex);
            }
            result = sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return result;
    }
    
	public static String EncoderByMd5(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException{			
		String newstr = encode(str.getBytes("utf-8"));//加密后的字符串
		return newstr;
	}
	
    /**
     * 获得32位唯一序列号
     * @return 32为ID字符串
     */
    public static String getUUID_32()
    {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
    
    /**
     * 截取字符串长度
     * @param beforeStr
     * @param cutLeng
     * @return 截取后的字符串
     */
    public static String subStr(String beforeStr, int cutLeng)
    {
        if (beforeStr.length() > cutLeng)
        {
            return beforeStr.substring(0, cutLeng) + "...";
        }
        return beforeStr;
    }
    
    /**
     * 生成随机字符串，字母和数字混合
     * @return 组合后的字符串 ^[0-9a-zA-Z]
     */
    public static String getRandomChar()
    {
        //生成一个0、1、2的随机数字
        int rand = (int)Math.round(Math.random() * 2);
        long itmp = 0;
        char ctmp = '\u0000';
        switch (rand)
        {
            //生成大写字母
            case 1:
                itmp = Math.round(Math.random() * 25 + 65);
                ctmp = (char)itmp;
                return String.valueOf(ctmp);
            //生成小写字母
            case 2:
                itmp = Math.round(Math.random() * 25 + 97);
                ctmp = (char)itmp;
                return String.valueOf(ctmp);
            //生成数字
            default:
                itmp = Math.round(Math.random() * 9);
                return itmp + "";
        }
    }
    
    /**
     * 替换字符串中的占位符
     * @param msg 消息
     * @param args 占位符替换数组
     * @return
     */
    public static String getPlaceHolder(String msg, Object[] args)
    {
        return MessageFormat.format(msg, args);
    }
    
    /**
     * 获取一个字符串的MD5
     * @param msg
     * @return 加密后的MD5字符串
     * @throws NoSuchAlgorithmException 
     */
    public static String md5Encryp(String msg)
    {
        byte[] source = msg.getBytes();
        String s = null;
        //用来将字节转换成16进制表示的字符  
        char[] hexDigits = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
        MessageDigest md = null;
        try
        {
            md = MessageDigest.getInstance("MD5");
            md.update(source);
            //MD5的计算结果是一个128位的长整数，用字节表示为16个字节  
            byte[] tmp = md.digest();
            //每个字节用16进制表示的话，使用2个字符(高4位一个,低4位一个)，所以表示成16进制需要32个字符  
            char[] str = new char[16 * 2];
            //转换结果中对应的字符位置
            int k = 0;
            //对MD5的每一个字节转换成16进制字符  
            for (int i = 0; i < 16; i++)
            {
                byte byte0 = tmp[i];
                //对字节高4位进行16进制转换  
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                //对字节低4位进行16进制转换
                str[k++] = hexDigits[byte0 & 0xf];
            }
            s = new String(str);
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        return s;
    }
    
    /**
     * 判断list是否为空
     * @param list
     * @return true==为空
     */
    public static <T> boolean isEmpty(List<T> list)
    {
        return (list == null || list.size() == 0);
    }
    
    /**
     * 判断Map是否为空
     * @param map
     * @return true==为空
     */
    public static <K, V> boolean isEmpty(Map<K, V> map)
    {
        return (map == null || map.size() == 0);
    }
    
    /**
     * 判断Set是否为空
     * @param set
     * @return true==为空
     */
    public static <T> boolean isEmpty(Set<T> set)
    {
        return (set == null) || (set.size() == 0);
    }
    
    /**
     * 判断String是否为空
     * @param str
     * @return true==为空
     */
    public static boolean isEmpty(String str)
    {
        return (str == null || str.trim().length() == 0);
    }
    
    /**
     * 判断Object是否为空
     * @param obj
     * @return true==为空
     */
    public static <T> boolean isEmpty(T t)
    {
        return (t == null);
    }
    
    /**
     * 判断Object[]是否为空
     * @param arrObject
     * @return true==为空
     */
    public static <T> boolean isEmpty(T[] arrObject)
    {
        return (arrObject == null || arrObject.length == 0);
    }
    
    /**
     * 判断List不为空
     * @param list
     * @return true==不为空
     */
    public static <T> boolean isNotEmpty(List<T> list)
    {
        return !isEmpty(list);
    }
    
    /**
     * 判断Map不为空
     * @param map
     * @return true==不为空
     */
    public static <K, V> boolean isNotEmpty(Map<K, V> map)
    {
        return !isEmpty(map);
    }
    
    /**
     * 判断Set不为空
     * @param set
     * @return true==不为空
     */
    public static <T> boolean isNotEmpty(Set<T> set)
    {
        return !isEmpty(set);
    }
    
    /**
     * 判断String不为空
     * @param str
     * @return true==不为空
     */
    public static boolean isNotEmpty(String str)
    {
        return !isEmpty(str);
    }
    
    /**
     * 判断Object不为空
     * @param obj
     * @return true==不为空
     */
    public static <T> boolean isNotEmpty(T t)
    {
        return !isEmpty(t);
    }
    
    /**
     * 判断Object[]不为空
     * @param arrObject
     * @return true==不为空
     */
    public static <T> boolean isNotEmpty(T[] arrObject)
    {
        return !isEmpty(arrObject);
    }
    
    /**
     * 根据传入的map判断是否返回新的hashmap，处理Map为空的情况
     */
    public static <K, V> Map<K, V> isGetNewMap(Map<K, V> map)
    {
        return Tools.isEmpty(map) ? new HashMap<K, V>() : map;
    }
    
    /**
     * 获取HashMap
     * @return
     */
    public static <K, V> Map<K, V> newHashMap()
    {
        return new HashMap<K, V>();
    }
    
    /**
     * 是否获取空hashset，判断为空情况
     * @param set
     * @return
     */
    public static <T> Set<T> isGetNewSet(Set<T> set)
    {
        return Tools.isEmpty(set) ? new HashSet<T>() : set;
    }
    
    /**
     * 获取HashSet
     * @return
     */
    public static <T> Set<T> newHashSet()
    {
        return new HashSet<T>();
    }
    
    /**
     * 获取HashSet
     * @return
     */
    public static <T> Set<T> newHashSet(Collection<T> t)
    {
        return new HashSet<T>(t);
    }
    
    /**
     * 是否获取新ArrayList
     * @param list
     * @return
     */
    public static <T> List<T> isGetNewList(List<T> list)
    {
        return Tools.isEmpty(list) ? new ArrayList<T>() : list;
    }
    
    /**
     * 获取ArrayList
     * @return
     */
    public static <T> List<T> newArrayList()
    {
        return new ArrayList<T>();
    }
    
    /**
     * 获取ArrayList
     * @return
     */
    public static <T> List<T> newArrayList(Collection<T> t)
    {
        return new ArrayList<T>(t);
    }
    
    /**
     * 获取LinkedHashMap
     * @return
     */
    public static <K,V> Map<K,V> newLinkedHashMap()
    {
        return new LinkedHashMap<K,V>();
    }
    
    /**
     * 获取list大小
     * @param list
     * @return
     */
    public static <T> Integer getListSize(List<T> list)
    {
        return Tools.isEmpty(list) ? 0 : list.size();
    }
    
    /**
     * 获取set大小
     * @param set
     * @return
     */
    public static <T> Integer getSetSize(Set<T> set)
    {
        return Tools.isEmpty(set) ? 0 : set.size();
    }
    
    /**
     * 获取map大小
     * @param map
     * @return
     */
    public static <K, V> Integer getMapSize(Map<K, V> map)
    {
        return Tools.isEmpty(map) ? 0 : map.size();
    }
    
    /**
     * 转化Long型空值 null为 0L
     * @param value
     * @return
     */
    public static Long transLongNullValue(Long value)
    {
        return isEmpty(value) ? 0L : value;
    }
    
    /**
     * 转化Double型空值 null为 0D
     * @param value
     * @return
     */
    public static Double transDoubleNullValue(Double value)
    {
        return isEmpty(value) ? 0D : value;
    }
    
    /**
     * 转化Integer型空值 null为 0
     * @param value
     * @return
     */
    public static Integer transIntegerNullValue(Integer value)
    {
        return isEmpty(value) ? 0 : value;
    }
    
}