<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	request.getSession().setAttribute("base", request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	// 	response.setHeader("X-Frame-Options", "ALLOW-FROM");
%>

<title>Free Life</title>
<link rel="stylesheet" type="text/css" href="${base}static/ui/easyui1.5/themes/metro/easyui.css">
<link rel="stylesheet" type="text/css" href="${base}static/ui/easyui1.5/themes/mobile.css">
<link rel="stylesheet" type="text/css" href="${base}static/ui/easyui1.5/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${base}static/ui/easyui1.5/themes/color.css">  
<script type="text/javascript" src="${base}static/ui/easyui1.5/jquery.min.js"></script>
<script type="text/javascript" src="${base}static/ui/easyui1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${base}static/ui/easyui1.5/jquery.easyui.mobile.js"></script>
