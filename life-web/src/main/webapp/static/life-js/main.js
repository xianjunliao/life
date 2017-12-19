$(function() {
	var btn = document.getElementById('btn');
	var content = document.getElementById('most');
	btn.onclick = function() {
		fullScreen(content);
	}
	var quite = document.getElementById('quite');
	quite.onclick = function() {
		exitFullScreen();
	}

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

	$.ajax({
		type : 'POST',
		dataType : "json",
		url : basePath + 'tree/panentTree',
		success : function(data) {
			$.each(data, function(i, n) {// 加载父类节点即一级菜单
				if (i == 0) {// 显示第一个一级菜单下的二级菜单
					$('#left_content').accordion('add', {
						title : n.text,
						iconCls : n.iconCls,
						selected : true,
						content : '<div style="padding:10px"><ul name="' + n.text + '"></ul></div>',
					});
				} else {
					$('#left_content').accordion('add', {
						title : n.text,
						iconCls : n.iconCls,
						selected : false,
						content : '<div style="padding:10px"><ul name="' + n.text + '"></ul></div>',
					});
				}
				// 屏蔽左下角出现"javascript:;;"
				$("#left_content>.panel .panel-tool>a").removeAttr("href");
				// alert($("#left_content>.panel
				// .panel-tool>a").length);

			});
		}
	});
	// 异步加载子节点，即二级菜单
	$('#left_content').accordion({
		onSelect : function(title, index) {
			$("ul[name='" + title + "']").tree({
				url : basePath + 'tree/getChildNode',
				queryParams : {
					text : title
				},
				animate : true,
				onClick : function(node) {
					if (node.url == null || node.url == "") {
						return;
					}
					if (node.readMode == 'web') {
						// $('#content').layout();
						// $('#content').layout('remove','north');
						$('#content').layout('collapse', 'north');
						$('#rss').attr('src', node.url);
					} else if (node.readMode == 'rss') {
						// addPanel();
						$('#content').layout('expand', 'north');
						rss(node.url);
					} else {

					}

				},
				onLoadSuccess : function(node, data) {
					$("ul[name='" + title + "'] li:eq(0) ul li:eq(0)").find("div").addClass("tree-node-selected"); // 设置第一个节点高亮
					var readMode = data[0].children[0].readMode;
					var url = data[0].children[0].url;
					if (url == null || url == "") {
						return;
					}
					if (readMode == 'web') {
						$('#content').layout('collapse', 'north');
						$('#rss').attr('src', url);
					}
					if (readMode == 'rss') {
						// addPanel();
						$('#content').layout('expand', 'north');
						rss(url);
					} else {

					}
				}
			});
		}
	});
});
function addPanel() {
	// var region = 'north';
	// var options = {
	// region: region
	// };
	// options.height = 200;
	// options.split = true;
	// options.title=" " ;
	// options.border=false;
	// $('#content').layout('add', options);
	// $('#content').html('<div region="north" split="true" title=" "
	// border="false" style="height: 200px"><table id="dg"></table></div>');
}
function rss(url) {
	var url = basePath + "tree/getUrlData?url=" + url;
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
			width : "37%"
		}, {
			field : 'description',
			title : '内容描述',
			width : "40%"
		}, {
			field : 'pubdate',
			title : '发布时间',
			align : 'right',
			width : "21%"
		} ] ]
	});
}
