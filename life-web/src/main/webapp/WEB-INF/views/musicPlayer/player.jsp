<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">TF-8">
<style type="text/css">
html,body{overflow:hidden;margin: 0px;}
#north-1 {
	/* 	background-color: aqua; */
	width: 12%;
	height: 99%;
	border: none;
	float: left;
	margin-right: 10px; 
	background-image: url(${base}static/interstellar_imgs/xjcy1.jpg);
	background-repeat: no-repeat;
}

#north-2 {
	/* 	background-color: blue; */
	width: 85%;
	height: 99%;
	border: none;
	float: left;
}

#north-3 {
	/* 	background-color: gray; */
	width: 100%;
	height: 45%;
	text-align:left;
	line-height:30px;
	border: none;
}

#north-4 {
	/* 	background-color: lime; */
	width: 100%;
	height: 30%;
	border: none;
}

.bar, .bar .played {
	position: relative;
	left: 0;
	top: 0;
	height: 2px;
	background: #cdcdcd;
}

.bar .played, .bar .thumb {
	position: absolute;
	left: 0;
	top: 0;
}

.bar .played {
	background: #e12828;
}

.bar .thumb {
	right: -4px;
	left: auto;
	top: -3px;
	width: 8px;
	height: 8px;
	background-position: -92px -14px;
	cursor: pointer;
}

.ctrlBox {
	float: right;
	width: 200px;
	padding: 10px 10px 0 0;
	position: relative;
}

.bg {
	background: url(${base}static/images/audio_sprite.png) no-repeat 0
		9999px;
}

.prev, .next {
	width: 9px;
	height: 10px;
	cursor: pointer;
}

.prev {
	background-position: -33px 0;
}

.prev:hover {
	background-position: -33px -28px;
}

.next {
	background-position: -58px 0;
}

.next:hover {
	background-position: -58px -28px;
}

.play, .pause {
	width: 14px;
	height: 18px;
	cursor: pointer;
}

.play {
	background-position: 0 0;
}

.play:hover {
	background-position: 0 -31px;
}

.pause {
	background-position: -36px -63px;
}

.pause:hover {
	background-position: -66px -63px;
}

.play-sm, .pause-sm {
	width: 10px;
	height: 14px;
	cursor: pointer;
}

.play-sm {
	background-position: 0 -98px;
}

.play-sm:hover {
	background-position: 0 -188px;
}

.pause-sm {
	background-position: -30px -98px;
}

.play-bg {
	width: 32px;
	height: 32px;
	background-position: -68px -118px;
	cursor: pointer;
}

.play-bg:hover {
	background-position: -68px -167px;
}

.pause-bg {
	width: 20px;
	height: 20px;
	background-position: 0 -60px;
	cursor: pointer;
}

.pause-bg:hover {
	background-position: 0 -157px;
}

.oprBox {
	position: relative;
	height: 20px;
	margin-top: 10px;
	line-height: 20px;
}

.oprBox .time {
	position: absolute;
	left: 0;
	font-size: 11px;
	color: #999;
}

.oprBox .btnGroup {
	position: relative;
	margin: 0 auto;
	width: 72px;
}

.oprBox .btnGroup .prev, .oprBox .btnGroup .next {
	position: absolute;
	top: 4px;
}

.oprBox .btnGroup .prev {
	left: 0;
}

.oprBox .btnGroup .next {
	right: 0;
}

.oprBox .btnGroup .mid {
	margin: 0 auto;
}

.oprBox .open {
	position: absolute;
	right: 0;
	top: 4px;
	width: 13px;
	height: 10px;
	background-position: -58px -14px;
	cursor: pointer;
	opacity: 0.8;
	filter: alpha(opacity = 80);
}

.oprBox .open:hover {
	opacity: 1;
	filter: alpha(opacity = 100);
}

.oprBox .open.z-dis {
	opacity: 0.3;
	filter: alpha(opacity = 30);
	cursor: default;
}

