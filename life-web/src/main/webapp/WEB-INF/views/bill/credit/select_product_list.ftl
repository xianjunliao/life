<#-- macro -->
<#import "/base/ftl-lib.ftl" as m />
<#include "/base/edit-page.ftl" />

<#-- 需要引入额外的js脚本时，往javascripts中加 -->
<@m.htmlTemplate title="选择产品" javascripts=[]>

<!-- title="选择产品"  -->
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
	<form id="SelectProductForm" class="easyui-form">
		<input type="hidden" name="customerId" value="${dealerid!}" />
		<table>
		<tr>
			<td class="bcs-form-lable">产品类型:</td>
			<td>
				<select name="whetherpromotionalproducts" class="easyui-combobox bcs-form-textbox" data-options="value:'',panelHeight:'120'">
					<option value="01">正租</option>
					<option value="02">回租</option>
					<option value="03">直营</option>
				</select>
			</td>
			<td class="bcs-form-lable">产品大类:</td>
			<td>
				<!-- bcs-cl="data:SelectProductDialog.getSuperList()' -->
				<select name="productsupertype" class="easyui-combobox bcs-form-textbox" bcs-cl="url:'/product/productSuperType/get',returnList:'rows',
				method:doPostJson,queryParams:{page:1,rows:100}"
				data-options="panelHeight:'240',valueField:'typeNo',textField:'typeName'" />
			</td>
		</tr>
		<tr>
			<td class="bcs-form-lable">车辆类别:</td>
			<td>
				<select name="cartype" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'BusinessCategory'" data-options="panelHeight:'120'" />
			</td>
			
			<td class="bcs-form-lable">购车用途:</td>
			<td>
				<select name="carcaruse" class="easyui-combobox bcs-form-textbox" data-options="value:'',panelHeight:'120'">
					<option value="01">乘用车</option>
					<option value="02">商用车</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="bcs-form-lable">车况:</td>
			<td>
				<select name="attribute9" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'CarStatusType'" data-options="panelHeight:'120'" />
			</td>
			
			<td class="bcs-form-lable">产品名称:</td>
			<td>
				<input name="typename" class="easyui-textbox bcs-form-textbox" data-options="" />
			</td>
			<td>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SelectProductDialog.search();">查询</a>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="SelectProductDialog.reset();">清空</a>
			</td>
		</tr>
		</table>
	</form>
	</div>
	</div>
	<!-- 表格  BEGIN -->
	
	<!-- 表格  END -->
	<table id="SelectProductGrid" data-options="border:true"></table>
	<!-- <div id="toolbar" style="display: none;">
		<a onclick="addUser();" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确认</a>
	</div> -->
	<!-- BODY END -->

	<!-- JAVASCRIPT BEGIN -->
	<script type="text/javascript">
	createPageObject("SelectProductDialog",function(page){
		page.init = function(){
			//设置经销商ID
			var customerIdObj = $("#SelectProductForm").formData();
			var options = {
				url : '${basePath}/compents/product/productVersion/getProductVersion',
				method : "GET",
				rownumbers : true,
				singleSelect : true,
	    		cache : false,
				pagination : true,
				width : 900,
	    		height : 430,
				idField : 'productid',
				/* toolbar : '#toolbar', */
				pageSize : 10,
				pageList : [ 10, 20, 40, 100],
				queryParams : customerIdObj,//设置经销商ID
				columns : [[
					{field:"ck",checkbox:true},
					{field:"productid",title:"产品编码",width:"100",hidden:true},
					{field:"versionid",title:"产品版本",width:"100",hidden:true},
					{field:"typename",title:"产品名称",width:"200"},
					{field:"whetherpromotionalproducts",title:"产品类型",width:"100"},
					{field:"attribute9",title:"车况",width:"100"},
					{field:"cartype",title:"车辆类别",width:"100"},
					{field:"tallprincipal",title:"最高贷款金额",width:"100"},
					{field:"lowprincipal",title:"最低贷款金额",width:"100",hidden:true},
					{field:"minfinancingamount",title:"最低融资总金额",width:"100",hidden:true},
					{field:"maxfinancingamount",title:"最高融资总金额",width:"100",hidden:true},
					{field:"minvehiclefinancingamount",title:"最低车辆融资金额",width:"100",hidden:true},
					{field:"maxvehiclefinancingamount",title:"最高车辆融资金额",width:"100",hidden:true},
					{field:"mincarage",title:"最低车龄",width:"100",hidden:true},
					{field:"maxcarage",title:"最高车龄",width:"100",hidden:true},
					{field:"loanobject",title:"放款对象设置",width:"100",hidden:true},
					{field:"journey",title:"行驶里程",width:"100",hidden:true},
					{field:"monthcalculationmethod",title:"还款方式（月供计算方式）Code:MonthMethod",width:"100",hidden:true}
				]]/*,
				loader:function(param,success,error){
					success
				}*/
			};
			page.$CarGrid = $("#SelectProductGrid").datagrid(options);
		};
		/**查询*/
		page.search = function(){
			var data = $("#SelectProductForm").formData();
			page.$CarGrid.datagrid("reload",data);
		};
		/**清空*/
		page.reset = function(){
			$("#SelectProductForm").form('reset');
		};
		/**点击保存方法方法*/
		page.clickSaveButton = function(callback,dialogID){
			callback(page.$CarGrid.datagrid("getSelected"));
		};
		
	});
	$(function(){
		SelectProductDialog.init();
	});
	</script>
	<!-- JAVASCRIPT END -->
</@m.htmlTemplate>