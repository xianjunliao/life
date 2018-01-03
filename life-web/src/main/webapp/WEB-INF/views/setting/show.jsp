<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div id="cc" class="easyui-layout" style="width: 100%; height: 100%; border: none;">
		<div data-options="region:'west',split:false,border:false" style="width: 50%;">
			<div id="cc1" class="easyui-layout" style="width: 100%; height: 100%;">
				<div data-options="region:'north',split:false,border:false" style="height: 50%; padding: 2px;">

					<div id="firstSetting" class="easyui-panel" title="首页设置" style="width: 100%; height: 100%; padding: 10px; background: #fafafa;" data-options="iconCls:'first-tab'"></div>

				</div>
				<div data-options="region:'center',border:false" style="padding: 2px;">
					<div id="firstSetting" class="easyui-panel" title="其他设置1" style="width: 100%; height: 100%; padding: 10px; background: #fafafa;" data-options="iconCls:'tree-life3'"></div>
				</div>
			</div>
		</div>
		<div data-options="region:'center',border:false">
			<div id="cc2" class="easyui-layout" style="width: 100%; height: 100%;">
				<div data-options="region:'north',split:false,border:false" style="height: 50%; padding: 2px;">
					<div id="treeSetting" class="easyui-panel" title="菜单设置" style="width: 100%; height: 100%; padding: 10px; background: #fafafa;" data-options="iconCls:'tree-setting'"></div>
				</div>
				<div data-options="region:'center',border:false" style="padding: 2px;">
					<div id="firstSetting" class="easyui-panel" title="其他设置2" style="width: 100%; height: 100%; padding: 10px; background: #fafafa;" data-options="iconCls:'tree-life3'"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>