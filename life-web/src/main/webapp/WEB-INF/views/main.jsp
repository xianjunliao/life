<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../layuiHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<style>
body {
	margin: 0px;
	padding: 0;
}

.layui-input {
	height: 30px;
	padding-left: 12px;
	background-color: rgba(255, 255, 255, 0.0470588);
	color: rgb(255, 255, 255);
	font-size: 12px;
	border-width: 0px;
	border-style: none;
	border-color: initial;
	border-image: initial;
	cursor: pointer;
}

#modelList {
	width: 200px;
	height: 200px;
	max-height: 200px;
	display: none;
	z-index: 3;
	background-color: white;
	opacity: 0.5;
	overflow: auto;
	max-height: 200px;
	display: none;
	z-index: 3;
	background-color: white;
	opacity: 0.8;
	border-radius: 2px;
}

.model_li {
	margin-top: 5px;
	margin-left: 5px;
	width: 190px;
	height: 30px;
}

.model_li a {
	color: black;
	font-style: normal;
	font-family: serif;
	line-height: 30px;
	margin-left: 10px;
}

.li_backbround {
	background-color: #f2f2f2;
}
</style>
<script type="text/javascript">
	function openWeb(url) {

		$("#openWeb").html('<iframe frameborder="0" src="' + url + '" width="100%" height="100%"></iframe>');
	}
	function autoGetCount() {

		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}memos/getCount',
			success : function(result) {
				$(".layui-badge").text(result);
			}
		});
	}
	function exit() {

		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}exit',
			success : function(result) {
				self.location.href = '${base }login';
			}
		});
	}
	function initPage() {
		$("#openWeb").html('<iframe frameborder="0" src="${base}tree/getAllUri" width="100%" height="100%"></iframe>');
		$("#fristOpen").addClass("layui-this");
	}
	$(function() {
		autoGetCount();
		setInterval("autoGetCount()", 30000);
		initPage();
	});
</script>
</head>
<body>
	<div style="height: 100%; background-color: #ffffff; overflow: hidden;">
		<div class="layui-row" style="width: 100%; background-color: #393d49;">
			<div class="layui-col-xs12 layui-col-md2">
				<div style="background-image:url('${base }static/images/1517542171_397616.png'); z-index: 999;height:60px;cursor: pointer;"></div>
			</div>
			<div class="layui-col-xs6 layui-col-md8">
				<ul class="layui-nav" lay-filter="demo">
					<li class="layui-nav-item" id="fristOpen" onclick="openWeb('${base}tree/getAllUri')"><a>网站导航</a></li>
					<li class="layui-nav-item" onclick="openWeb('${base}learn/ENG_chooce')"><a>每日英语</a></li>
					<li class="layui-nav-item" onclick="openWeb('${base}finance/main')"><a>精达细算</a></li>
					<li class="layui-nav-item" onclick="openWeb('${base}file/upLoad')"><a>自由云</a></li>
					<li class="layui-nav-item" onclick="openWeb('${base}/memos')"><a>备忘录<span class="layui-badge">0</span></a></li>
					<li class="layui-nav-item" onclick="openWeb('${base}learn/IT_index')"><a>编程技能要点</a></li>
					<li class="layui-nav-item" onclick="openWeb('${base}music/music_stand')"><a>乐谱谱架</a></li>
				</ul>
			</div>
			<div class="layui-col-xs12 layui-col-md2 layui-bg-black">
				<ul class="layui-nav" lay-filter="demo1" style="margin-left: 25px;">
					<li class="layui-nav-item" lay-unselect=""><a href="javascript:;"><img <c:if test="${userInfo.headaddress==null}"> src="${base}/static/images/default_head.png"</c:if> <c:if test="${userInfo.headaddress!=null}"> src="${userInfo.headaddress}"</c:if> class="layui-nav-img"> <c:if test="${userInfo.username!=null}">${userInfo.username}</c:if> <c:if test="${userInfo.username==null}">我</c:if>
							<c:if test="${userInfo.username==''}">我</c:if> </a>
						<dl class="layui-nav-child">
							<!-- 							<dd> -->
							<!-- 								<a href="javascript:;">个人中心<span class="layui-badge-dot"></span></a> -->
							<!-- 							</dd> -->
							<dd>
								<a onclick="openWeb('${base}update')">完善个人信息</a>
							</dd>
							<dd>
								<a onclick="openWeb('${base}updateHeadImg')">更换头像</a>
							</dd>
							<!-- 							<dd> -->
							<!-- 								<a href="javascript:;">修改密码</a> -->
							<!-- 							</dd> -->
							<dd>
								<a onclick="exit()">注销登录</a>
							</dd>
						</dl></li>
				</ul>
			</div>
		</div>
		<div style="width: 100%; height: 95%;" id="openWeb"></div>

	</div>
	<script type="text/javascript" src="${base}static/ui/layui/layui.all.js"></script>
	<script>
		layui.use('element', function() {
			var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块

			//监听导航点击
			element.on('nav(demo)', function(elem) {
			});
		});
	</script>
</body>
</html>
