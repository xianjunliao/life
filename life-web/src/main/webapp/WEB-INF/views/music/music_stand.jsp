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
	background-color: #f7f5f5;
}

.stand-main {
	width: 100%;
	height: 100%;
	overflow: auto;
	/* 	opacity: 0.9; */
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
	background-color: #ecdada;
}

.empty-stand-msg {
	text-align: left;
	font-size: 28px;
	margin-top: 30%;
	font-weight: 900;
	padding-left: 40px;
}

.operation-main {
	position: fixed;
	transform: translateY(-50%);
	font-size: 14px;
	top: 50%;
	left: 5px;
}

.query-main {
	position: fixed;
	font-size: 12px;
	left: 5px;
	top: 50%;
	position: fixed;
	transform: translateY(-50%);
}

.edit-main {
	font-size: 14px;
	left: 5px;
	top: 50%;
	position: fixed;
	transform: translateY(-50%);
}

.edit-stand-button {
	width: 20px;
	margin: 5px;
	text-align: center;
	color: white;
	cursor: pointer;
	background-color: #e01a1a;
	/* 	padding: 2px; */
}

.query-stand-button {
	width: 20px;
	margin: 5px;
	text-align: center;
	cursor: pointer;
	background-color: #cbe2d8;
	color: black;
}

.query-stand-button:HOVER {
	background-color: black;
	color: white;
}

.edit-stand-button:HOVER {
	background-color: black;
	color: white;
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
	width: 20px;
	/* 	height: 16px; */
	bottom: 100%;
	left: 97%;
	color: white;
	cursor: pointer;
	position: relative;
	text-align: center;
	background-color: red;
}

.delete-img-false {
	width: 20px;
	bottom: 100%;
	left: 97%;
	color: white;
	cursor: pointer;
	position: relative;
	text-align: center;
	background-color: maroon;
}

.print-img:HOVER {
	margin-top: 5px;
	width: 20px;
	height: 20px;
	bottom: 100%;
}

