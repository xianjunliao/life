<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<script type="text/javascript">
	$(function() {
		$('#dg').datagrid({
			onSelect : function(index, row) {
				var url = row.link;
				$('#cc').attr('src', url);
				// 				$('#description').html(row.description);
			},
			onLoadSuccess : function() {
				var rows = $(this).datagrid('getRows');
				if (rows.length) {
					$(this).datagrid('selectRow', 0);
				}
			}
		});
		$('#t-channels').tree({
			onSelect : function(node) {
				var url = node.attributes.url;
				$('#dg').datagrid('load', {
					url : url
				});
			},
			onLoadSuccess : function(node, data) {
				if (data.length) {
					var id = data[0].children[0].children[0].id;
					var n = $(this).tree('find', id);
					$(this).tree('select', n.target);
				}
			}
		});

	});
</script>
<style>
</style>
</head>
<body>
<body class="easyui-layout">
	<div region="north" border="false" class="rtitle"></div>
	<div region="west" title="Channels Tree" split="true" border="false"
		style="width: 200px; background: #EAFDFF;">
		<ul id="t-channels" url="${base}data/channels.json"></ul>
	</div>
	<div region="center" border="false">
		<div class="easyui-layout" fit="true">
			<div region="north" split="true" border="false" style="height: 200px">
				<table id="dg" url="${base}data/get_feed.jsp" border="false"
					rownumbers="true" fit="true" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th field="title" width="100">Title</th>
							<!-- 							<th field="description" width="200">Description</th> -->
							<th field="pubdate" width="80">Publish Date</th>
						</tr>
					</thead>
				</table>
			</div>
			<div region="center" border="false" style="overflow: auto;">
				<iframe id="cc" scrolling="auto" frameborder="0"
					style="width: 100%; height: 100%"> </iframe>
				<!-- 				<div id="description"></div> -->
			</div>
		</div>
	</div>
</body>
</body>
</html>