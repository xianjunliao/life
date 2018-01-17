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
* {
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="width: 100%; height: 100%; overflow: hidden;">
	<div class="easyui-layout" style="width: 100%; height: 100%; overflow: hidden;">
		<div data-options="region:'west',split:false,border:true" style="width: 400px; height: 100%;">
			<form id="upLoadFileForm" class="easyui-form" style="width: 100%;" method="post" enctype="multipart/form-data">
				<table cellpadding="5" style="width: 365px; margin-left: 5px; margin-top: 20px;">
					<tr>
						<td style="width: 365px;"><input style="width: 365px;" class="easyui-filebox" id="file" name="file" data-options="prompt:'选择你要上传的文件...',required:true"></td>
					</tr>
				</table>
			</form>
			<fieldset class="layui-elem-field site-demo-button" style="width: 365px; margin-top: 10px; margin-left: 5px;">
				<div id="buttons" style="float: left;">
					<button class="layui-btn layui-btn-normal layui-btn-sm" onclick="submitForm()">确定上传</button>
				</div>
			</fieldset>

			<div style="width: 365px; margin-left: 5px; margin-top: 20px;">
				<table id="fileTypeSum" class="easyui-datagrid" title="类型汇总" data-options="singleSelect:true,collapsible:true,url:'${base}file/getSumGroupTypeByUserCode',method:'post',toolbar:'#tb'">
					<thead>
						<tr>
							<th data-options="field:'fileType'">文件类型</th>
							<th data-options="field:'fileSum',align:'right'">总数量</th>
							<th data-options="field:'fileSize',align:'right'">总大小(M)</th>
						</tr>
					</thead>
				</table>
			</div>
			<!-- 			<div style="width: 365px; margin-left: 5px; margin-top: 5px;" class="layui-progress layui-progress-big" lay-showpercent="true" lay-filter="progressUpload"> -->
			<!-- 				<div class="layui-progress-bar layui-bg-red" lay-percent="0%"></div> -->
			<!-- 			</div> -->
		</div>
		<div data-options="region:'center',border:true">
			<div class="easyui-layout" style="width: 100%; height: 100%;">
				<div data-options="region:'north',split:true,collapsible:true,title : '文件列表',border:false" style="height: 200px;">
					<table id="fileList" data-options="fit:true,border:false">
					</table>
				</div>
				<div data-options="region:'center',border:false" style="overflow: hidden;">
					<div id="fileShow" style="margin-top: 5px; text-align: left; overflow: hidden; width: 100%; height: 100%;">
						<span>如果播放失败，请尝试使用IE浏览器或含有IE内核的浏览器。</span>
					</div>
				</div>
			</div>


		</div>
	</div>
	<script type="text/javascript" src="${base}static/life-js/common.js"></script>
	<script type="text/javascript">
		layui.use('element', function() {
			var $ = layui.jquery, element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
			//触发事件
			var active = {
				upload : function(othis) {
					var isValid = $("#upLoadFileForm").form('enableValidation').form('validate');
					if (!isValid) {
						return;
					}
					var DISABLED = 'layui-btn-disabled';
					if (othis.hasClass(DISABLED))
						return;
					//模拟loading
					var n = 0, timer = setInterval(function() {
						n = n + Math.random() * 10 | 0;
						if (n > 100) {
							n = 100;
							clearInterval(timer);
							submitForm();
							othis.removeClass(DISABLED);
						}
						element.progress('progressUpload', n + '%');
					}, 10);
					othis.addClass(DISABLED);
				}
			};
			$('.layui-btn-normal').on('click', function() {
				var othis = $(this), type = $(this).data('type');
				active[type] ? active[type].call(this, othis) : '';
			});
		});

		function submitForm() {
			progressLoadById("upLoadFileForm","正在上传。。。","35%","50%");
			submit("upLoadFileForm", {
				url : "${base}file/add/uploadFile",
				onSubmit : function() {
					var isValid = $(this).form('enableValidation').form('validate');
					if (!isValid) {
						progressClose();
					}
					return isValid;
				},
				success : function(result) {
					progressClose();
					result = $.parseJSON(result);
					if (result.code == 200) {
						$('#fileTypeSum').datagrid('reload');
						$('#fileList').datagrid('reload');
						$("#upLoadFileForm").form('clear');
						$(".layui-progress-bar").css('background-color', '#e2e2e2');
					} else {
						$.messager.alert("提示", result.message, "warning");
					}
				}
			});
		}
		var dataGrid;
		$(function() {

			dataGrid = $('#fileList').datagrid({
				// 				title : '文件列表',
				url : '${base}file/getFiles',
				fit : true,
				striped : true,
				singleSelect : true,
				checkOnSelect : true,
				selectOnCheck : true,
				idField : 'id',
				border : false,
				fitColumns : true,
				loadMsg : '正在加载数据。。。',
				frozenColumns : [ [ {
					title : '操作',
					field : 'aStr',
					formatter : function(value, row, index) {
						var aStr = '';
						var type = row.fileType;
						if (type == 'mp3') {
							aStr += '  <a  onclick="playAudio(\'' + row.fileUrl + '\')" class="easyui-linkbutton"><b style="text-decoration: underline;">播放</b></a>';
						} else if (type == 'mp4') {
							aStr += '  <a onclick="playVideo(\'' + row.fileUrl + '\')" class="easyui-linkbutton"><b style="text-decoration: underline;">播放</b></a>';
						} else if (type == 'png' || type == 'jpeg' || type == 'jpg') {
							aStr += '  <a onclick="img(\'' + row.fileUrl + '\')" class="easyui-linkbutton"><b style="text-decoration: underline;">预览</b></a>';
						}
						aStr += '  <a onclick="detele(\'' + row.id + '\')" class="easyui-linkbutton"><b style="text-decoration: underline;">删除</b></a>';
						aStr += '  <a href="' + row.fileUrl+ '" target="_blank" class="easyui-linkbutton"><b style="text-decoration: underline;">下载</b></a>';
						return aStr;
					}
				} ] ],
				columns : [ [ {
					field : 'id',
					title : '文件编号'
				}, {
					field : 'fileName',
					title : '文件名称',
					editor : 'text'
				}, {
					field : 'fileType',
					title : '文件类型'
				}, {
					field : 'fileSize',
					title : '文件大小(M)',
					align : 'right'
				}, {
					field : 'uploadTime',
					title : '上传时间'
				}, {
					field : 'fileUrl',
					title : '文件下载地址'
				} ] ],
				onDblClickRow : function(rowIndex, rowData) {
					var type = rowData.fileType;
					var url = rowData.fileUrl;
					if (type == 'mp3') {
						playAudio(url);
					} else if (type == 'mp4') {
						playVideo(url)
					} else if (type == 'png' || type == 'jpeg' || type == 'jpg') {
						img(url);
					} else {
						cannotShow();
					}

				},
				onDblClickCell : function(index, field, value) {
					if (field == 'fileName') {
						$('#fileList').datagrid('beginEdit', index);
						var ed = $('#fileList').datagrid('getEditor', {
							index : index,
							field : field
						});
						$(ed.target).focus();
						var id = $('#fileList').datagrid('getSelected').id;
						console.log(id);
						var newFileName = $(ed.target)[0].value;
						$(ed.target).keydown(function(e) {
							var newFileName = $(ed.target)[0].value;
							if (e.keyCode == 13) {
								console.log(newFileName);
								$.ajax({
									type : 'POST',
									dataType : "json",
									url : '${base}file/update?id=' + id + '&fileName=' + newFileName,
									success : function(result) {
										if (result.code == 200) {
											$('#fileList').datagrid('reload');
										} else {
											$.messager.alert("提示", result.message, "warning");
										}
									}
								});
							}
						});
						$(ed.target).blur(function() {
							$('#fileList').datagrid('reload');
						});
					}
				}
			});

			$('#fileTypeSum').datagrid({
				onSelect : function(index, row) {
					var url = '${base}file/getFiles?type=' + row.fileType;
					$("#fileShow").empty();
					$("#fileShow").html('<span>如果播放失败，请尝试使用IE浏览器或含有IE内核的浏览器。</span>');
					$.ajax({
						type : 'POST',
						dataType : "json",
						url : url,
						success : function(result) {
							var url = '${base}file/getFiles';
							$('#fileList').datagrid({
								url : url,
								queryParams : {
									type : row.fileType
								},
								method : "post"
							});
							console.log(url);
						}
					});
				}
			});

		});
		function playAudio(url) {
			$("#fileShow").html("<audio src=" + url + " controls='controls' style='width: 100%;' autoplay='autoplay' loop='loop'></audio>");
		}
		function playVideo(url) {
			$("#fileShow").html("<video src=" + url + " controls='controls' style='width: 100%;height:99%;' autoplay='autoplay' loop='loop'></video>");
		}
		function img(url) {
			$("#fileShow").html("<img src='" + url + "' style='width: 100%;height:100%;'></img>");
		}
		function cannotShow() {
			$("#fileShow").html("<span>该文件不支持预览</span>");
		}
		function detele(id) {
			$.messager.confirm('提示', '确定删除吗?', function(r) {
				if (r) {
					$.ajax({
						type : 'POST',
						dataType : "json",
						url : '${base}file/delete?id=' + id,
						success : function(result) {
							if (result.code == 200) {
								$("#fileShow").empty();
								$('#fileTypeSum').datagrid('reload');
								$('#fileList').datagrid('reload');
							} else {
								$.messager.alert("提示", result.message, "warning");
							}
						}
					});
				}
			});

		}
	</script>
</body>
</html>