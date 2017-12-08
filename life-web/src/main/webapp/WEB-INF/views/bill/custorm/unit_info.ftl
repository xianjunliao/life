<#-- macro -->
<#import "../../base/ftl-lib.ftl" as m />
<#include "../../base/edit-page.ftl" />

<#-- 需要引入额外的js脚本时，往javascripts中加 -->
<@m.htmlTemplate title="任务清单编辑" javascripts=[]>
	<!-- BODY BEGIN -->
	<@m.navTips content="添加单位信息"/>
	
	<!-- 表单  BEGIN-->
	<div id="area-form" style="width: 100%;background-color:white;">
		<div style="padding: 10px 60px 15px 5px;">
			<form id="address_form" class="easyui-form" method="post" data-options="novalidate:true">
                <input type="hidden" name="customerid" data-options="required:true" value="${customerId}"/>
                <input type="hidden" name="addtype" data-options="required:true" value="${addType}"/>
                <table cellpadding="5">
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
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitFormUnit()">保存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="resetUnit()">重置</a>
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

		function submitFormUnit() {
			submit("address_form", {
				url:"${basePath}/bill/custorm/saveUnitInfo",
				success:function(result) {
					console.log(result);
					var result = eval('(' + result + ')');
					
					if(result.code == '200') {
					
						$.mytools.successAlert("保存成功",function() {
                            var addType = $("input[name='addtype']").val();
                            if ("1" == addType) {
                                var v_workAddId = $("input[name='workAddId']");
                                if (!isUndefined(v_workAddId)) {
                                    $("#workAddId").textbox("setValue", result.data);
                                    $("#editCondition").dialog("close");
                                }
                            }else{
                                var v_familyAddDetail = $("input[name='familyAddDetail']");
                                if (!isUndefined(v_familyAddDetail)) {
                                    $("#familyAddDetail").textbox("setValue", result.data);
                                    $("#editCondition").dialog("close");
                                }
							}
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
		
		function resetUnit() {
			resetForm("address_form");
		}
	</script>
	<!-- JAVASCRIPT END -->
</@m.htmlTemplate>