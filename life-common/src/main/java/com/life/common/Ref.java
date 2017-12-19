package com.life.common;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

public class Ref {
	public static void setStr(Class<?> objclass, Object obj, String function, String value) throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		if(value == null){
			return;
		}
		Method func = objclass.getMethod(function, String.class);
		if(func != null){
			func.invoke(obj, value);
		}
	}
	
	public static String getStr(Class<?> objclass, Object obj, String function)
			throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		Method func = objclass.getMethod(function);  		
		if(func != null){
			return (String)func.invoke(obj);				
		}
		return null;
	}
	
	public static void setInt(Class<?> objclass, Object obj, String function, Integer value) throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		if(value == null){
			return;
		}
		
		Method func = objclass.getMethod(function, Integer.class);
		if(func != null){
			func.invoke(obj, value);
		}
	}
	
	public static Integer getInt(Class<?> objclass, Object obj, String function)
			throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		Method func = objclass.getMethod(function);  		
		if(func != null){
			return (Integer)func.invoke(obj);			
		}
		return null;
	}
	
	public static void setLong(Class<?> objclass, Object obj, String function, Long value) throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		if(value == null){
			return;
		}
		Method func = objclass.getMethod(function, Long.class);
		if(func != null){
			func.invoke(obj, value);
		}
	}
	
	public static Long getLong(Class<?> objclass, Object obj, String function)
			throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		Method func = objclass.getMethod(function);  		
		if(func != null){
			return (Long)func.invoke(obj);			
		}
		return null;
	} 
	
	public static void setFloat(Class<?> objclass, Object obj,  String function, Float value) throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		if(value == null){
			return;
		}
		Method func = objclass.getMethod(function, Float.class);
		if(func != null){
			func.invoke(obj, value);
		}
	}
	
	public static Float getFloat(Class<?> objclass, Object obj, String function)
			throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		Method func = objclass.getMethod(function);  		
		if(func != null){
			return (Float)func.invoke(obj);			
		}
		return null;
	}
	
	public static String StringFilter(String str) throws PatternSyntaxException { 
		// 只允许字母和数字 // String regEx ="[^a-zA-Z0-9]"; 
		// 清除掉所有特殊字符 
		String regEx="[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]"; 
		Pattern p = Pattern.compile(regEx); 
		Matcher m = p.matcher(str);
		return m.replaceAll("").trim();
	} 
}
