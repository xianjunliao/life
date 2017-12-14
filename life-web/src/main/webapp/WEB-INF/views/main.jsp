<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	function outWorld() {
		self.location.href = "${base}"
	}
</script>
</head>
<body style="margin:10px;overflow: hidden;">
	<div id="main" class="easyui-layout" style="width: 100%; height: 98%;">
		<div data-options="region:'north',border:true" style="width: 100%; height: 50px"></div>
		<div data-options="region:'south',split:false,border:true" style="width: 100%; height: 35px; overflow: hidden;">
			<div id="music" style="float: right;">
				<a href="javascript:void(0)" onclick="outWorld()" style="text-decoration: underline;font-size:24px"><b>out your world</b></a><span>&nbsp;&nbsp;</span>
			</div>
		</div>
		<div data-options="region:'west',split:false,border:true" style="width: 200px;"></div>
		<div data-options="region:'center',title:'',iconCls:'icon-ok',border:true">
			<div>
				<table style="width: 100%; height: 100%;">
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><span id="times"></span></td>
					</tr>
					<tr>
						<td></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>