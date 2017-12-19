package com.life.common.file;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import javax.imageio.ImageIO; 

public class Upload {
	/**
	 * 获取文件扩展名
	 * 
	 * @return string
	 */
	public static String getFileExt(String fileName) {
		return fileName.substring(fileName.lastIndexOf("."));
	}
	/**
	 * 依据原始文件名生成新文件名
	 * @return
	 */
	public static String getName(String fileName) {
		Random random = new Random();
		return fileName = "" + random.nextInt(10000)
				+ System.currentTimeMillis() + getFileExt(fileName);
	}
	
	/**
	 * 只获取名字
	 * @return
	 */
	public static String getSingleName() {
		Random random = new Random();
		return  "" + random.nextInt(10000)+ System.currentTimeMillis();
	}
	/**
	 * 获取图片宽高值
	 */
	public static Map<String, Long> getImageHW(File imgfile){
		   Map<String, Long> map = new HashMap<String, Long>(3); 
	       long width=0;
	       long height=0;
	       try { 
	               FileInputStream fis = new FileInputStream(imgfile); 
	               BufferedImage buff = ImageIO.read(imgfile); 
	             width =  (buff.getWidth() * 1L);
	             height =   (buff.getHeight() * 1L);
	               fis.close(); 
	       } catch (FileNotFoundException e) { 
	               System.err.println("所给的图片文件" + imgfile.getPath() + "不存在！计算图片尺寸大小信息失败！"); 
	               map = null; 
	       } catch (IOException e) { 
	               System.err.println("计算图片" + imgfile.getPath() + "尺寸大小信息失败！"); 
	               map = null; 
	       } 
		float bili1 = width/314f;
		float bili2 = height/144f;
		float min=bili1>bili2?bili2:bili1;
		  long nw= (long) (width/min);
		  long nh =(long) (height/min);
		  map.put("newwidth", nw);
		  map.put("newheight", nh);
		  map.put("width", width);
		  map.put("height", height);
		  
		  
		  return map;

	}
	
}
