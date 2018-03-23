<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../mobileHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script type="text/javascript">
	var isError = false;
	$(function() {
		$(".pause-voice").hide();
	})
	function back() {
		window.location.replace("${base}learn/mob?idx=0");
	}
	function addWord(type,timeClass){
		$('#word-add-title').text("添加"+type);
		$('#word-timeClass').text(timeClass);
		$.mobile.go('#word-add');
	}
	function openit(target) {
		var text = $(target).find("b").text();
		$('#switchbutton').switchbutton("check");
		playV(2);
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}learn/getWordInfo?word=' + text,
			success : function(result) {
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
				}
				$.mobile.go('#word-info');
			}
		});

	}
	function getVway() {
		if (isError == true) {
			return "null";
		} else {
			var tx = $('#switchbutton').switchbutton("options").checked;
			return tx;
		}
	}
	function playV(v) {
		if (v == 1) {
			$(".pause-voice").show();
			$(".play-voice").hide();
			playAudio(1);
		} else {
			$(".pause-voice").hide();
			$(".play-voice").show();
			playAudio(2);
		}

	}
	function playAudio(p) {
		var url;
		if (isError == true) {
			url = $("#mp3url").text();
		} else {
			if (getVway()) {
				url = $("#usAudio").text();
			}
			if (!getVway()) {
				url = $("#ukAudio").text();
			}
			if (url == 'null' || url == null) {
				url = $("#mp3url").text();
			}
		}
		var audioV = document.getElementById('audioV');
		$("#audioV").attr("src", url);
		if (p == 1) {
			audioV.play();
			audioV.loop = false;
			audioV.addEventListener('ended', function() {
				playV(2);
			}, false);
			audioV.onerror = function() {
				isError = true;
				playAudio(1);
			};
		} else {
			audioV.pause();
		}
	}
	function confrmAdd(){
		var text=$("#word-someone").textbox("getValue");
		var timeClass=$('#word-timeClass').text();
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}learn/addLearn?word=' + text+"&wordType=word"+"&timeClass="+timeClass,
			success : function(result) {
				console.log(result);
			}
		});
		
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
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick=" back()">返回</a>
				</div>
			</div>
		</header>
		<div class="easyui-accordion" data-options="fit:true,border:false,selected:0">
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
					<ul class="m-list">
						<c:forEach items="${words}" var="wd">
							<c:if test="${wd.type==wt.itemNo}">
								<c:if test="${wd.type=='word'}">
									<li style="text-align: left;"><a onclick="openit(this)"><b>${wd.word}</b>&nbsp;&nbsp;&nbsp;&nbsp;美:${wd.usPronunciation}&nbsp;&nbsp; 英：${wd.ukPronunciation} </a></li>
								</c:if>
								<c:if test="${wd.type!='word'}">
									<li style="text-align: left;"><a onclick="openit(this)"><b>${wd.word}</b>&nbsp;&nbsp;&nbsp;&nbsp; ${wd.definition}</a></li>
								</c:if>
							</c:if>
						</c:forEach>
					</ul>
					<div style="text-align: center;">
						<a href="javascript:void(0)"  onclick="addWord('${wt.itemName }','${learn.id}')"  class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加${wt.itemName }</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div id="word-info" class="easyui-navpanel" style="opacity: 0.8;">
		<header>
			<div class="m-toolbar">
				<span id="p2-title" class="m-title">单词详情</span>
				<div class="m-left">
					<a href="javascript:void(0)"  class="easyui-linkbutton m-back" plain="true" outline="true" onclick="$.mobile.back()">返回</a>
				</div>
			</div>
		</header>
		<div style="margin: 50px 0 0; text-align: center" align="center">
			<div id="word" style="font-size: 32px; font-weight: 700; color: red; height: 50px; line-height: 50px; margin-bottom: 30px;"></div>
			<div id="pronunciation" style="font-size: 14px; margin-bottom: 160px; padding-left: 50px; padding-right: 50px;">
				<div id="usPronunciation" style="float: left;"></div>
				<div id="ukPronunciation" style="float: right;"></div>
			</div>
			<div id="definition" style="font-size: 18px; margin-bottom: 40px; text-align: left; width: 300px; padding-left: 55px;"></div>
			<div style="position: absolute; bottom: 25px; left: 44%;">
				<img onclick="playV(1)" class="play-voice" src="${base}static/mobile/images/play.png" width="48px;" height="48px;"> <img onclick="playV(2)" class="pause-voice" src="${base}static/mobile/images/pause.png" width="48px;" height="48px;">
			</div>
			<div id="wordType" style="position: absolute; top: 60px; left: 0px;">
				<input id="switchbutton" onText="美" offText="英" class="easyui-switchbutton">
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
                    <a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick="$.mobile.go('#words')">返回</a>
                </div>
			</div>
		</header>
        <div style="margin:50px 0 0;text-align:center">
           <input class="easyui-textbox" id="word-someone" data-options="multiline:true,prompt:'请输入需要添加的单词或词组或句子或文章......'" style="width:80%;height: 380px;">
           <a onclick="confrmAdd(1)" class="easyui-linkbutton" style="width: 40%; height: 40px;margin-top: 15px;"><span style="font-size: 16px">新增</span></a>
           <a onclick="confrmAdd(2)" class="easyui-linkbutton" style="width: 40%; height: 40px;margin-top: 15px;"><span style="font-size: 16px">新增后返回</span></a>
        </div>
        <div id="word-timeClass" style="display: none;"></div>
	</div>
	<audio id="audioV" hidden></audio>
	<audio id="audioVErr" hidden></audio>
</body>
</html>
