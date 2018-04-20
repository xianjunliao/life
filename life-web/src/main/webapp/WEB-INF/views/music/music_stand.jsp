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
	cursor: pointer;
	border: 1px red solid;
}

.stand-img-add {
	background-color: white;
	margin: 5px;
	float: left;
	border: 1px #ecdada dashed;
	text-align: center;
}

.stand-msg {
	background-color: white;
	margin: 5px;
	float: left;
	border: 2px red solid;
	text-align: center;
}

.stand-img-add-old {
	background-color: white;
	margin: 5px;
	float: left;
	border: 1px #ecdada solid;
	text-align: center;
}

.empty-add {
	text-align: center;
	font-size: 28px;
	cursor: pointer;
	margin-top: 40%;
}

.empty-stand-msg {
	text-align: center;
	font-size: 28px;
	margin-top: 35%;
	font-weight: 900;
	text-decoration: underline;
}

.operation-main {
	position: fixed;
	transform: translateX(-50%);
	font-size: 24px;
	left: 50%;
	top: 2px;
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

.delete-img {
	margin-top: 5px;
	width: 17px;
	height: 17px;
	bottom: 100%;
	left: 94%;
	cursor: pointer;
	position: relative;
	background-image: url("${base}static/images/delete.png");
	background-repeat: no-repeat;
}

.print-img:HOVER {
	margin-top: 5px;
	width: 20px;
	height: 20px;
	bottom: 100%;
}

.delete-img:HOVER {
	margin-top: 5px;
	width: 20px;
	height: 20px;
}

.stand-button {
	margin-right: 5px;
	margin-left: 20px;
	float: left;
	padding: 2px;
	cursor: pointer;
	border-radius: 2px;
	background-color: #e87788;
	padding: 2px;
	box-shadow: -1px 1px 11px 5px #eaa0a0;
}

.stand-button-self {
	margin: 2px;
	padding: 2px;
	cursor: pointer;
	border-radius: 2px;
	background-color: #f7eaec;
	float: left;
	color: red;
	text-align: center;
	padding: 2px;
}

.stand-button-self:HOVER {
	background-color: #252424;
	color: white;
}

.stand-button:HOVER {
	background-color: #252424;
	color: white;
	font-weight: 700;
}

.add-musicname {
	position: absolute;
	top: 2px;
	left: 10px;
}

#first-socre {
	border: 1px red dashed !important;
}

#second-socre {
	border: 1px #ecdada dashed !important;
}

#msg-upload {
	color: red;
	font-weight: 900;
	font-size: 12px;
}

#stand-main:-webkit-full-screen {
	width: 100%;
	height: 100%;
}

.all-div {
	float: left;
	width: 210px;
	height: 210px;
	margin: 50px 10px 10px 10px;
	border: 1px #988b8b solid;
	box-shadow: 5px 5px 10px #171516;
	background-image: url("${base}static/images/20180321_110947_3856.jpg");
	background-size: 100%;
	text-align: center;
	cursor: pointer;
}

.all-div-this {
	float: left;
	width: 210px;
	height: 210px;
	border: 1px #988b8b solid;
	box-shadow: 5px 5px 10px #171516;
	background-image: url("${base}static/images/20180321_110947_3856.jpg");
	background-size: 100%;
	text-align: center;
	position: absolute;
	cursor: pointer;
	font-weight: 900;
	top: 0px;
	left: 0px;
	opacity: 0.8;
	top: 0px;
}

.all-div:HOVER {
	border: 1px red solid;
	box-shadow: 5px 5px 10px #a59fa0;
}

.all-items {
	color: red;
	margin-top: 20px;
}

.all-buttons {
	width: 100%;
	position: relative;
	top: 23%;
	left: 10px;
}

