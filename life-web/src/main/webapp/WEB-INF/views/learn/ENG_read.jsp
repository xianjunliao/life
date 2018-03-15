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
	function leftGo() {
		
		var d=$("#div3").css("display");
		if(d=='block'){
			$("#div3").hide();
			$("#div3").css("left","+415px");
			
			$("#div2").show();
			$("#div2").animate({
				left : '+55px'
			}, "slow");
		}else{
			$("#div2").hide();
			$("#div2").css("left","+415px");
			
			$("#div3").show();
			$("#div3").animate({
				left : '+55px'
			}, "slow");
		}
		
		
	}
	function rightGo() {
		
		var d=$("#div3").css("display");
		if(d=='block'){
			$("#div3").hide();
			$("#div3").css("left","-415px");
			
			$("#div2").show();
			$("#div2").animate({
				left : '150px'
			}, "slow");
		}else{
			$("#div2").hide();
			$("#div2").css("left","-415px");
			
			$("#div3").show();
			$("#div3").animate({
				left : '150px'
			}, "slow");
		}
	}
</script>
<style type="text/css">
#div1 {
	width: 200px;
	height: 350px;
	float: left;
	position: absolute;
	border: 1px red solid;
	left: -200px;
	z-index: 1;
	display: none;
	margin-top: 10px;
}
#div2 {
	width: 200px;
	height: 350px;
	float: left;
	position: absolute;
	border: 1px red solid;
	right: -200px;
	z-index: 1;
	display: none;
	margin-top: 10px;
}
#div3 {
	width: 200px;
	height: 350px;
	float: left;
	position: absolute;
	border: 1px red solid;
	left:55px;
	z-index: 1;
	margin-top: 10px;
}
</style>

</head>
<body style="width: 320px; height: 415px;overflow: hidden;">
	<div>
		<div style="width: 55px; height: 180px; float: left; padding-top: 180px; position: absolute; left: 0px;" align="center">
			<i onclick="leftGo()" class="layui-icon" style="font-size: 30px; color: #1E9FFF; cursor: pointer;">&#xe65a;</i>
		</div>
		<div id="div1">
			<span id="share"> 分享 1</span>
		</div>
		<div id="div2">
			<span id="share"> 分享2 </span>
		</div>
		<div id="div3">
			<span id="share"> 分享3 </span>
		</div>
		<div style="width: 55px; height: 180px; float: left; padding-top: 180px; position: absolute; right: 0px;" align="center">
			<i onclick="rightGo()" class="layui-icon" style="font-size: 30px; color: #1E9FFF; cursor: pointer;">&#xe65b;</i>
		</div>
	</div>
	<div style="width: 320px; height: 50px; position: absolute; bottom: 0px;" align="center">
		<i class="layui-icon" style="font-size: 30px; color: #1E9FFF; display: none;">&#xe652;</i><i onclick="leftGo()" class="layui-icon" style="font-size: 30px; color: #1E9FFF;">&#xe651;</i>
	</div>
</body>
</html>