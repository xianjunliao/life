<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div id="cc" class="easyui-layout" style="width: 100%; height: 100%; border: none;">
		<div data-options="region:'center',border:false">
			<form id="treeLevelForm" method="post" data-options="novalidate:true">
				<input type="hidden" name="id" value="${treeModel.id}" />
				<table cellpadding="5" style="width: 99%;">
					<tr>
						<td align="right"><span>菜单名称:</span></td>
						<td><input class="easyui-textbox" style="width: 100%;" type="text" name="text" value="${treeModel.text}" data-options="required:true" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$('#treeLevelForm').form({
				url : '${base}tree/update',
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
					if (result.code == '200') {
						$('#dialog').dialog('close');
						self.location.href = "${base}house";
						$('#left_content').accordion('selected', false);
						$.messager.alert('提示', result.message, 'info');
					} else {
						$.messager.alert("提示", result.message, "warning");
					}
				}
			});
		});
	</script>
</body>
</html>