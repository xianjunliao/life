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
.title_ {
	margin-top: 30%;
	width: 140px;
	height: 90%;
}

.title_home {
	width: 100px;
	height: 100px;
	margin: 20px 20px 20px 20px;
	background-color: gray;
	text-align: center;
	line-height: 100px;
	border-radius: 50%;
	cursor: pointer;
	font-size: 16px;
}

.title_over {
	width: 100px;
	height: 100px;
	margin: 20px 20px 20px 20px;
	background-color: green;
	text-align: center;
	line-height: 100px;
	border-radius: 10%;
	cursor: pointer;
	font-size: 22px;
}

.title_this {
	width: 100px;
	height: 100px;
	margin: 20px 20px 20px 20px;
	background-color: #7cd495;
	text-align: center;
	line-height: 100px;
	border-radius: 10%;
	cursor: pointer;
	font-size: 22px;
}
</style>
<script type="text/javascript">
	$(function() {
		$(".title_home").hover(function() {
			$(this).addClass("title_over");
		}, function() {
			$(this).removeClass("title_over");
		});

		$(".title_home").click(function() {
			$('.title_home').removeClass("title_this");
			$(this).addClass("title_this");
			var way = $.trim($(this).text());
			console.log(way);
			var url = "${base}learn/ENG_listen";
			if (way.localeCompare("词汇日记")==0) {
				url = "${base}learn/ENG_listen";
			}
			if (way.localeCompare("每日跟读")==0) {
				url = "${base}learn/ENG_speak";
			}
			if (way.localeCompare("美文收藏")==0) {
				url = "${base}learn/ENG_read";
			}
			if (way.localeCompare("复习")==0) {
				url = "${base}learn/ENG_write";
			}
			$("#learn_way").html('<iframe src="' + url + '" scrolling="auto" frameborder="0" width="100%" height="100%"></iframe>');
		});

	});
</script>
</head>
<body style="width: 99%; height: 99%; margin: 5px 5px 5px 5px; overflow: hidden; border-radius: 5px;">
	<div class="easyui-layout" style="width: 100%; height: 100%; overflow: hidden;">
		<div data-options="region:'north',title:'',split:false" style="height: 20px;">
			<span style="font-family: sans-serif; font-size: 12px; font-style: oblique; color: #b7958b;"> >>学海无涯 >英语的听说读写 </span>
		</div>
		<div data-options="region:'west',split:false,border:true" style="width: 145px; height: 100%;">
			<div class="title_">
				<div class="title_home title_this">
					<span class="title_size">词汇日记</span>
				</div>
				<div class="title_home">
					<span class="titlet_size">每日跟读</span>
				</div>
				<div class="title_home">
					<span class="title_size">美文收藏</span>
				</div>
				<div class="title_home">
					<span class="title_size">复习</span>
				</div>
			</div>
		</div>
		<div data-options="region:'center',border:false" id="learn_way">
			<iframe src="${base}learn/ENG_listen" scrolling="auto" frameborder="0" width="100%" height="100%"></iframe>
		</div>
	</div>
	<script type="text/javascript">
		
	</script>
</body>
</html>
