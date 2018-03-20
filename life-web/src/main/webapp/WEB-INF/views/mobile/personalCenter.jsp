<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../mobileHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script type="text/javascript">
	function back() {
		window.location.replace("${base}learn/mob?idx=3");
	}
</script>
<style>
.hh-inner {
	position: relative;
	line-height: 20px;
	background: #fff;
	font-weight: bold;
	margin: -5px;
	padding: 5px;
}
</style>
</head>
<body>
<div class="easyui-navpanel">
		<header>
			<div class="m-toolbar">
				<span class="m-title">个人中心</span>
			</div>
			<div class="m-left">
				<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick=" back()">返回</a>
			</div>
		</header>
		<ul class="m-list">
			<li>Large</li>
			<li>Spotted Adult Female</li>
			<li>Venomless</li>
			<li>Rattleless</li>
			<li>Green Adult</li>
			<li>Tailless</li>
			<li>With tail</li>
			<li><a href="#" class="easyui-linkbutton c5" style="width:100%">退出登陆</a></li>
		</ul>
	</div>
</body>
</html>
