<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<style type="text/css">
</style>
</head>
<body style="overflow: hidden;">
	<div id="cc" class="easyui-layout" style="width: 100%; height: 100%; border: none;overflow: hidden;">
		<div data-options="region:'west',split:false,border:false" style="width: 50%;overflow: hidden;">
			<div id="cc1" class="easyui-layout" style="width: 100%; height: 100%;overflow: hidden;">
				<div data-options="region:'north',split:false,border:false" style="height: 50%; padding: 2px;overflow: hidden;">

					<div id="firstSetting" class="easyui-panel" title="首页设置" style="width: 100%; height: 100%; padding: 10px; background: #fafafa;" data-options="iconCls:'first-tab'"></div>

				</div>
				<div data-options="region:'center',border:false" style="padding: 2px;overflow: hidden;">
					<div id="firstSetting" class="easyui-panel" title="其他设置1" style="width: 100%; height: 100%; padding: 10px; background: #fafafa;" data-options="iconCls:'tree-life3'"></div>
				</div>
			</div>
		</div>
		<div data-options="region:'center',border:false" style="overflow: hidden;">
			<div id="cc2" class="easyui-layout" style="width: 100%; height: 100%;overflow: hidden;">
				<div data-options="region:'north',split:false,border:false" style="height: 50%; padding: 2px;overflow: hidden;">
					<div id="treeSetting" class="easyui-panel" title="菜单设置" style="width: 100%; height: 100%; padding: 10px;" data-options="iconCls:'tree-setting'">
						<ul style="margin: 0; padding: 0; margin-left: 10px;">
							<c:forEach items="${trees}" var="t">
								<li class="drag-item">${t.text}</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div data-options="region:'center',border:false" style="padding: 2px;overflow: hidden;">
					<div id="firstSetting" class="easyui-panel" title="其他设置2" style="width: 100%; height: 100%; padding: 10px; background: #fafafa;" data-options="iconCls:'tree-life3'"></div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(function() {
			var indicator = $('<div class="indicator">>></div>').appendTo('body');
			$('.drag-item').draggable({
				revert : true,
				deltaX : 0,
				deltaY : 0
			}).droppable({
				onDragOver : function(e, source) {
					indicator.css({
						display : 'block',
						left : $(this).offset().left - 10,
						top : $(this).offset().top + $(this).outerHeight() - 5
					});
					console.log("onDragOver");
				},
				onDragLeave : function(e, source) {
					indicator.hide();
					console.log("onDragLeave");
				},
				onDrop : function(e, source) {
					$(source).insertAfter(this);
					indicator.hide();
					console.log("onDrop");
				}
			});
		});
	</script>
</body>
</html>