.stand-button {
	margin-top: 10px;
	width: 20px;
	cursor: pointer;
	border-radius: 2px;
	background-color: #e87788;
	padding: 2px;
	box-shadow: -1px 1px 11px 5px #eaa0a0;
	width: 20px;
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

.to-top {
	border: 2px #171516 solid !important;
	box-shadow: 5px 5px 20px #171516 !important;
}

.all-div {
	float: left;
	width: 205px;
	height: 210px;
	margin: 10px 10px 10px 40px;
	border: 1px #988b8b solid;
	box-shadow: inset 1px -2px 10px 4px #171516;
	background-image: url("${base}static/images/xjcy1.jpg");
	background-size: 100% 100%;
	text-align: center;
	cursor: pointer;
}

.all-div-this {
	float: left;
	width: 210px;
	height: 210px;
	border: 1px red solid;
	box-shadow: 5px 5px 20px #171516;
	background-image: url("${base}static/images/xjcy8.jpg");
	background-size: 100% 100%;
	text-align: center;
	position: absolute;
	cursor: pointer;
	color: red;
	font-weight: 900;
	top: 0px;
	left: 0px;
	opacity: 0.7;
}

.all-div:HOVER {
	border: 1px red solid;
	box-shadow: 5px 5px 10px #a59fa0;
}

.all-items {
	color: #f7f1f1;
	margin-top: 20px;
}

.all-buttons {
	width: 100%;
	position: relative;
	top: 23%;
	left: 10px;
	opacity: 0.9;
}

.stand-button-add {
	cursor: pointer;
	border-radius: 2px;
	background-color: #e87788;
}

.only-back {
	width: 20px;
	/* 	height: 16px; */
	bottom: 70%;
	left: 95%;
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

.only-show {
	position: relative;
	left: 50%;
	transform: translateX(-50%);
}

.query-main {
	position: absolute;
	left: 2px;
	top: 50%;
	width: 20px;
	transform: translateY(-50%);
}
</style>
<script type="text/javascript" src="${base}static/life-js/html5upload.js"></script>
<script type="text/javascript">
	var wh = window.screen.height;
	var ww = window.screen.width;
	var ary = new Array();
	$(function() {
		$("#add-stand-div").hide();
		$("#add-model").hide();
		$(".query-main").hide();
		$(".operation-main").hide();
		$(".edit-main").hide();

		initWH(".stand-img");
		initWH(".stand-img-add");
		initWH(".stand-msg");

		$("#toTop").hide();
		$('#first-socre').hide();
		$('#stand-msg').show();
		initTop();
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
		$(".edit-main").show();
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}music/getScore?name=' + name,
			success : function(result) {
				var data = result.data;
				if (result.code = "200" && data != null) {
					var len = data.length;
					$(".newpage").remove();
					$(".oldpage").remove();
					for (var d = 0; d < len; d++) {
						var sf = data[d];
						var textHtml = "<div id=" + sf.id + " title="+sf.filename+" class='stand-img-add-old oldpage'><img  name='attachment' src='" + sf.url
								+ "'width='100%' height='100%'/><div title='该乐谱文件已上传至服务器，请谨慎删除' onclick='deleteImgReal(" + sf.id + ")' class='delete-img'>删除</div></div>";
						$("#first-socre").after(textHtml);
						initWH(".stand-img-add-old");
					}
					$("#msg-upload").html(result.message);
				} else {
					$(".newpage").remove();
					$(".oldpage").remove();
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
					initAll();
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
						var clas = "all-div";
						if (isTop == "1") {
							t = "已置顶";
							clas += " to-top";
						}
						var textHtml = "<div class='"+clas+"' id=" + d + " ><div class='all-items items-"+d+"'>谱名：" + sf.musicname + "</div><div class='all-items items-"+d+"'>共"
								+ sf.pagenumber + "页</div><div class='all-items items-"+d+"'>总大小：" + sf.filesize
								+ "KB</div><div class='all-buttons'> <div class='stand-button-self' title='点击将图片显示在界面上' id='stand-see" + d + "'  onclick='standOverDiv(" + d
								+ ",\"" + sf.musicname + "\")'>查看</div><div title='窗口打开显示乐谱' class='stand-button-self' onclick='openStand(\"" + sf.musicname
								+ "\")'>窗口</div><div class='stand-button-self' onclick='toTopByName(\"" + sf.musicname + "\",\"" + t + "\")'>" + t
								+ "</div><div class='stand-button-self' onclick='addStand(\"" + sf.musicname
								+ "\")'>编辑</div><div class='stand-button-self' onclick='deleteByName(\"" + sf.musicname + "\")'>删除</div></div>";
						$("#stand-main").append(textHtml);
						// 						initWH(".stand-img");
						$(".query-main").hide();
						$(".operation-main").show();
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
		$(".edit-main").show();

	}
	function backPlay() {
		clearAddInfo();
		$("#stand-main").show();
		$("#add-stand-div").hide();
		initTop();
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
				+ "'width='100%' height='100%'/><div title='该文件尚未上传到服务器，删除的只是临时文件' onclick='deleteImg(" + file.lastModified + ")' class='delete-img-false'>删除</div></div>";
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
				$(".edit-main").show();
			}
			$("#msg-upload").html("【" + musicname + "】曲谱上传成功！");

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
						location.reload();
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
		$(".query-main").hide();
		$(".operation-main").hide();
		$(".edit-main").hide();

	}
	function toTopByName(musicname, t) {
		var isTo = true;
		if (t != "置顶") {
			isTo = false;
		}
		confirmToTop(musicname, 1, isTo);
	}
	function toTop(target) {
		var isTo = true;
		var txt = $("#toTop").text();
		if (txt != "置顶") {
			isTo = false;
		}
		var musicname = $("#musicname").val();
		if (musicname == "" || musicname == null) {
			$("#msg-upload").html("请输入乐谱名！");
			return;
		}
		confirmToTop(musicname, 0, isTo);
	}

	function confirmToTop(musicname, v, isTo) {
		var m = "置顶后可点击打开置顶按钮直接窗口化显示，只能置顶一个乐谱，置顶后之前置顶的都将取消置顶，确定将乐谱【" + musicname + "】置顶吗？";
		if (!isTo) {
			m = "取消置顶后将不做主页面显示，确定取消乐谱【" + musicname + "】的置顶吗？"
		}
		if (confirm(m)) {
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : '${base}music/toTop?name=' + musicname + "&isTo=" + isTo,
				success : function(result) {
					if (result.code = 200) {
						if (v == 1) {
							location.reload();
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
			var textHtml = "<div id='stand-img-"+sf.id+"'  class='stand-img '><img id=" + sf.id + " title=" + sf.filename + "  name='attachment' src='" + sf.url + "'width='100%' height='100%'/><div id='only-" + sf.id + "' class='only-back' onclick='onlyShow(\"" + sf.id + "\")'>只显示这张</div></div>";
			$(id).append(textHtml);
			initWH(".stand-img");
		}
		showTopButton();
	}
	function standOverDiv(id, name) {
		$(".all-div").hide(300);
		$("#play-model").hide();
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
					var textHtml = "<div id='stand-img-"+sf.id+"'  class='stand-img'><img id=" + sf.id + " title=" + sf.filename + "  name='attachment' src='" + sf.url
							+ "'width='100%' height='100%'/><div id='only-" + sf.id + "' class='only-back' onclick='onlyShow(\"" + sf.id + "\")'>只显示这张</div></div>";
					$("#stand-main").append(textHtml);
					initWH(".stand-img");
				}
			}
		});
		showTopButton(name);
	}
	function showTopButton(name) {
		if (name == null || name == "") {
			name = "${musicname}";
		}
		$("#stand-window").attr("onclick", "openStand(\'" + name + "\')");
		$("#stand-update-this").attr("onclick", "addStand(\'" + name + "\')");
		$("#stand-delete-this").attr("onclick", "deleteByName(\'" + name + "\')");
		$(".query-main").show(300);

	}

	function onlyShow(id) {
		var txt = $("#only-" + id).text();
		if (txt == '只显示这张') {
			$(".stand-img").hide(300);
			$("#stand-img-" + id).show(800);
			$("#stand-img-" + id).addClass("only-show");
			$("#only-" + id).text("全部显示");
		} else {
			$("#stand-img-" + id).removeClass("only-show");
			$(".stand-img").show(800);
			$("#only-" + id).text("只显示这张");
		}
	}
</script>

</head>
<body>
	<div class="operation-main" id="play-model">
		<!-- 		<div title="显示所有的乐谱信息" class="stand-button" id="change-stand" onclick="backPlay()">返回</div> -->
		<div title="上传一个乐谱或添加乐谱图片文件" class="stand-button" id="add-stand" onclick="addStand()">上传乐谱</div>
		<c:if test="${musicname!=null}">
			<div title="窗口显示置顶的乐谱" class="stand-button" id="change-stand" onclick="openStand('top')">打开置顶</div>
		</c:if>
		<!-- 		<div title="全屏显示乐谱" class="stand-button" id="full-stand" onclick="openFullScreen()">全屏</div> -->
		<!-- 		<div title="窗口化显示乐谱" class="stand-button" id="window-stand" onclick="openStand('top')">窗口</div> -->
	</div>
	<div class="edit-main" id="add-model">
		<div title="回到乐谱主界面" class="edit-stand-button" onclick="backPlay()">返回乐谱列表</div>
	</div>
	<div class="query-main">
		<div title="回到乐谱主界面" class="query-stand-button" id="stand-list" onclick="initAll()">乐谱列表</div>
		<div title="窗口打开该乐谱 " class="query-stand-button" id="stand-window">窗口</div>
		<div title="新增或删除该乐谱图片文件" class="query-stand-button" id="stand-update-this">编辑</div>
		<div title="删除该乐谱" class="query-stand-button" id="stand-delete-this">删除</div>
	</div>

	<div class="stand-main" id="stand-main">
		<span>请上传乐谱！</span>
	</div>
	<div id="add-stand-div">
		<div class="add-musicname">
			<label>乐谱名：</label> <input type="text" placeholder="请输入..." autofocus="autofocus" id="musicname" name="musicname" style="margin-top: 10px;"> <a class="stand-button-add" onclick="UpladFile()">确认上传</a> <input type="file" id="attachment" style="display: none;" onchange="getPhoto(this)" accept="image/*" /><span id="msg-upload"></span>
		</div>
		<div id="add-imgs">
			<div class="stand-img-add" id="first-socre">
				<div class="empty-add" id="empty-add" onClick="ahclick()">点击选择或拖拽图片文件到此处！</div>
			</div>
			<div class="stand-msg" id="stand-msg">
				<div class="empty-stand-msg" id="stand-msg-name">为了避免上传重复名称的乐谱，请先输入乐谱名称。</div>
			</div>
			<div title="乐谱文件显示处" class="stand-img-add" id="second-socre"></div>
		</div>
	</div>

</body>
</html>
