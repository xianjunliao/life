<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../mobileHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<script type="text/javascript">
	var isError = false;
	var acc_index = 0;
	var wordSize = 0;
	var maxIndex = 0;
	var tindex = 0;
	var playUrl;
	var words;
	var time;
	var isOrder = true;
	var isUs = true;
	$(function() {
		var id = "${id}";
		$(".pause-voice").hide();
		$("#stop-read").hide();
		$(".play-voice").show();
		$('#switchbutton').switchbutton({
			onChange : function(param) {
				wayChange(param);
			}
		});
		var startX, startY;
		$("#words-type").on("touchstart", function(e) {
			// 判断默认行为是否可以被禁用
			if (e.cancelable) {
				// 判断默认行为是否已经被禁用
				if (!e.defaultPrevented) {
					e.preventDefault();
				}
			}
			startX = e.originalEvent.changedTouches[0].pageX, startY = e.originalEvent.changedTouches[0].pageY;
		});
		$("#words-type").on("touchend", function(e) {
			// 判断默认行为是否可以被禁用
			if (e.cancelable) {
				// 判断默认行为是否已经被禁用
				if (!e.defaultPrevented) {
					e.preventDefault();
				}
			}
			var moveEndX = e.originalEvent.changedTouches[0].pageX;
			var moveEndY = e.originalEvent.changedTouches[0].pageY;
			var X = moveEndX - startX;
			var Y = moveEndY - startY;
			//右滑
			if (X > 100) {

				rightGo();
			}
			//左滑
			else if (X < -100) {
				leftGo();
			}
			$(e.target).click();
		});
	})

	function leftGo() {
		if (isOrder) {
			tindex++;
		} else {
			tindex = randomNum();
		}
		var length = maxIndex - 1;
		if (tindex >= maxIndex) {
			tindex = 0;
		}
		var first = tindex;
		var leftIndex = first - 1;
		var rightIndex = first + 1;

		if (leftIndex < 0) {
			leftIndex = length;
		}

		if (rightIndex > length) {
			rightIndex = 0;
		}
		setReadingValue(words[first], "first");
		setReadingValue(words[leftIndex], "left");
		setReadingValue(words[rightIndex], "right");
		$(".first-total").html("<b>" + (tindex + 1) + "</b>/" + maxIndex);

	}
	function rightGo() {

		if (isOrder) {
			tindex--;
		} else {
			tindex = randomNum();
		}
		var length = maxIndex - 1;
		if (tindex < 0) {
			tindex = length;
		}

		var first = tindex;
		var leftIndex = first - 1;
		var rightIndex = first + 1;

		if (leftIndex < 0) {
			leftIndex = length;
		}
		if (rightIndex > length) {
			rightIndex = 0;
		}
		setReadingValue(words[first], "first");
		setReadingValue(words[leftIndex], "left");
		setReadingValue(words[rightIndex], "right");
		$(".first-total").html("<b>" + (tindex + 1) + "</b>/" + maxIndex);

	}
	function back() {
		window.location.replace("${base}learn/mob?idx=0");
	}

	function back1() {
		$.mobile.go('#words');
		location.reload();
	}
	function back2() {
		$.mobile.go('#words');
		$('#acc-items').accordion('select', acc_index);
	}
	function addWord(type, timeClass, typeNo) {
		var pp = $('#acc-items').accordion('getSelected');
		acc_index = $('#acc-items').accordion('getPanelIndex', pp);
		$('#word-add-title').text("添加" + type);
		$('#word-timeClass').text(timeClass);
		$('#word-type-no').text(typeNo);
		var msg = "请输入需要添加的" + type + "......";
		$('#word-someone').textbox({
			prompt : msg
		});
		$.mobile.go('#word-add');
	}

	function fastRead(type, learnId, typeNo) {
		$('#word-fast-title').text(type + "速记");
		$.mobile.go('#fast-reading');
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}learn/getWordsByType?id=' + learnId + "&type=" + typeNo,
			success : function(result) {
				if (result.code == 200) {
					words = result.data;
					wordSize = words.length;
					maxIndex = words.length;
					if (maxIndex > 0) {
						if (maxIndex == 1) {
							setReadingValue(words[0], "first");
							setReadingValue(words[0], "left");
							setReadingValue(words[0], "right");
						} else if (maxIndex == 2) {
							setReadingValue(words[0], "first");
							setReadingValue(words[1], "left");
							setReadingValue(words[1], "right");

						} else if (maxIndex > 2) {
							setReadingValue(words[0], "first");
							setReadingValue(words[1], "left");
							setReadingValue(words[maxIndex - 1], "right");
						}
						$(".first-total").html("<b>1</b>/" + maxIndex);
					} else {
						$('#words-type').empty();

						$('#words-type').html('<div class="icon-add-self-word"  onclick="addWord(\'' + type + '\',\'' + learnId + '\',\'' + learnId + '\')">添加</div>');
					}
				} else {
					$('#words-type').html("<h3>查询出现异常！</h3>");
				}
			}
		});
	}
	function autoPlayStop(target) {
		var t = $(target).text();
		if (t == "暂停") {
			clearInterval(time);
			$(target).text("播放");
		} else {
			$(target).text("暂停");
			leftGo();
			time = setInterval("leftGo()", 3000);
		}

	}

	function randomNum() {
		var x = maxIndex;
		var y = 0;
		var rand = parseInt(Math.random() * (x - y + 1) + y);
		return rand;
	}
	function setReadingValue(obj, target) {

		var url;
		$("#" + target + "-word-text").text(obj.word);
		$("#" + target + "-definition").html(obj.definition);
		if (obj.type == 'word') {
			if (target == 'first') {
				if (isUs) {
					url = obj.usAudio;
				} else {
					url = obj.ukAudio;
				}
				playFast(url);
			}
			$("#" + target + "-usPronunciation").text("美:" + obj.usPronunciation);
			$("#" + target + "-ukPronunciation").text("英:" + obj.ukPronunciation);
			$("#" + target + "-div-pro").show();
		} else {
			$("#" + target + "-div-pro").hide();
			if (target == 'first') {
				url = obj.mp3url;
				playFast(url);
			}
		}
	
	}

	function openit(target, wordType) {
		var text = $(target).find("span").text();
		var pp = $('#acc-items').accordion('getSelected');
		acc_index = $('#acc-items').accordion('getPanelIndex', pp);
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
	function playFast(url) {
		var audioVus = document.getElementById('audioVFast');
		$("#audioVFast").attr("src", url);
		audioVus.play();
		audioVus.loop = false;
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
	function playSound(target) {
		var t = $(target).text();
		if (t == "美式发音") {
			isUs = false;
			$("#first-usPronunciation").css("color", "#47474a");
			$("#first-ukPronunciation").css("color", "green");
			$(target).text("英式发音");
		} else {
			isUs = true;
			$("#first-ukPronunciation").css("color", "#47474a");
			$("#first-usPronunciation").css("color", "green");
			$(target).text("美式发音");
		}

	}
	function playRandom(target) {
		var t = $(target).text();
		if (t == "顺序播放") {
			isOrder = false;
			$(target).text("随机播放");
		} else {
			isOrder = true;
			$(target).text("顺序播放");
		}

	}
</script>
<style>
.icon-add-self-word {
	background-color: #aedff1;
	width: 100%;
	position: absolute;
	top: 50%;
	text-align: center;
	font-size: 20px;
	box-shadow: 1px 1px 5px #333333;
}

#first-usPronunciation {
	color: green;
}

#first-ukPronunciation {
	color: #47474a;
}

