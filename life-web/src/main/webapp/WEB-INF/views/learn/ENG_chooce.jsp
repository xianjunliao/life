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
	/* 	width: 100%; */
	/* 	height: 100%; */
	/* 	margin: 5px 5px 5px 5px; */
	/* 	border-radius: 5px; */
	
}

.main-divs {
	/* 	padding: 10px; */
	/* 	margin: 10px 80px 10px 140px; */
	margin-left: 50px;
}

.divs-dayLearn {
	cursor: pointer;
	width: 180px;
	height: 220px;
	background-color: #ccc;
	margin: 10px;
	float: left;
	box-shadow: 5px 5px 10px #501d1f;
	padding: 5px;
	border-radius: 5px 5px 5px 5px !important;
	background-image: url("${base}static/images/20180321_110947_3856.jpg");
	background-size: 100%;
}

.divs-dayLearn-today {
	border-radius: 5px 5px 5px 5px !important;
	box-shadow: 5px 5px 15px #b75a5e !important;
}

.dayLearn-title {
	text-align: center;
	font-size: 18px;
	font-weight: 700;
	margin: 15px;
	color: #f1f3f1;
}

.dayLearn-total {
	text-align: center;
	font-size: 12px;
	margin: 2px 5px 5px 5px;
	color: #f5bfbf;
}

.dayLearn-operate {
	text-align: center;
	margin-top: 35%;
	font-size: 12px !important;
}

.dayLearn-operate-button {
	height: 25px;
	background-color: #398da7;
	margin: 5px;
	padding: 5px;
	line-height: 20px;
	border-radius: 5px;
}

.word-input {
	border: 1px #e0bcbc solid;
	width: 280px;
	height: 25px;
	margin-top: 2px;
}

#word-add-window {
	display: none;
	/* 	width: 300px; */
	/* 	height: 85px; */
	background-color: #eac7bc;
	text-align: center;
	opacity: 0.9;
	padding: 10px;
}

.word-button {
	margin-top: 5px;
	background-color: #eadcc2;
	border-radius: 2px;
}

.maybe-hide {
	display: block;
}

.div-unSelect {
	display: none;
}

.div-select {
	border: 2px solid red !important;
	width: 220px !important;
	height: 240px !important;
}

.divs-dayLearn-select {
	/* 	border: 1px solid #DE3D3C; */
	width: 180px;
	height: 220px;
	box-shadow: 0px 0px 2px 2px red !important;
}

#word-book-window {
	display: none;
	width: 840px;
	height: 600px;
	text-align: center;
	position: absolute;
	left: 20%;
	top: 2%;
	background-image: url(${base}static/images/books2.png);
	background-size: 100%;
	background-repeat: no-repeat;
	background-position: 20px -50px;
	height: 600px;
	height: 600px;
}

.book-page1 {
	float: left;
	width: 300px;
	height: 435px;
	margin: 85px 0px 0px 5px;
	z-index: 999;
}

.book-page2 {
	float: left;
	width: 300px;
	height: 435px;
	margin: 85px 0px 0px 15px;
	z-index: 999;
}

.book-pages {
	width: 80%;
	height: 100%;
	margin-left: 130px;
	margin-top: 0px;
	/*     background-image: url(http://127.0.0.1:80/life//static/images/left-page.gif); */
	background-size: 100%;
	background-repeat: no-repeat;
	/*     display: none; */
}

#wordType {
	line-height: 25px;
	width: 60px;
	border: 1px solid #e2aaaa;
}

.book-title {
	margin: 2px;
	color: #9ea7a0;
	font-weight: 700;
	/* 	border: 1px solid red; */
}

.book-butt {
	margin: 2px;
	color: blue;
	border: 1px solid red;
	position: relative;
	text-align: left;
	top: 80%;
}

.book-content-word {
	float: none;
	width: 100%;
	height: 55%;
}

.book-content-phrase {
	float: none;
	width: 100%;
	height: 10%;
}

.book-content-sentence {
	float: none;
	width: 100%;
	text-align: left;
	height: 20%;
}

.book-content-article {
	overflow: auto;
	height: 90%;
}

.book-content {
	overflow: auto;
	height: 90%;
}

.book-word {
	float: left;
	height: 15px;
	font-size: 12px;
	margin: 2px;
	line-height: 15px;
	padding: 2px;
	color: #1f1d1d;
	/* 	border: 1px solid #e2d9d9; */
	cursor: pointer;
	text-decoration: underline;
	padding: 2px;
}

