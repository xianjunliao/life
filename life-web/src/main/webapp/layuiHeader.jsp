<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	request.getSession().setAttribute("base",
			request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	// 	response.setHeader("X-Frame-Options", "ALLOW-FROM");
%>
<title>Free Life</title>
<link rel="shortcut icon" href="${base}/static/images/lifehead.png" />
<link href="${base}static/ui/layui/css/layui.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${base}static/ui/insdep/jquery.min.js"></script>
<script type="text/javascript" src="${base}static/ui/layui/layui.js"></script>
