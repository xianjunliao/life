<#-- macro -->
<#import "/base/ftl-lib.ftl" as m />
<#include "/base/edit-page.ftl" />

<#-- 需要引入额外的js脚本时，往javascripts中加 -->
<@m.htmlTemplate title="创建申请" javascripts=[]>

<!-- title="创建申请"  -->
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
	<@m.navTips content="提单  &gt; 创建申请"/>
	
	<!-- 表单  BEGIN-->
	<div id="form-area" >
	
	<div style="margin: 10px 0px 10px 0px;">
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="Bill.CreditApply.save()">保存</a>
	</div>
	
	<div id="form-body" >
	
		<form id="CreditApplyForm" class="easyui-form" method="post" data-options="novalidate:true">
			<input type="hidden" name="serialno" />
			<!-- 登录人信息 -->
			<input id="userId" type="hidden" value="${shiroUser.userId!}" />
			<input id="userName" type="hidden" value="${shiroUser.userName!}" />
			<input id="orgId" type="hidden" value="${shiroUser.orgId!}" />
			
			<@m.fieldset legend="申请信息">
			<table>
				<tr>
					<td class="bcs-form-lable">业务类型<@m.redStar/></td>
					<td class="">
						<!-- bcs-cl="data:[{value:'01',text:'aaa'}]" -->
						<!-- bcs-cl="data:Bill.CreditApply.getData()" -->
						<!-- bcs-cl="codeNo:'BusinessCategory'" -->
						<select name="businesscategory" class="easyui-combobox bcs-form-textbox" data-options="required:true,value:'01',panelHeight:'120'">
							<option value="01">正租</option>
							<option value="02">回租</option>
							<option value="03">直营</option>
						</select>
					</td>
					<td class="bcs-form-lable">经销商<@m.redStar/></td>
					<td class="">
						<input name="dealerid" type="hidden" />
						<input name="serviceproviderstype" type="hidden" />
						<input name="belongarea" type="hidden" />
						<input name="city" type="hidden" />
						<input name="spprovince" type="hidden" />
						<input name="spcity" type="hidden" />
						<input name="sparea" type="hidden" />
						<input name="billright" type="hidden" />
						<!-- drm信息 -->
						<input name="drmid" type="hidden" />
						<input name="drmname" type="hidden" />
						<input name="drmtelephone" type="hidden" />
						<select name="dealername" class="easyui-combobox bcs-form-textbox" bcs-cl="url:'/dealerServiceController/getList/${shiroUser.userId!}',
						setData:['dealerid','serviceproviderstype','belongarea','city','spprovince','spcity','sparea','billright'],onSelect:Bill.CreditApply.onSelectDealer" 
						data-options="required:true,panelHeight:'180',valueField:'dealername',textField:'dealername'" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">客户类型<@m.redStar/></td>
					<td class="">
						<select name="customertype" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'CustomerType'" data-options="required:true,value:'03',panelHeight:'180'" />
					</td>
					
					<td class="bcs-form-lable">客户名称<@m.redStar/></td>
					<td>
						<input name="customername" class="easyui-textbox bcs-form-textbox" type="text" data-options="required:true" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">证件类型<@m.redStar/></td>
					<td class="">
						<select name="certtype" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'CertType'" data-options="required:true,value:'Ind01',panelHeight:'240'" />
					</td>
					<td class="bcs-form-lable">证件号码<@m.redStar/></td>
					<td class="">
						<input name="certid" class="easyui-textbox bcs-form-textbox" data-options="required:true" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">产品名称<@m.redStar/></td>
					<td class="">
						<input type="hidden" name="businesstype" />
						<input type="hidden" name="productversion" />
						<input name="typename" class="easyui-textbox bcs-form-textbox" data-options="required:true,buttonText:'选择',onClickButton:Bill.CreditApply.selectProduct" />
					</td>
					<td class="bcs-form-lable">放款合作模式<@m.redStar/></td>
					<td class="">
						<select id="ID_PCM" name="putoutcooperationmode" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'PutoutCooperationMode'" data-options="required:true,value:'1',panelHeight:'90'" />
					</td>
				</tr>
				
			</table>
			</@m.fieldset>
			
			<@m.fieldset legend="申请信息">
				<p>1、额度：</p>
				<p>2、最低首付：</p>
				<p>3、保证金：</p>
			</@m.fieldset>
		</form>
		
	</div>
	</div>
	<!-- 表单  END-->

	<!-- BODY END -->

	<!-- JAVASCRIPT BEGIN -->
	<script type="text/javascript">
	createPageObject("Bill.CreditApply",function(page){
		page.ready = function(){
			page.$form = $("#CreditApplyForm");
			page.$form.form('disableValidation').form('validate');
		};
		/**选择经销商之后*/
		page.onSelectDealer = function(recode){
			//重新加载放款合作模式的下拉列表
			var dataList = $("#ID_PCM").combobox("getData");
			var pcm_itmes = recode.putoutcooperationmode.split(",");
			$.each(dataList,function(i,v){
				v["disabled"] = $.inArray(v.itemNo,pcm_itmes)<0;
			});
			$("#ID_PCM").combobox("loadData",dataList);
			$.inArray(page.$form.formData("putoutcooperationmode"),pcm_itmes)<0 && $("#ID_PCM").combobox("clear");
			//获取DRM信息
			var list = page.drmList = recode.drmList;
			if(!list || list.length <1) return $.mytools.warningAlert("经销商DRM信息获取失败");
			page.$form.formData({drmid:list[0].userId,drmname:list[0].userName,drmtelephone:list[0].userTel});
		};
		/**选择产品*/
		page.selectProduct = function(){
			var dealerid = page.$form.formData("dealerid");
			if(!dealerid) return $.mytools.warningAlert("请先选择经销商");
			openDialogPage("SelectProductDialog","/bill/credit/toSelectProduct?dealerid="+dealerid,function(product){
				page.$form.formData(product);
			});
		};
		/**保存*/
		page.save = function(){
			//表单验证
			var validate = page.$form.form('enableValidation').form('validate');
			if(!validate) return; 
			var data = page.$form.formData();
			doPostJson("/bill/credit/creditApply",data,function(reData){
				$.mytools.successAlert("保存成功",function(){
					parent.openTab("合同详情",webResourceRoot+"/bill/credit/toDetailsMain?serialno="+reData.data.serialno);
					parent.closeTab("创建申请");
				});
			});
		};
		
	});

$(function(){
	Bill.CreditApply.ready();
});
	</script>
	<!-- JAVASCRIPT END -->
</@m.htmlTemplate>