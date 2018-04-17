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
	/* 	width: 22%; */
	background-color: white;
	margin: 5px;
	float: left;
	border: 1px #ecdada solid;
}

.stand-img:hover {
	/* 	width: 22%; */
	background-color: white;
	cursor: pointer;
	margin: 5px;
	float: left;
	border: 1px red solid;
}

.stand-img-add {
	width: 48%;
	height: 98%;
	background-color: white;
	margin: 5px;
	float: left;
	border: 1px #ecdada solid;
}

.empty-add {
	text-align: center;
	font-size: 72px;
	cursor: pointer;
	margin-top: 40%;
}

.operation-main {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	left: 5px;
}

.print-img {
	margin-top: 5px;
	width: 17px;
	height: 17px;
	bottom: 100%;
	left: 94%;
	cursor: pointer;
	position: relative;
	background-image: url("${base}static/images/print.png");
	background-repeat: no-repeat;
}

.print-img:HOVER {
	margin-top: 5px;
	width: 20px;
	height: 20px;
	bottom: 100%;
	left: 96%;
	cursor: pointer;
	position: relative;
	background-image: url("${base}static/images/print.png");
	background-repeat: no-repeat;
	bottom: 100%;
}

.stand-button {
	margin: 2px;
	padding: 2px;
	cursor: pointer;
	border-radius: 2px;
	background-color: #f7eaec;
	opacity: 0.8;
}

.stand-button:HOVER {
	margin: 2px;
	padding: 2px;
	cursor: pointer;
	border-radius: 2px;
	background-color: #252424;
	color: white;
	font-weight: 700;
}

