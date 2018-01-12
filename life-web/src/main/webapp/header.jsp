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
<title>Do Not Go Gentle Into That Good Night.</title>
<link rel="shortcut icon" href="${base}/static/images/life-1.png" />
<link href="${base}static/ui/insdep/themes/insdep/easyui.css" rel="stylesheet" type="text/css">
<link href="${base}static/ui/insdep/themes/insdep/insdep_theme_default.css" rel="stylesheet" type="text/css">
<link href="${base}static/ui/insdep/themes/insdep/icon.css" rel="stylesheet" type="text/css">
<link href="${base}static/ui/insdep/plugin/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
document.oncontextmenu = function(){
	　　return false;
}
</script>
<script type="text/javascript" src="${base}static/ui/insdep/jquery.min.js"></script>
<script type="text/javascript" src="${base}static/ui/insdep/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${base}static/ui/insdep/themes/insdep/jquery.insdep-extend.min.js"></script>
<script type="text/javascript" src="${base}static/js/common-utils.js"></script>