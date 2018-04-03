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
	margin: 50px 5px 5px 5px;
	color: #f5bfbf;
}

.dayLearn-operate {
	text-align: center;
	margin-top: 45%;
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
}

#word-add-window {
	display: none;
	width: 300px;
	height: 80px;
	background-color: #eac7bc;
	text-align: center;
	opacity: 0.9;
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
	border: 2px solid red;
	width: 220px;
	height: 260px;
}

.divs-dayLearn-select {
	border: 2px solid #DE3D3C;
	box-shadow: 0px 0px 2px 2px #DE3D3C !important;
}

#word-book-window {
	display: none;
	width: 60%;
	height: 90%;
	text-align: center;
	position: absolute;
	left: 20%;
	top: 2%;
	background-image:
		url(http://127.0.0.1:80/life//static/images/books2.png);
	background-size: 100%;
	background-repeat: no-repeat;
	background-position: 20px -50px;
}

.book-page1 {
	float: left;
	width: 48%;
	height: 72%;
	margin: 85px 0px 0px 10px;
	background-color: #d6f5d8;
	z-index: 999;
}

.book-page2 {
	float: left;
	width: 48%;
	height: 72%;
	margin: 85px 0px 0px 10px;
	background-color: #d6f5d8;
	z-index: 999;
}

.book-pages {
	width: 73%;
	height: 106%;
	margin-left: 130px;
	margin-top: 0px;
	/*     background-image: url(http://127.0.0.1:80/life//static/images/left-page.gif); */
	background-size: 100%;
	background-repeat: no-repeat;
	/*     display: none; */
}
</style>
<script type="text/javascript">
	$(function() {
		initDays(null);
	});
	function initDays(v) {
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}learn/getDays',
			success : function(result) {
				if (result.code == 200) {
					var days = result.data;
					for (var i = 0; i < days.length; i++) {
						var id = days[i].id;
						var headline = days[i].headline;
						var wordsSum = days[i].wordsSum;
						var divClass = "divs-dayLearn maybe-hide";
						var opt = '<a class="dayLearn-operate-button"  onClick="wordFast(' + id + ',' + wordsSum + ')">单词速记</a> <a class="dayLearn-operate-button" onClick="wordAdd(' + id + ')">新增</a> <a id="query'+id+'" class="dayLearn-operate-button" onClick="openDetails(' + id + ')">查看</a>';
						if (v != null && v == id) {
							divClass += " div-select";
						}
						if (v != null && v != id) {
							divClass += " div-unSelect";
						}
						if (i == 0) {
							divClass += " divs-dayLearn-today";
						}
						$('.main-divs').append(
								'<div id="' + id + '" class="' + divClass + '" ondblclick="openDetails(' + id + ')" onmouseover="dayKearnSelect(' + id + ')"  onmouseout="dayKearnUnSelect(' + id + ')"><div class="dayLearn-title">' + headline + '</div><div class="dayLearn-total">词汇量：<b>' + wordsSum + '</b></div><div class="dayLearn-operate">' + opt + '</div></div>');

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
			$.messager.alert('提示', '请先添加单词！');
			return;
		}
		$("#" + id).removeClass("maybe-hide");
		$("#" + id).addClass("div-select");
		$(".maybe-hide").hide(300);
		$(".div-select").show();
		layer.open({
			type : 2,
			anim : 3,
			title : '单词速记',
			area : [ '320px', '460px' ],
			shade : [ 0.3, '#393D49' ],
			content : '${base}learn/wordFast?id=' + id,
			zIndex : layer.zIndex,
			success : function(layero) {
				layer.setTop(layero);
			},
			cancel : function() {
				closeAdd();
				dayKearnUnSelect(id);
			}
		});
	}
	function wordAdd(id) {
		dayKearnUnSelect(id);
		$("#" + id).removeClass("maybe-hide");
		$("#" + id).addClass("div-select");
		$(".maybe-hide").hide(300);
		$("#word-add-window").show();
		$("#word").val(null);
		$("#word").focus();
		$(".div-select").show();
		$("#learnId").val(id);
		setDivCenter("#word-add-window");
	}

	function setDivCenter(divName) {
		var top = ($(window).height() - $(divName).height()) / 2;
		var left = ($(window).width() - $(divName).width()) / 2;
		var scrollTop = $(document).scrollTop();
		var scrollLeft = $(document).scrollLeft();
		$(divName).css({
			position : 'absolute',
			'top' : '40%',
			left : '30%'
		}).show();
	}
	function confrimAdd(v) {
		var timeClass = $("#learnId").val();
		var text = $("#word").val();
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
			url : '${base}learn/addLearn?word=' + text + "&wordType=word" + "&timeClass=" + timeClass,
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
		initDays(null);
	}
	function dayKearnSelect(id) {
		$("#" + id).addClass("divs-dayLearn-select");

	}
	function dayKearnUnSelect(id) {
		$("#" + id).removeClass("divs-dayLearn-select");
	}

	function openDetails(id) {
		var isShow = $("#word-book-window").css("display");
		if (isShow == 'none') {
			$("#query"+id).text("关闭");
			$("#" + id).removeClass("maybe-hide");
			$("#" + id).addClass("div-select");
			$(".maybe-hide").hide(300);
			$(".div-select").show();
			$("#word-book-window").show();
		} else {
			$("#word-book-window").hide();
			closeAdd();
		}
	}
</script>
</head>
<body>
	<div class="main-divs"></div>
	<div id="word-add-window">
		<div>
			单词：<input class="word-input" type="text" id="word" name="word" />
		</div>
		<div class="word-add-buttons">
			<input type="hidden" id="learnId"> <input class="word-button" type="button" id="word-button" name="word-button" value="新增" onclick="confrimAdd(0)" /> <input type="hidden" id="learnId"> <input class="word-button" type="button" id="word-button" name="word-button" value="新增后关闭" onclick="confrimAdd(1)" /> <input class="word-button" type="button" id="close-button"
				name="word-button" value="关闭" onclick="closeAdd()" />
		</div>
	</div>
	<div id="word-book-window">
		<div class="book-pages">
			<div class="book-page1"></div>
			<div class="book-page2"></div>
		</div>
	</div>
</body>
</html>