.add-musicname {
	position: absolute;
	top: 2px;
	left: 10px;
}
</style>
<script type="text/javascript">
	var wb = $("#wb");
	var wh = window.screen.height;
	var ww = window.screen.width;
	var isok = true;
	var ary = new Array()
	var fileList = {};
	$(function() {
		$("#add-stand-div").hide();
		$("#add-model").hide();
		if (ww >= 1366) {
			var w = ww / 2 - 50;
			var h = wh - 200;
			$(".stand-img").css({
				"width" : w + "px",
				"height" : h + "px"
			});
		}
		if (ww >= 1920) {
			var w = ww / 3 - 50;
			var h = wh - 200;
			$(".stand-img").css({
				"width" : w + "px",
				"height" : h + "px"
			});
		}
		if (ww >= 2560) {
			var w = ww / 4 - 50;
			var h = wh - 200;
			$(".stand-img").css({
				"width" : w + "px",
				"height" : h + "px"
			});
		}

		$("#musicname").keyup(function() {
			$("#musicname").css({
				"border" : "1px #a9a9a9 solid"
			});
			$("#msg-upload").html();
		});
	});

	function openWindow() {
		$("#close-window").show();
		window.open('${base}music/music_stand', "ss", 'height=' + wh + ', width=' + ww + ', top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	}
	function openFullScreen() {
		fullScreen("stand-main");
	}
	function printSome(path) {
		//传入文件路径  
		$("#to_print").show();
		$("#to_print").html('<iframe width="100%" height="100%" src=' + path + ' id="FILEtoPrint"></iframe>');
		setTimeout(function() {
			$("#print_button").click();
			$("#to_print").hide();
		}, 100);
	}
	function addStand() {
		$("#stand-main").hide();
		$("#play-model").hide();
		$("#add-stand-div").show();
		$("#add-model").show();
		$("#musicname").focus();
	}
	function backPlay() {
		$("#stand-main").show();
		$("#play-model").show();
		$("#add-stand-div").hide();
		$("#add-model").hide();
	}
	function getPhoto(node) {
		// 		$('#path').val($('#attachment').val());
		var imgURL = "";
		try {
			var file = null;
			if (node.files && node.files[0]) {
				file = node.files[0];
			} else if (node.files && node.files.item(0)) {
				file = node.files.item(0);
			}
			//Firefox 因安全性问题已无法直接通过input[file].value 获取完整的文件路径
			try {
				fileList[file.name] = file;
				imgURL = file.getAsDataURL();
			} catch (e) {
				imgRUL = window.URL.createObjectURL(file);
			}
		} catch (e) {
			if (node.files && node.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					imgURL = e.target.result;
				};
				reader.readAsDataURL(node.files[0]);
			}
		}
		creatImg(imgRUL);
		return imgURL;
	}
	function ahclick() {
		$("#attachment").click();
	}
	function creatImg(imgRUL) {
		var textHtml = "<div class='stand-img-add newpage'><img name='attachment' src='" + imgRUL + "'width='100%' height='100%'/></div>";
		$("#first-socre").after(textHtml);
	}
	function UpladFile() {
		var musicname = $("#musicname").val();
		if (musicname == null || musicname == "") {
			$("#musicname").css({
				"border" : "1px red solid"
			});
			$("#msg-upload").html("谱名不能为空！");
			return;
		}
		if (getLength() > 0) {
			for ( var i in fileList) {
				// 			
				ary.push(fileList[i]);
			}
			createForm(ary[0].name, ary[1].name, 2, musicname);
		} else {
			$("#msg-upload").html("曲谱文件不能为空！");
		}

	}
	function getLength() {
		var count = 0;
		for ( var i in fileList) {
			if (fileList.hasOwnProperty(i)) {
				count++;
			}
		}
		return count;
	}
	function createForm(name, nextname, index, musicname) {
		$("#msg-upload").html("正在上传" + name + "...");
		var url = "${base}music/addScore" // 接收上传文件的后台地址 
		var form1 = new FormData(); // FormData 对象
		form1.append("musicname", musicname);
		form1.append("nextname", nextname);
		form1.append("index", index);
		form1.append("file", fileList[name]); // 文件对象
		xhr = new XMLHttpRequest(); // XMLHttpRequest 对象
		xhr.open("post", url, true); //post方式，url为服务器请求地址，true 该参数规定请求是否异步处理。
		xhr.onload = uploadComplete; //请求完成
		xhr.onerror = uploadFailed; //请求失败
		xhr.send(form1); //开始上传，发送form数据
	}

	//上传成功响应
	function uploadComplete(evt) {
		//服务断接收完文件返回的结果
		var musicname = $("#musicname").val();
		var data = JSON.parse(evt.target.responseText);
		if (data.code == 200) {
			var thisname = data.data[0];
			var next = data.data[1];
			if (thisname != "null") {
				if (next >= ary.length) {
					createForm(thisname, "null", next + 1, musicname);
					$(".newpage").remove();
				} else {
					var nextname = ary[next].name;
					createForm(thisname, nextname, next + 1, musicname);
				}
			}
			$("#msg-upload").html("上传成功！");

		} else {
			$("#msg-upload").html("上传失败！");
		}

	}
	//上传失败
	function uploadFailed(evt) {
		isok = false;
		$("#msg-upload").html("上传失败！");
	}
	//取消上传
	function cancleUploadFile() {
		isok = false;
		xhr.abort();
	}
</script>
</head>
<body>
	<div class="operation-main" id="play-model">
		<div title="换一个区谱显示在当前界面上" class="stand-button" id="change-stand">换谱</div>
		<div title="新增一个乐谱" class="stand-button" id="add-stand" onclick="addStand()">增谱</div>
		<div title="更改界面显示的乐谱信息" class="stand-button" id="update-stand">改谱</div>
		<div title="全屏显示乐谱" class="stand-button" id="full-stand" onclick="openFullScreen()">全屏</div>
		<div title="窗口化显示乐谱" class="stand-button" id="window-stand" onclick="openWindow()">窗口</div>
		<input type="hidden" id="print_button" value="Print" onclick="document.getElementById('FILEtoPrint').focus(); document.getElementById('FILEtoPrint').contentWindow.print();" />
	</div>
	<div class="operation-main" id="add-model">
		<div title="回到乐谱主界面" class="stand-button" id="change-stand" onclick="backPlay()">谱架</div>
	</div>
	<div class="stand-main" id="stand-main">
		<div class="stand-img">
			<img id="img-1" src="${base}static/images/1.gif" width="100%" height="100%">
			<div title="打印" onclick="printSome('${base}static/images/1.gif')" class="print-img"></div>
		</div>
		<div class="stand-img">
			<img id="img-2" src="${base}static/images/2.gif" width="100%" height="100%">
			<div title="打印" onclick="printSome('${base}static/images/2.gif')" class="print-img"></div>
		</div>
		<div class="stand-img">
			<img id="img-3" src="${base}static/images/3.gif" width="100%" height="100%">
			<div title="打印" onclick="printSome('${base}static/images/3.gif')" class="print-img"></div>
		</div>
		<div class="stand-img">
			<img id="img-4" src="${base}static/images/3.gif" width="100%" height="100%">
			<div title="打印" onclick="printSome('${base}static/images/3.gif')" class="print-img"></div>
		</div>
	</div>
	<div id="to_print" style="display: none;"></div>
	<div id="add-stand-div">
		<div class="add-musicname">
			<label>谱名：</label> <input type="text" autofocus="autofocus" id="musicname" name="musicname" style="margin-top: 10px;"> <a class="stand-button" onclick="UpladFile()">确认上传</a> <input type="file" id="attachment" style="display: none;" onchange="getPhoto(this)" accept="image/*" /> <a class="stand-button">置顶</a> <span id="msg-upload"></span>
		</div>
		<div id="add-imgs">
			<div class="stand-img-add" id="first-socre">
				<div class="empty-add" onClick="jQuery('#attachment').click()">+</div>
			</div>
		</div>
	</div>
</body>
</html>