.pronunciation {
	font-size: 10px;
	font-weight: 700;
	margin-left: 15px;
}

.definition {
	margin-left: 15px;
	margin-top: 15px;
	font-size: 14px;
	color: #595561;
	font-weight: 700;
	font-size: 14px;
}

.div-pro {
	text-align: right;
}

#fast-buttons {
	background-color: #aedff1;
	width: 100%;
	height: 27px;
}

#words-type {
	width: 100%;
}

.fast-one-by-one {
	display: none;
	height: 88%;
	width: 320px;
	background-color: #c2e6f7;
	margin: 10px 30px 10px 30px;
	box-shadow: 1px 1px 20px #333333;
	float: left;
	position: absolute;
	bottom: 5px;
	z-index: 2;
	opacity: 0.8;
}

.fast-one-by-one-first {
	display: block;
}

.fast-one-by-one-left {
	display: block;
	position: absolute;
	background-color: #c2e6f7;
	box-shadow: inset 20px 0px 50px 20px #3a3838;
	left: -100px;
	width: 270px;
	float: left;
	height: 85%;
	top: 60px;
	z-index: 1;
	opacity: 0.6;
}

.fast-one-by-one-right {
	display: block;
	position: absolute;
	background-color: #c2e6f7;
	box-shadow: inset -20px 0px 20px 20px #3a3838;
	right: -100px;
	width: 270px;
	float: left;
	height: 85%;
	top: 60px;
	z-index: 1;
	opacity: 0.6;
}

.fast-content {
	padding-top: 20px;
}

.fast-word-content {
	padding-top: 80px;
	font-size: 28px;
	text-align: center;
	font-weight: 900;
	color: red;
	padding-bottom: 45px;
	font-weight: 900;
}

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

.words-text {
	/* 	width: 60px; */
	min-width: 35px;
	padding: 2px;
	/* 	border: 1px solid #d9e5f7; */
	display: inline-block;
	color: #e82954;
	font-weight: 700;
}

.words-opt-buttons {
	text-align: right;
}

.read-buttons-div {
	float: left;
}

