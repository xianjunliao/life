<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<style>
body {
	margin: 0;
	padding: 0;
}

.stand-main {
	width: 100%;
	height: 100%;
	overflow: auto;
}

.stand-img {
	background-color: white;
	margin: 5px;
	float: left;
	border: 1px #ecdada solid;
}

.stand-img:hover {
	background-color: white;
	cursor: pointer;
	margin: 5px;
	float: left;
	border: 1px red solid;
}

#stand-main:-webkit-full-screen {
	width: 100%;
	height: 100%;
}
</style>
<script type="text/javascript" src="${base}static/life-js/html5upload.js"></script>
<script type="text/javascript">
	var wh = window.screen.height;
	var ww = window.screen.width;
	var time;
	$(function() {
		initWH(".stand-img");
		initWH(".stand-img-add");
		initTop();
	});

	function initWH(target) {
		var w, h;
		if (ww >= 1366) {
			w = ww / 2 - 30;
			h = wh - 5;
		}
		if (ww >= 1920) {
			w = ww / 3 - 30;
			h = wh - 5;

		}
		$(target).css({
			"width" : w + "px",
			"height" : h + "px"
		});
	}
	function initTop() {
		var v = $("#musicname").val();
		$
				.ajax({
					type : 'POST',
					dataType : "json",
					url : '${base}music/getScore?name=' + v,
					success : function(result) {
						var data = result.data;
						if (result.code = "200" && data != null) {
							$("#stand-main").empty();
							toPlay(data);
						} else {
							$("#stand-main")
									.html(
											"<h1>请置顶一个乐谱后再使用窗口打开，或点击全部按钮后选择想窗口打开的乐谱。<span id='m'>5</span>秒后自动<a id='wx' onclick='wc()'>关闭</a>该窗口。</h1>");
							time=setInterval("m()", 1000);
						}
					}
				});

	}
	function toPlay(data) {
		var len = data.length;
		for (var d = 0; d < len; d++) {
			var sf = data[d];
			var textHtml = "<div  class='stand-img'><img id=" + sf.id
					+ " title=" + sf.filename + "  name='attachment' src='"
					+ sf.url + "'width='100%' height='100%'/></div></div>";
			$("#stand-main").append(textHtml);
			initWH(".stand-img");
		}
	}
	function wc() {
		clearInterval(time);
		window.close();
	}
	function m() {
		var t = $("#m").text();
		if (t == 1) {
			wc();
			return;
		}
		$("#m").text(t - 1);
	}
</script>

</head>
<body>
	<input type="hidden" id="musicname" value="${musicname}">
	<div class="stand-main" id="stand-main"></div>
</body>
</html>
