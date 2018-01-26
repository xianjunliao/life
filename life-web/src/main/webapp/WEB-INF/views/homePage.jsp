<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<style scoped="scoped">
.md {
	height: 12px;
	line-height: 12px;
	background-position: 1px center;
	text-align: right;
	font-weight: bold;
	padding: 0 2px;
	color: red;
	opacity: 0.1;
}
</style>
</head>
<body class="easyui-layout" style="width: 100%; height: 100%;">
	<div region="center" border="false" style="width: 80%; height: 80%; padding: 20px;">
		<div style="float: left;">
			<div style="margin: 10px 0"></div>
			<div id="cc" style="width: 250px; height: 250px;"></div>
			<div>
				<input id="ss" style="width: 250px;">
			</div>
			<div>
				<input id="fullTime" style="width: 250px">
			</div>
		</div>
		<div style="float: left; margin-left: 10px;">
			<div style="margin: 10px 10px 10px 10px"></div>
			<div>
				<div style="margin-bottom: 10px">
					<div>备忘名称:</div>
					<input id="memoTitle" class="easyui-textbox" data-options="prompt:'请输入备忘标题。。。',validType:'email'" style="width: 250px; height: 32px">
				</div>
				<div id="mc" style="margin-bottom: 5px">
					<div>备忘内容:</div>
					<input id="memoContent" class="easyui-textbox" data-options="prompt:'请输入备忘内容。。。',multiline:true" style="width: 250px; height: 155px">
				</div>
				<div>
					<span>已经输入1/25个字了。。。</span>
				</div>
			</div>

		</div>
	</div>
	<script>
		var d1 = new Date();
		var d2 = new Date();
		function formatDay(date) {
			var m = date.getMonth() + 1;
			var d = date.getDate();
			var opts = $(this).calendar('options');
			console.log(d1);
			console.log(d);
			if (opts.month == m && d == d1.getdate()) {
				return '<div class="icon-ok md">' + d + '</div>';
			}
			return d;
		}
		$(function() {
			$('#ss').timespinner({
				value : '07:00',
				showSeconds : true,
				onChange : function() {
					var ss = $(this).timespinner("getValue");
					var d = new Date();
					d2 = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate() + " " + ss;
					$('#fullTime').textbox('setValue', d2);
				}
			});
			$('#fullTime').textbox({
				value : d1.getFullYear() + "-" + (d1.getMonth() + 1) + "-" + d1.getDate() + " " + "07:00:00"
			});
			$('#cc').calendar({
				current : d1,
				onSelect : function(date) {
					var ss = $('#ss').timespinner("getValue");
					d2 = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " " + ss;
					$('#fullTime').textbox('setValue', d2);
				}
			});
			$("#memoContent").textbox({
				onChange : function() {
					var ss = "";
					ss = ss + $(this).textbox("getValue");
					console.log(ss);
				}
			});
			$('#mc').keypress(function(e) {
				var ss = "";
				ss = ss + $("#memoContent").textbox("getValue");
				console.log(ss.length);
			});
		});
	</script>
</body>
</html>
