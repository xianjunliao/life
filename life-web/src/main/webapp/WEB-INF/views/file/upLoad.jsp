<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
</style>

</head>
<body class="easyui-layout" style="width: 100%; height: 100%">
	<div region="center" border="false" style="width: 100%; height: 100%">
		<form action="">
			<table>
				<tr>
					<td>类型：</td>
					<td><select class="easyui-combobox" name="fileType" style="width:100%;">
					<option value="img">图片</option>
					<option value="audio">音频</option>
					<option value="vudio">视频</option>
					<option value="else">其他类型文件</option>
					</select>
					</td>
				</tr>
				<tr>
					<td><span>文件名称：</span></td>
					<td><input class="easyui-textbox" name="fileName" data-options="prompt:'请输入文件名称。。。'" style="width: 100%"></td>
				</tr>
				<tr>
					<td><span>文件：</span></td>
					<td><input class="easyui-filebox" name="files" data-options="prompt:'从电脑中选择你要上传的文件。。。'" style="width: 100%"></td>
				</tr>
				<tr>
				<td></td>
				<td></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>