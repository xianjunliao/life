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
// 			$('.title_home').addClass("title_home");
			$(this).addClass("title_this");
			var cla=$(this).attr('class');
			alert(cla);
// 			if(cla.indexOf("3") != -1 ){
// 				alert("1");
// 			}else{
// 				alert("2");
// 			}
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
				<div class="title_home">
					<span class="title_size">听</span>
				</div>
				<div class="title_home">
					<span class="titlet_size">说</span>
				</div>
				<div class="title_home">
					<span class="title_size">读</span>
				</div>
				<div class="title_home">
					<span class="title_size">写</span>
				</div>
			</div>
		</div>
		<div data-options="region:'center',border:true"></div>
	</div>
	<script type="text/javascript">
		
	</script>
</body>
</html>
