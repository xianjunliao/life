<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<style>
</style>

</head>
<body class="easyui-layout" style="width: 100%; height: 100%">
	<div id="north" region="north" border="false"  >
	<table id="dg" class="easyui-datagrid"  style="height: 200px"
			data-options="singleSelect:true,collapsible:true,method:'get',idField:'title',title:' ',split:true">
		<thead>
			<tr>
				<th data-options="field:'title',width:'24%'">标题</th>
				<th data-options="field:'description',width:'35%'">描述</th>
				<th data-options="field:'pubdate',width:'15%',align:'right'">推送时间</th>
				<th data-options="field:'link',width:'20%',align:'right'">连接地址</th>
			</tr>
		</thead>
		 <tbody>
		<c:forEach items="${rss}" var="rss">
				<tr>
				  <td>${rss.title}</td>
				  <td>${rss.description}</td>
				  <td>${rss.pubdate}</td>
				  <td>${rss.link}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	<div region="center" border="false" style="overflow: auto;">
		<iframe id="rss" scrolling="auto" frameborder="0" style="width: 100%; height: 100%"> </iframe>
	</div>
		<script type="text/javascript">
	$(function() {
		$('#dg').datagrid({
			onSelect : function(index, row) {
				var url = row.link;
				$('#rss').attr('src', url);
			},
			onLoadSuccess : function() {
				var rows = $(this).datagrid('getRows');
				if (rows.length) {
					$(this).datagrid('selectRow', 0);
				}
			}
		});
	});
</script>
</body>
</html>