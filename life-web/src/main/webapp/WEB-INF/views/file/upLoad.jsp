<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
* {
	margin: 0;
	padding: 0;
}
</style>
</head>
<body>
	<div class="easyui-layout" style="width: 100%; height: 100%;">
		<div data-options="region:'west',split:false,border:true" style="width: 400; height: 100%;">

			<form id="upLoadFileForm" class="easyui-form" style="width: 100%;" method="post" enctype="multipart/form-data">
				<table cellpadding="5" style="width: 350px; margin-left: 5px; margin-top: 20px;">
					<tr>
						<td style="width: 280px;"><input style="width: 260px;" class="easyui-filebox" name="file" data-options="prompt:'选择你要上传的文件...'"></td>
						<td style="width: 120px;"><a style="width: 100px;" id="upload" onclick="submitForm()" class="easyui-linkbutton" data-options="plain:false,iconCls:'icon-save'">确认上传</a></td>
					</tr>
				</table>
			</form>
			<div style="width: 365px; margin-left: 5px; margin-top: 20px;">
				<table id="fileTypeSum" class="easyui-datagrid" title="类型汇总" data-options="singleSelect:true,collapsible:true,url:'${base}file/getSumGroupTypeByUserCode',method:'post',toolbar:'#tb'">
					<thead>
						<tr>
							<th data-options="field:'fileType'">文件类型</th>
							<th data-options="field:'fileSum',align:'right'">总数量</th>
							<th data-options="field:'fileSize',align:'right'">总大小(M)</th>
						</tr>
					</thead>
				</table>
			</div>
			<!-- 			<div style="width: 365px; margin-left: 5px; margin-top: 20px;"> -->
			<%-- 				<table id="fileList" class="easyui-datagrid" title="文件列表" data-options="singleSelect:false,collapsible:true,url:'${base}file/getFiles',method:'post',toolbar:'#tb'"> --%>
			<!-- 					<thead> -->
			<!-- 						<tr> -->
			<!-- 							<th data-options="field:'',checkbox:true"></th> -->
			<!-- 							<th data-options="field:'id'">文件编号</th> -->
			<!-- 							<th data-options="field:'fileName'">文件名称</th> -->
			<!-- 							<th data-options="field:'fileType'">文件类型</th> -->
			<!-- 							<th data-options="field:'fileSize',align:'right'">文件大小(M)</th> -->
			<!-- 							<th data-options="field:'uploadTime'">上传时间</th> -->
			<!-- 						</tr> -->
			<!-- 					</thead> -->
			<!-- 				</table> -->
			<!-- 			</div> -->
		</div>
		<div data-options="region:'center',border:true">
			<div id="fileShow" style="">
				<!-- 				<audio id="mp3"  controls="controls"  > </audio> -->
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${base}static/life-js/common.js"></script>
	<script type="text/javascript">
		function submitForm() {
			submit("upLoadFileForm", {
				url : "${base}file/add/uploadFile",
				onSubmit : function() {
					progressLoad();
					var isValid = $(this).form('enableValidation').form('validate');
					if (!isValid) {
						progressClose();
					}
					return isValid;
				},
				success : function(result) {
					progressClose();
					result = $.parseJSON(result);
					if (result.code == 200) {
						$.messager.alert('提示', result.message, 'info');
						$('#fileTypeSum').datagrid('reload');
						$('#fileList').datagrid('reload');
						$('#upLoadFileForm').clear();
					} else {
						$.messager.alert("提示", result.message, "warning");
					}
				}
			});
		}
		$(function() {
			$('#fileTypeSum').datagrid({
				onSelect : function(index, row) {
					var url = '${base}file/getFiles?type=' + row.fileType;
					$("#fileShow").empty();
					$.ajax({
						type : 'POST',
						dataType : "json",
						url : url,
						success : function(result) {
							for (var i = 0; i < result.length; i++) {
								console.log(result[i]);
								var context = null;
								var url = result[i].fileUrl;
								var fileName = result[i].fileName;
								var type = result[i].fileType;
								if (type == 'audio/mp3') {
									context = "" + fileName + "<audio id="+i+" src="+url+" controls='controls' ></audio>";
								} else if (type == 'image/png' || type == 'image/jpeg') {
									context = "" + fileName + "<a href="+url+"><b style='color:red'>下载</b><img id="+i+" src='"+url+"'></img> </a>";
								} else {
									context = "" + fileName + "<a href="+url+" id="+i+">    <b style='color:red'>下载</b></a>";
								}
								$("#fileShow").append("</br>");
								$("#fileShow").append(context);
							}
						}
					});
				}
			});

			// 			$('#fileList').datagrid({
			// 				onSelect : function(index, row) {
			// 					var url = row.fileUrl;
			// 					var type = row.fileType;
			// 					console.log(type);
			// 					var context = null;
			// 					if (type == 'audio/mp3') {
			// 						context = "<audio src="+url+" controls='controls' ></audio><span>" + row.fileName + " </span>";
			// 					} else if (type == 'image/png' || type == 'image/jpeg') {
			// 						context = "" + row.fileName + "<a href="+url+"><b style='color:red'>下载</b><img src='"+url+"'></img> </a>";
			// 					} else {
			// 						context = "" + row.fileName + "<a href="+url+">    <b style='color:red'>下载</b></a>";
			// 					}
			// 					$("#fileShow").append("</br>");
			// 					$("#fileShow").append(context);
			// 				}
			// 			});
		});
	</script>
</body>
</html>