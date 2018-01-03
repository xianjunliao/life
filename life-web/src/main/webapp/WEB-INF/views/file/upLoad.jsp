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
		<div data-options="region:'west',split:false,border:true" style="width: 30%; height: 100%;">
			<input type="hidden" id="hideNo" value="${sortNo }" />
			<form id="upLoadFileForm" class="easyui-form" style="width: 100%;" method="post" enctype="multipart/form-data">
				<table cellpadding="5" style="width: 85%; padding-top: 20px;">
					<tr style="width: 100%;">
						<td style="width: 25%" align="right"><span style="width: 20%">类型：</span></td>
						<td style="width: 75%;"><select style="width: 100%;" class="easyui-combobox" name="fileType" data-options="prompt:'请选择文件类型...'">
								<option></option>
								<c:forEach items="${fileTypes}" var="type">
									<option value="${type.fileType}">${type.fileType}</option>
								</c:forEach>
						</select></td>
					</tr>
					<tr style="width: 100%;">
						<td style="width: 25%" align="right"><span style="width: 20%">名称：</span></td>
						<td style="width: 75%;"><input style="width: 100%;" class="easyui-textbox" name="fileName" data-options="prompt:'请输入文件名称...'"></td>
					</tr>
					<tr style="width: 100%;">
						<td style="width: 25%;" align="right"><span style="width: 20%">文件：</span></td>
						<td style="width: 75%;"><input style="width: 100%;" class="easyui-filebox" name="file" data-options="prompt:'选择你要上传的文件...'"></td>
					</tr>
					<tr style="width: 100%;">
						<td style="width: 25%;" align="right"><span style="width: 20%">序号：</span></td>
						<td style="width: 75%;"><input style="width: 100%;" class="easyui-textbox" id="sortNo" name="sortNo" data-options="prompt:'界面显示的顺序号。。。'" value="${sortNo}"></td>
					</tr>
				</table>
			</form>
			<div style="text-align: center;; padding: 5px">
				<a id="upload" onclick="submitForm()" class="easyui-linkbutton" data-options="plain:false,iconCls:'icon-save'">确认上传</a> <a id="cancel" onclick="clearForm()" class="easyui-linkbutton" data-options="plain:false,iconCls:'icon-cancel'">清空填写</a>
			</div>
			<div style="text-align: center; padding: 25px; width: 85%; height: 150px;">
				<table id="fileTypeSum" class="easyui-datagrid" title="类型汇总" data-options="singleSelect:true,collapsible:true,url:'${base}file/getSumGroupTypeByUserCode',method:'post',toolbar:'#tb'">
					<thead>
						<tr>
							<th data-options="field:'fileType',width:'60%'">文件类型</th>
							<th data-options="field:'fileSum',width:'30%',align:'right'">上传的文件数量</th>
						</tr>
					</thead>
				</table>
			</div>
			<div style="text-align: center; padding: 25px; width: 85%; height: 350px;">
				<table id="fileList" class="easyui-datagrid" title="文件列表" data-options="singleSelect:true,collapsible:true,url:'${base}file/getFiles',method:'post',toolbar:'#tb'">
					<thead>
						<tr>
							<th data-options="field:'',checkbox:true"></th>
							<th data-options="field:'id',width:80,align:'right'">文件编号</th>
							<th data-options="field:'fileName',width:220">文件名称</th>
							<th data-options="field:'fileType',width:60">文件类型</th>
							<th data-options="field:'fileSize',width:150,align:'left'">文件大小</th>
							<th data-options="field:'uploadTime',width:180">上传时间</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<div data-options="region:'center',border:true">
			<div style="text-align: center; padding: 25px; width: 55%; height: 90% ；; border: 2px">
				<audio id="mp3" controls="controls"> </audio>
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
						refreshTab("上传文件", "${base}file/upLoad");
					} else {
						$.messager.alert("提示", result.message, "warning");
					}
					console.log(result);
				}
			});
		}
		function clearForm() {
			refreshTab("上传文件", "${base}file/upLoad");
		}

		$(function() {
			$('#fileTypeSum').datagrid({
				onSelect : function(index, row) {
					var url = '${base}file/getFiles';
					$('#fileList').datagrid({
						url : url,
						queryParams : {
							type : row.fileType
						},
						method : "post"
					});
					console.log(url);
				},
				onLoadSuccess : function() {
					// 					var rows = $(this).datagrid('getRows');
					// 					if (rows.length) {
					// 						$(this).datagrid('selectRow', 0);
					// 					}
				}
			});

			$('#fileList').datagrid({
				onSelect : function(index, row) {
					var url = '${base}file/fileDownload?id='+row.id;
					$("#mp3").attr("src", url);
				},
				onLoadSuccess : function() {
					// 					var rows = $(this).datagrid('getRows');
					// 					if (rows.length) {
					// 						$(this).datagrid('selectRow', 0);
					// 					}
				}
			});
		});
	</script>
</body>
</html>