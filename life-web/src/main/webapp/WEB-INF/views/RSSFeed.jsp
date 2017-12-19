<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>
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

		$
				.ajax({
					type : 'POST',
					dataType : "json",
					url : '${base}tree/panentTree',
					success : function(data) {
						$
								.each(
										data,
										function(i, n) {//加载父类节点即一级菜单  
											if (i == 0) {//显示第一个一级菜单下的二级菜单  
												$('#left_content')
														.accordion(
																'add',
																{
																	title : n.text,
																	iconCls : n.iconCls,
																	selected : n.checked,
																	content : '<div style="padding:10px"><ul name="'+n.text+'"></ul></div>',
																});
											} else {
												$('#left_content')
														.accordion(
																'add',
																{
																	title : n.text,
																	iconCls : n.iconCls,
																	selected : n.checked,
																	content : '<div style="padding:10px"><ul name="'+n.text+'"></ul></div>',
																});
											}
											// 屏蔽左下角出现"javascript:;;"
											$(
													"#left_content>.panel .panel-tool>a")
													.removeAttr("href");
											//alert($("#left_content>.panel .panel-tool>a").length);

										});
					}
				});
		//异步加载子节点，即二级菜单  
		$('#left_content')
				.accordion(
						{
							onSelect : function(title, index) {
								$("ul[name='" + title + "']")
										.tree(
												{
													url : '${base}tree/getChildNode',
													queryParams : {
														text : title
													},
													animate : true,
													//lines : true,//显示虚线效果    
													onClick : function(node) {
														if (node.url == null
																|| node.url == "") {
															return;
														}
														if (node.readMode == 'rss') {
															var url = "${base}tree/getUrlData?url="
																	+ node.url;
															rss(url);
														} else {

														}

													},
													onLoadSuccess : function(
															node, data) {
														$(
																"ul[name='"
																		+ title
																		+ "'] li:eq(0) ul li:eq(0)")
																.find("div")
																.addClass(
																		"tree-node-selected"); //设置第一个节点高亮   
														var nodeUrl = data[0].children[0].url;
														var url = "${base}tree/getUrlData?url="
																+ nodeUrl;
														rss(url);
													}
												});
							}
						});
	});

	function rss(url) {
		$('#dg').datagrid({
			url : url,
			fit : true,
			striped : true,

			singleSelect : true,
			checkOnSelect : true,
			selectOnCheck : true,
			columns : [ [ {
				field : 'title',
				title : '标题',
				width : 200
			}, {
				field : 'description',
				title : '内容描述',
				width : 700
			}, {
				field : 'pubdate',
				title : '发布时间',
				align : 'right',
				width : 180
			} ] ]
		});
	}
</script>
<style>
</style>
</head>
<body class="easyui-layout">
	<div region="north" border="false"></div>
	<div region="west" title=" " split="true" border="false" style="width: 200px; background: #EAFDFF;">
		<%-- 		<ul id="t-channels" url="${base}tree/tree?pid=0"></ul> --%>
		<div id="left_content" class="easyui-accordion" data-options="border:false,fit:true"></div>
	</div>
	<div region="center" border="false">
		<div class="easyui-layout" fit="true">
			<div region="north" split="true" title="  " border="false" style="height: 200px">
				<table id="dg"></table>
			</div>
			<div region="center" border="false" style="overflow: auto;">
				<iframe id="cc" scrolling="auto" frameborder="0" style="width: 100%; height: 100%"> </iframe>
				<!-- 					<div id="description"></div> -->
			</div>
			<div style="float: right;">
				阅读模式：<select id="readMode" class="easyui-combobox" name="readMode" style="width: 200px;">
					<option value="web">网页</option>
					<option value="text">文本</option>
					<option value="window">弹窗</option>
				</select>
			</div>
		</div>
	</div>
</body>
</html>