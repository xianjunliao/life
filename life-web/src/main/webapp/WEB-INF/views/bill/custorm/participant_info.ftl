<#-- macro -->
<#import "../../base/ftl-lib.ftl" as m />
<#include "../../base/edit-page.ftl" />

<#-- 需要引入额外的js脚本时，往javascripts中加 -->
<@m.htmlTemplate title="任务清单编辑" javascripts=[]>
	<!-- BODY BEGIN -->
	<@m.navTips content="添加联系人信息"/>
	
	<!-- 表单  BEGIN-->
	<div id="area-form" style="width: 100%;background-color:white;">
		<div style="padding: 10px 60px 15px 5px;">
			<form id="address_form" class="easyui-form" method="post" data-options="novalidate:true">
				<table cellpadding="5">
                    <tr>
						<@m.text id="participantname" title="姓名"/>
                    </tr>
                    <tr>
						<@m.text id="participantphone" title="联系人号码"/>
                    </tr>
					<tr>
						<@m.select selectId="participantstatus" optionId="participantstatusItem" title="与申请人关系" defaultValue="请选择" onclick="getCodeLibrary('participantstatusItem','ApplyRelationType');"/>
					</tr>
					<tr>
						<@m.select selectId="province" optionId="provinceItem" title="省" defaultValue="请选择您所在省份" onchange="getCity('province','cityItem');" required="true"/>
					</tr>
					<tr>
						<@m.select selectId="city" optionId="cityItem" title="市" defaultValue="请选择您所在城市" onchange="getDistrict('city','areaItem');" required="true"/>
					</tr>
					<tr>
						<@m.select selectId="area" optionId="areaItem" title="区域" defaultValue="请选择您所在城市" required="true"/>
					</tr>
					<tr>
						<@m.text id="township" title="乡镇"/>
					</tr>
					<tr>
						<@m.text id="street" title="街道"/>
					</tr>
					<tr>
						<@m.text id="cell" title="小区"/>
					</tr>
					<tr>
						<@m.text id="room" title="房间"/>
					</tr>
				</table>
				<div style="margin-left: 120px; padding-top: 10px">
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitFormParticipant()">保存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="resetParticipant()">重置</a>
				</div>
			</form>
			
			
		</div>
	</div>
	<!-- 表单  END-->

	<!-- BODY END -->

	<!-- JAVASCRIPT BEGIN -->
	<script type="text/javascript">
        $(function() {
            //初始化省市区
            getProvince("provinceItem");
        });

		function submitFormParticipant() {
			submit("address_form", {
				url:"${basePath}/bill/custorm/saveParticipant",
				success:function(result) {
                    console.log(result);
					result = eval('(' + result + ')');
                    var rowData = result.data;

					if(result.code == '200') {
						$.mytools.successAlert("保存成功",function(){
                            insertRowData(rowData);
							$("#editCondition").dialog("close");
						});
					} else {
						$.mytools.errorAlert(result.message);
					}
				}
			});
		}
		
		function resetParticipant() {
			resetForm("address_form");
		}

		function insertRowData(data){
			var newRow = todoGridContact.insertRow();
			newRow.className = "datagrid-row";
			newRow.style = "height: 35px";
            newRow.insertCell().innerHTML = '<div style="height:auto;" class="datagrid-cell">'+data.participantname+'</div>';
            newRow.insertCell().innerHTML = '<div style="height:auto;" class="datagrid-cell">'+data.participantphone+'</div>';
            newRow.insertCell().innerHTML = '<div style="height:auto;" class="datagrid-cell">'+data.participantstatus+'</div>';
            newRow.insertCell().innerHTML = '<div style="height:auto;" class="datagrid-cell">'+data.participantadd+'</div>';
		}

    </script>
	<!-- JAVASCRIPT END -->
</@m.htmlTemplate>