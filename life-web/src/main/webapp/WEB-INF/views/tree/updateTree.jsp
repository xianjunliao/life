<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
</head>
<body>
	<div id="cc" class="easyui-layout" style="width: 100%; height: 100%; border: none;">
		<div data-options="region:'center',border:false">
			<form id="treeLevelForm" method="post" data-options="novalidate:true">
				<input type="hidden" name="id" value="${treeModel.id}" />
				<table cellpadding="5" style="width: 99%;">
					<tr>
						<td align="right"><span>菜单名称:</span></td>
						<td><input class="easyui-textbox" style="width: 100%;" type="text" id="text" name="text" value="${treeModel.text}" data-options="required:true" /></td>
					</tr>
					<tr>
						<td align="right">菜单url:</td>
						<td><input class="easyui-textbox" style="width: 100%;" type="text" name="url" value="${treeModel.url}" <c:if test="${level=='3'}">data-options="required:true"</c:if> /></td>
					</tr>
					<tr>
						<td align="right">打开方式:</td>
						<td><select class="easyui-combobox" name="readMode" style="width: 100%;" <c:if test="${level=='3'}">data-options="required:true"</c:if>>
								<option <c:if test="${treeModel.readMode=='web' }"> selected="selected" </c:if> value="web">iframe网页嵌套</option>
								<option <c:if test="${treeModel.readMode=='rss' }"> selected="selected" </c:if> value="rss">RSS订阅</option>
								<option <c:if test="${treeModel.readMode=='newWindow' }"> selected="selected" </c:if> value="newWindow">新标签页打开</option>

						</select></td>
					</tr>
					<tr>
						<td align="right">一级菜单:</td>
						<td><c:if test="${level=='2'}">
								<select class="easyui-combobox" id="pid" name="pid" style="width: 100%;" data-options="required:true">
									<c:forEach items="${all1trees}" var="tree">
										<option <c:if test="${pid==tree.id}">selected="selected"</c:if> value="${tree.id}">${tree.text}</option>
									</c:forEach>
								</select>
							</c:if> <c:if test="${level=='3'}">
								<select class="easyui-combobox" id="pid0" name="pid0" style="width: 100%;" data-options="required:true">
									<c:forEach items="${all1trees}" var="tree">
										<option <c:if test="${pid==tree.id}">selected="selected"</c:if> value="${tree.id}">${tree.text}</option>
									</c:forEach>
								</select>
							</c:if> <c:if test="${level=='1'||level=='0'}">
								<select class="easyui-combobox" style="width: 100%;" data-options="required:true,disabled:true"></select>
							</c:if></td>
					</tr>
					<tr>
						<td align="right">二级菜单:</td>
						<td><c:if test="${level=='3'}">
								<input id="pid" name="pid" style="width: 100%;" data-options="required:true">
							</c:if> <c:if test="${level=='2'||level=='1'||level=='0' }">
								<select class="easyui-combobox" style="width: 100%;" data-options="required:true,disabled:true"></select>
							</c:if></td>
					</tr>
					<tr>
						<td align="right">是否分享:</td>
						<td><select class="easyui-combobox" name="isShare" style="width: 100%;" data-options="required:true">
								<option value="1">分享</option>
								<option value="0">不分享</option>
						</select></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$('#text').textbox().next('span').find('input').focus()
			if ('${level}' == '3') {
				$('#pid').combobox({
					valueField : 'id',
					textField : 'text'
				});
				$('#pid').combobox({
					onLoadSuccess : function() {
						var s = $('#pid').combobox("getData");
						var pid = s[0].id;
						var pidP = '${treeModel.pid}';
						for (var i = 0; i < s.length; i++) {
							if (pidP == s[i].id) {
								pid = pidP;
							}
						}
						$('#pid').combobox('setValue', pid);

					}
				});
				$('#pid0').combobox({
					onSelect : function(param) {
						$('#pid').combobox("clear");
						$('#pid').combobox('reload', '${base}tree/getTreeByPid?pid=' + param.value);
					}
				});
			}
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