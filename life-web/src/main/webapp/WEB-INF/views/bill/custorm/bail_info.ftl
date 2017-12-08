<#-- macro -->
<#import "../../base/ftl-lib.ftl" as m />
<#include "../../base/edit-page.ftl" />

<#-- 需要引入额外的js脚本时，往javascripts中加 -->
<@m.htmlTemplate title="任务清单编辑" javascripts=[]>
	<!-- BODY BEGIN -->
	<@m.navTips content="添加保证人"/>
	
	<!-- 表单  BEGIN-->
	<div id="area-form" style="width: 100%;background-color:white;">
		<div style="padding: 10px 60px 15px 5px;">
			<form id="bail-info-guarantor" class="easyui-form" method="post" data-options="novalidate:true">
				<input type="hidden" name="serialno" data-options="required:true" value="${serialno}"/>
				<table cellpadding="5">
					<tr>
						<@m.select selectId="relationstatus" optionId="relationstatusItem" title="客户类型" defaultValue="请选择" onclick="getCodeLibrary('relationstatusItem','CustomerType');" required="true"/>
					</tr>
					<tr>
						<@m.text id="customername" title="客户名称"/>
					</tr>
					<tr>
						<@m.select selectId="certtype" optionId="certtypeItemBail" title="证件类型" defaultValue="请选择" onclick="getCodeLibrary('certtypeItemBail','CertType');" required="true"/>
					</tr>
					<tr>
						<@m.text id="certid" title="证件号码"/>
					</tr>
					<tr>
						<@m.select selectId="customerrelation" optionId="customerrelationItem" title="与主审人申请关系" defaultValue="请选择" onclick="getCodeLibrary('customerrelationItem','ApplyRelationType');"/>
					</tr>
				</table>
			</form>
			
			<div style="margin-left: 120px; padding-top: 10px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitFormGuarantor()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="resetGuarantor()">重置</a>
			</div>
		</div>
	</div>
	<!-- 表单  END-->

	<!-- BODY END -->

	<!-- JAVASCRIPT BEGIN -->
	<script type="text/javascript">
		function submitFormGuarantor() {
			submit("bail-info-guarantor", {
				url:"${basePath}/bill/custorm/saveBailInfo",
				success:function(result) {
					console.log(result);
					var result = eval('(' + result + ')');
                    var rowData = result.data;
					
					if(result.code == '200') {
                        $.mytools.successAlert("保存成功",function(){
                            insertRowData(rowData);
                            $("#editCondition").dialog("close");
                        });
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
		
		function resetGuarantor() {
			resetForm("bail-info-guarantor");
		}

        function insertRowData(data){
            var newRow = todoGridGuarantor.insertRow();
            newRow.className = "datagrid-row";
            newRow.style = "height: 35px";
            newRow.insertCell().innerHTML = '<div style="height:auto;" class="datagrid-cell">'+data.relationstatus+'</div>';
            newRow.insertCell().innerHTML = '<div style="height:auto;" class="datagrid-cell">'+data.customername+'</div>';
            newRow.insertCell().innerHTML = '<div style="height:auto;" class="datagrid-cell">'+data.certtype+'</div>';
            newRow.insertCell().innerHTML = '<div style="height:auto;" class="datagrid-cell">'+data.certid+'</div>';
            newRow.insertCell().innerHTML = '<div style="height:auto;" class="datagrid-cell">'+data.customerrelation+'</div>';
        }
	</script>
	<!-- JAVASCRIPT END -->
</@m.htmlTemplate>