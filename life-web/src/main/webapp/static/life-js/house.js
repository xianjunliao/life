var treeNode;
$(function() {
	$("html").bind("contextmenu", function(e) {
		return false;
	});
	$("#quite").hide();
	$("#showTree").hide();
	var btn = document.getElementById('btn');
	// var content = document.getElementById('most');
	var exitHouse = document.getElementById('exitHouse');
	var hideTree = document.getElementById('hideTree');
	var showTree = document.getElementById('showTree');
	var uploadFile = document.getElementById('uploadFile');
	var setting = document.getElementById('setting');
	var isFull = false;
	btn.onclick = function() {
		$("#btn").hide();
		$("#quite").show();
		fullScreen('most');
		isFull = true;
	}
	var quite = document.getElementById('quite');
	quite.onclick = function() {
		$("#btn").show();
		$("#quite").hide();
		exitFullScreen('most');
		isFull = false;
	}
	exitHouse.onclick = function() {
		if (!isFull) {
			exitFullScreen('most');
		}
		exit();
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
			if (title != 'Home page') {
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
				if (title != 'Home page') {
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
	// 关闭左侧页
	$("#m-closeLeft").click(function() {
		var currTab = $('#tt').tabs('getSelected');
		var currTitle = currTab.panel('options').title;
		var currentTabIndex = $('#tt').tabs('getTabIndex', currTab);
		$(".tabs li").each(function(i, n) {
			var title = $(n).text();
			if (i < currentTabIndex) {
				if (title != 'Home page') {
					$('#tt').tabs('close', title);
				}
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
		var title = "上传文件";
		if ($('#tt').tabs('exists', title)) {
			$('#tt').tabs('select', title);
		} else {
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
			$('#tt').tabs('add', {
				id : "upload",
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
						$('#tt').tabs('close', title);
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
				} ]
			});
		}
	}
	// 打开设置页面
	setting.onclick = function() {
		var title = "环境设置";
		if ($('#tt').tabs('exists', title)) {
			$('#tt').tabs('select', title);
		} else {
			$('#tt').tabs('add', {
				id : "setting",
				title : title,
				href : basePath + 'setting/show',
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
	// $.ajax({
	// type : 'POST',
	// dataType : "json",
	// url : basePath + 'tree/panentTree',
	// success : function(data) {
	//	
	// }
	// });

	// if (data == null || data.length == 0) {
	// $("#m-level2").hide();
	// $("#m-level3").hide();
	// } else {
	// $("#m-level2").show();
	// $("#m-level3").show();
	// }
	// $.each(data, function(i, n) {// 加载父类节点即一级菜单
	//
	// $('#left_content').accordion('add', {
	// id : n.id,
	// title : n.text,
	// iconCls : n.iconCls,
	// selected : false,
	// tools : [],
	// content : '<div style="padding:10px"><ul name="' + n.text +
	// '"></ul></div>',
	// });
	// // 屏蔽左下角出现"javascript:;;"
	// $("#left_content>.panel .panel-tool>a").removeAttr("href");
	// // alert($("#left_content>.panel
	// // .panel-tool>a").length);
	// if (n.sortNo == '1') {
	// $('#left_content').accordion('select', n.text);
	// }
	// });
	// 异步加载子节点，即二级菜单
	 $('#left_content').accordion('select', initText);
	$('#left_content').accordion({
		onSelect : function(title, index) {
			loadTree(title);
		}
	});
	$('#left_west').bind('contextmenu', function(e) {
		e.preventDefault();
		var pp = $('#left_content').accordion('getSelected');
		var options = pp.panel('options');
		$('#treeMenu').menu('show', {
			left : e.pageX,
			top : e.pageY
		});
	});
	$("#m-ul1").click(function() {
		var pp = $('#left_content').accordion('getSelected');
		var pid = pp.panel('options').id;
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
		var pp = $('#left_content').accordion('getSelected');
		var id = null;
		if (pp != null) {
			id = pp.panel('options').id;
		}
		openAddDialog("新增二级菜单", "2", id);
	});
	$("#m-level3").click(function() {
		var pp = $('#left_content').accordion('getSelected');
		var id = null;
		if (pp == null) {
			$.messager.alert("提示", "没有打开任何菜单！", "info");
			return;
		} else {
			id = pp.panel('options').id;
		}
		openAddDialog("新增三级菜单", "3", id)
	});
	$("#m-level4").click(function() {
		var pp = $('#left_content').accordion('getSelected');
		var id = null;
		var title = null;
		if (pp == null) {
			$.messager.alert("提示", "没有选中任何菜单！", "info");
			return;
		} else {
			id = pp.panel('options').id;
			title = pp.panel('options').title;
		}
		$.messager.confirm('提示', '确定将菜单[<b>' + title + '</b>]以及包含的子菜单删除吗？?', function(r) {
			if (r) {
				deteleTree(id);
			}
		});

	});
	$("#m-level5").click(function() {
		var pp = $('#left_content').accordion('getSelected');
		var id = null;
		var title = null;
		if (pp == null) {
			$.messager.alert("提示", "没有选中任何菜单！", "info");
			return;
		} else {
			id = pp.panel('options').id;
			title = pp.panel('options').title;
		}
		openUpdateDialog("修改菜单", '0', id, '0');
	});
});

function openAddDialog(title, level, id) {
	$('#dialog').dialog({
		title : title,
		width : 350,
		height : 260,
		closed : false,
		cache : false,
		href : basePath + 'tree/addTree?level=' + level + '&id=' + id,
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

function mouseTab() {

	var e = window.event;
	if (e.button == "0") {
		console.log("左键:" + e.pageX + "," + e.pageX);
		$('#treeMenu').menu('show', {
			left : e.pageX + 500,
			top : e.pageY + 500
		});
	} else {
		console.log("右键:" + e.pageX + "," + e.pageX);
		$('#treeMenu').menu('show', {
			left : e.pageX + 200,
			top : e.pageY + 200
		});
	}
}

function openUpdateDialog(title, level, id, pid) {
	$('#dialog').dialog({
		title : title,
		width : 350,
		height : 300,
		closed : false,
		cache : false,
		href : basePath + 'tree/updateTree?level=' + level + '&id=' + id + '&pid=' + pid,
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
				window.open(node.url);
				return;
			} else {

			}
			if ($('#tt').tabs('exists', node.text)) {
				$('#tt').tabs('select', node.text);
			} else {
				var tab = $('#tt').tabs('getSelected');
				$('#tt').tabs('add', {
					id : node.id,
					title : node.text,
					href : contentUrl,
					closable : false,
					tools : [ {
						iconCls : 'refresh',
						handler : function() {
							$('#tt').tabs('select', node.text);
							refreshTab();
						}
					}, {
						iconCls : 'close',
						handler : function() {
							$('#tt').tabs('close', node.text);
						}
					} ]
				});
			}

		},
		onDblClick : function(node) {
			var pp = $('#left_content').accordion('getSelected');
			var pid = pp.panel('options').id;
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