.stand-button-add {
	cursor: pointer;
	border-radius: 2px;
	background-color: #e87788;
}
</style>
<script type="text/javascript" src="${base}static/life-js/html5upload.js"></script>
<script type="text/javascript">
	var wh = window.screen.height;
	var ww = window.screen.width;
	var ary = new Array();
	var isShow = false;
	$(function() {
		$("#add-stand-div").hide();
		$("#add-model").hide();
		initWH(".stand-img");
		initWH(".stand-img-add");
		initWH(".stand-msg");

		$("#toTop").hide();
		$('#first-socre').hide();
		$('#stand-msg').show();
		initAll();
		disableDrop();
		$("#musicname").keyup(function(e) {
			$("#musicname").css({
				"border" : "1px #a9a9a9 solid"
			});
			$("#msg-upload").html();
			var name = $(this).val();
			if ($.trim(name) == "" || $.trim(name) == null) {
				$(".newpage").remove();
				$(".oldpage").remove();
				$("#msg-upload").html("必须先输入乐谱名！");
				disableDrop();
				$('#stand-msg').show();
				$('#first-socre').hide();
				$("#toTop").hide();
				return;
			}
			ZhangHongyang.html5upload.init();
			$('#first-socre').show();
			$('#stand-msg').hide();
			initScore(name);
		});
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
	function initScore(name) {
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}music/getScore?name=' + name,
			success : function(result) {
				$(".newpage").remove();
				$(".oldpage").remove();
				$("#toTop").text("置顶");
				var data = result.data;
				if (result.code = "200" && data != null) {
					$("#toTop").show();
					var len = data.length;
					for (var d = 0; d < len; d++) {
						var sf = data[d];
						if (sf.isTop == "1") {
							$("#toTop").text("已置顶");
						} else {
							$("#toTop").text("置顶");
						}
						var textHtml = "<div id=" + sf.id + " title="+sf.filename+" class='stand-img-add-old oldpage'><img  name='attachment' src='" + sf.url
								+ "'width='100%' height='100%'/><div title='删除' onclick='deleteImgReal(" + sf.id + ")' class='delete-img'></div></div>";
						$("#first-socre").after(textHtml);
						initWH(".stand-img-add-old");
					}
					$("#msg-upload").html(result.message);
				} else {
					$(".newpage").remove();
					$(".oldpage").remove();
					$("#toTop").text("置顶");
					$("#toTop").hide();
					$("#msg-upload").html(result.message);
				}
			}
		});
	}

	function initTop(v) {
		var url = '${base}music/getTop';
		if (v != null) {
			url = '${base}music/getScore?name=' + v;
		}
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : url,
			success : function(result) {
				var data = result.data;
				if (result.code = "200" && data != null) {
					$("#stand-main").empty();
					toPlay(data, "#stand-main");
				} else {
					$("#stand-main").html("<h1>目前一个置顶的乐谱都没有！</h1>");
				}
			}
		});

	}

	function openStand(name) {
		window.open('${base}music/openScore?name=' + name, name, 'height=' + wh + ', width=' + ww
				+ ', top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');

	}
	function fullOpen(name) {
		url = '${base}music/getScore?name=' + name;
		fullScreen("stand-main");
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : url,
			success : function(result) {
				var data = result.data;
				if (result.code = "200" && data != null) {
					$("#stand-main").empty();
					toPlay(data, "#stand-main");
				} else {
					$("#stand-main").text("查无此谱！！！");
				}
			}
		});

	}

	function initAll() {
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}music/getAll',
			success : function(result) {
				var data = result.data;
				if (result.code = "200" && data != null) {
					$("#stand-main").empty();
					var len = data.length;
					for (var d = 0; d < len; d++) {
						var sf = data[d];
						var isTop = sf.isTop;
						var t = "置顶";
						if (isTop == "1") {
							t = "已置顶";
						}
						var textHtml = "<div class='all-div' id=" + d + " ><div class='all-items'>谱名：" + sf.musicname + "</div><div class='all-items'>共" + sf.pagenumber
								+ "页</div><div class='all-items'>总大小：" + sf.filesize + "KB</div><div class='all-buttons'> <div class='stand-button-self' title='点击将图片显示在界面上' id='stand-see"+d+"'  onclick='standOverDiv("
								+ d + ",\"" + sf.musicname + "\")'>查看</div><div title='窗口打开显示乐谱' class='stand-button-self' onclick='openStand(\"" + sf.musicname
								+ "\")'>窗口</div><div class='stand-button-self' onclick='toTopByName(\"" + sf.musicname + "\",\"" + t + "\")'>" + t
								+ "</div><div class='stand-button-self' onclick='addStand(\"" + sf.musicname
								+ "\")'>编辑</div><div class='stand-button-self' onclick='deleteByName(\"" + sf.musicname + "\")'>删除</div></div>";
						$("#stand-main").append(textHtml);
						// 						initWH(".stand-img");
					}
				} else {
					addStand();
				}
			}
		});

	}

	function openWindow() {
		var bt = getBrowserType();
		if (bt != "Chrome") {
			alert("请使用谷歌或含有谷歌内核的浏览器来获取最佳使用体验！");
		}
		window.open('${base}music/music_stand', "ss", 'height=' + wh + ', width=' + ww
				+ ', top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	}
	function openFullScreen() {
		var bt = getBrowserType();
		if (bt != "Chrome") {
			alert("请使用谷歌或含有谷歌内核的浏览器来获取最佳使用体验！");
		}
		fullScreen("stand-main");
	}

	function addStand(v) {
		var bt = getBrowserType();
		if (bt != "Chrome") {
			alert("请使用谷歌或含有谷歌内核的浏览器来获取最佳使用体验！");
		}
		$("#stand-main").hide();
		$("#play-model").hide();
		$("#add-stand-div").show();
		$("#add-model").show();
		$("#musicname").focus();
		clearAddInfo();
		if (v != null) {
			initScore(v);
			$('#first-socre').show();
			$('#stand-msg').hide();
			$("#musicname").val(v);
		}

	}
	function backPlay() {
		clearAddInfo();
		$("#stand-main").show();
		$("#play-model").show();
		$("#add-stand-div").hide();
		$("#add-model").hide();
		initAll();
	}
	function getPhoto(node) {
		// 		$('#path').val($('#attachment').val());
		var imgURL = "";
		var musicname = $("#musicname").val();
		if (musicname == null || musicname == "") {
			$("#musicname").css({
				"border" : "2px red solid"
			});
			$("#msg-upload").html("谱名不能为空！");
			return;
		}
		$("#msg-upload").html("");
		$("#musicname").css({
			"border" : "1px #a9a9a9 solid"
		});
		try {
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
		creatImg(imgRUL, file);
		return imgURL;
	}
	function ahclick() {
		var musicname = $("#musicname").val();
		if (musicname == null || musicname == "") {
			$("#musicname").css({
				"border" : "2px red solid"
			});
			$("#msg-upload").html("请输入乐谱名！");
			return;
		}
		$("#attachment").click();
	}
	function creatImg(imgRUL, file) {
		// 		fname = "\'" + fname + "\'";
		var textHtml = "<div id=" + file.lastModified + " title="+file.name+" class='stand-img-add newpage'><img  name='attachment' src='" + imgRUL
				+ "'width='100%' height='100%'/><div title='删除' onclick='deleteImg(" + file.lastModified + ")' class='delete-img'></div></div>";
		$("#first-socre").after(textHtml);
		initWH(".stand-img-add");
	}
	function UpladFile() {
		var musicname = $("#musicname").val();
		if (musicname == null || musicname == "") {
			$("#musicname").css({
				"border" : "2px red solid"
			});
			$("#msg-upload").html("谱名不能为空！");
			return;
		}
		console.log(fileList);
		console.log(ary);

		if (confirm("请仔细检查上传的乐谱顺序是否正确，确定上传吗？")) {
			var len = getLength();
			if (len == 1) {
				createForm(ary[0].name, "null", 2, musicname);
			} else if (len > 1) {
				createForm(ary[0].name, ary[1].name, 2, musicname);
			} else {
				$("#msg-upload").html("新上传的乐谱图片文件不能为空！");
			}
		}
		console.log(ary);
	}
	function getLength() {
		var count = 0;
		for ( var i in fileList) {
			ary.push(fileList[i]);
			if (fileList.hasOwnProperty(i)) {
				count++;
			}
		}
		return count;
	}
	function createForm(name, nextname, index, musicname) {
		$("#msg-upload").html("正在上传" + musicname + "曲谱...");
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
				} else {
					var nextname = ary[next].name;
					createForm(thisname, nextname, next + 1, musicname);
				}
			} else {
				clearAddInfo();
			}
			$("#msg-upload").html(musicname + "曲谱上传成功！");

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
	function deleteImg(id) {
		var fname = $("#" + id).attr("title");
		delete fileList[fname];
		$("#" + id).remove();
		$('#attachment').val(null);

	}
	function deleteImgReal(id) {

		if (confirm("确定删除这张乐谱图片吗？")) {
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : '${base}music/delete?id=' + id,
				success : function(result) {
					if (result.code = 200) {
						deleteImg(id);
						$("#msg-upload").html(result.message);
					} else {
						$("#msg-upload").html(result.message);
					}
				}
			});
		}
	}

	function deleteByName(name) {

		if (confirm("确定删除【" + name + "】乐谱吗？")) {
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : '${base}music/deleteByName?name=' + name,
				success : function(result) {
					if (result.code = 200) {
						initAll();
					} else {

					}
				}
			});
		}
	}

	function clearAddInfo() {
		$(".newpage").remove();
		$(".oldpage").remove();
		fileList = {};
		ary = [];
		file = null;
		$('#attachment').val(null);
		$("#musicname").val(null);
		$("#msg-upload").html(null);
		disableDrop();
		$('#stand-msg').show();
		$('#first-socre').hide();

	}
	function toTopByName(musicname, t) {
		if (t != "置顶") {
			return;
		}
		confirmToTop(musicname, 1);
	}
	function toTop(target) {
		var txt = $("#toTop").text();
		if (txt != "置顶") {
			return;
		}
		var musicname = $("#musicname").val();
		if (musicname == "" || musicname == null) {
			$("#msg-upload").html("请输入乐谱名！");
			return;
		}
		confirmToTop(musicname, 0);
	}

	function confirmToTop(musicname, v) {
		if (confirm("置顶后会在主页面显示，并且只能置顶一个乐谱，置顶后之前置顶的都将取消置顶，确定将乐谱【" + musicname + "】置顶吗？")) {
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : '${base}music/toTop?name=' + musicname,
				success : function(result) {
					if (result.code = 200) {
						if (v == 1) {
							initAll();
						}
						$("#msg-upload").html(result.message);
					} else {
						$("#msg-upload").html(result.message);
					}
				}
			});
		}
	}

	function getBrowserType() {

		var userAgent = navigator.userAgent; // 取得浏览器的userAgent字符串
		var isOpera = userAgent.indexOf("Opera") > -1;
		// 判断是否Opera浏览器
		if (isOpera) {
			return "Opera"
		}
		// 判断是否Firefox浏览器
		if (userAgent.indexOf("Firefox") > -1) {
			return "FF";
		}
		// 判断是否chorme浏览器
		if (userAgent.indexOf("Chrome") > -1) {
			return "Chrome";
		}
		// 判断是否Safari浏览器
		if (userAgent.indexOf("Safari") > -1) {
			return "Safari";
		}
		// 判断是否IE浏览器
		if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
			return "IE";
		}
		// 判断是否Edge浏览器
		if (userAgent.indexOf("Trident") > -1) {
			return "Edge";
		}
	}

	function disableDrop() {
		document.addEventListener("dragenter", function(e) {
			e.stopPropagation();
			e.preventDefault();
		}, false);
		document.addEventListener("dragover", function(e) {
			e.stopPropagation();
			e.preventDefault();
		}, false);
		document.addEventListener("drop", function(e) {
			e.stopPropagation();
			e.preventDefault();

		}, false);
	}

	function toPlay(data, id) {
		var len = data.length;
		for (var d = 0; d < len; d++) {
			var sf = data[d];
			var textHtml = "<div  class='stand-img'><img id=" + sf.id + " title=" + sf.filename + "  name='attachment' src='" + sf.url + "'width='100%' height='100%'/></div>";
			$(id).append(textHtml);
			initWH(".stand-img");
		}
	}
	function standOverDiv(id, name) {
		if (!isShow) {
			isShow = true;
			$("#stand-see"+id).text("取消");
			$(".all-div").hide();
			$("#" + id).removeClass("all-div").addClass("all-div-this");
			var url = '${base}music/getScore?name=' + name;
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : url,
				success : function(result) {

					var data = result.data;
					var len = data.length;
					$(".stand-img").remove();
					for (var d = 0; d < len; d++) {
						var sf = data[d];
						var textHtml = "<div  class='stand-img'><img id=" + sf.id + " title=" + sf.filename + "  name='attachment' src='" + sf.url
								+ "'width='100%' height='100%'/></div>";
						$("#stand-main").append(textHtml);
						initWH(".stand-img");
					}
				}
			});
			$("#" + id).show();
		} else {
			isShow = false;
			$("#stand-see"+id).text("查看");
			backPlay();
		}
	}