.book-word-select {
	text-align: left;
	height: 20px;
	font-size: 18px;
	margin: 5px 2px 2px 2px;
	line-height: 15px;
	padding: 2px;
	color: red;
	cursor: pointer;
	padding: 2px;
}

.book-phrase {
	float: left;
	height: 15px;
	font-size: 12px;
	margin: 2px;
	padding: 3px;
	line-height: 15px;
	color: #5a1313;
	/* 	border: 1px solid #a5a1a1; */
	cursor: pointer;
	text-decoration: underline;
}

.book-sentence {
	text-align: left;
	height: 15px;
	font-size: 12px;
	line-height: 15px;
	margin: 2px;
	padding: 3px;
	color: #5a1313;
	/* 	border: 1px solid #a5a1a1; */
	cursor: pointer;
	height: 25px;
	text-decoration: underline;
}

.book-article {
	text-align: left;
	color: #5a1313;
	line-height: 15px;
	margin: 2px;
	cursor: pointer;
	padding: 3px;
	text-decoration: underline;
}

.book-article-select {
	text-align: left;
	color: #DE3D3C;
	line-height: 15px;
	margin: 2px;
	cursor: pointer;
	padding: 3px;
	text-decoration: underline;
}

#word-fast-window {
	display: none;
	width: 320px;
	height: 415px;
	box-shadow: 10px 5px 14px 5px #bfb8b8 !important;
}

.word-interp {
	float: none;
	text-align: left;
	margin: 5px;
}

.book-play {
	text-align: center;
	margin-top: 50px;
	font-weight: 900;
	font-size: 24px;
	cursor: pointer;
}

.div-disabled {
	pointer-events: none;
	cursor: default;
	opacity: 0.6;
}

.word-pru {
	margin: 5px 25px 5px 5px;
}

.div-seting {
	left: 0px;
	position: fixed;
	top: 50%;
	transform: translateY(-50%);
	width: 40px;
}

.div-seting {
	right: 15px;
	position: fixed;
	top: 50%;
	transform: translateY(-50%);
	width: 40px;
}

.seting-botton {
	font-weight: 900;
	margin: 25px 5px 5px 5px;
	border-radius: 5px;
	box-shadow: 0px 0px 2px 2px #ccc !important;
	cursor: pointer;
	font-size: 6px;
	padding: 2px;
}

.div-fanyi {
	width: 605px;
	height: 165px;
	background-color: #f9f4f4;
	top: 30%;
	left: 35%;
	border-radius: 12px;
	box-shadow: 0px 0px 5px 5px #ccc !important;
	position: absolute;
	display: none;
}

.fanyi-text {
	margin: 5px;
	float: left;
	background-color: #eee;
}

.fanyi-to {
	margin-top: 75px;
	font-size: 14px;
	background-color: #bfb8b8;
	color: red;
}

