<#-- macro -->
<#import "/base/ftl-lib.ftl" as m />
<#include "/base/edit-page.ftl" />

<#-- 需要引入额外的js脚本时，往javascripts中加 -->
<@m.htmlTemplate title="合同详情主页" javascripts=[]>

<!-- title="合同详情主页"  -->
<!-- CSS BEGIN -->
<link href="/bcs-web/static/css/bill-style.css" rel="stylesheet" type="text/css">
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

	<!-- BODY BEGIN -->
	<@m.navTips content="提单  &gt; 合同详情主页"/>
	
	<!-- 表单  BEGIN-->
	<form id="DetailsMainForm">
		<input type="hidden" name="serialno" value="${credit.serialno!}" /><!-- 合同编号 -->
		<input type="hidden" name="businesscategory" value="${credit.businesscategory!}" /><!-- 业务类型 -->
		<input type="hidden" name="businesstype" value="${credit.businesstype!}" /><!-- 产品代码 -->
		<input type="hidden" name="productversion" value="${credit.productversion!}" /><!-- 产品版本 -->
		<input type="hidden" name="customerid" value="${credit.customerid!}" /><!-- 客户编号 -->
		<input type="hidden" name="customertype" value="${credit.customertype!}" /><!-- 客户类型, code: customertype, 03-个人, 05-公司 -->
	</form>
	<!-- 表单  END-->
	
	<!-- 合同详情tab标签  BEGIN-->
	<div id="details-tabs" class="easyui-tabs" data-options="plain:true,iconCls:'icon-reload'" style="width: 100%;height: 100%;background-color:white;">
	</div>
	<!-- 合同详情tab标签  END-->
	<!-- BODY END -->

	<!-- JAVASCRIPT BEGIN -->
	<script type="text/javascript">
	createPageObject("Bill.DetailsMain",function(page){
		page.init = function(){
			page.$tabs = $("#details-tabs");
			page.$form = $("#DetailsMainForm");
			var credit = page.$form.formData();
			page.panel_list = [
				{title:"贷款信息",ObjectName:"Bill.CreditInfo",href:webResourceRoot+"/bill/credit/toCreditInfo",queryParams:credit,selected:true},
				{title:"主申人",href:webResourceRoot+"/bill/custorm/enterCustomerInfo",queryParams:credit,selected:false},
				{title:"审批文件",href:webResourceRoot+"/bill/credit/toCreditInfo",queryParams:credit,selected:false}
			];
			$.each(page.panel_list,function(i,v){
				page.tab_add(v);
			});
		};
		page.tab_add = function(options){
			var add_options = {
				tools : [{iconCls: "icon-reload", handler: function(){
					page.tab_refresh($(this.parentElement.parentElement).find(".tabs-title").text());
				}}],
				onLoad : function(){
					Bcs.PageLoad.load_all($(this));
					var onLoad = (onLoad=options.ObjectName)&&(onLoad=eval(onLoad).ready)&&onLoad();
				} 
			};
			page.$tabs.tabs('add',$.extend(options,add_options));
		};
		page.tab_refresh = function(tab){
			(page.$tabs.tabs('getTab',tab)||page.$tabs.tabs('getSelected')).panel("refresh");
		};
		page.tab_close = function(tab){
			page.$tabs.tabs('close', tab);
		};
	});

$(function(){
	Bill.DetailsMain.init();
});
	</script>
	<!-- JAVASCRIPT END -->
</@m.htmlTemplate>