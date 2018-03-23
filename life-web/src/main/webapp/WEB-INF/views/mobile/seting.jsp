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

body {
	font-family: "STKaiti";
	width: 100%;
	height: 100%;
	background: url("${base}static/mobile/images/20180321_110947_3856.jpg")
		no-repeat;
	background-size: 100%;
}

.list-ul {
	padding: 0px;
	margin: 0px;
	background-color: white;
	border: 1px #white solid !important;
	box-shadow: 1px 1px 20px #333333;
	-moz-box-shadow: 2px 2px 20px #333333;
	-webkit-box-shadow: 2px 2px 20px #333333;
	background-color: white;
	background-color: white
}
</style>
</head>
<body>
	<div class="easyui-navpanel" style="background-color: #f2f6f9; opacity: 0.9; box-shadow: 1px 1px 1px #333333;">
		<header>
			<div class="m-toolbar">
				<span class="m-title">设置</span>
				<div class="m-left">
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick=" back()">返回</a>
				</div>
			</div>
		</header>
		<div style="background-color: #f2f6f9; height: auto; padding-top: 15px;">
			<ul class="m-list list-ul" style="margin-top: 20px;">
				<li><a href="javascript:void(0)" onclick="$.mobile.go('#day-words');">每日词汇</a></li>
				<li><a href="javascript:void(0)" onclick="$.mobile.go('#remember-words');">单词速记</a></li>
				<li><a href="javascript:void(0)" onclick="$.mobile.go('#sentence-reading');">句子常读</a></li>
				<li><a href="javascript:void(0)" onclick="$.mobile.go('#article-reading');">美文欣赏</a></li>
			</ul>
			<ul class="m-list list-ul" style="margin-top: 120px;">
				<li><a href="javascript:void(0)" onclick="$.mobile.go('#for-money');">精打细算</a></li>
				<li><a href="javascript:void(0)" onclick="$.mobile.go('#memos');">备忘录</a></li>
			</ul>
		</div>
	</div>
	
	<div id="day-words" class="easyui-navpanel" style="opacity: 0.8;">
		<header>
			<div class="m-toolbar">
				<span id="day-words-title" class="m-title">每日词汇设置</span>
				<div class="m-left">
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick="$.mobile.back();">返回</a>
				</div>
			</div>
		</header>
		<div style="margin: 50px 0 0; text-align: center">
			<span>每日词汇</span>
		</div>
	</div>
	<div id="remember-words" class="easyui-navpanel" style="opacity: 0.8;">
		<header>
			<div class="m-toolbar">
				<span id="remember-words-title" class="m-title">单词速记设置</span>
				<div class="m-left">
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick="$.mobile.back();">返回</a>
				</div>
			</div>
		</header>
		<div style="margin: 50px 0 0; text-align: center">
			<span>单词速记</span>
		</div>
	</div>
	<div id="sentence-reading" class="easyui-navpanel" style="opacity: 0.8;">
		<header>
			<div class="m-toolbar">
				<span id="sentence-reading-title" class="m-title">句子常读设置</span>
				<div class="m-left">
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick="$.mobile.back();">返回</a>
				</div>
			</div>
		</header>
		<div style="margin: 50px 0 0; text-align: center">
			<span>句子常读</span>
		</div>
	</div>
	<div id="article-reading" class="easyui-navpanel" style="opacity: 0.8;">
		<header>
			<div class="m-toolbar">
				<span id="article-reading-title" class="m-title">美文欣赏设置</span>
				<div class="m-left">
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick="$.mobile.back();">返回</a>
				</div>
			</div>
		</header>
		<div style="margin: 50px 0 0; text-align: center">
			<span>美文欣赏</span>
		</div>
	</div>
	<div id="for-money" class="easyui-navpanel" style="opacity: 0.8;">
		<header>
			<div class="m-toolbar">
				<span id="for-money-title" class="m-title">精打细算设置</span>
				<div class="m-left">
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick="$.mobile.back();">返回</a>
				</div>
			</div>
		</header>
		<div style="margin: 50px 0 0; text-align: center">
			<span>精打细算</span>
		</div>
	</div>
	<div id="memos" class="easyui-navpanel" style="opacity: 0.8;">
		<header>
			<div class="m-toolbar">
				<span id="memos-title" class="m-title">备忘录设置</span>
				<div class="m-left">
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick="$.mobile.back();">返回</a>
				</div>
			</div>
		</header>
		<div style="margin: 50px 0 0; text-align: center">
			<span>备忘录</span>
		</div>
	</div>
</body>
</html>