textarea {
	font-weight: 700;
	font-family: sans-serif;
	color: maroon;
}
</style>
<script type="text/javascript">
	var bookOpen = false;
	var addOpen = false;
	var fastOpen = false;
	var todayLearnId;
	$(function() {
		initDays(null);
		$("#wordType").change(function() {
			var v = $("#wordType").val();
			if (v == 'article') {
				setDivCenter("#word-add-window", "15%");
				$("#div-value").html('<textarea id="word" name="word" rows="22" cols="50"></textarea>');
			} else {
				setDivCenter("#word-add-window", "32%");
				$("#div-value").html('<input class="word-input" type="text" id="word" name="word" />');
			}
			$("#word").focus();
		});
	});
	function initDays(v) {
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}learn/getDays',
			success : function(result) {
				if (result.code == 200) {
					var days = result.data;
					todayLearnId = days[0].id;
					for (var i = 0; i < days.length; i++) {
						var id = days[i].id;
						var headline = days[i].headline;
						var wordSum = days[i].wordSum;
						var phraseSum = days[i].phraseSum;
						var sentenceSum = days[i].sentenceSum;
						var articleSum = days[i].articleSum;
						var count = wordSum + phraseSum;
						var divClass = "divs-dayLearn maybe-hide";
						var opt = '<a id="wordFast' + id + '" class="dayLearn-operate-button"  onClick="wordFast(' + id + ',' + count + ')">词汇速记</a> <a id="wordAdd' + id + '" class="dayLearn-operate-button" onClick="wordAdd(' + id + ')">新增</a> <a id="query' + id + '" class="dayLearn-operate-button" onClick="openDetails(' + id + ')">详情</a>';
						if (v != null && v == id) {
							divClass += " div-select";
						}
						if (v != null && v != id) {
							divClass += " div-unSelect";
						}
						if (i == 0) {
							divClass += " divs-dayLearn-today";
						}
						var div1 = '<div id="' + id + '" class="' + divClass + '"  onmouseover="dayKearnSelect(' + id + ')"  onmouseout="dayKearnUnSelect(' + id + ')">';
						var div2 = '<div class="dayLearn-title">' + headline + '</div><div class="dayLearn-total">单词:<b>' + wordSum + ' 个</b><div class="dayLearn-total">词组:<b>' + phraseSum + ' 个</b></div>';
						var div2a = '<div class="dayLearn-total">句子:<b>' + sentenceSum + ' 个</b></div><div class="dayLearn-total">文章:<b>' + articleSum + ' 篇</b></div>';
						var div3 = '<div class="dayLearn-operate">' + opt + '</div></div>';
						$('.main-divs').append(div1 + div2 + div2a + div3);

					}
					if (v == null) {
						$(".maybe-hide").hide();
						$(".maybe-hide").show(600);
					}
				}
			}
		});
	}
	function wordFast(id, num) {
		if (num == 0) {
			alert('请先添加单词！');
			return;
		}
		var isShow = $("#wordFast" + id).text();
		if (isShow == '关闭窗口') {
			$("#word-fast-window").hide();
			$("#word-fast-window").empty();
			closeAdd();
		} else {
			$("#wordAdd" + id).hide();
			$("#query" + id).hide();
			$("#wordFast" + id).text('关闭窗口')
			$("#" + id).removeClass("maybe-hide");
			$("#" + id).addClass("div-select");
			$(".maybe-hide").hide(300);
			$(".div-select").show();
			setDivCenter("#word-fast-window", "12%");
			$("#word-fast-window").html('<iframe width="100%" height="100%" frameborder="0" src="${base}learn/wordFast?id=' + id + '"></iframe>');
			$("#word-fast-window").show(1000);
			fastOpen = true;
		}
	}
	function wordAdd(id) {
		if (bookOpen) {
			return;
		}
		var isShow = $("#wordAdd" + id).text();
		if (isShow == '关闭窗口') {
			// 			$("#word-add-window").hide();
			closeAdd();
		} else {
			addOpen = true;
			$("#query" + id).hide();
			$("#wordFast" + id).hide();
			$("#wordAdd" + id).text("关闭窗口");
			dayKearnUnSelect(id);
			$("#" + id).removeClass("maybe-hide");
			$("#" + id).addClass("div-select");
			$(".maybe-hide").hide(300);
			$("#word-add-window").show();
			$("#word").val(null);
			$("#word").focus();
			$(".div-select").show();
			$("#learnId").val(id);
			setDivCenter("#word-add-window", "32%");
		}
	}

	function setDivCenter(divName, top) {
		$(divName).css({
			position : 'absolute',
			'top' : top,
			left : '30%'
		}).show();
	}
	function confrimAdd(v) {
		var timeClass = $("#learnId").val();
		var text = $("#word").val();
		var wordType = $("#wordType").val();
		if (text == null || text == '') {
			$.messager.alert("提示", "请输入需添加的单词！");
			return;
		}
		$.messager.progress({
			title : '请稍等',
			msg : '正在新增...'
		});
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}learn/addLearn?word=' + text + "&wordType=" + wordType + "&timeClass=" + timeClass,
			success : function(result) {
				$.messager.progress('close');
				if (result.code == 200) {
					if (v == 0) {
						$('.divs-dayLearn').remove();
						initDays(timeClass);
						$("#word").val(null);
					} else {
						closeAdd();
					}
				} else {
					$.messager.alert("错误", "新增失败！", "woring");
				}
			}
		});

	}
	function closeAdd() {
		$(".maybe-hide").show(200);
		$("#word-add-window").hide();
		$('.divs-dayLearn').remove();
		$("#div-value").html('<input class="word-input" type="text" id="word" name="word" />');
		$("#wordType").val('word');
		initDays(null);
		bookOpen = false;
		addOpen = false;
		fastOpen = false;
		clearBookContent();

	}
	function dayKearnSelect(id) {
		if (bookOpen) {
			return;
		}
		if (addOpen) {
			return;
		}
		if (fastOpen) {
			return;
		}
		$("#" + id).addClass("divs-dayLearn-select");

	}
	function dayKearnUnSelect(id) {
		if (bookOpen) {
			return;
		}
		if (addOpen) {
			return;
		}
		if (fastOpen) {
			return;
		}
		$("#" + id).removeClass("divs-dayLearn-select");
	}

	function openDetails(id) {
		var isShow = $("#word-book-window").css("display");
		if (isShow == 'none') {
			var idd = id;
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : '${base}learn/getWords?id=' + idd,
				success : function(result) {
					if (result.code == 200) {
						var words = result.data;
						var a = 1;
						if (words.length > 0) {
							bookOpen = true;
							clearBookContent();
							$("#query" + idd).text("关闭窗口");
							$("#wordFast" + idd).hide();
							$("#wordAdd" + idd).hide();
							$("#" + idd).removeClass("maybe-hide");
							$("#" + idd).addClass("div-select");
							$(".maybe-hide").hide(300);
							$(".div-select").show();
							$("#word-book-window").show(100);
							for (var i = 0; i < words.length; i++) {
								var id = words[i].id;
								var type = words[i].type;
								var word = words[i].word;
								var mp3url = words[i].mp3url;
								if (type == 'word') {
									var usAudio = words[i].usAudio;
									var ukAudio = words[i].ukAudio;
									var usPronunciation = words[i].usPronunciation;
									var ukPronunciation = words[i].ukPronunciation;
									usPronunciation = replace(usPronunciation, "[", "BBB");
									usPronunciation = replace(usPronunciation, "]", "CCC");
									usPronunciation = replace(usPronunciation, "'", "AAA");
									ukPronunciation = replace(ukPronunciation, "[", "BBB");
									ukPronunciation = replace(ukPronunciation, "]", "CCC");
									ukPronunciation = replace(ukPronunciation, "'", "AAA");
									var div1 = '<div id=' + id + ' onclick="wordQuery(' + id + ',\'' + usAudio + '\',\'' + usPronunciation + '\',\'' + ukPronunciation + '\')" class="book-word">' + word + '</div>';
									$(".book-content-word").append(div1);
								} else if (type == 'phrase') {
									var div1 = '<div id=' + id + ' onclick="phraseQuery(' + id + ',\'' + mp3url + '\')" class="book-phrase">' + word + '</div>';
									$(".book-content-phrase").append(div1);
								} else if (type == 'sentence') {
									var div1 = '<div id=' + id + ' onclick="sentenceQuery(' + id + ',\'' + mp3url + '\')" class="book-sentence">' + word + '</div>';
									$(".book-content-sentence").append(div1);
								} else {
									var div1 = '<div id=' + id + ' onclick="articleQuery(' + id + ',\'' + mp3url + '\')" class="book-article">' + a + '. ' + word + '</div>';
									$(".book-content-article").append(div1);
									a++;

								}
							}
						} else {
							alert("请添加单词或其他内容！");
						}
					} else {

					}
				}
			});
		} else {
			$("#word-book-window").hide(100);
			closeAdd();
		}
	}

	function wordQuery(id, url, usPronunciation, ukPronunciation) {
		var cl = $("#" + id).attr("class");
		if (cl == 'book-word') {
			usPronunciation = replace(usPronunciation, "BBB", "[");
			usPronunciation = replace(usPronunciation, "CCC", "]");
			usPronunciation = replace(usPronunciation, "AAA", "'");
			ukPronunciation = replace(ukPronunciation, "BBB", "[");
			ukPronunciation = replace(ukPronunciation, "CCC", "]");
			ukPronunciation = replace(ukPronunciation, "AAA", "'");
			$(".book-word").hide();
			$(".book-content-phrase").hide();
			$(".book-content-sentence").hide();
			$("#" + id).show(300);
			$(".word-interp").remove();
			$(".book-content-article").addClass("div-disabled");
			$(".book-content-word").append("<span class='word-pru'>美:" + usPronunciation + "</span>   <span class='word-pru'>英:" + ukPronunciation + "</span>")
			$("#" + id).removeClass("book-word").addClass("book-word-select");
			getIniterp(id, "book-content-word");
			pauseAutio();
			playAutio(url);
		} else {
			$(".book-word").show(300);
			$(".book-content-phrase").show(300);
			$(".book-content-sentence").show(300);
			$("#" + id).removeClass("book-word-select").addClass("book-word");
			$(".word-pru").remove();
			$(".word-interp").remove();
			$(".book-play").hide();

			pauseAutio();
			$(".book-content-article").removeClass("div-disabled");

		}
	}

	function phraseQuery(id, url) {
		var cl = $("#" + id).attr("class");
		if (cl == 'book-phrase') {
			$(".book-content-word").hide();
			$(".book-phrase").hide();
			$(".book-content-sentence").hide();
			$("#" + id).show(300);
			$(".word-interp").remove();
			$(".book-content-article").addClass("div-disabled");
			$("#" + id).removeClass("book-phrase").addClass("book-word-select");
			getIniterp(id, "book-content-phrase");

			pauseAutio();
			playAutio(url);
		} else {
			$(".book-phrase").show(300);
			$(".book-content-word").show(300);
			$(".book-content-sentence").show(300);
			$("#" + id).removeClass("book-word-select").addClass("book-phrase");
			$(".word-interp").remove();
			$(".book-play").hide();
			pauseAutio();
			$(".book-content-article").removeClass("div-disabled");

		}
	}

	function sentenceQuery(id, url) {
		var cl = $("#" + id).attr("class");
		if (cl == 'book-sentence') {
			$(".book-content-word").hide();
			$(".book-content-phrase").hide();
			$(".book-sentence").hide();
			$(".word-interp").remove();
			$("#" + id).show(300);
			$("#" + id).removeClass("book-sentence").addClass("book-word-select");
			$(".book-content-article").addClass("div-disabled");
			getIniterp(id, "book-content-sentence");
			pauseAutio();
			playAutio(url);
		} else {
			$(".book-sentence").show(300);
			$(".book-content-word").show(300);
			$(".book-content-phrase").show(300);
			$("#" + id).removeClass("book-word-select").addClass("book-sentence");
			$(".word-interp").remove();
			$(".book-play").hide();
			pauseAutio();
			$(".book-content-article").show();
			$(".book-content-article").removeClass("div-disabled");
		}
	}

	function articleQuery(id, url) {
		var cl = $("#" + id).attr("class");
		if (cl == 'book-article') {
			$(".book-article").hide();
			$(".book-content").addClass("div-disabled");
			$(".word-interp").remove();
			$("#" + id).show(300);
			$("#" + id).removeClass("book-article").addClass("book-article-select");
			getIniterp(id, "book-content-article");
			pauseAutio();
			playAutio(url);
		} else {
			$(".book-article").show(300);
			$("#" + id).removeClass("book-article-select").addClass("book-article");
			$(".word-interp").remove();
			$(".book-play").hide();
			pauseAutio();
			$(".book-content").removeClass("div-disabled");
		}
	}
	function getIniterp(id, cl) {
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}learn/getInts?id=' + id,
			success : function(result) {
				if (result.code == 200) {
					var ints = result.data;
					for (var i = 0; i < ints.length; i++) {
						var wordtype = ints[i].wordtype;
						if (wordtype == null || "" == wordtype) {
							wordtype = (i + 1) + ".";
						}
						var wordinterpretation = ints[i].wordinterpretation;
						$("." + cl).append("<div class='word-interp'>" + wordtype + wordinterpretation + "</div>");
					}
					$("." + cl).append("<div onclick='playWord(this)' class='book-play'>暂停<div>");
				} else {

				}
			}
		});
	}
	function playWord(obj) {
		var txt = $(obj).text();
		var url = $("#playEnglish").attr("src");
		if (txt == '播放') {
			playAutio(url);
		} else {
			pauseAutio();
		}
		console.log(txt);
	}
	function playAutio(url) {
		var music = document.getElementById('playEnglish');
		$("#playEnglish").attr("src", url);
		music.play();
		$(".book-play").text("暂停");
		music.loop = false;
		music.addEventListener('ended', function() {
			$(".book-play").text("播放");
		}, false);
	}

	function pauseAutio() {
		var music = document.getElementById('playEnglish');
		music.pause();
		$(".book-play").text("播放");
	}

	function clearBookContent() {
		$(".book-content-phrase").empty();
		$(".book-content-sentence").empty();
		$(".book-content-word").empty();
		$(".book-content-article").empty();
		$(".book-content-phrase").show();
		$(".book-content-sentence").show();
		$(".book-content-word").show();
		$(".book-content-article").show();
		$(".book-content-article").removeClass("div-disabled");
		$(".book-content").removeClass("div-disabled");
		$(".word-pru").remove();
	}
	function replace(fullStr, oldStr, newStr) {
		if (fullStr.indexOf(oldStr) >= 0) {
			fullStr.replace(oldStr, newStr);
		}
		return fullStr;
	}
	function fanyiTo() {
		var obj = $("#fanyi-word").val();
		var type = "bdc";
		if (obj == null || obj == "") {
			$("#fanyi-result").val(null);
			$("#fanyi-result").attr("placeholder", "请输入需要翻译的内容。。。");
		} else {
			$("#fanyi-result").attr("placeholder", "正在获取翻译结果。。。。。。");
			type = $(".fanyi-to").text();
			getFanyiResult(type, obj);
		}
	}
	function getFanyiResult(type, text) {

		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}learn/translate?type=' + type + '&text=' + text,
			success : function(result) {
				if (result.code == 200) {
					var obj = $("#fanyi-word").val();
					if (obj != null || obj != "") {
						$("#fanyi-result").val(result.data);
					}
				}
			}
		});
	}

	function openFanyi(type) {
		$("#fanyi-result").val(null);
		$("#fanyi-word").val(null);
		$(".fanyi-to").text(type);
		$(".div-fanyi").hide(300);
		$(".div-fanyi").show(100);
		$(".main-divs").hide(800);
		$("#fanyi-word").focus();
	}
	function closeFanyi() {
		$(".main-divs").show(800);
		$(".div-fanyi").hide(300);
	}
