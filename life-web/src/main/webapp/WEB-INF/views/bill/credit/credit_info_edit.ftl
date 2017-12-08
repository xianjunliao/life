<#-- macro -->
<#import "/base/ftl-lib.ftl" as m />
<#include "/base/edit-page.ftl" />

<#-- 需要引入额外的js脚本时，往javascripts中加 -->
<@m.htmlTemplate title="贷款信息" javascripts=[]>

<!-- title="贷款信息"  -->
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
	
	<div style="margin: 10px 0px 10px 0px;">
		<a href="#" class="easyui-linkbutton" data-options="iconCls:''" onclick="Bill.CreditInfo.saveTemp()">暂存</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="Bill.CreditInfo.saveCredit()" style="margin-left: 10px;">保存</a>
	</div>
	
	<div id="form-body" >
		
		<form id="CreditInfoForm" class="easyui-form" method="post" data-options="novalidate:true">
			<!-- 贷款信息 -->
			<input name="serialno" type="hidden" value="${credit.serialno}" />
			<input name="tempsaveflag" type="hidden" value="${credit.tempsaveflag!}" />
			<!-- 登录人信息 -->
			<input id="userId" type="hidden" value="${shiroUser.userId!}" />
			<input id="userName" type="hidden" value="${shiroUser.userName!}" />
			<input id="orgId" type="hidden" value="${shiroUser.orgId!}" />
			
			
			<@m.fieldset legend="基础信息">
			<table>
				<tr>
					<td class="bcs-form-lable">经销商名称<@m.redStar/></td>
					<td class="">
						<input name="dealerid" value="${credit.dealerid!}" type="hidden" />
						<input name="serviceproviderstype" value="${credit.serviceproviderstype!}" type="hidden" />
						<input name="belongarea" value="${credit.belongarea!}" type="hidden" />
						<input name="city" value="${credit.city!}" type="hidden" />
						<input name="spprovince" value="${credit.spprovince!}" type="hidden" />
						<input name="spcity" value="${credit.spcity!}" type="hidden" />
						<input name="sparea" value="${credit.sparea!}" type="hidden" />
						<input name="billright" value="${credit.billright!}" type="hidden" />
						<select name="dealername" class="easyui-combobox bcs-form-textbox" bcs-cl="url:'/dealerServiceController/getList/${shiroUser.userId!}',
						setData:['dealerid','serviceproviderstype','belongarea','city','spprovince','spcity','sparea','billright'],onSelect:Bill.CreditInfo.onSelectDealer" 
						data-options="value:'${credit.dealername!''}',panelHeight:'120',valueField:'dealername',textField:'dealername'" />
					</td>
					<td class="bcs-form-lable">DRM姓名<@m.redStar/></td>
					<td class="">
						<input name="drmid" value="${credit.drmid!}" type="hidden" />
						<input name="drmname" value="${credit.drmname!}" class="easyui-textbox bcs-form-textbox" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">业务类型<@m.redStar/></td>
					<td class="">
						<select name="businesscategory" class="easyui-combobox bcs-form-textbox" data-options="value:'${credit.businesscategory!'02'}',panelHeight:'60'">
							<option value="01">回租</option>
							<option value="02">正租</option>
						</select>
					</td>
					<td class="bcs-form-lable">DRM电话<@m.redStar/></td>
					<td class="">
						<input name="drmtelephone" value="${credit.drmtelephone!}" class="easyui-textbox bcs-form-textbox" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">放款合作模式<@m.redStar/></td>
					<td class="">
						<select name="putoutcooperationmode" class="easyui-combobox bcs-form-textbox" data-options="value:'${credit.putoutcooperationmode!'01'}',panelHeight:'90'">
							<option value="01">租赁模式</option>
							<option value="02">信托模式</option>
							<option value="03">助贷模式</option>
						</select>
					</td>
					<td class="bcs-form-lable">二级网点<@m.redStar/></td>
					<td class="">
						<input name="suborganization" value="${credit.suborganization!}" class="easyui-textbox bcs-form-textbox" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">助贷公司<@m.redStar/></td>
					<td class="">
						<select name="helpcreditcompany" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'HelpCreditCompany'" data-options="value:'${credit.helpcreditcompany!}',multiple:true,panelHeight:'90'" />
					</td>
					<td class="bcs-form-lable">二级网点销售<@m.redStar/></td>
					<td class="">
						<input name="suborganizationsale" value="${credit.suborganizationsale!}" class="easyui-textbox bcs-form-textbox" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">是否电销<@m.redStar/></td>
					<td class="">
						<select name="electricitypin" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'YesNo'" data-options="value:'${credit.electricitypin!'2'}',panelHeight:'60'" />
					</td>
					<td class="bcs-form-lable">二级网点联系方式<@m.redStar/></td>
					<td class="">
						<input name="suborganizationsalephone" value="${credit.suborganizationsalephone!}" class="easyui-textbox bcs-form-textbox" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">是否反贷<@m.redStar/></td>
					<td class="">
						<select name="uncreditflag" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'YesNo'" data-options="value:'${credit.uncreditflag!'2'}',panelHeight:'60'" />
					</td>
					<td class="bcs-form-lable"></td>
					<td></td>
				</tr>
			</table>
			</@m.fieldset>
			
			<@m.fieldset legend="车辆信息">
			<table cellpadding="5">
				<tr>
					<td class="bcs-form-lable">品牌<@m.redStar/></td>
					<td class="">
						<!--
						<input name="brandid" value="${credit.brandid!}" type="hidden" />
						<input name="carbrand" value="${credit.carbrand!}" class="easyui-textbox bcs-form-textbox" data-options="buttonText:'选择',onClickButton:Bill.CreditInfo.selectCar" />
						-->
						<!--
						<input name="carbrand" value="${credit.carbrand!}" type="hidden" />
						<select name="brandid" class="easyui-combobox bcs-form-textbox" bcs-cl="url:'/carTypeLibrary/getCar',returnList:'rows',
						queryParams:{page:1,rows:2000},setData:['carbrand']"
						data-options="value:'${credit.brandid!}',buttonText:'选择',onClickButton:Bill.CreditInfo.selectCar,panelHeight:'300',valueField:'brandid',textField:'carbrand'" />
						-->
						<input name="carbrand" value="${credit.carbrand!}" type="hidden" />
						<select name="brandid" class="easyui-combobox bcs-form-textbox" bcs-cl="data:[{brandid:'38',carbrand:'宝马'}],
						queryParams:{page:1,rows:2000},setData:['carbrand']"
						data-options="value:'${credit.brandid!}',buttonText:'选择',onClickButton:Bill.CreditInfo.selectCar,panelHeight:'300',valueField:'brandid',textField:'carbrand'" />
					</td>
					<td class="bcs-form-lable">车况<@m.redStar/></td>
					<td class="">
						<select name="carstatus" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'CarStatusType'" data-options="value:'${credit.carstatus!}',panelHeight:'90'" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">系列<@m.redStar/></td>
					<td class="">
						<!--
						<input name="seriesid" value="${credit.seriesid!}" type="hidden" />
						<input name="carseries" value="${credit.carseries!}" class="easyui-textbox bcs-form-textbox" />
						-->
						<!---->
						<input name="carseries" value="${credit.carseries!}" type="hidden" />
						<select name="seriesid" class="easyui-combobox bcs-form-textbox" bcs-cl="url:'/carTypeLibrary/getCar',returnList:'rows',
						queryParams:{page:1,rows:2000,brandid:'{#brandid}'},setData:['carbrand']"
						data-options="value:'${credit.seriesid!}',panelHeight:'300',valueField:'seriesid',textField:'carseries'" />
						
						<!--
						<input name="carseries" value="${credit.carseries!}" type="hidden" />
						<select name="seriesid" class="easyui-combobox bcs-form-textbox" bcs-cl="data:[{seriesid:'699',carseries:'3系三厢'}],
						queryParams:{page:1,rows:2000,brandid:'{#brandid}'},setData:['carseries']"
						data-options="value:'${credit.seriesid!}',panelHeight:'300',valueField:'seriesid',textField:'carseries'" />
						-->
					</td>
					<td class="bcs-form-lable">车辆出厂日期<@m.redStar/></td>
					<td class="">
						<input name="productdate" value="${credit.productdate!}" class="easyui-datebox bcs-form-textbox" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">款式<@m.redStar/></td>
					<td class="">
						<!-- -->
						<input name="typeid" value="${credit.typeid!}" type="hidden" />
						<input name="cartype" value="${credit.cartype!}" class="easyui-textbox bcs-form-textbox" />
						
						<!--
						<input name="cartype" value="${credit.cartype!}" type="hidden" />
						<select name="typeid" class="easyui-combobox bcs-form-textbox" bcs-cl="url:'/carTypeLibrary/getCar',returnList:'rows',
						queryParams:{page:1,rows:2000},setData:['cartype']"
						data-options="value:'${credit.typeid!}',panelHeight:'300',valueField:'typeid',textField:'cartype'" />
						-->
					</td>
					<td class="bcs-form-lable">车辆登记日期<@m.redStar/></td>
					<td class="">
						<input name="carinputdate" value="${credit.carinputdate!}" class="easyui-datebox bcs-form-textbox" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">厂商名称<@m.redStar/></td>
					<td class="">
						<input name="mfrname" value="${credit.mfrname!}" class="easyui-textbox bcs-form-textbox" />
					</td>
					<td class="bcs-form-lable">行驶里程<@m.redStar/></td>
					<td class="">
						<input name="journey" value="${credit.journey!}" class="easyui-textbox bcs-form-textbox" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">年款<@m.redStar/></td>
					<td class="">
						<select name="yeargroup" class="easyui-combobox bcs-form-textbox" data-options="value:'${credit.yeargroup!}',panelHeight:'90'">
							<option value="2017">2017款</option>
							<option value="2016">2016款</option>
						</select>
					</td>
					<td class="bcs-form-lable">车辆年龄<@m.redStar/></td>
					<td class="">
						<input name="caryear" value="${credit.caryear!}" class="easyui-numberbox bcs-form-textbox" data-options="min:0,precision:2" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">公告代码<@m.redStar/></td>
					<td class="">
						<input name="cataloguenumber" value="${credit.cataloguenumber!}" class="easyui-textbox bcs-form-textbox" />
					</td>
					<td class="bcs-form-lable">过户次数<@m.redStar/></td>
					<td class="">
						<input name="transfertimes" value="${credit.transfertimes!}" class="easyui-numberbox bcs-form-textbox" data-options="min:0,max:1000,precision:0" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">颜色<@m.redStar/></td>
					<td class="">
						<input name="carcolour" value="${credit.carcolour!}" class="easyui-textbox bcs-form-textbox" />
					</td>
					<td class="bcs-form-lable">车架号<@m.redStar/></td>
					<td class="">
						<input name="carframe" value="${credit.carframe!}" class="easyui-numberbox bcs-form-textbox" data-options="min:0,max:1000,precision:0" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">购车用途<@m.redStar/></td>
					<td class="">
						<select name="carcaruse" class="easyui-combobox bcs-form-textbox" data-options="value:'${credit.carcaruse!}',panelHeight:'60'">
							<option value="01">商用</option>
							<option value="02">自用</option>
						</select>
					</td>
					<td class="bcs-form-lable">发动机号<@m.redStar/></td>
					<td class="">
						<input name="enginenumber" value="${credit.enginenumber!}" class="easyui-textbox bcs-form-textbox" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">车辆售价<@m.redStar/></td>
					<td class="">
						<input name="vehicleprice" value="${credit.vehicleprice!}" class="easyui-numberbox bcs-form-textbox" data-options="min:0,max:90000000,precision:2" />
					</td>
					<td class="bcs-form-lable">车辆规格<@m.redStar/></td>
					<td class="">
						<select name="carspecifications" class="easyui-combobox bcs-form-textbox" data-options="value:'${credit.carspecifications!'02'}',panelHeight:'60'">
							<option value="01">美规车</option>
							<option value="02">中规车</option>
						</select>
					</td>
				</tr>
			</table>
			</@m.fieldset>
			
			<@m.fieldset legend="贷款信息">
			<table cellpadding="5">
				<tr>
					<td class="bcs-form-lable">产品名称<@m.redStar/></td>
					<td class="">
						<input type="hidden" name="businesstype" />
						<input type="hidden" name="productversion" />
						<input name="typename" value="${credit.typename!}" class="easyui-textbox bcs-form-textbox" data-options="buttonText:'选择',onClickButton:Bill.CreditInfo.selectProduct" />
					</td>
					<td class="bcs-form-lable">贷款期限<@m.redStar/></td>
					<td class="">
						<select name="periods" class="easyui-combobox bcs-form-textbox" data-options="value:'${credit.periods!}',panelHeight:'120'">
							<option value="12">12</option>
							<option value="24">24</option>
							<option value="36">36</option>
							<option value="36">48</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">首付款比例<@m.redStar/></td>
					<td class="">
						<input name="paymentrate" value="${credit.paymentrate!}" class="easyui-numberbox bcs-form-textbox" data-options="min:0,max:100,precision:2" />
					</td>
					<td class="bcs-form-lable">贷款利率<@m.redStar/></td>
					<td class="">
						<input name="creditrate" value="${credit.creditrate!}" class="easyui-numberbox bcs-form-textbox" data-options="disabled:true,min:0,max:100,precision:5" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">首付金额<@m.redStar/></td>
					<td class="">
						<input name="paymentsum" value="${credit.paymentsum!}" class="easyui-numberbox bcs-form-textbox" data-options="disabled:true,min:0,max:99999999,precision:2" />
					</td>
					<td class="bcs-form-lable">贷款金额<@m.redStar/></td>
					<td class="">
						<input name="businesssum" value="${credit.businesssum!}" class="easyui-numberbox bcs-form-textbox" data-options="disabled:true,precision:2" />
					</td>
				</tr>
				<tr>
					<td class="bcs-form-lable">月还款金额<@m.redStar/></td>
					<td class="">
						<input name="monthrepayment" value="${credit.monthrepayment!}" class="easyui-numberbox bcs-form-textbox" data-options="disabled:true,precision:2" />
					</td>
					<td class="bcs-form-lable">月还款本息<@m.redStar/></td>
					<td class="">
						<input name="monthrepayment2" value="${credit.monthrepayment2!}" class="easyui-numberbox bcs-form-textbox" data-options="disabled:true,precision:2" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">基于评估价的贷款比例<@m.redStar/></td>
					<td class="">
						<input name="creditrates" value="${credit.creditrates!}" class="easyui-numberbox bcs-form-textbox" data-options="disabled:true,precision:5" />
					</td>
					<td class="bcs-form-lable"></td>
					<td></td>
				</tr>
			</table>
			</@m.fieldset>
			
			<@m.fieldset legend="费用信息">
			<table cellpadding="5">
				<tr>
					<td class="bcs-form-lable">保险金额<@m.redStar/></td>
					<td class="">
						<input name="certtypexx1" value="${credit.creditrates!}" class="easyui-numberbox bcs-form-textbox" data-options="disabled:true,precision:2" />
					</td>
					<td class="bcs-form-lable">车牌费<@m.redStar/></td>
					<td class="">
						<input name="certtypexx2" value="${credit.creditrates!}" class="easyui-numberbox bcs-form-textbox" data-options="disabled:true,precision:2" />
					</td>
				</tr>
			</table>
			</@m.fieldset>
			
			<@m.fieldset legend="代扣信息">
			<table cellpadding="5">
				<tr>
					<td class="bcs-form-lable">代扣账户名称<@m.redStar/></td>
					<td class="">
						<input name="replacename" value="${credit.replacename!}" class="easyui-textbox bcs-form-textbox" />
					</td>
					<td class="bcs-form-lable">代扣账号类型<@m.redStar/></td>
					<td class="">
						<select name="replaceaccounttype" class="easyui-combobox bcs-form-textbox" data-options="value:'${credit.replaceaccounttype!'02'}',panelHeight:'60'">
							<option value="01">存折</option>
							<option value="02">银行卡</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">代扣开户银行名称<@m.redStar/></td>
					<td class="">
						<input name="openbankname" value="${credit.openbankname!}" type="hidden"/>
						<select name="openbank" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'BankCode',setData:['itemName:openbankname']"
						data-options="value:'${credit.openbank!}',panelHeight:'300',valueField:'typeNo',textField:'typeName'" />
					</td>
					<td class="bcs-form-lable">代扣账号<@m.redStar/></td>
					<td class="">
						<input name="replaceaccount" value="${credit.replaceaccount!}" class="easyui-textbox bcs-form-textbox" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">代扣开户支行名称<@m.redStar/></td>
					<td class="">
						<select name="openbranch" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'ParamBankBranch',queryParams:{itemNo:'{#openbank}'}"
						data-options="value:'${credit.openbranch!}',panelHeight:'300',valueField:'typeNo',textField:'typeName',limitToList:true" />
					</td>
					<td class="bcs-form-lable"></td>
					<td></td>
				</tr>
			</table>
			</@m.fieldset>
			
			<@m.fieldset legend="放款信息">
			<table cellpadding="5">
				<tr>
					<td class="bcs-form-lable">放款对象<@m.redStar/></td>
					<td class="">
						<select name="putoutobj" class="easyui-combobox bcs-form-textbox" data-options="value:'${credit.putoutobj!'01'}',panelHeight:'60'">
							<option value="01">经销商</option>
							<option value="02">客户</option>
						</select>
					</td>
					<td class="bcs-form-lable"></td>
					<td></td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">放款账户名称<@m.redStar/></td>
					<td class="">
						<input name="putoutacctname" value="${credit.putoutacctname!}" class="easyui-textbox bcs-form-textbox" />
					</td>
					<td class="bcs-form-lable">开户行省份<@m.redStar/></td>
					<td class="">
						<select name="putoutprovince" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'Province'"
						data-options="value:'${credit.putoutprovince!}',panelHeight:'300',valueField:'typeNo',textField:'typeName',limitToList:true,onSelect:function(){
						}" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">放款开户银行名称<@m.redStar/></td>
					<td class="">
						<input name="putoutbankname" value="${credit.putoutbankname!}" type="hidden"/>
						<select name="putoutbankno" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'BankCode',setData:['itemName:putoutbankname']"
						data-options="value:'${credit.putoutbankno!}',panelHeight:'300',valueField:'typeNo',textField:'typeName'" />
					</td>
					<td class="bcs-form-lable">开户行城市<@m.redStar/></td>
					<td class="">
						<select name="putoutcity" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'City',queryParams:{itemNo:'{#putoutprovince}'}"
						data-options="value:'${credit.putoutcity!}',panelHeight:'300',valueField:'typeNo',textField:'typeName',limitToList:true" />
					</td>
				</tr>
				
				<tr>
					<td class="bcs-form-lable">放款开户支行名称<@m.redStar/></td>
					<td class="">
						<input name="putoutbrhbankname" value="${credit.putoutbrhbankname!}" type="hidden"/>
						<select name="putoutbrhbankno" class="easyui-combobox bcs-form-textbox" bcs-cl="codeNo:'ParamBankBranch',queryParams:{itemNo:'{#putoutbankno}',extendAttribute:'{#putoutcity}'}"
						data-options="value:'${credit.putoutbrhbankno!}',panelHeight:'300',valueField:'typeNo',textField:'typeName',limitToList:true" />
					</td>
					<td class="bcs-form-lable">放款账号<@m.redStar/></td>
					<td class="">
						<input name="putoutacctno" value="${credit.putoutacctno!}" class="easyui-textbox bcs-form-textbox" />
					</td>
				</tr>
			</table>
			</@m.fieldset>
		</form>
	</div>
	</div>
	<!-- 表单  END-->
	
	<div style="padding-bottom: 200px;"></div>
	<!-- BODY END -->

	<!-- JAVASCRIPT BEGIN -->
	<script type="text/javascript">
	createPageObject("Bill.CreditInfo",function(page){
		page.ready = function(){
			page.$form = $("#CreditInfoForm");
			page.$form.form('disableValidation').form('validate');
		};
		/**选择经销商之后*/
		page.onSelectDealer = function(recode){
			//获取DRM信息
			page.drmList = recode.drmList;
			if(!page.drmList || page.drmList.length <1) return $.mytools.warningAlert("经销商DRM信息获取失败");
			page.$form.formData({drmid:page.drmList[0].userId,drmname:page.drmList[0].userName,drmtelephone:page.drmList[0].userTel});
		};
		
		/**选择车型*/
		page.selectCar = function(){
			openDialogPage("SelectCarDialog","/bill/credit/toSelectCar",function(carMode){
				page.$form.formData(carMode);
			});
		};
		/**选择产品*/
		page.selectProduct = function(){
			openDialogPage("SelectProductDialog","/bill/credit/toSelectProduct".replaceData(page.$form),function(product){
				debugger;
				page.$form.formData(product);
			});
		};
		/**暂存*/
		page.saveTemp = function(){
			debugger;
			//表单数据
			page.$form.form('disableValidation').form('validate');
			var data = page.$form.formData();
			doPostJson("/bill/credit/saveTemp",data,function(reData){
				Bill.DetailsMain.tab_refresh();
			});
		};
		/**保存*/
		page.saveCredit = function(){
			//表单数据
			var validate = page.$form.form('enableValidation').form('validate');
			if(!validate) return; 
			//表单数据
			var data = page.$form.formData();
			doPostJson("/bill/credit/saveCredit",data,function(reData){
				Bill.DetailsMain.tab_refresh();
			});
		};
	});
	</script>
	<!-- JAVASCRIPT END -->
</@m.htmlTemplate>