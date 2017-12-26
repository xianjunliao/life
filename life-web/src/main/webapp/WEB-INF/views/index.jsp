<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<style>

</style>
<script type="text/javascript">
	var basePath = "${base}";
	var user = "${user}";
</script>
<script type="text/javascript" src="${base}static/life-js/common.js"></script>
<script type="text/javascript" src="${base}static/life-js/main.js"></script>
</head>
<body  style="margin: 0px; overflow: hidden;">
	<div id="main" class="easyui-layout" style="width: 100%; height: 100%;">
		<div data-options="region:'south',split:false" style="height: 40px">
			<div style="float: right; margin-top: 2px; margin-right: 3px;">
				<table>
					<tr>
						<td><div id="inputCode" style="margin-top: 1px;">
								<input class="easyui-textbox" id="code" data-options="prompt:'Please enter your code...'" style="width: 200px; height: 25px;">
							</div></td>
						<td><div id="audios"></div></td>
						<td>
							<div id="btns" style="margin: 1px;">
							    <a style="height: 25px; width: 31px;" title="星际穿越" id="xjcy" onclick="cornfield()" class="easyui-linkbutton" data-options="plain:false,iconCls:'xiaomai'"></a>
								<a style="height: 25px; width: 31px;" title="进入房子" id="house" onclick="intoWorld()" class="easyui-linkbutton" data-options="plain:false,iconCls:'main-house'"></a> 
								<a style="height: 25px; width: 31px;" onclick="exitHouse()" title="退出" id="exitHouse" class="easyui-linkbutton" data-options="plain:false,iconCls:'main-exit'"></a>
							</div>
						</td>

					</tr>
				</table>
			</div>
		</div>
		<div data-options="region:'center',title:'',iconCls:'icon-ok',border:false">
			<!-- 			<div id="main_2" class="easyui-layout" fit="true"> -->
			<!-- 				<div id="north" region="west" split="false" border="false" style="width: 30%"> -->
			<!-- 					<div> -->
			<!-- 						<div id="times"><h3>Welcome to here......</h3></div> -->
			<%-- 						<div><img alt="" width="100%" height="100%" src="${base}static/images/kekeersitao.jpg"></div> --%>
			<!-- 					</div> -->
			<!-- 				</div> -->
			<!-- 				<div region="center" border="false" style="overflow: auto;"> -->
			<!-- 					<iframe id="main_html" scrolling="auto" frameborder="0" style="width: 100%; height: 100%"> </iframe> -->
			<!-- 				</div> -->
			<!-- 			</div> -->


			<div class="vid-wrappper" id="cornfield">
<%-- 				<iframe id="main_html" scrolling="auto" frameborder="0" style="width: 100%; height: 100%" src="${base}static/video/Cornfield Chase2.mkv"> </iframe> --%>
<%-- 				<video  width="100%" loop="loop" autoplay="autoplay" style="" controls="controls" src="${base}static/video/Cornfield Chase.mp4"> --%>
<!-- 				</video> -->
			</div>
		</div>
	</div>
</body>
</html>
