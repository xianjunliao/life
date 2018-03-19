<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript">
	var wordSize = 0;
	var maxSize = '${words.size()}';
	var time;
	var isOrder = true;//是否顺序播放
	var isUs = true;
	$(function() {

		playAutio('${words.get(0).usAudio}');
		$("#this_url").text('${words.get(0).usAudio}');
		time = setInterval('rightGo()', 3000);

	});

	function leftGo() {
		if (wordSize < 0) {
			return;
		}
		if (!isOrder) {
			wordSize = randomPlay();
		} else {
			wordSize = orderPlay();
		}
		wordSize--;
		$(".wordDivs").hide();
		$("#div5").hide();
		$("#div5").css("left", "-200px");
		var d = $("#div3").css("display");
		var word = $("#word" + wordSize).text();//获取单词
		var pronunciation = $("#pronunciation" + wordSize).html();//获取音标
		var definition = $("#definition" + wordSize).html();//获取释义
		var url = $("#url" + wordSize).text();
		if (isUs) {
			var url = $("#usUrl" + wordSize).text();//获取语音地址
		} else {
			url = $("#ukUrl" + wordSize).text();
		}
		$("#this_url").text(url);
		if (word == null || word == '') {
			wordSize = (maxSize - 1);
			word = $("#word" + wordSize).text();
			pronunciation = $("#pronunciation" + wordSize).html();
			definition = $("#definition" + wordSize).html();
			if (isUs) {
				var url = $("#usUrl" + wordSize).text();//获取语音地址
			} else {
				url = $("#ukUrl" + wordSize).text();
			}
		}
		if (d == 'block') {
			$("#div3").hide();
			$("#div3").css("left", "+415px");

			$("#div2word").text(word);
			$("#div2pronunciation").html(pronunciation);
			$("#div2definition").html(definition);
			$("#div2total").html('<b>' + (wordSize + 1) + '</b>/' + maxSize + '');
			playAutio(url);

			$("#div2").show();
			$("#div2").animate({
				left : '+32px'
			}, 500);
		} else {
			$("#div2").hide();
			$("#div2").css("left", "+415px");

			$("#div3word").text(word);
			$("#div3pronunciation").html(pronunciation);
			$("#div3definition").html(definition);
			$("#div3total").html('<b>' + (wordSize + 1) + '</b>/' + maxSize + '');
			playAutio(url);

			$("#div3").show();
			$("#div3").animate({
				left : '+32px'
			}, 500);
		}
	}
	function rightGo() {
		if (wordSize >= maxSize) {
			return;
		}
		if (!isOrder) {
			wordSize = randomPlay();
		} else {
			wordSize = orderPlay();
		}
		wordSize++;
		$(".wordDivs").hide();
		$("#div3").hide();
		$("#div3").css("left", "+415px");
		var word = $("#word" + (wordSize)).text();//获取单词
		var pronunciation = $("#pronunciation" + wordSize).html();//获音标
		var definition = $("#definition" + wordSize).html();//获释义
		var url = $("#url" + wordSize).text();
		if (isUs) {
			var url = $("#usUrl" + wordSize).text();//获取语音地址
		} else {
			url = $("#ukUrl" + wordSize).text();
		}
		$("#this_url").text(url);
		if (word == null || word == '') {
			wordSize = 0;
			word = $("#word" + wordSize).text();
			pronunciation = $("#pronunciation" + wordSize).html();
			definition = $("#definition" + wordSize).html();
			if (isUs) {
				var url = $("#usUrl" + wordSize).text();//获取语音地址
			} else {
				url = $("#ukUrl" + wordSize).text();
			}
		}
		var d = $("#div5").css("display");
		if (d == 'block') {
			$("#div5").hide();
			$("#div5").css("left", "-200px");

			$("#div4word").text(word);
			$("#div4pronunciation").html(pronunciation);
			$("#div4definition").html(definition);
			$("#div4total").html('<b>' + (wordSize + 1) + '</b>/' + maxSize + '');
			playAutio(url);

			$("#div4").show();
			$("#div4").animate({
				left : '32px'
			}, 500);
		} else {
			$("#div4").hide();
			$("#div4").css("left", "-200px");

			$("#div5word").text(word);
			$("#div5pronunciation").html(pronunciation);
			$("#div5definition").html(definition);
			$("#div5total").html('<b>' + (wordSize + 1) + '</b>/' + maxSize + '');
			playAutio(url);

			$("#div5").show();
			$("#div5").animate({
				left : '32px'
			}, 500);
		}
	}

	function playAutio(url) {
		$(".play-show").hide();
		$(".play-hide").show();
		isClick = true;
		var music = document.getElementById('playEnglish');
		$("#playEnglish").attr("src", url);
		music.play();
		music.loop = false;
		music.addEventListener('ended', function() {
			$(".play-show").show();
			$(".play-hide").hide();
			isClick = false;
		}, false);
	}

	function playThis() {
		var thisUrl = $("#this_url").text();
		playAutio(thisUrl);
	}
	function autoPlayOn() {
		$(".auto-paly-show").hide();
		$(".auto-paly-hide").show();
		clearInterval(time);
	}
	function autoPlayOff() {
		$(".auto-paly-show").show();
		$(".auto-paly-hide").hide();
		time = setInterval("rightGo()", 3000);
	}

	function randomPlay() {
		isOrder = false;
		$(".random-paly-show").hide();
		$(".random-paly-hide").show();
		var x = maxSize;
		var y = 0;
		var rand = parseInt(Math.random() * (x - y + 1) + y);
		return rand;
	}
	function orderPlay() {
		isOrder = true;
		$(".random-paly-show").show();
		$(".random-paly-hide").hide();
		return wordSize;
	}

	function usPlay() {
		$(".us-paly-show").hide();
		$(".uk-paly-hide").show();
		isUs = false;

	}

	function ukPlay() {
		$(".uk-paly-show").hide();
		$(".us-paly-hide").show();
		isUs = true;
	}
