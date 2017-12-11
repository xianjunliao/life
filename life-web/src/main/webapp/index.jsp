
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	request.getSession().setAttribute("base",
			request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>My life</title>
<%-- 	<link rel="shortcut icon" href="${base}favicon.ico" /> --%>
<link href="${base}static/ui/insdep/themes/insdep/easyui.css" rel="stylesheet" type="text/css">
<link href="${base}static/ui/insdep/themes/insdep/insdep_theme_default.css" rel="stylesheet" type="text/css">
<link href="${base}static/ui/insdep/themes/insdep/icon.css" rel="stylesheet" type="text/css">
<link href="${base}static/ui/insdep/plugin/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${base}static/ui/insdep/jquery.min.js"></script>
<script type="text/javascript" src="${base}static/ui/insdep/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${base}static/ui/insdep/themes/insdep/jquery.insdep-extend.min.js"></script>
<script type="text/javascript" src="${base}static/js/common-utils.js"></script>
<style>
</style>
<script type="text/javascript">
	$(function() {
		$('#entrance').keydown(function(e) {
			if (e.keyCode == 13) {
				alert("code");
			}
		});
	});
</script>
</head>
<body>
	<div id="entrance" class="easyui-dialog" title="" data-options="iconCls:'icon-save',closable: true,border:false " style="width: 370px; height: 45px; padding: 5px">
		<input class="easyui-textbox" data-options="prompt:'Please enter your code...'" style="width: 358px; height: 34px">
	</div>
</body>
</html>