#last-read {
	position: absolute;
	left: 10px;
}

#next-read {
	position: absolute;
	right: 10px;
}

#play-read, #stop-read {
	position: absolute;
	right: 50%;
	transform: translateX(50%);
}

.first-opter {
	cursor: pointer;
	position: absolute;
	bottom: 0px;
	width: 100%;
	text-align: center;
	font-size: 20px;
	box-shadow: 1px 1px 5px #333333;
}

.first-total {
	position: absolute;
	bottom: 28px;
	width: 100%;
	text-align: center;
	font-size: 16px;
	color: red;
}

.first-sound {
	cursor: pointer;
	position: absolute;
	top: 30px;
	width: 30%;
	right: 3px;
	text-align: center;
	font-size: 16px;
	box-shadow: 1px 1px 5px #333333;
}

.first-autoOrNot {
	cursor: pointer;
	position: absolute;
	top: 60px;
	width: 30%;
	right: 3px;
	text-align: center;
	font-size: 16px;
	box-shadow: 1px 1px 5px #333333;
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
						<div class="hh-inner" id="words-title">
							<span style="font-size: 24px; color: green;">${wt.itemName }</span>
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
						<div class="hh-inner words-opt-buttons">
							<a href="javascript:void(0)" onclick="addWord('${wt.itemName}','${learn.id}','${wt.itemNo}')" class="easyui-linkbutton" data-options="iconCls:'icon-add-self',plain:true">添加</a> <a href="javascript:void(0)" onclick="fastRead('${wt.itemName}','${learn.id}','${wt.itemNo}')" class="easyui-linkbutton" data-options="iconCls:'icon-fast-self',plain:true">速记</a>
						</div>
					</header>
					<ul class="m-list">
						<c:forEach items="${words}" var="wd">
							<c:if test="${wd.type==wt.itemNo}">
								<c:if test="${wd.type=='word'}">
									<li style="text-align: left;"><a onclick="openit(this,'${wt.itemName}')"><span class="words-text">${wd.word}</span>&nbsp;&nbsp;${wd.usPronunciation}&nbsp;&nbsp;&nbsp;&nbsp;${wd.definition}</a></li>
								</c:if>
								<c:if test="${wd.type!='word'}">
									<li style="text-align: left;"><a onclick="openit(this,'${wt.itemName}')"><span class="words-text">${wd.word}</span>&nbsp;&nbsp;${wd.usPronunciation}&nbsp;&nbsp;&nbsp;&nbsp; ${wd.definition}</a></li>
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
	<div id="fast-reading" class="easyui-navpanel" style="opacity: 0.8;">
		<header>
			<div class="m-toolbar">
				<span id="word-fast-title" class="m-title"></span>
				<div class="m-left">
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick="back1()">返回</a>
				</div>
			</div>
		</header>
		<div>
			<div id="words-type">
				<div id="first-div" class="fast-all fast-one-by-one fast-one-by-one-first">
					<div class="fast-content">
						<div id="first-word-text" class="fast-word-content"></div>
						<div>
							<div id="first-div-pro" class="div-pro">
								<div id="first-usPronunciation" class="pronunciation" style="float: left; margin-right: 15px;"></div>
								<div id="first-ukPronunciation" class="pronunciation" style="margin-right: 15px;"></div>
							</div>
							<div id="first-definition" class="definition"></div>
						</div>
					</div>
					<div class="first-sound" onclick="playSound(this)">美式发音</div>
					<div class="first-autoOrNot" onclick="playRandom(this)">顺序播放</div>
					<div class="first-total">0/0</div>
					<div class="first-opter" onclick="autoPlayStop(this)">播放</div>
				</div>
				<div id="left-div" class="fast-all fast-one-by-one-left">
					<div class="fast-content">
						<div id="left-word-text" class="fast-word-content"></div>
						<div>
							<div id="left-div-pro" class="div-pro">
								<div id="left-usPronunciation" class="pronunciation" style="float: left; margin-right: 15px;"></div>
								<div id="left-ukPronunciation" class="pronunciation" style="margin-right: 15px;"></div>
							</div>
							<div class="left-definition" class="definition"></div>
						</div>
					</div>
				</div>
				<div id="right-div" class="fast-all fast-one-by-one-right">
					<div class="fast-content">
						<div id="right-word-text" class="fast-word-content"></div>
						<div>
							<div id="right-div-pro" class="div-pro">
								<div id="right-usPronunciation" class="pronunciation" style="float: left; margin-right: 15px;"></div>
								<div id="right-ukPronunciation" class="pronunciation" style="margin-right: 15px;"></div>
							</div>
							<div class="right-definition" class="definition"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<audio id="audioVus" hidden></audio>
	<audio id="audioVuk" hidden></audio>
	<audio id="audioVFast" hidden></audio>
</body>
</html>
