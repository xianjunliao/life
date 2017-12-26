<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$(function() {
		$('#dg').datagrid({
			onSelect : function(index, row) {
				var url = row.link;
				$('#rss').attr('src', url);
				// $('#description').html(row.description);
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
<style>
</style>

</head>
<body class="easyui-layout" style="width: 100%; height: 100%">
	<div id="north" region="north" split="true" title="  " border="false" style="width: 100%;height: 200px">
		<table id="dg" url="${base}tree/getUrlData?url=${treeModel.url}" border="false" rownumbers="true" fit="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="title" width="30%">Title</th>
					<th field="description" width="50%">Description</th>
					<th field="pubdate" width="20%">Publish Date</th>
				</tr>
			</thead>
		</table>
	</div>
	<div region="center" border="false" style="overflow: auto;">
		<iframe id="rss" scrolling="auto" frameborder="0" style="width: 100%; height: 100%"> </iframe>
	</div>
</body>
</html>