<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript">
	var basePath = "${base}";
	var initText = "${initText}";
</script>
<script type="text/javascript" src="${base}static/life-js/common.js"></script>
<script type="text/javascript" src="${base}static/life-js/house.js"></script>
<style>
* {
	margin: 0;
	padding: 0;
}

.drag-item {
	list-style-type: none;
	display: block;
	padding: 5px;
	border: 1px solid #ccc;
	margin: 2px;
	width: 150px;
	background: #fafafa;
	color: #444;
}

.indicator {
	position: absolute;
	font-size: 9px;
	width: 10px;
	height: 10px;
	display: none;
	color: red;
}
</style>
</head>
<body id="most" class="easyui-layout" style="width: 100%; height: 100%;overflow: hidden;">
	<div id="left_west" data-options="region:'west',border:false" style="width: 200px;">
		<div id="left_content" class="easyui-accordion" data-options="border:false,fit:true,selected:false">
			<c:forEach items="${data}" var="tree">
				<div title="${tree.text}" id="${tree.id}" data-options="iconCls:'${tree.iconCls}'">
					<div style="padding: 10px">
						<ul name="${tree.text}"></ul>
					</div>
				</div>
			</c:forEach>
			<c:if test="${empty data||data.size()==0}">
				<div>
					<div style="text-align: center; margin-top: 300px;" id="m-level1-1" data-options="iconCls:'tree-add1'">
						<a style="font-size: 18px;">新增菜单</a>
					</div>
				</div>
				<script type="text/javascript">
					$(document).ready(function() {
						var left_control_panel = $("#most").layout("panel", 'west');
						$("#showTree").show();
						$("#hideTree").hide();
						left_control_panel.hide('fast', function() {
							left_control_panel.panel('resize', {
								width : 0
							});
							$("#most").layout('resize', {
								width : '100%'
							})
						});
					});
				</script>
			</c:if>
		</div>
	</div>
	<div id="center" region="center" border="false" style="overflow: hidden;">
		<div id="tt" class="easyui-tabs" style="width: 100%; height: 100%;"></div>
	</div>

	<div data-options="region:'south',split:false" style="height: 37px">
		<div style="float: left; margin-top: 3px; margin-right: 3px;">
			<table>
				<tr>
					<td><a style="height: 25px; width: 31px; margin-left: 2px;" title="显示菜单" id="showTree" class="easyui-linkbutton" data-options="plain:false,iconCls:'showTree'"></a></td>
					<td><a style="height: 25px; width: 31px; margin-left: 2px;" title="隐藏菜单" id="hideTree" class="easyui-linkbutton" data-options="plain:false,iconCls:'hideTree'"></a></td>
					<td><a style="height: 25px; width: 31px; margin-left: 2px;" title="全屏" id="btn" class="easyui-linkbutton" data-options="plain:false,iconCls:'full-screen'"></a></td>
					<td><a style="height: 25px; width: 31px; margin-left: 2px;" title="退出全屏" id="quite" class="easyui-linkbutton" data-options="plain:false,iconCls:'exit-full-screen'"></a></td>
					<td><a style="height: 25px; width: 31px; margin-left: 2px;" title="上传文件" id="uploadFile" class="easyui-linkbutton" data-options="plain:false,iconCls:'upload'"></a></td>
					<td><a style="height: 25px; width: 31px; margin-left: 2px;" title="环境设置" id="setting" class="easyui-linkbutton" data-options="plain:false,iconCls:'setting'"></a></td>
					<td><a style="height: 25px; width: 31px; margin-left: 2px;" title="添加菜单" id="m-level1-2" class="easyui-menubutton" data-options="plain:false,menu:'#treeMenu',iconCls:'addTree'"></a></td>
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
		<c:if test="${empty data||data.size()==0}">
			<div id="m-level1" data-options="iconCls:'addTree'">新增一级菜单</div>
		</c:if>
		<c:if test="${not empty data||data.size()>0}">
			<div id="m-level1" data-options="iconCls:'addTree'">新增一级菜单</div>
			<div id="m-level2" data-options="iconCls:'addTree'">新增二级级菜单</div>
			<div id="m-level3" data-options="iconCls:'addTree'">新增三级级菜单</div>
			<div class="menu-sep"></div>
			<div id="m-level4" data-options="iconCls:'deleteTree'">删除一级菜单</div>
			<div id="m-level5" data-options="iconCls:'updateTree'">修改一级菜单</div>
		</c:if>
	</div>
	<div id="ulMenu" class="easyui-menu" style="width: 150px;">
		<div id="m-ul1" data-options="iconCls:'updateTree'">修改</div>
		<div id="m-ul2" data-options="iconCls:'deleteTree'">删除</div>
	</div>
	<div id="dialog"></div>
</body>
</html>