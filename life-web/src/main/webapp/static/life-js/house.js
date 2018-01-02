$(function() {
	$("#quite").hide();
	$("#showTree").hide();
	var btn = document.getElementById('btn');
	var content = document.getElementById('most');
	var exitHouse = document.getElementById('exitHouse');
	var hideTree = document.getElementById('hideTree');
	var showTree = document.getElementById('showTree');
	var uploadFile = document.getElementById('uploadFile');
	var isFull = false;
	btn.onclick = function() {
		$("#btn").hide();
		$("#quite").show();
		fullScreen(content);
		isFull = true;
	}
	var quite = document.getElementById('quite');
	quite.onclick = function() {
		$("#btn").show();
		$("#quite").hide();
		exitFullScreen();
		isFull = false;
	}
	exitHouse.onclick = function() {
		if (!isFull) {
			exitFullScreen();
		}
		window.location.href = basePath;
	}
	var left_control_status = true;
	var left_control_panel = $("#most").layout("panel", 'west');
	hideTree.onclick = function() {
		$("#showTree").show();
		$("#hideTree").hide();
		left_control_panel.hide('fast', function() {
			left_control_panel.panel('resize', {
				width : 0
			});
			$("#most").layout('resize', {
				width : '100%'
			})
		});

	}
	showTree.onclick = function() {
		$("#hideTree").show();
		$("#showTree").hide();
		left_control_panel.show('fast', function() {
			left_control_panel.panel('resize', {
				width : 200
			});
			$("#most").layout('resize', {
				width : '100%'
			})
		});

	}
	$('#tt').tabs({
		onContextMenu : function(e, title, index) {
			$('#tt').tabs('select', title);
			if ('首页' != title) {
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		}
	});

	// 刷新
	$("#m-refresh").click(function() {
		refreshTab();
	});

	// 关闭所有
	$("#m-closeall").click(function() {
		$(".tabs li").each(function(i, n) {
			var title = $(n).text();
			if (title != '首页') {
				$('#tt').tabs('close', title);
			}
		});
	});

	// 除当前之外关闭所有
	$("#m-closeother").click(function() {
		var currTab = $('#tt').tabs('getSelected');
		var currTitle = currTab.panel('options').title;
		$(".tabs li").each(function(i, n) {
			var title = $(n).text();

			if (currTitle != title) {
				if (title != '首页') {
					$('#tt').tabs('close', title);
				}
			}
		});
		$('#tt').tabs('select', currTitle);
	});

	// 关闭当前
	$("#m-close").click(function() {
		var currentTab = $('#tt').tabs('getSelected');
		var currentTabIndex = $('#tt').tabs('getTabIndex', currentTab);
		$('#tt').tabs('close', currentTabIndex);
	});
	$("#m-closeLeft").click(function() {
		var currTab = $('#tt').tabs('getSelected');
		var currTitle = currTab.panel('options').title;
		var currentTabIndex = $('#tt').tabs('getTabIndex', currTab);
		$(".tabs li").each(function(i, n) {
			var title = $(n).text();
			if (i < currentTabIndex) {
				if (title != '首页') {
					$('#tt').tabs('close', title);
				}
			}
		});
		$('#tt').tabs('select', currTitle);
	});
	$("#m-closeRight").click(function() {
		var currTab = $('#tt').tabs('getSelected');
		var currTitle = currTab.panel('options').title;
		var currentTabIndex = $('#tt').tabs('getTabIndex', currTab);
		$(".tabs li").each(function(i, n) {
			var title = $(n).text();
			if (i > currentTabIndex) {
				$('#tt').tabs('close', title);
			}
		});
		$('#tt').tabs('select', currTitle);
	});

	uploadFile.onclick = function() {
		var title = "上传文件";
		if ($('#tt').tabs('exists', title)) {
			$('#tt').tabs('select', title);
		} else {
			$('#tt').tabs('add', {
				title : title,
				href : basePath + 'file/upLoad',
				closable : false,
				tools : [ {
					iconCls : 'refresh',
					handler : function() {
						$('#tt').tabs('select', title);
						refreshTab();
					}
				}, {
					iconCls : 'close',
					handler : function() {
						var currentTab = $('#tt').tabs('getSelected');
						var currentTabIndex = $('#tt').tabs('getTabIndex', currentTab);
						$('#tt').tabs('close', currentTabIndex);
					}
				} ]
			});
		}
	}
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
					var contentUrl = "";
					if (node.url == null || node.url == "") {
						return;
					}
					if (node.readMode == 'web') {
						contentUrl = basePath + 'openWeb/addWeb?id=' + node.id;
					} else if (node.readMode == 'rss') {
						contentUrl = basePath + 'openWeb/addRss?id=' + node.id;
					} else {

					}
					if ($('#tt').tabs('exists', node.text)) {
						$('#tt').tabs('select', node.text);
					} else {
						var tab = $('#tt').tabs('getSelected');
						console.log(tab);
						$('#tt').tabs('add', {
							title : node.text,
							href : contentUrl,
							closable : false,
							tools : [ {
								iconCls : 'refresh',
								handler : function() {
									$('#tt').tabs('select', title);
									refreshTab();
								}
							}, {
								iconCls : 'close',
								handler : function() {
									var currentTab = $('#tt').tabs('getSelected');
									var currentTabIndex = $('#tt').tabs('getTabIndex', currentTab);
									$('#tt').tabs('close', currentTabIndex);
								}
							} ]
						});
					}

				}
			});
		}
	});
});

function mouseTab() {

	var e = window.event;
	if (e.button == "0") {
		console.log("左键:" + e.pageX + "," + e.pageX);
		$('#menu').menu('show', {
			left : e.pageX + 500,
			top : e.pageY + 500
		});
	} else {
		console.log("右键:" + e.pageX + "," + e.pageX);
		$('#menu').menu('show', {
			left : e.pageX + 200,
			top : e.pageY + 200
		});
	}
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