.list {
	border-top: 0px solid #e6e6e6;
}

div.list.z-close {
	height: 0 !important;
	overflow: hidden;
	display: none;
}

.list ul {
	height: 100%;
	overflow: hidden;
	position: relative;
}

.list .box {
	position: relative;
}

.list .box .track {
	position: absolute;
	right: 0;
	top: 0;
	width: 7px;
}

.list .box .scroll {
	position: absolute;
	top: 0;
	right: 0;
	width: 7px;
	height: 114px;
	background: #dadada;
	border-radius: 3px;
	z-index: 9999;
}

.list li {
	height: 30px;
	position: relative;
	line-height: 30px;
	padding-right: 18px;
	float: left;
}

.list li.odd {
	background: #f7f7f7;
}

.list li.z-sel {
	background: #e9e9e9;
}

.list li .cur {
	width: 3px;
	height: 22px;
	position: absolute;
	left: 0;
	top: 4px;
	display: none;
	background: #df2d2d;
}

.list li.z-sel .cur {
	display: block;
}

.list .index, .list .name {
	float: left;
}

.list .index {
	width: 40px;
	text-align: center;
	color: #999;
	color: #999;
}

.list .by {
	float: right;
	color: #666;
	text-align: right;
}

.list .foot {
	line-height: 40px;
	padding: 0 10px;
	background: #f1f1f1;
	cursor: pointer;
	padding: 0 10px;
	background: #f1f1f1;
	cursor: pointer;
}

.list .logo {
	float: left;
	margin-top: 11px;
}

.list .yyy {
	float: left;
	margin-left: 10px;
	font-size: 14px;
}

.list .slogan {
	float: right;
	color: #999;
}

#cc {
 	margin: 10px; 
	box-shadow: 0 0 10px #ccc;
	background: #fff;
	width: 25%;
	height: 99%;
}
</style>
</head>
<body>
		<div id="cc" class="easyui-layout">
			<div data-options="region:'north',split:false,border:false" style="height: 5%;">
				<div id="north-1"></div>
				<div id="north-2">
					<div id="north-3">11111</div>
					<div id="north-4">
						<div id="bar" class="bar">
							<div class="played j-flag" style="width: 0%;">
								<span class="bg thumb j-flag" id="auto-id-52M4wUAgJdPaDsun"></span>
							</div>
						</div>
						<div class="oprBox">
							<div id="time" class="time">- 0:00</div>
							<div class="btnGroup f-cb">
								<div id="prev" class="bg prev" data-action="prev"></div>
								<!-- 							<div id="pause" class="bg mid pause f-hide" data-action="pause"></div> -->
								<div id="play" class="bg mid play" data-action="play"></div>
								<div id="next" class="bg next" data-action="next"></div>
							</div>
							<div class="bg open " data-action="open"></div>
						</div>
					</div>
				</div>
			</div>
			<div data-options="region:'center',border:false" >
				<div id="list" class="list" style="height: 100%">
					<div class="box" style="height: 96.2%;">
						<ul class="f-cb" id="list-box">
							<li class="f-cb odd" data-action="playByIndex" data-index="0" style="width: 99%;">
								<div class="cur"></div>
								<div class="index">1</div>
								<div class="name f-thide" title="Зая" style="width: 63%;">Зая</div>
								<div class="by f-thide" style="width: 25%;">Бамбинтон</div>
								<div style="width: 40px; float: right;"></div>
							</li>
						</ul>
						<div class="track j-flag" id="auto-id-x1v6saqJ5x6RJUqH">
							<div class="scroll j-flag" style="display: none; top: 0px;"></div>
						</div>
					</div>
					<div data-action="home" class="foot" style="height: 3.8%;">
						<div class="bg logo"></div>
						<div class="yyy">收藏最经典的音乐</div>
						<div class="slogan">只听自己喜欢的</div>
					</div>
				</div>

			</div>
		</div>
</body>
</html>