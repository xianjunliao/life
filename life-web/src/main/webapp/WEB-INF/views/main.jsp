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
	border-radius:2px;
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
	var isOpen = 1;
	function modelClick() {
		if (isOpen == 1) {
			isOpen = 2;
			$("#modelList").css("display", "block");
			$("#modelList").css("left", 229);
			$("#modelList").css("top", 48);
			$("#modelList").css("position", "absolute");

		} else {
			isOpen = 1;
			$("#modelList").css("display", "none");
		}
	}
	function modelLeave() {
		isOpen = 1;
		$("#modelList").css("display", "none");
	}
	function modelLi(li) {
		$(li).addClass("li_backbround");
	}
	function modelLiMouseout(li) {
		$(li).removeClass("li_backbround");
	}
	function openWeb(url) {
		modelLeave();
		$("#openWeb").html('<iframe src="' + url + '" width="100%" height="90%"></iframe>');
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
</script>
</head>
<body>
	<div onmousedown="modelLeave()" style="height: 100%; background-color: #CCC; overflow: hidden;">
		<div class="layui-row" style="background-color: #393D49;background-image:url('${base }static/images/1517542171_397616.png'); z-index: 1; width: 100%">
			<div class="layui-col-xs12 layui-col-md2">
				<div style="width: 100px;">&nbsp;</div>
			</div>
			<div class="layui-col-xs12 layui-col-md2">
				<div style="border-color: red; width: 200px; height: 30px; z-index: 2; margin-top: 15px;">
					<input id="modelText" class="layui-input" type="text" placeholder="搜索组件或模块" onclick="modelClick()" />
				</div>
			</div>
			<div class="layui-col-xs6 layui-col-md8">
				<ul class="layui-nav" lay-filter="demo">
					<li class="layui-nav-item layui-this" onclick="openWeb('${base}house')"><a>网站导航</a></li>
					<li class="layui-nav-item"><a>我的学习</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;">英语</a>
							</dd>
							<dd>
								<a href="javascript:;">编程</a>
							</dd>
							<dd>
								<a href="javascript:;">吉他</a>
							</dd>
						</dl></li>
					<li class="layui-nav-item" onclick="openWeb('${base}file/upLoad')"><a>我的文件</a></li>
					<li class="layui-nav-item" onclick="openWeb('${base}file/upLoad')"><a>我的账本</a></li>
					<li class="layui-nav-item" onclick="openWeb('${base}file/upLoad')"><a>我的大事件</a></li>
					<li class="layui-nav-item" onclick="openWeb('${base}/homePage')"><a>我的备忘录<span class="layui-badge">0</span></a></li>
					<li class="layui-nav-item"><a href="">个人中心<span class="layui-badge-dot"></span></a></li>
					<li class="layui-nav-item" lay-unselect=""><a href="javascript:;"><img <c:if test="${userInfo.headaddress==null}"> src="${base}/static/images/default_head.png"</c:if> <c:if test="${userInfo.headaddress!=null}"> src="${userInfo.headaddress}"</c:if> class="layui-nav-img">${userInfo.username}</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;">修改信息</a>
							</dd>
							<dd>
								<a href="javascript:;">安全管理</a>
							</dd>
							<dd>
								<a onclick="exit()">退了</a>
							</dd>
						</dl></li>
				</ul>
			</div>
		</div>
		<div style="width: 100%; height: auto;" id="openWeb">
			<iframe src="${base}house" width="100%" height="90%"></iframe>
		</div>
	</div>
	<div id="modelList">
		<div>
			<ul style="position: absolute; max-height: 200px; color: black; font-style: inherit;">
				<c:forEach items="${trees}" var="tree">
					<li class="model_li" onclick="openWeb('${tree.url}')" onmouseover="modelLi(this)" onmouseout="modelLiMouseout(this)"><a>${tree.text}</a></li>
				</c:forEach>
			</ul>
		</div>

	</div>
	<script type="text/javascript" src="${base}static/ui/layui/layui.all.js"></script>
	<script>
		layui.use('element', function() {
			var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块

			//监听导航点击
			element.on('nav(demo)', function(elem) {
				console.log(elem);
			});
		});
	</script>
</body>
</html>
