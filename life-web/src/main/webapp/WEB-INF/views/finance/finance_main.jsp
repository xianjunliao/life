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
		<div class="finance-settings-type">
			<input type="date" placeholder="开始日期..." name="financeday" id="beginday">
		</div>
		<div class="finance-settings-type">
			<input type="date" placeholder="结束日期..." name="financeday" id="endday">
		</div>
		<div class="finance-settings-type" id="finance-order" onclick="goOrder(this)">升序</div>
		<div class="finance-settings-type" id="query0" onclick="goQuery(0)">查询明细</div>
		<div class="finance-settings-type interval"></div>
		<div class="finance-settings-type query" id="query1" onclick="goQuery(1)">日汇总</div>
		<div class="finance-settings-type query" id="query2" onclick="goQuery(2)">月汇总</div>
		<div class="finance-settings-type query" id="query3" onclick="goQuery(3)">季汇总</div>
		<div class="finance-settings-type query" id="query4" onclick="goQuery(4)">年汇总</div>
		<div class="finance-settings-type" id="query6" onclick="goQuery(6)">固定记录</div>
		<div class="finance-settings-type interval"></div>
		<div class="finance-settings-type" id="addFixed" onclick="showOperation('setting')">新增固定记录</div>
		<div class="finance-settings-type" id="addRecord" onclick="showOperation(null)">新增支出收入记录</div>
		<div class="finance-settings-type" id="updateFixed" onclick="updateRecord('修改固定记录')">修改固定记录</div>
		<div class="finance-settings-type" id="updateRecord" onclick="updateRecord('修改支出收入记录')">修改支出收入记录</div>
		<div class="finance-settings-type" id="deleteFixed" onclick="deleteRecord()">删除固定记录</div>
		<div class="finance-settings-type" id="deleteRecord" onclick="deleteRecord()">删除支出收入</div>

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
			<div id="finance-record-items">
				<table class="finance-record-tables">
					<thead id="finance-record-head">
					</thead>
					<tbody id="finance-record-rows">
					</tbody>
					<tfoot>
						<td colspan="1" align="left">合计：</td>
						<td colspan="9" align="right">支出:￥<b><span class="totalm">0.00</span></b>&nbsp;&nbsp;收入:<b>￥<span class="totalo">0.00</span></b>&nbsp;&nbsp;余额:<b>￥<span class="totalb">0.00</span></b></td>
					</tfoot>
				</table>
			</div>
			<div id="finance-record-total">
				<table class="finance-record-tables">
					<thead id="finance-record-total-head">
					</thead>
					<tbody id="finance-record-total-rows">
					</tbody>
					<tfoot>
						<td colspan="1" align="left">合计：</td>
						<td colspan="3" align="right">支出:￥<b><span class="totalm">0.00</span></b>&nbsp;&nbsp;收入:<b>￥<span class="totalo">0.00</span></b>&nbsp;&nbsp;余额:<b>￥<span class="totalb">0.00</span></b></td>
					</tfoot>
				</table>
			</div>
			<div id="finance-record-fixed">
				<table class="finance-record-tables">
					<thead id="finance-record-fixed-head">
					</thead>
					<tbody id="finance-record-fixed-rows">
					</tbody>
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
		<form id="finance-operation-form" method="post">
			<div class="operation-form-title">
				<h5 id="record-title">新增记录</h5>
			</div>
			<div class="operation-form-filed filed-hide">
				<input type="hidden" name="id" id="recordId"> <label>记录日期：</label><input type="date" placeholder="请选择日期..." required="required" class="life-input-date" name="financeday" id="financeday">
			</div>
			<div class="operation-form-filed">
				<label>记录名称：</label><input type="text" autofocus="autofocus" placeholder="输入这笔记录的名称..." required="required" name="financename" id="financename">
			</div>
			<div class="operation-form-filed">
				<label>记录金额：</label><input type="number" placeholder="输入这笔记录的金额..." step="0.01" required="required" name="financemoney" id="financemoney">
			</div>
			<div class="operation-form-filed">
				<label>记录类型：</label><select required="required" name="financetype" id="financetype">
					<option selected="selected" value="支出">支出</option>
					<option value="收入">收入</option>
				</select>
			</div>
			<div class="operation-form-filed">
				<label>记录方式：</label><select required="required" name="financemode" id="financemode">
					<option selected="selected" value="微信">微信</option>
					<option value="支付宝">支付宝</option>
					<option value="借记卡">借记卡</option>
					<option value="Apply Pay">Apply Pay</option>
					<option value="信用卡">信用卡</option>
					<option value="现金">现金</option>
					<option value="饭卡">饭卡</option>
				</select>
			</div>
			<div class="operation-form-filed filed-hide">
				<label>记录备注：</label>
				<textarea rows="5" placeholder="请输入消费备注..." cols="39" name="financeremarks" id="financeremarks"></textarea>
			</div>
			<div class="operation-form-filed">
				<button type="button" id="comfrimBut" onclick="recordSubmit()">确定添加</button>
				<button type="reset">清空</button>
				<button type="button" onclick="$('.finance-operation').hide(300)">关闭</button>
			</div>
		</form>
	</div>
</body>
</html>
