<#-- macro -->
<#import "../../base/ftl-lib.ftl" as m />
<#include "../../base/edit-page.ftl" />

<#-- 需要引入额外的js脚本时，往javascripts中加 -->
<@m.htmlTemplate title="任务清单编辑" javascripts=[]> 
	<!-- BODY BEGIN -->
	<@m.navTips content="个人信息 &gt"/>
	
	<!-- 表单  BEGIN-->
	<!-- 表单  BEGIN-->
	<div id="form-area" >
	<div id="form-body" >
		<form id="ff" class="easyui-form" method="post" data-options="novalidate:true">
			<@m.fieldset legend="基础信息">
			<div id="basic_info">
				<table cellpadding="5">
					<tr>
						<input type="hidden" name="customerid" data-options="required:true" value="${indInfo.customerid!""}"/>
						<input type="hidden" name="serialno" data-options="required:true" value="${indInfo.serialno!""}"/>
						<@m.select selectId="customertype" optionId="customertypeItem" title="客户类型" defaultValue="请选择" onclick="getCodeLibrary('customertypeItem','CustomerType');" required="true"/>
						<@m.text id="age" title="年龄"/>
					</tr>

					<tr>
						<@m.text id="customername" title="客户名称" required="true"/>
						<@m.text id="country" title="国籍"/>
					</tr>

					<tr>
						<@m.select selectId="certtype" optionId="certtypeItem" title="证件类型" defaultValue="请选择" onclick="getCodeLibrary('certtypeItem','CertType');" required="true"/>
						<@m.text id="nativeplace" title="户籍所在地" required="true"/>
					</tr>
					<tr>
						<@m.text id="certid" title="证件号码"/>
						<@m.select selectId="marriage" optionId="marriageItem" title="婚姻状况" defaultValue="请选择" onclick="getCodeLibrary('marriageItem','Marriage');" required="true"/>
					</tr>
					<tr>
						<@m.dateText id="birthday" title="出生日期"/>
						<@m.select selectId="eduexperience" optionId="eduexperienceItem" title="学历" defaultValue="请选择" onclick="getCodeLibrary('eduexperienceItem','CarEducationExperience');"/>
					</tr>
					<tr>
						<@m.select selectId="sex" optionId="sexItem" title="性别" defaultValue="请选择" onclick="getCodeLibrary('sexItem','Sex');"/>
						<@m.select selectId="edudegree" optionId="edudegreeItem" title="学位" defaultValue="请选择" onclick="getCodeLibrary('edudegreeItem','职称或最高学历');"/>
					</tr>
				</table>
				<!-- 加表格 -->
			</div>
			</@m.fieldset>
			
			<@m.fieldset legend="单位信息">
			<div id="danwei_info">
				<table cellpadding="5" style="width: 100%;">
					<tr>
						<@m.text id="workcorp" title="单位名称" required="true"/>
						<@m.text id="seniority" title="本单位工龄"/>
					</tr>
					<tr>
						<@m.text id="unitkind" title="所属行业"/>
						<@m.text id="worktel" title="办公电话"/>
					</tr>
					<tr>
						<@m.text id="occupation" title="职业"/>
						<@m.text id="headship" title="职务"/>
					</tr>
					<tr>
						<@m.text id="position" title="职称"/>
						<@m.text id="employeetype" title="雇员类型"/>
					</tr>
					<tr>
						<@m.linkText id="workAddId" title="单位地址" linkTitle="编辑" linkOnclick="openUnit()"/>
					</tr>
				</table>
			</div>
			</@m.fieldset>

			<@m.fieldset legend="个人收入信息">
			<div id="shouru_info">
			<table cellpadding="5" style="width: 100%;">
				<tr>
					<@m.text id="childrentotal" title="子女数目" required="true"/>
				</tr>
				<tr>
					<@m.text id="oneselfincome" title="本人月收入" required="true"/>
					<@m.text id="monthexpend" title="家庭月支出"/>
				</tr>
				<tr>
					<@m.text id="spouseincome" title="配偶月收入"/>
					<@m.text id="creditmonth" title="贷款月供"/>
				</tr>
				<tr>
					<@m.text id="otherrevenue" title="其他月收入"/>
					<@m.text id="rentexpend" title="月房租支出"/>
				</tr>
				<tr>
					<@m.text id="monthtotal" title="月总收入"/>
					<@m.text id="netmargin" title="月净收入"/>
				</tr>
			</table>
			</div>
			</@m.fieldset>

			<@m.fieldset legend="居住信息">
			<div id="juzhu_info">
			<table cellpadding="5" style="width: 100%;">
				<tr>
					<@m.text id="postalAddDetail" title="通讯地址"/>
					<@m.text id="familystatus" title="住宅类型"/>
				</tr>
				<tr>
					<@m.text id="flag5" title="有无房产"/>
					<@m.text id="startroomdate" title="自何时开始居住"/>
				</tr>
				<tr>
					<@m.text id="housedate" title="购买第一套房时间"/>
					<@m.text id="liveduration" title="居住时长(年)"/>
				</tr>
				<tr>
					<@m.text id="mobiletelephone" title="手机号码"/>
					<@m.text id="familytel" title="住宅电话"/>
				</tr>
				<tr>
					<@m.text id="emailadd" title="电子邮箱"/>
					<@m.text id="familyzip" title="邮政编码"/>
				</tr>
				<tr>
					<@m.linkText id="familyAddDetail" title="住宅地址" linkTitle="新增" linkOnclick="addhomeAddress()"/>
				</tr>
				</table>
				</div>
			</@m.fieldset>

			<@m.fieldset legend="配偶信息">
			<div id="peiou_info">

			<table cellpadding="5" style="width: 100%;">
				<tr>
					<@m.text id="spousename" title="配偶姓名"/>
					<@m.text id="spousetel" title="配偶号码"/>
				</tr>
				<tr>
					<@m.text id="spouseCerttype" title="配偶证件类型"/>
					<@m.text id="spouseAddDetail" title="配偶单位地址"/>
				</tr>
				<tr>
					<@m.text id="spouseCertid" title="配偶证件号"/>
				</tr>
				<tr>
					<@m.text id="spouseWorkcorp" title="配偶单位名称"/>
				</tr>
			</table>
			</div>
			</@m.fieldset>

			<!-- 表格 联系人信息  BEGIN -->
			<@m.fieldset legend="联系人信息">
			<div id="area-operate-contact">
				<a class="easyui-linkbutton .a-cursor-pointer" onclick="openTabPartic()">新增</a>
				<a class="easyui-linkbutton .a-cursor-pointer" onclick="openEditContract()">编辑</a>
				<a class="easyui-linkbutton .a-cursor-pointer" onclick="deleteContract()">删除</a>
			</div>
			<div class="datagrid-body" style="width:100%;">
				<table class="datagrid-btable" cellspacing="0" cellpadding="0" border="0">
					<thead>
					<tr class="datagrid-header-row" style="background-color:#EAEAEA;">
						<td field="participantname" style="width:200px;"><div class="datagrid-cell">姓名</div></td>
						<td field="participantphone" style="width:200px;"><div class="datagrid-cell">联系人号码</div></td>
						<td field="participantstatus" style="width:200px;"><div class="datagrid-cell">与申请人关系</div></td>
						<td field="participantadd" style="width:260px;"><div class="datagrid-cell">联系人住宅地址</div></td>
					</tr>
					</thead>
					<tbody id="todoGridContact">

					</tbody>
				</table>
			</div>
			</@m.fieldset>
			<!-- 表格  END -->

				<!-- 表格 保证人信息  BEGIN -->
			<@m.fieldset legend="保证人信息">
			<div id="area-operate-guarantor">
				<a class="easyui-linkbutton .a-cursor-pointer" onclick="openTab()">新增</a>
				<a class="easyui-linkbutton .a-cursor-pointer" onclick="openGuarantorDetail()">详情</a>
				<a class="easyui-linkbutton .a-cursor-pointer" onclick="deleteGuarantor()">删除</a>
			</div>
			<div class="datagrid-body" style="width:100%;">
				<table class="datagrid-btable" cellspacing="0" cellpadding="0" border="0">
                    <thead>
                    <tr class="datagrid-header-row" style="background-color:#EAEAEA;">
                        <td field="relationstatus" style="width:180px;"><div class="datagrid-cell">客户类型</div></td>
                        <td field="customername" style="width:180px;"><div class="datagrid-cell">客户名称</div></td>
                        <td field="certtype1" style="width:180px;"><div class="datagrid-cell">证件类型</div></td>
                        <td field="certid" style="width:200px;"><div class="datagrid-cell">证件号码</div></td>
                        <td field="customerrelation" style="width:180px;"><div class="datagrid-cell">与申请人关系</div></td>
                    </tr>
                    </thead>
					<tbody id="todoGridGuarantor">

					</tbody>
				</table>
			</div>
			</@m.fieldset>
			<!-- 表格  END -->
			
		</form>
			
		<div style="margin-left: 120px; padding-top: 10px">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">保存</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="reset()">重置</a>
		</div>
	</div>
