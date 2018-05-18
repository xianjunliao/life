<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<style>
.gridopt {
	text-decoration: underline;
	cursor: pointer;
	color: red;
}
</style>
<script>
	$(function() {
		$('#dg').datagrid({
			fit : true,
			striped : true,
			singleSelect : true,
			checkOnSelect : true,
			selectOnCheck : true,
			idField : 'id',
			border : false,
			fitColumns : true,
			loadMsg : '正在加载数据。。。',
			url : '${base}AllMenus',
			columns : [ [ {
				field : 'id',
				title : '菜单编号',
				width : 100
			}, {
				field : 'menuname',
				title : '菜单名称',
				editor : 'text',
				width : 100
			}, {
				field : 'menuurl',
				title : '菜单地址',
				width : 220
			}, {
				field : 'menustatus',
				title : '菜单状态',
				width : 100,
				align : 'center',
				formatter : function(value, row, index) {
					var status = 1;
					if (value == "0") {
						status = 1;
						return "<a class='gridopt' onclick='startUser(" + row.id + "," + status + ")'>正常</a>";
					} else {
						status = 0;
						return "<a class='gridopt' onclick='startUser(" + row.id + "," + status + ")'>停用</a>";
					}

				}
			}, {
				field : 'menuorder',
				title : '排序号',
				width : 100,
				align : 'right',
				formatter : function(value, row, index) {
					return initToolbar(row.id, index, value);
				}
			} ] ],
			onDblClickCell : function(index, field, value) {
				if (field == 'menuname') {
					$('#dg').datagrid('beginEdit', index);
					var ed = $('#dg').datagrid('getEditor', {
						index : index,
						field : field
					});
					$(ed.target).focus();
					var id = $('#dg').datagrid('getSelected').id;
					$(ed.target).keydown(function(e) {
					var newName = $(ed.target)[0].value;
						if (e.keyCode == 13) {
							updateName(id, newName);
						}
					});
					$(ed.target).blur(function() {
						var newName = $(ed.target)[0].value;
						updateName(id, newName);
					});
				}
			}
		});
	});

	function toMove(type, id, rowIndex) {
		if (type == 'down') {
			rowIndex = rowIndex + 1;
		} else {
			rowIndex = rowIndex - 1;
		}
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}toMove?id=' + id + "&type=" + type,
			success : function(result) {
				$('#dg').datagrid('reload');
			}
		});
	}
	function initToolbar(id, rowIndex, v) {
		var rows = $('#dg').datagrid('getRows');
		var ht = "";
		if (rowIndex == 0) {
			var oc = "toMove('down'," + id + "," + rowIndex + ")";
			ht += "&nbsp;&nbsp;<a class='easyui-linkbutton gridopt' onclick="+oc+">下移</a>&nbsp;&nbsp;" + v + "";
		} else if (rowIndex == (rows.length - 1)) {
			var oc = "toMove('up'," + id + "," + rowIndex + ")";
			ht += "&nbsp;&nbsp;<a class='easyui-linkbutton gridopt' onclick="+oc+">上移</a>&nbsp;&nbsp;" + v + "";
		} else {
			var oc = "toMove('up'," + id + "," + rowIndex + ")";
			var od = "toMove('down'," + id + "," + rowIndex + ")";
			ht += "&nbsp;&nbsp;<a class='easyui-linkbutton gridopt' onclick="+oc+">上移</a>&nbsp;&nbsp;<a class='easyui-linkbutton gridopt' onclick="+od+">下移</a>&nbsp;&nbsp;" + v
					+ "";
		}
		return ht;
	}

	function startUser(id, status) {
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}startUser?id=' + id + "&status=" + status,
			success : function(result) {
				$('#dg').datagrid('reload');
			}
		});
	}
	function updateName(id, name) {
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}updateName?id=' + id + '&name=' + name,
			success : function(result) {
				if (result.code == 200) {
					$('#dg').datagrid('reload');
				} else {
					$.messager.alert("提示", result.message, "warning");
				}
			}
		});

	}
</script>
</head>
<body>
	<div id="toolbar"></div>
	<table id="dg"></table>
</body>
</html>
