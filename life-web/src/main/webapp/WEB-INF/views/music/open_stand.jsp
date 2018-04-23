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

.full-div {
	width: 16px;
	position: absolute;
	top: 35%;
	left: 10px;
	background-color: #e7e7ef;
	border-radius: 2px;
	padding: 2px;
	font-size: 14px;
	color: #f51111;
	font-weight: 700;
	position: absolute;
}

.full-div2 {
	width: 16px;
	position: absolute;
	top: 50%;
	left: 10px;
	background-color: #e7e7ef;
	border-radius: 2px;
	padding: 2px;
	font-size: 14px;
	color: #f51111;
	font-weight: 700;
}

.full-div:HOVER {
	background-color: black;
	color: red;
	font-weight: 900;
}

.full-div2:HOVER {
	background-color: black;
	color: red;
	font-weight: 900;
}

.print-img {
	width: 20px;
	bottom: 100%;
	left: 97%;
	color: white;
	cursor: pointer;
	position: relative;
	text-align: center;
	background-color: maroon;
}

.only-back {
	width: 20px;
	/* 	height: 16px; */
	bottom: 65%;
	left: 97%;
	color: white;
	cursor: pointer;
	position: relative;
	text-align: center;
	background-color: maroon;
}

.only-back:HOVER {
	background-color: black;
	color: white;
}

.print-img:HOVER {
	background-color: black;
	color: white;
}

.only-show {
	position: relative;
	left: 50%;
	transform: translateX(-50%);
}
</style>
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
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}music/getScore?name=' + v,
			success : function(result) {
				var data = result.data;
				if (result.code = "200" && data != null) {
					$("#stand-main").empty();
					toPlay(data);
				} else {
					$("#stand-main").html("<h1>请置顶一个乐谱后再使用窗口打开，或点在乐谱列表中选择一个你想要窗口打开的乐谱。<span id='m'>5</span>秒后自动<a id='wx' onclick='wc()'>关闭</a>该窗口。</h1>");
					time = setInterval("m()", 1000);
				}
			}
		});

	}
	function toPlay(data) {
		var len = data.length;
		var v = $("#musicname").val();
		for (var d = 0; d < len; d++) {
			var sf = data[d];
			var textHtml = "<div id='stand-img-"+sf.id+"'   class='stand-img'><img id=" + sf.id + " title=" + sf.filename + "  name='attachment' src='" + sf.url
					+ "'width='100%' height='100%'/><div title='打印这张图片' class='print-img' onclick='printSome(\"" + sf.id + "\")'>打印</div><div id='only-" + sf.id
					+ "' class='only-back' onclick='onlyShow(\"" + sf.id + "\")'>只显示这张</div></div>";
			$("#stand-main").append(textHtml);
			initWH(".stand-img");
		}
		$("#stand-main").append("<div class='full-div' id='full-name'   onclick='toFullShow(this)'>全屏展示</div>");
		$("#stand-main").append("<div class='full-div2' onclick='wc()'>关闭窗口</div>");

	}
	function printSome(id) {
		//传入文件路径  
		var path = "${base}music/printScore?id=" + id;
		$("#to_print").show();
		$("#to_print").html('<iframe width="100%" height="100%" src=' + path + ' id="FILEtoPrint"></iframe>');
		setTimeout(function() {
			$("#print_button").click();
			$("#to_print").hide();
		}, 1000);
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
	function toFullShow(target) {
		var t = $(target).text()
		if (t == '全屏展示') {
			fullScreen("stand-main");
			$(target).text("退出全屏");
		} else {
			exitFullScreen("stand-main")
			$(target).text("全屏展示");
		}
	}
	function onlyShow(id) {
		var txt = $("#only-" + id).text();
		if (txt == '只显示这张') {
			$(".stand-img").hide(300);
			$("#stand-img-" + id).addClass("only-show");
			$("#stand-img-" + id).show(800);
			$("#only-" + id).text("全部显示");
		} else {
			$(".stand-img").show(800);
			$("#stand-img-" + id).removeClass("only-show");
			$("#only-" + id).text("只显示这张");
		}
	}
</script>

</head>
<body>
	<div id="to_print" style="display: none;"></div>
	<input type="hidden" id="musicname" value="${musicname}">
	<input type="hidden" id="print_button" value="Print" onclick="document.getElementById('FILEtoPrint').focus(); document.getElementById('FILEtoPrint').contentWindow.print();" />
	<div class="stand-main" id="stand-main"></div>
</body>
</html>
