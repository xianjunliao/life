<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../JqueryHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link href="${base}static/css/finance/common.css" rel="stylesheet" type="text/css">
<link href="${base}static/css/finance/finance_main.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${base}static/js/finance/common.js"></script>
<script type="text/javascript" src="${base}static/js/finance/finance_main.js"></script>

<style>
</style>
<script type="text/javascript">
	var baseUrl = "${base}";
</script>
</head>
<body>
	<div class="finance-settings">
		<div class="finance-settings-type">每日固定消费额度设置</div>
		<div class="finance-settings-type">信用卡每月还款额度设置</div>
		<div class="finance-settings-type">信用卡设置</div>
		<div class="finance-settings-type">支付宝管理</div>
		<div class="finance-settings-type">微信钱包管理</div>
		<div class="finance-settings-type">工资额度</div>
		<div class="finance-settings-type">其他收入额度</div>
		<div class="eliminate-float"></div>
	</div>
	<div class="finance-record">
		<!-- 		<div class="finance-record-buttons"> -->
		<!-- 			<div class="finance-record-confirm expenditure">确认消费</div> -->
		<!-- 			<div class="finance-record-confirm repayment">确认还款</div> -->
		<!-- 			<div class="finance-record-confirm income">确认收入</div> -->
		<!-- 			<div class="eliminate-float"></div> -->
		<!-- 		</div> -->
		<div class="finance-record-table-type">
			<div class="finance-record-tables">
				<table>
					<thead>
						<tr>
							<th>消费日期</th>
							<th>消费类型</th>
							<th>消费额度</th>
							<th>是否确认</th>
						</tr>
					</thead>
					<tbody>
						<tr class="record-tables-tr">
							<td>2018-04-23</td>
							<td>固定消费</td>
							<td>33332.00</td>
							<td>否</td>
						</tr>
					</tbody>
					<tfoot>
						<td colspan="4" align="right"><button>添加</button></td>
					</tfoot>
				</table>
			</div>
			<div class="finance-record-tables">
				<table>
					<thead>
						<tr>
							<th>还款日期</th>
							<th>还款方</th>
							<th>还款额度</th>
							<th>是否确认</th>
						</tr>
					</thead>
					<tbody>
						<tr class="record-tables-tr">
							<td>2018-04-27</td>
							<td>招商信用卡</td>
							<td>1500</td>
							<td>否</td>
						</tr>
					</tbody>
					<tfoot>
						<td colspan="4" align="right"><button>添加</button></td>
					</tfoot>
				</table>
			</div>
			<div class="finance-record-tables">
				<table>
					<thead>
						<tr>
							<th>收入日期</th>
							<th>收入类型</th>
							<th>收入额度</th>
							<th>是否确认</th>
						</tr>
					</thead>
					<tbody>
						<tr class="record-tables-tr">
							<td>2018-04-15</td>
							<td>工资卡</td>
							<td>9000</td>
							<td>否</td>
						</tr>
					</tbody>
					<tfoot>
						<td colspan="4" align="right"><button>添加</button></td>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
	<div class="finance-tatal">统计</div>
</body>
</html>
