<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../mobileHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script type="text/javascript">
function back(){
	window.location.replace("${base}learn/mob");
}
</script>
<style>
</style>
</head>
<body>
	<div id="p2" class="easyui-navpanel">
		<header>
			<div class="m-toolbar">
				<span id="p2-title" class="m-title">dayLearn</span>
				<div class="m-left">
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick="back()">Back</a>
				</div>
			</div>
		</header>
		<div style="margin: 50px 0 0; text-align: center">
			<ul class="m-list">
			<c:forEach items="${wordTypes}" var="wt">
				<li class="m-list-group">${wt.itemName}</li>
			</c:forEach>
			</ul>
		</div>
	</div>
</body>
</html>
