<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<style>
* {
	margin: 0;
	padding: 0;
}

#imgsDiv {
	width: 100%;
	height: 210px;
	background-color: #646464;
	border: 1px dashed #CCC;
	position: relative;
	overflow: hidden;
}

#imgsDiv ul {
	position: absolute;
	left: 0;
	top: 0;
	overflow: hidden;
	background-color: #3b7796;
}

#text {
	background: #F0F0F0;
	border: 1px dashed #CCC;
	width: 100%;
	height: 100%;
}

img {
	float: left;
	width: 300px;
	height: 210px;
}

#imgsDiv ul li {
	float: left;
	width: 300px;
	height: 210px;
	list-style: none;
}
</style>
<script type="text/javascript">
	var basePath = "${base}";
	var user = "${user}";
</script>
<script type="text/javascript" src="${base}static/life-js/common.js"></script>
<script type="text/javascript" src="${base}static/life-js/main.js"></script>
</head>
<body style="margin: 0px; overflow: hidden;">
	<div id="main" class="easyui-layout" style="width: 100%; height: 100%;">
		<div data-options="region:'south',split:false" style="height: 30px">
			<div style="float: left; margin-top: 2px; margin-right: 3px;">
				<table>
					<tr>
						<td><a title="跳转到测试页面" id="test" href="${bser}test" style="height: 25px; width: 31px" class="easyui-linkbutton" data-options="plain:false,iconCls:'test'"></a></td>
					</tr>
				</table>
			</div>
			<div style="float: right; margin-top: 2px; margin-right: 3px;">
				<table>
					<tr>
						<td><div id="inputCode" style="margin-top: 1px;">
								<input class="easyui-textbox" type="password" id="code" data-options="prompt:'Please enter your code...'" style="width: 200px; height: 25px;">
							</div></td>
						<td><div id="audios"></div></td>
						<td>
							<div id="btns" style="margin: 1px;">
								<a style="height: 25px; width: 31px;" title="跳转到主页面" id="house" onclick="intoWorld()" class="easyui-linkbutton" data-options="plain:false,iconCls:'main-house'"></a> <a style="height: 25px; width: 31px;" onclick="exitHouse()" title="退回入口页面" id="exitHouse" class="easyui-linkbutton" data-options="plain:false,iconCls:'main-exit'"></a>
							</div>
						</td>

					</tr>
				</table>
			</div>
		</div>
		<div data-options="region:'center',border:false">
			<div id="center" class="easyui-layout" style="width: 100%; height: 100%;">
				<div id="" data-options="region:'north',border:false" style="width: 100%; height: 212px; overflow: hidden; margin-top: 2px; padding-right: 2px;">
					<div id=imgsDiv>
						<ul id="imgs">
							<li><img src="${base}/static/images/xjcy1.jpg" border="0" /></li>
							<li><img src="${base}/static/images/xjcy2.jpg" border="0" /></li>
							<li><img src="${base}/static/images/xjcy3.jpg" border="0" /></li>
							<li><img src="${base}/static/images/xjcy4.jpg" border="0" /></li>
							<li><img src="${base}/static/images/xjcy5.jpg" border="0" /></li>
							<li><img src="${base}/static/images/xjcy6.jpg" border="0" /></li>
						</ul>
					</div>
				</div>
				<div data-options="region:'center',border:true" style="width: 100%; height: 100%; overflow: hidden; margin-top: 1px; padding-right: 2px;">
					<div id="text">
					 <div id="info" style="width: 100%;height: 80%;margin: 15px"></div>
					</div>
					<audio id="audio" loop="loop" src="${base }static/music/Cornfield Chase.mp3">
					</audio>
				</div>
			</div>
			<script>
				window.onload = function() {
					var oDiv = document.getElementById('imgsDiv');
					var oUl = document.getElementById('imgs');
					var speed = -1;//初始化速度

					oUl.innerHTML += oUl.innerHTML;//图片内容*2-----参考图（2）
					var oLi = document.getElementsByTagName('li');
					oUl.style.width = oLi.length * 300 + 'px';//设置ul的宽度使图片可以放下

					function move() {
						if (oUl.offsetLeft > 0) {//向右滚动，当靠右的图1移出边框时
							oUl.style.left = -(oUl.offsetWidth / 2) + 'px';
						}
						if (oUl.offsetLeft < -(oUl.offsetWidth / 2)) {//向左滚动，当靠左的图4移出边框时
							oUl.style.left = 0;
						}
						oUl.style.left = oUl.offsetLeft + speed + 'px';
					}
					var timer = setInterval(move, 30);//全局变量 ，保存返回的定时器
					oDiv.addEventListener('mouseout', function() {
						timer = setInterval(move, 30);
					}, false);
					oDiv.addEventListener('mousemove', function() {
						clearInterval(timer);//鼠标移入清除定时器
					}, false);
					var info = 'Do not go gentle into that good night,Old age should burn and rave at close of day,Rage rage against the dying of the light.Though wise men at their end know dark is right,Because their words had forked no lightning they,Do not go gentle into that good night.Good men,the last wave by, crying how bright,Their frail deeds might have danced in a green bay,Rage rage against the dying of the light.Wild men who caught and sang the sun in flight,And learn,too late,they grieved it on its way,Do not go gentle into that good night.Grave men, near death,who see with blinding sight,Blind eyes could blaze like meteors and be gay,Rage, rage against the dying of the light.And you, my,father,there on the sad height,Curse,bless me now with your fierce tears,I pray,Do not go gentle into that good night.Rage rage against the dying of the light.';
					welcomeTo(1000, info, 80);
				}
			</script>
		</div>
	</div>
</body>
</html>
