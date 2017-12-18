<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.life.util.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	response.setHeader("X-Frame-Options", "ALLOW-FROM");
	String xml = "https://www.zhihu.com/rss";
	String json = RSSUtil.xmlToJson(xml);
	out.println(json);
	// 	System.out.println(json);
%>