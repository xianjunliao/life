
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
		$('#main').hide();
		$('#code').textbox().next('span').find('input').focus()
		$('#entrance').keydown(
				function(e) {
					if (e.keyCode == 13) {
						var v = $('#code').val();
						$.ajax({
							//提交数据的类型 POST GET
							type : "POST",
							//提交的网址
							url : "${base}/entrance/enterCode",
							//提交的数据
							data : {
								code : v
							},
							//返回数据的格式
							datatype : "json",//"xml", "html", "script", "json", "jsonp", "text".
							success : function(data) {
								if (data != null&&data != "") {
									result = $.parseJSON(data);
									welcomeTo(result.userMotto);
									playMp3(result.userMusic);
								} else {
									showMsg("Your code is wrong !");
									$('#code').textbox().next('span').find(
											'input').select();
								}
							},
							//调用出错执行的函数
							error : function() {
								//请求出错处理
							}
						});
					}
				});
	});

	function showMsg(msg) {

		$.messager.show({
			msg : msg,
			showType : 'show',
			style : {
				width : 150,
				height : 35,
				left : '',
				right : 0,
				top : '',
				bottom : -document.body.scrollTop
						- document.documentElement.scrollTop
			}
		});
	}

	function welcomeTo(m) {
		var t = 1500;
		var d = [];
		for (i = 0; i < m.length; i++) {
			if (i == 0) {
				d.push('<br />')
				d.push('&nbsp;&nbsp;&nbsp;&nbsp;')
			}
			// 			if (m.charAt(i-1)==',') {
			// 				d.push('<br />')
			// 				d.push('&nbsp;&nbsp;&nbsp;&nbsp;')
			// 			}
			if (m.charAt(i - 1) == '.'||m.charAt(i - 1) == '?'||m.charAt(i - 1) == '!') {
				d.push('<br />')
				d.push('<br />')
				d.push('&nbsp;&nbsp;&nbsp;&nbsp;')
			}
			d.push(m.charAt(i))
		}
		var arr = new Array();
		for (j = 0; j < d.length; j++) {
			arr.push(d[j]);
			setTimeout("enterCode('" + arr.join("") + "')", t);
			t += 100;
		}
	}

	function enterCode(code) {
		$('#entrance').dialog('close');
		$('#main').show();
		$('#times').html(code);
	}
	
	function playMp3(songName){
		$('#music').append('<audio style="height: 30px;" id="audio" src="${base}/music/'+songName+'"></audio>');	
		var myAuto = document.getElementById('audio');
		myAuto.controls=true;
		myAuto.play();
	}
</script>
</head>
<body style="margin: 0px;">
	<div id="entrance" class="easyui-dialog" title="" data-options="iconCls:'icon-save',closable: true,border:false " style="width: 370px; height: 45px; padding: 5px">
		<input class="easyui-textbox" id="code" data-options="prompt:'Please enter your code...'" style="width: 358px; height: 34px">
	</div>
	<!-- 	<div style="margin: 5px;"></div> -->
	<div id="main" class="easyui-layout" style="width: 100%; height: 100%;">
		<div data-options="region:'north',border:false" style="width: 100%;height: 50px"></div>
		<div data-options="region:'south',split:false,border:false" style="width: 100%;height: 30px;overflow: hidden;">
		 <div id="music" style="float:right;"></div>
		</div>
		<div data-options="region:'west',split:false,border:false" style="width: 200px;"></div>
		<div data-options="region:'center',title:'',iconCls:'icon-ok',border:false">
			<div>
				<table style="width: 100%; height: 100%;">
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><span id="times"></span></td>
					</tr>
					<tr>
						<td></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
