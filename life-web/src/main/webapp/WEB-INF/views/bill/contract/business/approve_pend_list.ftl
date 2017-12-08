<#-- macro -->
<#import "../../../base/ftl-lib.ftl" as m />
<#include "../../../base/list-page.ftl" />
<#include "../../../base/edit-page.ftl" />

<#-- 需要引入额外的js脚本时，往javascripts中加 -->
<@m.htmlTemplate title="待审批" javascripts=[] >
	<!-- BODY BEGIN -->
	<@m.navTips content="工作台 &gt; 提单系统 &gt; 业务处理 &gt; 待审批"/>
	
	<!-- 表单  BEGIN-->
	<div id="area-form" style="width: 100%;">
		<div style="padding: 10px 60px 15px 5px;">
			<form id="searchForm" class="easyui-form" method="post" data-options="novalidate:true">
                <input type="text" name="selectFlag" value="${contractListInfo.selectFlag}" hidden="hidden"/>
                <input type="text" name="phaseType" value="${contractListInfo.phaseType}" hidden="hidden"/>
				<table cellpadding="5">
                    <tr>
						<@m.select selectId="businessCategory" optionId="businessCategoryItem" title="业务类型" onclick="getCodeLibrary('businessCategoryItem','BusinessCategory');" width="120"/>
						<@m.text id="typeName" title="产品名称" width="120"/>
						<@m.text id="serialNo" title="合同号" width="120"/>
                    </tr>
                    <tr>
						<@m.datePeriodText beginName="applyDateBegin" endName="applyDateEnd" title="申请日期" connector="至" width="120"/>
						<@m.text id="customerName" title="客户名称" width="120"/>
                    </tr>
					<tr>
                        <td colspan="2" style="padding-left:20px;padding-top:5px">
							<a href="javascript:void(0)" class="easyui-linkbutton" onclick="conditionalQuery()">查询</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="reset()">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div id="func_operate">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="toDetail()">申请详情</a>
		</div>
	</div>
	<!-- 表单  END-->
	
	<!-- 表格  BEGIN -->
	<div id="area-dataGrid" style="width:100%;">
		<table id="todoGrid" data-options="toolbar:'#area-form'">
			<thead>
				<tr>
					<th data-options="field:'serialNo',width:80">合同号</th>
					<th data-options="field:'customerName',width:80">客户名称</th>
					<th data-options="field:'applyDate',width:80">申请日期</th>
					<th data-options="field:'businessCategory',width:80"  formatter="formatBusinessCategory">业务类型</th>
					<th data-options="field:'typeName',width:80">产品名称</th>
					<th data-options="field:'businessSum',width:80">贷款金额</th>
					<th data-options="field:'yearGroup',width:80">车型</th>
					<th data-options="field:'contractStatus',width:80"  formatter="formatContractStatus">合同状态</th>
					<th data-options="field:'contractStatus2',width:80" formatter="formatContractStatus2" >合同子状态</th>
				</tr>
			</thead>
		</table>
	</div>
	<!-- 表格  END -->

	<!-- BODY END -->

	<!-- JAVASCRIPT BEGIN -->
	<script type="text/javascript">
        //初始化
		$(function() {
            //隐藏域
            var selectFlag = $("input[name='selectFlag']").val();
            var phaseType = $("input[name='phaseType']").val();
			// 加载数据表格
			loadDataGrid("todoGrid", {
				url : "${basePath}/bill/contract/get",
                queryParams	: {
                    paramObj: {
                        "selectFlag": selectFlag,
                        "phaseType": phaseType
                    }}
			});
			// datagrid自适应窗口大小改变
			datagridWindowResizeFit("todoGrid", 5, 25);
		});

        // 数据查询并更新表格数据
        function conditionalQuery() {
            var businessCategory = $("#businessCategory").val();
            var typeName = $("input[name='typeName']").val();
            var serialNo = $("input[name='serialNo']").val();
            var applyDateBegin = $("input[name='applyDateBegin']").val();
            var applyDateEnd = $("input[name='applyDateEnd']").val();
            var customerName = $("input[name='customerName']").val();

            //隐藏域
            var selectFlag = $("input[name='selectFlag']").val();
            var phaseType = $("input[name='phaseType']").val();
            searchAndReloadGrid("todoGrid", {
                paramObj:{
                    "businessCategory": businessCategory,
                    "typeName": typeName,
                    "serialNo": serialNo,
                    "applyDateBegin": applyDateBegin,
                    "applyDateEnd": applyDateEnd,
                    "customerName": customerName,
                    "selectFlag": selectFlag,
                    "phaseType": phaseType
                }
            });
        }

        //列表的 字典值处理
        var businessCategoryData = [];
        function formatBusinessCategory(value, row, index){
            var transData = "";
            if(index==0){
                businessCategoryData = getCodeLibraryToTrans("BusinessCategory");
            }
            if(null!=row && null!=row.businessCategory) {
                $.each(businessCategoryData,
                        function (i, val) {
                            if (row.businessCategory == val.itemNo) {
                                transData = val.itemName;
                                return false;
                            }
                        });
            }
            return transData;
        }

        var contractStatusData = [];
        function formatContractStatus(value, row, index){
            var transData = "";
            if(index==0){
                contractStatusData = getCodeLibraryToTrans("ContractStatus");
            }
            if(null!=row && null!=row.contractStatus) {
                $.each(contractStatusData,
                        function (i, val) {
                            if (row.contractStatus == val.itemNo) {
                                transData = val.itemName;
                                return false;
                            }
                        });
            }
            return transData;
        }

        var contractStatus2Data = [];
        function formatContractStatus2(value, row, index){
            var transData = "";
            if(index==0){
                contractStatus2Data = getCodeLibraryToTrans("ContractStatus");
            }
            if(null!=row && null!=row.contractStatus2) {
                $.each(contractStatus2Data,
                        function (i, val) {
                            if (row.contractStatus2 == val.itemNo) {
                                transData = val.itemName;
                                return false;
                            }
                        });
            }
            return transData;
        }
		//重置
        function reset() {
            resetForm("searchForm");
        }

	</script>
	<!-- JAVASCRIPT END -->

</@m.htmlTemplate>