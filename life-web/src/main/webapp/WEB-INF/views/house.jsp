<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<script type="text/javascript">
	var basePath = "${base}";
</script>
<script type="text/javascript" src="${base}static/life-js/common.js"></script>
<script type="text/javascript" src="${base}static/life-js/house.js"></script>
<style>
* {
	margin: 0;
	padding: 0;
}
</style>
</head>
<body id="most" class="easyui-layout" style="width: 100%; height: 100%;">
	<div id="left_west" data-options="region:'west',border:false" style="width: 200px;">
		<div id="left_content" class="easyui-accordion" data-options="border:false,fit:true">
			<div>
				<div style="text-align: center; margin-top: 300px;" id="m-level1-1" data-options="iconCls:'tree-add1'">
					<a style="font-size: 18px;">新增菜单</a>
				</div>
			</div>
		</div>
	</div>
	<div id="center" region="center" border="false" style="overflow: hidden;">

		<div id="tt" class="easyui-tabs" style="width: 100%; height: 100%;">
			<div title="Home page" style="padding: 10px;">
				<%-- 			<iframe scrolling="auto" frameborder="0" src="${base }musicPlayer/player" style="width: 100%; height: 100%;"></iframe> --%>
<!-- 				<iframe scrolling="auto" frameborder="0" src="http://www.baidu.com/" style="width: 100%; height: 100%;"></iframe> -->
			</div>
		</div>

	</div>

	<div data-options="region:'south',split:false" style="height: 37px">
		<div style="float: left; margin-top: 3px; margin-right: 3px;">
			<table>
				<tr>
					<td><a href="javascript:;" id="showTree" style="height: 25px; width: 31px" class="easyui-linkbutton" data-options="plain:false,iconCls:'showTree'"></a> <a href="javascript:;" id="hideTree" style="height: 25px; width: 31px"
						class="easyui-linkbutton" data-options="plain:false,iconCls:'hideTree'"></a> <a style="height: 25px; width: 31px" title="全屏" id="btn" class="easyui-linkbutton" data-options="plain:false,iconCls:'full-screen'"></a> <a
						style="height: 25px; width: 31px" title="退出全屏" id="quite" class="easyui-linkbutton" data-options="plain:false,iconCls:'exit-full-screen'"></a> <a style="height: 25px; width: 31px" title="上传文件" id="uploadFile" class="easyui-linkbutton"
						data-options="plain:false,iconCls:'upload'"></a> <a style="height: 25px; width: 31px" title="环境设置" id="setting" class="easyui-linkbutton" data-options="plain:false,iconCls:'setting'"></a></td>
					<td><span style="font-size: 14px; color: red;">左侧处鼠标右键可添加1、2、3级菜单</span></td>
				</tr>
			</table>
		</div>

		<div style="float: right; margin-top: 3px; margin-right: 3px;">
			<table>
				<tr>
					<td></td>
					<td><a style="height: 25px; width: 31px" title="退出" id="exitHouse" class="easyui-linkbutton" data-options="plain:false,iconCls:'main-exit'"></a></td>
			</table>
		</div>
	</div>
	<div id="menu" class="easyui-menu" style="width: 150px;">
		<div id="m-refresh">刷新</div>
		<div id="m-full-screen">全屏</div>
		<div class="menu-sep"></div>
		<div id="m-closeall">全部关闭</div>
		<div id="m-closeother">除此之外全部关闭</div>
		<div id="m-closeLeft">关闭左侧页</div>
		<div id="m-closeRight">关闭右侧页</div>
		<div class="menu-sep"></div>
		<div id="m-close">关闭</div>
	</div>


	<div id="treeMenu" class="easyui-menu" style="width: 150px;">
		<div id="m-level1" data-options="iconCls:'tree-add1'">新增一级菜单</div>
		<div id="m-level2" data-options="iconCls:'tree-add1'">新增二级级菜单</div>
		<div id="m-level3" data-options="iconCls:'tree-add1'">新增三级级菜单</div>
	</div>
	<div id="dialog"></div>
</body>
</html>