</script>

</head>
<body>
	<div class="operation-main" id="play-model">
		<!-- 		<div title="显示所有的乐谱信息" class="stand-button" id="change-stand" onclick="backPlay()">返回</div> -->
		<div title="上传一个乐谱或添加乐谱图片文件" class="stand-button" id="add-stand" onclick="addStand()">上传乐谱</div>
		<div title="窗口显示置顶的乐谱" class="stand-button" id="change-stand" onclick="openStand('top')">打开置顶乐谱</div>
		<!-- 		<div title="全屏显示乐谱" class="stand-button" id="full-stand" onclick="openFullScreen()">全屏</div> -->
		<!-- 		<div title="窗口化显示乐谱" class="stand-button" id="window-stand" onclick="openStand('top')">窗口</div> -->
	</div>
	<div class="operation-main" id="add-model">
		<div title="回到乐谱主界面" class="stand-button" id="change-stand" onclick="backPlay()">返回乐谱列表</div>
	</div>
	<div class="stand-main" id="stand-main">
		<span>请上传乐谱！</span>
	</div>
	<div id="add-stand-div">
		<div class="add-musicname">
			<label>乐谱名：</label> <input type="text" placeholder="请输入..." autofocus="autofocus" id="musicname" name="musicname" style="margin-top: 10px;"> <a class="stand-button-add" onclick="UpladFile()">确认上传</a> <input type="file" id="attachment" style="display: none;" onchange="getPhoto(this)" accept="image/*" /> <a class="stand-button-add" id="toTop" onclick="toTop()">置顶</a> <span
				id="msg-upload"></span>
		</div>
		<div id="add-imgs">
			<div class="stand-img-add" id="first-socre">
				<div class="empty-add" id="empty-add" onClick="ahclick()">点击选择或拖拽图片文件到此处！</div>
			</div>
			<div class="stand-msg" id="stand-msg">
				<div class="empty-stand-msg" id="stand-msg-name">上传乐谱图片前，请先输入乐谱名。输入谱名后即可拖拽或点击选择文件到此处！</div>
			</div>
			<div title="乐谱文件显示处" class="stand-img-add" id="second-socre"></div>
		</div>
	</div>

</body>
</html>
