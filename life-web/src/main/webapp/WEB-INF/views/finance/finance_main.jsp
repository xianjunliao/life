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
<script type="text/javascript">
	var base = "${base}";
</script>
<script type="text/javascript" src="${base}static/js/finance/common.js"></script>
<script type="text/javascript" src="${base}static/js/finance/finance_main.js"></script>
<script type="text/javascript" src="${base}static/js/finance/finance_statistics.js"></script>
<style>
</style>
</head>
<body>
	<div class="finance-settings">
		<div class="finance-settings-type" onclick="settingFixed()">每日固定消费设置</div>
		<div class="finance-settings-type">支付方式设置</div>
		<div class="finance-settings-type">显示消费明细记录</div>
		<div class="finance-settings-type">显示消费汇总记录</div>
		<div class="finance-settings-type">显示统计图</div>
		<!-- 		<div class="finance-settings-type">信用卡设置</div> -->
		<!-- 		<div class="finance-settings-type">支付宝管理</div> -->
		<!-- 		<div class="finance-settings-type">微信钱包管理</div> -->
		<!-- 		<div class="finance-settings-type">工资额度</div> -->
		<!-- 		<div class="finance-settings-type">其他收入额度</div> -->
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
			<div>
				<table class="finance-record-tables">
					<thead>
						<tr>
							<th>年份</th>
							<th>季度</th>
							<th>月份</th>
							<th>星期</th>
							<th>消费日期</th>
							<th>消费名称</th>
							<th>消费类型</th>
							<th>消费方式</th>
							<th>消费额度</th>
							<th>备注</th>
						</tr>
					</thead>
					<tbody>
						<tr class="record-tables-tr" onclick="showOperation()">
							<td>2018年</td>
							<td>第一季</td>
							<td>4月</td>
							<td>第17周</td>
							<td>2018-04-23</td>
							<td>早餐</td>
							<td>支出</td>
							<td>微信</td>
							<td align="right">5.00</td>
							<td align="left">第二个参数可以指定前面引入的主题.</td>
						</tr>
						<tr class="record-tables-tr">
							<td>2018年</td>
							<td>第一季</td>
							<td>4月</td>
							<td>第17周</td>
							<td>2018-04-24</td>
							<td>早餐</td>
							<td>支出</td>
							<td>支付宝</td>
							<td align="right">6.00</td>
							<td align="left">第二个参数可以指定前面引入的主题............</td>
						</tr>
					</tbody>
					<tfoot>
						<td colspan="1" align="left">合计：</td>
						<td colspan="9" align="right">￥5.00</td>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
	<div class="finance-total" id="finance-total-pie">
		<!-- 		<div class="finance-total-echart" ></div> -->
		<!-- 		<div class="finance-total-echart" id="finance-total-line"></div> -->
	</div>
	<div class="finance-total" id="finance-total-line">
		<!-- 		<div class="finance-total-echart" ></div> -->
		<!-- 		<div class="finance-total-echart" id="finance-total-line"></div> -->
	</div>
	<div class="eliminate-float"></div>
	<div class="finance-operation">
		<form action="${base}finance/addRecord" id="finance-operation-form" method="post" >
			<div class="operation-form-title">
				<h5 id="record-title">新增记录</h5>
			</div>
			<div class="operation-form-filed">
				<input type="hidden" name="id" id="recordId"> <label>日期：</label><input type="date" placeholder="请选择日期..."  required="required" class="life-input-date" name="fixedtime">
			</div>
			<div class="operation-form-filed">
				<label>名称：</label><input type="text" autofocus="autofocus" placeholder="输入这笔消费的名称..." required="required" name="financename">
			</div>
			<div class="operation-form-filed">
				<label>金额：</label><input type="number" placeholder="输入这笔消费的金额..." step="0.01" required="required" name="financemoney">
			</div>
			<div class="operation-form-filed">
				<label>类型：</label><select required="required" name="financetype">
					<option selected="selected" value="0">支出</option>
					<option value="1">收入</option>
				</select>
			</div>
			<div class="operation-form-filed">
				<label>方式：</label><select required="required" name="financemode">
					<option selected="selected" value="0">微信</option>
					<option value="1">支付宝</option>
					<option value="2">借记卡</option>
					<option value="3">信用卡</option>
					<option value="4">现金</option>
					<option value="5">饭卡</option>
				</select>
			</div>
			<div class="operation-form-filed">
				<label>备注：</label>
				<textarea rows="5" placeholder="请输入消费备注..." cols="35" name="financeremarks"></textarea>
			</div>
			<div class="operation-form-filed">
				<button type="button" onclick="recordSubmit()">确定添加</button>
				<button type="reset">清空</button>
			</div>
		</form>
	</div>
</body>
</html>