</script>
<style type="text/css">
#div2 {
	border-radius: 5px;
	width: 255px;
	height: 350px;
	float: left;
	position: absolute;
	right: -250px;
	z-index: 1;
	display: none;
	margin-top: 10px;
	-moz-box-shadow: 2px 2px 20px #333333;
	-webkit-box-shadow: 2px 2px 20px #333333;
	box-shadow: 2px 2px 20px #333333;
	background-color: #ffffff;
}

#div4 {
	border-radius: 5px;
	width: 255px;
	height: 350px;
	float: left;
	position: absolute;
	left: -250px;
	z-index: 1;
	display: none;
	background-color: #ffffff;
	margin-top: 10px;
	-moz-box-shadow: 2px 2px 20px #333333;
	-webkit-box-shadow: 2px 2px 20px #333333;
	box-shadow: 2px 2px 20px #333333;
}

#div5 {
	border-radius: 5px;
	width: 255px;
	height: 350px;
	float: left;
	position: absolute;
	left: -265px;
	z-index: 1;
	-moz-box-shadow: 2px 2px 20px #333333;
	background-color: #ffffff;
	-webkit-box-shadow: 2px 2px 20px #333333;
	box-shadow: 2px 2px 20px #333333;
	margin-top: 10px;
}

#div3 {
	border-radius: 5px;
	width: 255px;
	height: 350px;
	float: left;
	position: absolute;
	left: 32px;
	background-color: #ffffff;
	z-index: 1;
	-moz-box-shadow: 2px 2px 20px #333333;
	-webkit-box-shadow: 2px 2px 20px #333333;
	box-shadow: 2px 2px 20px #333333;
	margin-top: 10px;
}

.wordShow {
	width: 255px;
	height: 50px;
	text-align: center;
	font-size: 24px;
	margin: 50px 2px 2px 2px;
	font-weight: bold;
	line-height: 50px;
}

.pronunciationShow {
	width: 190px;
	height: 40px;
	text-align: left;
	font-size: 12px;
	margin: 10px 40px 10px 35px;
}

.definitionShow {
	width: 190px;
	height: auto;
	text-align: left;
	font-size: 14px;
	margin: 10px 40px 10px 35px;
}

.totalShow {
	width: 255px;
	height: 20px;
	text-align: center;
	position: absolute;
	bottom: 10px;
}
</style>

