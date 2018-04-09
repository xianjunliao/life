<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../mobileHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script type="text/javascript">
	var isError = false;
	var acc_index=0;
	$(function() {
		var id="${id}";
		$(".pause-voice").hide();
		$(".play-voice").show();
		$('#switchbutton').switchbutton({
			onChange : function(param) {
				wayChange(param);
			}
		});
	})
	function back() {
		window.location.replace("${base}learn/mob?idx=0");
	}

	function back1() {
		var id="${id}";
		window.location.replace("${base}learn/dayLearns?id="+id+"&tabIndex="+acc_index);
		$('#acc-items').accordion('select',acc_index);
	}
	function back2() {
		$.mobile.go('#words');
		$('#acc-items').accordion('select',acc_index);
	}
	function addWord(type, timeClass, typeNo) {
		var pp = $('#acc-items').accordion('getSelected');
		acc_index=$('#acc-items').accordion('getPanelIndex', pp);
		$('#word-add-title').text("添加" + type);
		$('#word-timeClass').text(timeClass);
		$('#word-type-no').text(typeNo);
		var msg = "请输入需要添加的" + type + "......";
		$('#word-someone').textbox({
			prompt : msg
		});
		$.mobile.go('#word-add');
	}
	function openit(target, wordType) {
		var text = $(target).find("b").text();
		var pp = $('#acc-items').accordion('getSelected');
		acc_index=$('#acc-items').accordion('getPanelIndex', pp);
		$('#switchbutton').switchbutton("check");
		wayChange(true);
		$(".pause-voice").hide();
		$(".play-voice").show();
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}learn/getWordInfo?word=' + text,
			success : function(result) {
				$("#word").css("text-align", "center");
				$("#word").css("padding-left", " 0px");
				$("#word").text(result.data.word);
				$("#usPronunciation").html("美：" + result.data.usPronunciation);
				$("#ukPronunciation").html("英：" + result.data.ukPronunciation);
				$("#definition").html(result.data.definition);
				$("#usAudio").text(result.data.usAudio);
				$("#ukAudio").text(result.data.ukAudio);
				$("#mp3url").text(result.data.mp3url);
				if (result.data.type != 'word') {
					$("#wordType").hide();
					$("#pronunciation").html("");
					$("#word").css("text-align", "left");
					$("#word").css("padding-left", " 50px");
				}
				$('#word-info-title').text(wordType + "详情");
				$.mobile.go('#word-info');
			}
		});

	}
	function getVway() {
		var tx = $('#switchbutton').switchbutton("options").checked;
		return tx;
	}

	function wayChange(param) {
		if (param) {
			$("#usPronunciation").css("color", "green");
			$("#ukPronunciation").css("color", "black");
		} else {
			$("#ukPronunciation").css("color", "green");
			$("#usPronunciation").css("color", "black");
		}
	}

	function playAudio() {
		$(".pause-voice").show();
		$(".play-voice").hide();
		var url;
		if (getVway()) {
			url = $("#usAudio").text();
			if (url == null || url == "null") {
				url = $("#mp3url").text();
			}
			var audioVus = document.getElementById('audioVus');
			$("#audioVus").attr("src", url);
			audioVus.play();
			audioVus.loop = false;
			audioVus.addEventListener('ended', function() {
				pauseAudio("audioVus");
			}, false);
		} else {
			url = $("#ukAudio").text();
			if (url == null || url == "null") {
				url = $("#mp3url").text();
			}
			var audioVuk = document.getElementById('audioVuk');
			$("#audioVuk").attr("src", url);
			audioVuk.play();
			audioVuk.loop = false;
			audioVuk.addEventListener('ended', function() {
				pauseAudio("audioVuk");
			}, false);
		}

	}

	function pauseAudio(id) {
		$(".pause-voice").hide();
		$(".play-voice").show();
		if (id != null) {
			var audioV = document.getElementById(id);
			audioV.pause();
		}
	}
	function confrmAdd(v) {
		var text = $("#word-someone").textbox("getValue");
		if (text == null || text == "") {
			addAfter(1, "<span style='color:red;'>请输入需要添加的内容。</span> ");
			setTimeout("addAfter(2)", 3000)
			return;
		}
		var timeClass = $('#word-timeClass').text();
		var typeno = $('#word-type-no').text();
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}learn/addLearn?word=' + text + "&wordType=" + typeno + "&timeClass=" + timeClass,
			success : function(result) {
				if (result.code == 200) {
					addAfter(1, "<span style='color:red;'>新增成功。</span> ");
					if (v == 2) {
						back1()
					}
					setTimeout("addAfter(2)", 3000)
				}
			}
		});

	}

	function addAfter(v, m) {
		if (v == 1) {
			$("#word-ps").html("提示：" + m);
			$("#word-someone").textbox("setValue", null);
		} else {
			$("#word-ps").html("提示：新增后会自动获取翻译结果。");
		}
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

.div-shadow {
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
	<div id="words" class="easyui-navpanel" style="opacity: 0.8;">
		<header>
			<div class="m-toolbar">
				<span class="m-title">${learn.headline}的学习情况</span>
				<div class="m-left">
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick="back()">返回</a>
				</div>
			</div>
		</header>
		<div id="acc-items" class="easyui-accordion" data-options="fit:true,border:false">
			<c:forEach items="${wordTypes}" var="wt">
				<div>
					<header>
						<div class="hh-inner">
							<span style="font-size: 16px; color: green;">${wt.itemName }</span>
							<c:if test="${wt.itemNo=='word' }">
								<span class="m-badge" style="float: right">${word}/${words.size()}</span>
							</c:if>
							<c:if test="${wt.itemNo=='phrase' }">
								<span class="m-badge" style="float: right">${phrase}/${words.size()}</span>
							</c:if>
							<c:if test="${wt.itemNo=='sentence' }">
								<span class="m-badge" style="float: right">${sentence}/${words.size()}</span>
							</c:if>
							<c:if test="${wt.itemNo=='article' }">
								<span class="m-badge" style="float: right">${article}/${words.size()}</span>
							</c:if>
						</div>
					</header>
					<div style="text-align: left; margin-bottom: 10px; border-bottom: 1px solid #e4caca;">
						<a href="javascript:void(0)" onclick="addWord('${wt.itemName}','${learn.id}','${wt.itemNo}')" class="easyui-linkbutton" data-options="iconCls:'icon-add-self',plain:true">添加${wt.itemName }</a> <a href="javascript:void(0)" onclick="fastRead('${wt.itemName}','${learn.id}','${wt.itemNo}')" class="easyui-linkbutton" data-options="iconCls:'icon-fast-self',plain:true">速记${wt.itemName }</a>
					</div>
					<ul class="m-list">
						<c:forEach items="${words}" var="wd">
							<c:if test="${wd.type==wt.itemNo}">
								<c:if test="${wd.type=='word'}">
									<li style="text-align: left;"><a onclick="openit(this,'${wt.itemName}')"><b>${wd.word}</b>&nbsp;&nbsp;&nbsp;&nbsp;${wd.definition}</a></li>
								</c:if>
								<c:if test="${wd.type!='word'}">
									<li style="text-align: left;"><a onclick="openit(this,'${wt.itemName}')"><b>${wd.word}</b>&nbsp;&nbsp;&nbsp;&nbsp; ${wd.definition}</a></li>
								</c:if>
							</c:if>
						</c:forEach>
					</ul>

				</div>
			</c:forEach>
		</div>
	</div>
	<div id="word-info" class="easyui-navpanel" style="opacity: 0.8;">
		<header>
			<div class="m-toolbar">
				<span id="word-info-title" class="m-title">单词详情</span>
				<div class="m-left">
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick="back2()">返回</a>
				</div>
			</div>
		</header>
		<div style="margin: 50px 0 0; text-align: center" align="center">
			<div id="word" style="font-size: 32px; font-weight: 700; color: red; height: 50px; line-height: 50px; margin-bottom: 30px;"></div>
			<div id="pronunciation" style="font-size: 16px; margin-bottom: 180px; padding-left: 20px; padding-right: 20px;">
				<div id="usPronunciation" style="float: left;"></div>
				<div id="ukPronunciation" style="float: right;"></div>
			</div>
			<div id="definition" style="font-size: 18px; margin-bottom: 40px; text-align: left; width: 300px; padding-left: 20px;"></div>
			<div style="position: absolute; bottom: 25px; left: 44%;">
				<img onclick="playAudio()" class="play-voice" src="${base}static/mobile/images/play.png" width="48px;" height="48px;"> <img onclick="pauseAudio()" class="pause-voice" src="${base}static/mobile/images/pause.png" width="48px;" height="48px;">
			</div>
			<div id="wordType" style="position: absolute; top: 60px; left: 0px;">
				<input id="switchbutton" onclick="wayChange()" onText="美" offText="英" class="easyui-switchbutton">
			</div>
			<div id="usAudio" style="display: none;"></div>
			<div id="ukAudio" style="display: none;"></div>
			<div id="mp3url" style="display: none;"></div>
		</div>
	</div>
	<div id="word-add" class="easyui-navpanel" style="opacity: 0.8;">
		<header>
			<div class="m-toolbar">
				<span id="word-add-title" class="m-title"></span>
				<div class="m-left">
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick="back1()">返回</a>
				</div>
			</div>
		</header>
		<div style="margin: 50px 0 0; text-align: center">
			<input class="easyui-textbox" id="word-someone" data-options="multiline:true" style="width: 80%; height: 380px;"> <a onclick="confrmAdd(1)" class="easyui-linkbutton" style="width: 40%; height: 40px; margin-top: 15px;"><span style="font-size: 16px">新增</span></a> <a onclick="confrmAdd(2)" class="easyui-linkbutton" style="width: 40%; height: 40px; margin-top: 15px;"><span
				style="font-size: 16px">新增后返回</span></a>
			<div id="word-ps" style="">提示：新增后会自动获取翻译结果。</div>
		</div>

		<div id="word-timeClass" style="display: none;"></div>
		<div id="word-type-no" style="display: none;"></div>

	</div>
	<audio id="audioVus" hidden></audio>
	<audio id="audioVuk" hidden></audio>
</body>
</html>
