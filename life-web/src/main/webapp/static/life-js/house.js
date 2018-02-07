var treeNode;
$(function() {
	$("html").bind("contextmenu", function(e) {
		return false;
	});
	createTab('myMeunTab', '默认网站', basePath + 'myMeun');
	$("#quite").hide();
	$("#showTree").hide();
	var hideTree = document.getElementById('hideTree');
	var showTree = document.getElementById('showTree');
	var uploadFile = document.getElementById('uploadFile');
	var setting = document.getElementById('setting');
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
			if ('Home page' != title) {
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
			$('#tt').tabs('close', title);
		});
	});

	// 除当前之外关闭所有
	$("#m-closeother").click(function() {
		var currTab = $('#tt').tabs('getSelected');
		var currTitle = currTab.panel('options').title;
		$(".tabs li").each(function(i, n) {
			var title = $(n).text();
			if (currTitle != title) {
				$('#tt').tabs('close', title);
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
	// 关闭左侧页
	$("#m-closeLeft").click(function() {
		var currTab = $('#tt').tabs('getSelected');
		var currTitle = currTab.panel('options').title;
		var currentTabIndex = $('#tt').tabs('getTabIndex', currTab);
		$(".tabs li").each(function(i, n) {
			var title = $(n).text();
			if (i < currentTabIndex) {
				$('#tt').tabs('close', title);
			}
		});
		$('#tt').tabs('select', currTitle);
	});
	// 关闭右侧页
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
	// 全屏
	$("#m-full-screen").click(function() {
		var currTab = $('#tt').tabs('getSelected');
		var id = currTab.panel('options').id;
		fullScreen(id);
	});
	// 打开文件上传页面
	uploadFile.onclick = function() {
		createTab('upload', '上传文件', basePath + 'file/upLoad');
	}
	// 打开设置页面
	setting.onclick = function() {
		createTab('setting', '环境设置', basePath + 'setting/show');
	}

	$('#left_content').accordion('select', initText);
	$('#left_content').accordion({
		onSelect : function(title, index) {
			loadTree(title);
		}
	});
	$("#m-ul1").click(function() {
		var pid = accordionOptions().id;
		openUpdateDialog("修改菜单", treeNode.level, treeNode.id, pid);
	});
	$("#m-ul2").click(function() {
		$.messager.confirm('提示', '确定将菜单[<b>' + treeNode.text + '</b>]以及包含的子菜单删除吗？?', function(r) {
			if (r) {
				deteleTree(treeNode.id);
			}
		});
	});
	$("#m-level1-1").click(function() {
		openAddDialog("新增一级菜单", "1", 0);
	});
	$("#m-level1").click(function() {
		openAddDialog("新增一级菜单", "1", 0);
	});
	$("#m-level2").click(function() {
		var id = accordionOptions().id;
		openAddDialog("新增二级菜单", "2", id);
	});
	$("#m-level3").click(function() {
		var id = accordionOptions().id;
		openAddDialog("新增三级菜单", "3", id)
	});
	$("#m-level4").click(function() {
		var id = accordionOptions().id;
		var title = accordionOptions().title;
		$.messager.confirm('提示', '确定将菜单[<b>' + title + '</b>]以及包含的子菜单删除吗？?', function(r) {
			if (r) {
				deteleTree(id);
			}
		});

	});
	$("#m-level5").click(function() {
		var id = accordionOptions().id;
		openUpdateDialog("修改菜单", '0', id, '0');
	});
	$('#left_west').bind('contextmenu', function(e) {
		e.preventDefault();
		$('#treeMenu').menu('show', {
			left : e.pageX,
			top : e.pageY
		});
	});
});

function openAddDialog(title, level, id) {
	var url;
	var height;
	if (level == '1') {
		url = basePath + 'tree/addParentTree?level=' + level + '&id=' + id;
		height = 125;
	} else {
		url = basePath + 'tree/addTree?level=' + level + '&id=' + id;
		height = 250;
	}

	$('#dialog').dialog({
		title : title,
		width : 350,
		height : height,
		closed : false,
		cache : false,
		href : url,
		modal : true,
		buttons : [ {
			text : '确定新增',
			iconCls : 'icon-add',
			handler : function() {
				var isValid = $('#treeLevelForm').form('enableValidation').form('validate');
				if (isValid) {
					$('#treeLevelForm').submit();
					$('#dialog').dialog('close');
				}
			}
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$('#dialog').dialog('close');
			}
		} ]
	});
}

function openUpdateDialog(title, level, id, pid) {
	var url;
	var height;
	if (level == '0') {
		url = basePath + 'tree/updateParentTree?level=' + level + '&id=' + id;
		height = 125;
	} else {
		url = basePath + 'tree/updateTree?level=' + level + '&id=' + id + '&pid=' + pid;
		height = 280;
	}
	$('#dialog').dialog({
		title : title,
		width : 350,
		height : height,
		closed : false,
		cache : false,
		href : url,
		modal : true,
		buttons : [ {
			text : '确认',
			iconCls : 'icon-add',
			handler : function() {
				$('#treeLevelForm').submit();
				$('#dialog').dialog('close');
			}
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$('#dialog').dialog('close');
			}
		} ]
	});
}
function deteleTree(id) {
	$.ajax({
		type : 'POST',
		dataType : "json",
		url : basePath + 'tree/delete?id=' + id,
		success : function(result) {
			if (result.code == 200) {
				$.messager.alert('提示', result.message, 'info');
				location.reload(true);
			} else {
				$.messager.alert("提示", result.message, "warning");
			}
		}
	});
}

function loadTree(title) {

	$("ul[name='" + title + "']").tree({
		id : 'aa',
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
			} else if (node.readMode == 'newWindow') {
				contentUrl = basePath + 'openWeb/addNewWondow?id=' + node.id;
			} else {

			}
			createTab(node.id, node.text, contentUrl);
		},
		onDblClick : function(node) {
			var pid = accordionOptions().id;
			openUpdateDialog("修改菜单", node.level, node.id, pid);
		},
		onAfterEdit : function(node) {
			// alert(node.id);

		},
		onContextMenu : function(e, node) {
			e.preventDefault();
			treeNode = node;
			$('#ulMenu').menu('show', {
				left : e.pageX,
				top : e.pageY
			});
		}
	});
}

function accordionOptions() {
	var pp = $('#left_content').accordion('getSelected');
	if (pp == null) {
		$.messager.alert("提示", "没有打开任何一个一级菜单！", "info");
		return;
	}
	var options = pp.panel('options');
	return options;
}

function createTab(id, title, url) {
	if ($('#tt').tabs('exists', title)) {
		$('#tt').tabs('select', title);
	} else {
		$('#tt').tabs('add', {
			id : id,
			title : title,
			href : url,
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
					$('#tt').tabs('close', title);
				}
			} ]
		});
	}
}

function getCurrTitleTitle(text) {
	$('#tt').tabs('close', text);
	var currTab = $('#tt').tabs('getSelected');
	var options = currTab.panel('options');
	console.log(options);
	if (options != null) {
		$('#tt').tabs('select', options.title);
	}
}