</script>
</head>
<body>
	<div class="main-divs"></div>
	<div id="word-add-window">
		<div>
			<select id="wordType" name="wordType">
				<option value="word" selected="selected">单词</option>
				<option value="phrase">词组</option>
				<option value="sentence">句子</option>
				<option value="article">文章</option>
			</select> <br>
			<div id="div-value">
				<input class="word-input" type="text" id="word" name="word" />
			</div>
		</div>
		<div class="word-add-buttons">
			<input type="hidden" id="learnId"> <input class="word-button" type="button" id="word-button" name="word-button" value="新增" onclick="confrimAdd(0)" /> <input type="hidden" id="learnId"> <input class="word-button" type="button" id="word-button" name="word-button" value="新增后关闭" onclick="confrimAdd(1)" /> <input class="word-button" type="button" id="close-button"
				name="word-button" value="关闭" onclick="closeAdd()" />
		</div>
	</div>
	<div id="word-book-window">
		<div class="book-pages">
			<div class="book-page1">
				<div class="book-title">单词、词组、句子</div>
				<div class="book-content">
					<div class="book-content-word"></div>
					<br>
					<div class="book-content-phrase"></div>
					<br>
					<div class="book-content-sentence"></div>
				</div>
				<!-- 				<div class="book-butt">上一页</div> -->
			</div>
			<div class="book-page2">
				<div class="book-title">美文欣赏</div>
				<div class="book-content-article"></div>
				<!-- 				<div class="book-butt">下一页</div> -->
			</div>
		</div>
	</div>
	<div id="word-fast-window"></div>
	<audio id="playEnglish" hidden>
		<source type="audio/mpeg">
	</audio>
	<div class="div-seting">
		<div class="seting-botton" onclick="openFanyi('CN')">英译</div>
		<div class="seting-botton" onclick="openFanyi('EN')">汉译</div>
		<div class="seting-botton" onclick="openFanyi('SB')">扇贝单词</div>
		<div class="seting-botton" onclick="closeFanyi()">关闭</div>
	</div>
	<div class="div-fanyi">
		<div class="fanyi-text">
			<textarea oninput="fanyiTo()" onchange="fanyiTo()" style="resize: none" id="fanyi-word" placeholder="请输入需要翻译的内容..." contenteditable="false" name="fanyi-word" rows="8" cols="32"></textarea>
		</div>
		<div class="fanyi-text fanyi-to">CN</div>
		<div class="fanyi-text ">
			<textarea style="resize: none" id="fanyi-result" readonly="readonly" name="fanyi-result" rows="8" cols="32"></textarea>
		</div>
	</div>
</body>
</html>