</div>
<!-- 表单  END-->

<!-- 弹窗  END-->
<div id="windows-container">
		<div id="editCondition" style="width:40%;height:40%;"></div>
</div>
	

	<!-- BODY END -->

	<!-- JAVASCRIPT BEGIN -->
	<script type="text/javascript">
		// 编辑单位地址
		function openUnit() {
			var customerid = $("input[name='customerid']").val();
			console.log("customerid-ind="+customerid);
			var url = "${basePath}/bill/custorm/getUnitInfo?customerId="+customerid+"&addType=1";
			addTodoList('editCondition',url,'模板条件新增');
		}

		// 编辑住宅地址
		function addhomeAddress(){
			var customerid = $("input[name='customerid']").val();
			console.log("customerid-ind="+customerid);
			var url = "${basePath}/bill/custorm/getUnitInfo?customerId="+customerid+"&addType=2";
			addTodoList('editCondition',url,'模板条件新增');
		}

		// 新增联系人
		function openTabPartic() {
			var url = "${basePath}/bill/custorm/enter/participant_info";
			addTodoList('editCondition',url,'模板条件新增');
		}

		// 新增保证人
		function openTab() {
			var serialno = $("input[name='serialno']").val();
			var url = "${basePath}/bill/custorm/getBailInfo?serialno="+serialno;
			addTodoList('editCondition',url,'模板条件新增');
		}

		/* ################### 弹窗  #################### */
		function addTodoList(domId,url,title){
			createDialog(domId, {
				title: title,
				href:url,
				fit:false
			});
		}
	
		
		function submitForm() {
			submit("ff", {
				url:"${basePath}/bill/custorm/updateIndInfo",
				success:function(result) {
					console.log(result);
					var result = eval('(' + result + ')');
					
					if(result.code == '200') {
						$(":hidden[name='customerid']").val(result.data);
						$.mytools.successAlert("保存成功");
					} else {
						$.mytools.errorAlert(result.message);
					}
				},
				error:function(e){
					$.mytools.errorAlert("保存失败！");
					console.log(e);
				}
			});
		}
		
		function reset() {
			resetForm("ff");
		}
		
		function closeWindow(){
			$("#editCondition").dialog("close");
		}
		
	</script>
	<!-- JAVASCRIPT END -->
</@m.htmlTemplate>