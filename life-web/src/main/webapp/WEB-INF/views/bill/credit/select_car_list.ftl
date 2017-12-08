<#-- macro -->
<#import "/base/ftl-lib.ftl" as m />
<#include "/base/edit-page.ftl" />

<#-- 需要引入额外的js脚本时，往javascripts中加 -->
<@m.htmlTemplate title="选择车辆" javascripts=[]>

<!-- title="选择车辆"  -->
<!-- CSS BEGIN -->
<style type="text/css">
/* 
body {background-color:white;}
#form-area {width: 100%;padding-left: 20px;}
#form-body {width: 900px;margin: 0px;}
#form-body .easyui-form table {width: 100%;}
#form-body .bcs-form-lable {width: 80px;}
#form-body .bcs-form-textbox {width: 250px;}
.textbox-disabled .textbox-text, .textbox-readonly .textbox-text {background: #efefef;}
.combobox-item-hover {background-color: #cccccc;}
 */
</style>
<!-- CSS END -->


	<!-- 表单  BEGIN-->
	<div id="form-area" >
	<div id="form-body">
	<form id="SelectCarForm">
		<table>
		<tr>
			<td>厂商名称:</td>
			<td><input class="easyui-textbox" name="mfrname" /></td>
			<td>品牌名称:</td>
			<td><input class="easyui-textbox" name="carbrand" /></td>
		</tr>
		<tr>
			<td>系列名称:</td>
			<td><input class="easyui-textbox" name="carseries" /></td>
			<td>款式名称:</td>
			<td><input class="easyui-textbox" name="cartype" /></td>
			
			<td>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SelectCarDialog.search();">查询</a>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="SelectCarDialog.reset();">清空</a>
			</td>
		</tr>
		</table>
	</form>
	</div>
	</div>
	<!-- 表格  BEGIN -->
	
	<!-- 表格  END -->
	<table id="SelectCarGrid" data-options="border:true"></table>
	<!-- <div id="toolbar" style="display: none;">
		<a onclick="addUser();" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确认</a>
	</div> -->
	<!-- BODY END -->

	<!-- JAVASCRIPT BEGIN -->
	<script type="text/javascript">
	createPageObject("SelectCarDialog",function(page){
		page.init = function(){
			var options = {
				url : '${basePath}/carTypeLibrary/getCar',
				method : "GET",
				rownumbers : true,
				singleSelect : true,
				cache : false,
				pagination : true,
				width : 900,
				height : 430,
				idField : 'typeid',
				/* toolbar : '#toolbar', */
				pageSize : 10,
				pageList : [ 10, 20, 40, 100],
				columns : [[
					{field:"ck",checkbox:true},
					{field:"mfrname",title:"厂商名称",width:"80"},
					{field:"brandid",title:"品牌ID",width:"80",hidden:true},
					{field:"carbrand",title:"品牌名称",width:"80"},
					{field:"seriesid",title:"系列ID",width:"80",hidden:true},
					{field:"carseries",title:"系列名称",width:"80"},
					{field:"typeid",title:"款式ID",width:"80",hidden:true},
					{field:"cartype",title:"款式名称",width:"80"},
					{field:"yeargroup",title:"年款",width:"80"},
					{field:"carguideprice",title:"车辆指导价",width:"80",hidden:true},
					{field:"buyyears",title:"购买年份",width:"80",hidden:true},
					{field:"emission",title:"排放标准",width:"80",hidden:true},
					{field:"exhaust",title:"排量",width:"80"},
					{field:"cataloguenumber",title:"公告代码",width:"80"},
					{field:"productdate",title:"出厂日期",width:"80"}
				]]/*,
				loader:function(param,success,error){
					success
				}*/
			};
			page.$CarGrid = $("#SelectCarGrid").datagrid(options);
		};
		/**查询*/
		page.search = function(){
			var data = $("#SelectCarForm").formData();
			page.$CarGrid.datagrid("reload",data);
		};
		/**清空*/
		page.reset = function(){
			$("#SelectCarForm").form('reset');
		};
		/**点击保存方法方法*/
		page.clickSaveButton = function(callback,dialogID){
			callback(page.$CarGrid.datagrid("getSelected"));
		};
		
	});
	$(function(){
		SelectCarDialog.init();
	});
	</script>
	<!-- JAVASCRIPT END -->
</@m.htmlTemplate>