<#-- macro -->
<#import "../../base/ftl-lib.ftl" as m />
<#include "../../base/edit-page.ftl" />

<#-- 需要引入额外的js脚本时，往javascripts中加 -->
<@m.htmlTemplate title="任务清单编辑" javascripts=[]>
	<!-- BODY BEGIN -->
	<@m.navTips content="企业信息 &gt"/>
	
	<!-- 表单  BEGIN-->
	<div id="form-area" >
	<div id="form-body" >
			<form id="ent-info" class="easyui-form" method="post" data-options="novalidate:true">
			<@m.fieldset legend="基础信息">
				<table cellpadding="5" style="width: 100%;">
					<tr>
                        <input  type="hidden" name=customerid data-options="required:true" value="${entInfo.customerid!}"/>
                        <input  type="hidden" name=serialno data-options="required:true" value="${entInfo.serialno!}"/>
						<@m.select selectId="customertype" optionId="customertypeItem" title="客户类型" defaultValue="请选择" onclick="getCodeLibrary('customertypeItem','CustomerType');" required="true"/>
						<@m.text id="workcorp" title="公司名称"/>
					</tr>
					<tr>
						<@m.select selectId="certtype" optionId="certtypeItem" title="证件类型" defaultValue="请选择" onclick="getCodeLibrary('certtypeItem','CertType');" required="true"/>
						<@m.select selectId="registertype" optionId="registertypeItem" title="注册类型" defaultValue="请选择" onclick="getCodeLibrary('registertypeItem','RegisterType');"/>
					</tr>
					<tr>
						<@m.text id="certid" title="统一社会信用代码" required="true"/>
						<@m.dateText id="registerdate" title="注册日期"/>
					</tr>
					<tr>
						<@m.text id="organizationnature" title="机构性质"/>
						<@m.dateText id="actualoperatingdate" title="实际经营日期"/>
					</tr>
					<tr>
						<@m.text id="employeenumber" title="员工人数"/>
						<@m.text id="businessplace" title="经营场所"/>
					</tr>
					<tr>
						<@m.text id="unitkind" title="公司行业类型"/>
						<@m.text id="worktel" title="公司电话"/>
					</tr>
					<tr>
						<@m.text id="annualturnover" title="年营业额"/>
						<@m.text id="companyfax" title="公司传真"/>
					</tr>
					<tr>
						<@m.text id="monthlyturnover" title="平均月营业额"/>
						<@m.text id="legalperson" title="法人姓名"/>
					</tr>
					<tr>
						<@m.text id="profit" title="净利润"/>
						<@m.text id="controlperson" title="实际控制人姓名"/>
					</tr>
					<tr>
						<@m.text id="otherincome" title="其他收入"/>
						<@m.text id="registerAddDetail" title="公司注册地址"/>
					</tr>
					<tr>
						<@m.text id="remark" title="备注"/>
						<@m.text id="workAddDetail" title="公司经营地址"/>
					</tr>
				</table>
			</@m.fieldset>
			<!-- 表格  END -->

			<!-- 表格 保证人信息  BEGIN -->
			<@m.fieldset legend="保证人信息">
			<div id="area-operate-guarantor">
				<a class="easyui-linkbutton .a-cursor-pointer" onclick="openTabEnt()">新增</a>
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
			</form>
			
			<div style="margin-left: 120px; padding-top: 10px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitFormEnt()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="resetEnt()">重置</a>
			</div>
		</div>
	</div>
	<!-- 表单  END-->
	<!-- 表格  END -->

	<!-- BODY END -->

	<!-- JAVASCRIPT BEGIN -->
	<script type="text/javascript">
		// 新增保证人
		function openTabEnt() {
			var url = "${basePath}/bill/custorm/enter/bail_info";
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
	
		$(function() {
			// 加载数据表格
			loadDataGrid("todoGrid", {
				pagination : false,
				width:$("#area-form").width()-30,
				height:300,
				//url : '${basePath}/sample/get',
				onLoadSuccess : function(data) {
					$('.button-delete').linkbutton({});
					$('.button-edit').linkbutton({});
				}
			});
		});
		function submitFormEnt() {
			submit("ent-info", {
				url:"${basePath}/bill/custorm/updateEntInfo",
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
		
		function resetEnt() {
			resetForm("ent-info");
		}
	</script>
	<!-- JAVASCRIPT END -->
</@m.htmlTemplate>