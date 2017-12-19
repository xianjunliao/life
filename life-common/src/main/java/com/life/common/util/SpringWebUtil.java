package com.life.common.util;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.request.ServletWebRequest;

/**
 * web工具类 <br/>
 * 提供web环境下获取HttpServletRequest、HttpServletResponse、getServletContext、HttpSession等功能；可以在非controller层使用
 * @author xiangxin.zou
 * @since JDK1.8
 * @version 1.0
 * 2017年9月10日
 */
public class SpringWebUtil {
	/**
	 * 获取HttpServletRequest
	 * @return
	 */
	public static HttpServletRequest getRequest() {
		return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	}
	
	/**
	 * 获取HttpServletResponse
	 * @return
	 */
	public static HttpServletResponse getResponse() {
		return ((ServletWebRequest) RequestContextHolder.getRequestAttributes()).getResponse();
	}
	
	/**
	 * 获取ServletContext
	 * @return
	 */
	public static ServletContext getServletContext(){
		return ContextLoader.getCurrentWebApplicationContext().getServletContext();
	}
	
	/**
	 * 获取HttpSession
	 * @return
	 */
	public static HttpSession getSession(){
        return getRequest().getSession();
    }
}
