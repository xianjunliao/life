package com.life.util;

import java.io.UnsupportedEncodingException;

import org.apache.commons.lang.StringEscapeUtils;

import com.sun.xml.internal.fastinfoset.Encoder;

public class Str {
   public static boolean isEmpty(String str){
	   return (str == null) || ("".equals(str.trim()));
   }
   
   public static String removeFourChar(String content) {
       byte[] conbyte = content.getBytes();
       for (int i = 0; i < conbyte.length; i++) {
           if ((conbyte[i] & 0xF8) == 0xF0) {
               for (int j = 0; j < 4; j++) {                          
                   conbyte[i+j]=0x30;                     
               }  
               i += 3;
           }
       }
       content = new String(conbyte);
       return content.replaceAll("0000", "");
   }
   
	public static String changeStr(String cname){		
		//cname = removeFourChar(cname);
		/* 
		byte[] err = new byte[]{-50, -80, 63};	
		if(cname.equals(new String(err))){
			cname = "系统未知";
		}
		
		byte[] in = cname.getBytes();
		char[] ch = cname.toCharArray();
		for(int i = 0; i <in.length; i++){
			if(i > err.length){
				continue;
			}else{
				continue;
			}			
		 
		}
	 
		
		if(cname.contains("\\x")){ // '\xF0\xA1\x98\x8A' 
			cname = StringEscapeUtils.unescapeJava(cname.replace("\\x", "\\u00")); 
		} 
		
		if(cname.contains("\\")){
			cname = cname.replace("\\", ""); 
		}
		else if(cname.contains("F0") && cname.contains("A1") && cname.contains("98") && cname.contains("8A")){
			cname = "FA98";
		} 
		*/
		
		return cname;
	}
	
	
	public static void main(String[] args) {
		/*
		try {
			//System.out.print(getDataToMiwen());
			byte[] s = new byte[]{(byte) 0xF0, (byte) 0xA1, (byte) 0x98, (byte) 0x8A};
			System.out.println( new String( new String(s).getBytes("UTF-8") ) );
			
			System.out.println(changeStr("\\xF0\\xA1\\x98\\x8A"));
			
		 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		for(int i = 0; i < 100; i++){
			try{
				
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		*/
		
		/*
		String v1 = new String("abc");
		String v2 = new String("abc");		
		if(v1 == v2){
			System.out.println("true");
		}else{
			System.out.println("false");
		}
		*/
		
		String v1 ="abc";	
		String v2 = v1; //"abc";		
		if(v1 == v2){
			System.out.println("true");
		}else{
			System.out.println("false");
		}
	}
}
