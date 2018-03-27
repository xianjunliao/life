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
	$(function() {

	});

	function goUrl(id, url) {
		$("#" + id).addClass("url-select");
		window.open(url);
	}
	function goOver(id, url, mode) {
		if(url==null||url==''){
			return ;
		}
		var X = $("#" + id).offset().top;
		var Y = $("#" + id).offset().left;
		var h = $("#" + id).height();
		$("#url-preview").css("display", "block");
		$("#url-preview").css("left", Y);
		$("#" + id).addClass("url-select");
		$("#url-preview").css("top", X + h + 12);
		$("#url-preview").css("position", "absolute");
		
		$("#url-preview").html("<span>" + url + "</span>");
	}

	function goOut(id) {
		$("#url-preview").css("display", "none");
		$("#" + id).removeClass("url-select");
	}
	
	function openAddUrl(){
		window.location.href="${base}house";
	}
</script>
<style>
.url-go {
	height: 35px;
	min-width: 100px;
	background-color: #a8a9a9;
	float: left;
	margin: 15px;
	font-weight: 700;
	font-size: 18;
	line-height: 35px;
	cursor: pointer;
	box-shadow: 1px 1px 20px #333333;
	text-align: center;
	padding: 5px;
}

.url-select {
	background-color: #a4d2f5;
}

#url-preview {
	text-align: center;
	box-shadow: 1px 1px 20px #333333;
	z-index: 9999;
	padding: 2px;
	font-weight: 700;
	color: #e47b7b;
}

.url-add {
	font-size: 28 !important;
	background-color: #f9f9db !important;
}
</style>

</head>
<body class="easyui-layout" style="width: 100%; height: 100%;">
	<div region="center" border="true" style="width: 100%; height: 100%;">

		<a target="_black" href="${u.url}">${u.text}</a>
		<div>
			<c:forEach items="${urls}" var="u">
			 <c:if test="${u.url!=null or u.url!='' }">
				<div id="${u.id}" class="url-go" onmouseout="goOut('${u.id}')" onmouseover="goOver('${u.id}','${u.url}','${u.readMode}')" onclick="goUrl('${u.id}','${u.url}')">${u.text}</div>
			 </c:if>
			</c:forEach>
		</div>
		<div title="新增网站收藏" class="url-go url-add" onclick="openAddUrl()">+</div>

	</div>

	<div id="url-preview">
	</div>
</body>
</html>