</head>
<body style="width: 320px; height: 415px; overflow: hidden; background-color: #F3F3F3;">
	<div>
		<div class="wordDivs" id="div2">
			<div id="div2word" class="wordShow"></div>
			<div id="div2pronunciation" class="pronunciationShow"></div>
			<div id="div2definition" class="definitionShow"></div>
			<div id="div2total" class="totalShow"></div>
		</div>
		<div id="div3">
			<div id="div3word" class="wordShow">${words.get(0).word}</div>
			<div id="div3pronunciation" class="pronunciationShow">
				<c:if test="${words.get(0).type=='word' }">
					<div style="float: left;">美：${words.get(0).usPronunciation}</div>
					<div style="float: right;">英：${words.get(0).ukPronunciation}</div>
				</c:if>
			</div>
			<div id="div3definition" class="definitionShow">${words.get(0).definition}</div>
			<div id="div3total" class="totalShow">
				<b>1</b>/${words.size()}
			</div>
		</div>

		<div class="wordDivs" id="div4">
			<div id="div4word" class="wordShow"></div>
			<div id="div4pronunciation" class="pronunciationShow"></div>
			<div id="div4definition" class="definitionShow"></div>
			<div id="div4total" class="totalShow"></div>
		</div>
		<div id="div5">
			<div id="div5word" class="wordShow">${words.get(0).word}</div>
			<div id="div5pronunciation" class="pronunciationShow">
				<c:if test="${words.get(0).type=='word' }">
					<div style="float: left;">美：${words.get(0).usPronunciation}</div>
					<div style="float: right;">英：${words.get(0).ukPronunciation}</div>
				</c:if>
			</div>
			<div id="div5definition" class="definitionShow">${words.get(0).definition}</div>
			<div id="div5total" class="totalShow">1/${words.size()}</div>
		</div>
	</div>
	<div style="width: 180px; height: 35px; position: absolute; bottom: 10px; border-radius: 20px; left: 66px; background-color: white;" align="center">
		<i title="自动播放" onclick="autoPlayOn()" class="layui-icon auto-paly-show" style="font-size: 35px; color: #333; cursor: pointer; position: absolute; top: 0px; left: 185px;">&#xe645;</i> <i title="手动播放" onclick="autoPlayOff()" class="layui-icon auto-paly-hide" style="font-size: 35px; color: red; cursor: pointer; display: none; position: absolute; top: 0px; left: 185px;">&#xe645;</i> <i title="顺序播放"
			onclick="randomPlay()" class="layui-icon random-paly-show" style="font-size: 18px; color: #333; cursor: pointer; position: absolute; top: 1px; left: -30px;">&#x1002;</i> <i title="随机播放" onclick="orderPlay()" class="layui-icon random-paly-hide" style="font-size: 18px; color: red; cursor: pointer; display: none; position: absolute; top: 1px; left: -30px;">&#x1002;</i> <i title="美式发音"
			onclick="usPlay()" class="layui-icon us-paly-show" style="font-size: 12px; color: #333; cursor: pointer; position: absolute; top: 20px; left: -28px;">美</i> <i title="英式发音" onclick="ukPlay()" class="layui-icon uk-paly-hide" style="font-size: 12px; color: #333; cursor: pointer; display: none; position: absolute; top: 20px; left: -28px;">英</i> <i onclick="leftGo()" class="layui-icon"
			style="font-size: 20px; color: #1E9FFF; cursor: pointer; margin-right: 25px; position: absolute; top: 8px; left: 15px;">&#xe603;</i> <i class="layui-icon play-show" style="font-size: 35px; color: #333; cursor: pointer;" onclick="playThis()">&#xe652;</i> <i class="layui-icon play-hide" style="font-size: 35px; color: #333; cursor: pointer; display: none;">&#xe651;</i> <i onclick="rightGo()"
			class="layui-icon" style="font-size: 20px; color: #1E9FFF; cursor: pointer; margin-left: 25px; position: absolute; top: 8px; left: 120px;">&#xe602;</i>
	</div>

	<c:forEach var="wd" varStatus="wdindex" items="${words}">
		<div id="word${wdindex.index}" style="display: none;">${wd.word}</div>
		<div id="url${wdindex.index}" style="display: none;">${wd.mp3url}</div>
		<div id="usUrl${wdindex.index}" style="display: none;">
			<c:if test="${wd.type=='word' }">${wd.usAudio}</c:if>
			<c:if test="${wd.type!='word' }">${wd.mp3url}</c:if>
		</div>
		<div id="ukUrl${wdindex.index}" style="display: none;">
			<c:if test="${wd.type=='word' }">${wd.ukAudio}</c:if>
			<c:if test="${wd.type!='word' }">${wd.mp3url}</c:if>
		</div>
		<div id="definition${wdindex.index}" style="display: none;">${wd.definition}</div>
		<div id="pronunciation${wdindex.index}" style="display: none;">
			<c:if test="${wd.type=='word' }">
				<div style="float: left;">美：${wd.usPronunciation}</div>
				<div style="float: right;">英：${wd.ukPronunciation}</div>
			</c:if>
		</div>
	</c:forEach>
	<div style="display: none;">
		<audio id="playEnglish" hidden> <source type="audio/mpeg"></audio>
		<span id="this_url" style="display: none;"></span>
	</div>

</body>
</html>