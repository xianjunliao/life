<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<script type="text/javascript">
	var basePath = "${base}";
</script>
<script type="text/javascript" src="${base}static/life-js/main.js"></script>
<script type="text/javascript" src="${base}static/life-js/common.js"></script>
<style>
</style>
</head>
<body class="easyui-layout">
	<div region="west" title=" " split="true" border="false" style="width: 200px; background: #EAFDFF;">
		<div id="left_content" class="easyui-accordion" data-options="border:false,fit:true"></div>
	</div>
	<div id="most" region="center" border="false">
		<div  id="content" class="easyui-layout" fit="true">
			<div  region="north" split="true" title="  " border="false" style="height: 200px">
				<table id="dg"></table>
			</div>
			<div region="center" border="false" style="overflow: auto;">
				<iframe id="rss"  scrolling="auto" frameborder="0" style="width: 100%; height: 100%"> </iframe>
			</div>
			<div data-options="region:'south',split:false" style="height: 37px">
				<div style="float: right; margin-top: 3px; margin-right: 3px;">
					<table>
						<tr>
							<td><a style="height: 25px;" href="#" id="btn" class="easyui-linkbutton" data-options="plain:true,iconCls:'full-screen'">全屏</a></td>
							<td><a style="height: 25px;" href="#" id="quite" class="easyui-linkbutton" data-options="plain:true,iconCls:'exit-full-screen'">退出全屏</a></td>
							<td>阅读模式：<select id="readMode" class="easyui-combobox" name="readMode" style="width: 100px; height: 25px;">
									<option value="web">网页</option>
									<option value="text">文本</option>
									<option value="window">弹窗</option>
							</select></td>
						</tr>
					</table>
				</div>
			</div>

		</div>
	</div>
</body>
</html>