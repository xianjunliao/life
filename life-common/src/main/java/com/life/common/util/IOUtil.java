package com.life.common.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

public class IOUtil {
	public static String allcloseSwitchPath = "/usr/local/apache-tomcat-7.0.72/webflie/closeSwitch";
	public static int readallCloseSwitch(){
		int flag = 0;
		File file = null;
		FileReader fr = null;
		BufferedReader br = null;
		try{
			file = new File(allcloseSwitchPath);
			if(file.exists()){
			fr = new FileReader(file);
			br = new BufferedReader(fr);
			String line = br.readLine();
			if(line != null && isNumeric(line))				
				flag = Integer.parseInt(line);		
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			file = null;
			fr = null;
			br = null;
		}		
		
		return flag;
	}
	public static boolean isNumeric(String str) {
		if(isNull(str))
			return false;
		if (str.matches("^[0-9]*$")) {
			return true;
		}
		if(str.matches("^\\d+\\.\\d+$"))
			return true;
		return false;
	}
	public static boolean isNull(String str){
		if(str == null)
			return true;
		if("".equals(str.trim()))
			return true;
		if("null".equalsIgnoreCase(str))
			return true;
		
		return false;
	}
}
