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
	
</script>
<style>
</style>

</head>
<body class="easyui-layout" style="width: 100%; height: 100%;">
	<div region="center" border="false" style="width: 80%; height: 80%;padding: 20px;">
		<h3>
			<a style="text-decoration: underline;" href="${treeModel.url}" target="_blank">【${treeModel.text}】新窗口打开</a>
		</h3>
		<h3>
			<a style="text-decoration: underline;" href="${treeModel.url}">【${treeModel.text}】本窗口打开（覆盖本网站）</a>
		</h3>
	</div>
</body>
</html>