<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
* {
	margin: 0;
	padding: 0;
}

#div1 {
	width: 100%;
	height: 200px;
	background-color: #646464;
	position: relative;
	overflow: hidden;
}

#div1 ul {
	position: absolute;
	left: 0;
	top: 0;
	overflow: hidden;
	background-color: #3b7796;
}

img {
	float: left;
	width: 300px;
	height: 200px;
}

#div1 ul li {
	float: left;
	width: 300px;
	height: 200px;
	list-style: none;
}
</style>

<script>
	window.onload = function() {
		var oDiv = document.getElementById('div1');
		var oUl = document.getElementById('ul1');
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
	}
</script>
</head>
<body>
	<div id="div1">
		<ul id="ul1">
			<li><img src="${base}/static/images/xjcy1.jpg" border="0" /></li>
			<li><img src="${base}/static/images/xjcy2.jpg" border="0" /></li>
			<li><img src="${base}/static/images/xjcy3.jpg" border="0" /></li>
			<li><img src="${base}/static/images/xjcy4.jpg" border="0" /></li>
			<li><img src="${base}/static/images/xjcy5.jpg" border="0" /></li>
			<li><img src="${base}/static/images/xjcy6.jpg" border="0" /></li>
		</ul>
	</div>
</body>
</html>