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
<body style="overflow: hidden;">
	<div class="easyui-layout" style="width: 99%; height: 99%; margin: 5px 5px 5px 5px; overflow: hidden; border-radius: 5px;">
		<div data-options="region:'west',title:'新增备忘录',split:false,border:true,collapsible:false" style="width: 575px; height: 100%; padding: 10px;">
			<div class="easyui-layout" style="width: 100%; height: 100%;">
				<div data-options="region:'north',border:false" style="height: 318px;">
					<div style="float: left;">
						<div style="margin: 10px 0"></div>
						<div id="cc" style="width: 250px; height: 250px;"></div>
						<div>
							<div style="margin: 15px 10px 10px 10px"></div>
							<div>
								<select id="timeAfter" style="width: 80px; height: 30px; line-height: 30px; border: 1px solid #ccc; font-size: inherit;">
								</select> <select id="timeInfo" style="width: 65px; height: 30px; line-height: 30px; border: 1px solid #ccc; font-size: inherit;">
									<!-- 									<option>早上</option> -->
									<!-- 									<option>上午</option> -->
									<!-- 									<option>中午</option> -->
									<!-- 									<option>下午</option> -->
									<!-- 									<option>晚上</option> -->
									<!-- 									<option>凌晨</option> -->
								</select> <select id="times" style="width: 66px; height: 30px; line-height: 30px; border: 1px solid #ccc; margin-top: 2px; font-size: inherit;">
								</select> <input style="width: 20px; height: 30px; line-height: 30px; border: 1px solid #ccc; font-size: inherit; border: 0px;" value="点" />
							</div>
						</div>
						<div style="margin: 10px 10px 10px 10px"></div>
					</div>
					<div style="float: left; margin-left: 10px;">
						<div style="margin: 10px 10px 10px 10px"></div>
						<div>
							<div style="margin-bottom: 5px">
								<div>备忘名称:</div>
								<input type="text" name="memotitle" id="memotitle" required lay-verify="required" oninput="subjectInput()" placeholder="请输入标题" autocomplete="off" class="layui-input">
							</div>
							<div id="mc">
								<div>备忘内容:</div>
								<textarea class="layui-textarea" placeholder="请输入备注内容" style="resize: none" autofocus="autofocus" name="content" id="textarea" cols="33" rows="9" oninput="font_siz()"></textarea>
							</div>
							<div>
								<span class="title2 hide">还可以输入<span>140</span>字
								</span>
							</div>
						</div>
					</div>
				</div>
				<div data-options="region:'center',border:false">
					<div style="margin-top: 5px;"></div>
					<div>
						<div style="float: left;">
							<div style="">发送给：</div>
						</div>
						<div>
							<input type="text" style="width: 180px; height: 20px; float: left;" id="emailNo" value="${userInfo.emailaddress }" name="emailNo" required lay-verify="required" placeholder="请输入邮箱" autocomplete="off" class="layui-input"></input>
						</div>
						<div>
							<div style="float: left;">或</div>
							<input type="text" style="width: 180px; height: 20px; float: left; margin-right: 10px;" value="${userInfo.phoneno }" id="phoneNo" name="phoneNo" required lay-verify="required" placeholder="手机号码" autocomplete="off" class="layui-input"></input>
							<div style="margin-left: 10px; height: 20px;">
								<button class="layui-btn layui-btn-xs" onclick="addMemo()">
									<i class="layui-icon">&#xe654;</i> 确认添加
								</button>
							</div>

						</div>
						<div>
							标题：<label id="subject"></label>
						</div>
						<div>发送内容：</div>
						<div>
							<div style="width: 525px; height: 120px; border: 1px solid #ccc; word-wrap: break-word;">
								<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span id="content"></span>
							</div>
							<!-- 							<textarea class="layui-textarea" name="content" id="content" cols="25" rows="1"></textarea> -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<div data-options="region:'center',iconCls:'memos',border:true,title : '备忘录列表'">
			<div style="overflow: auto; width: 100%; height: 100%;">
				<table id="memosList" data-options="fit:true,border:false">
				</table>
			</div>

		</div>
	</div>
	<script>
		var newDate = new Date();
		var d1 = new Date();
		var d2 = new Date();
		var d3 = newDate.getFullYear() + "-" + (newDate.getMonth() + 1) + "-" + newDate.getDate();
		var jt = {
			'早上' : [ '06', '07', '08', '09' ],
			'上午' : [ '10', '11' ],
			'中午' : [ '12' ],
			'下午' : [ '13', '14', '15', '16', '17' ],
			'晚上' : [ '18', '19', '20', '21', '22', '23', '24' ],
			'凌晨' : [ '01', '02', '03', '04', '05' ]
		};
		var tafter = {
			0 : '今天',
			1 : '明天',
			2 : '后天',
			7 : '一周后',
			30 : '30天后',
			90 : '三个月后',
			182 : '半年后',
			365 : '一年后'
		};
		var timeInfoArr = {
			0 : '凌晨',
			1 : '早上',
			2 : '上午',
			3 : '中午',
			4 : '下午',
			5 : '晚上'
		};
		var dateTime = d1.getFullYear() + "年" + (d1.getMonth() + 1) + "日" + d1.getDate() + "日";
		var dateTimes = d1.getFullYear() + "-" + (d1.getMonth() + 1) + "-" + d1.getDate() + " 01:00:00";
		var timeInfo = "早上6点";
		var timeAfter = "今天";
		$('#memotitle').val(timeAfter + timeInfo);
		$('#textarea').val(timeAfter + timeInfo);
		$('#subject').html($('#memotitle').val());
		$('#content').html($("#textarea").val());
		$('#dt').val(dateTime);
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
		function font_siz() {
			var num = $("#textarea").val().length;
			var title = $('#memotitle').val();
			console.log(title);
			if (num <= 140) {
				$(".title2").html('还可以输入' + '<span></span>' + '字');
				var all = $(".title2 span").text();
				$(".title2 span").text(140 - num);
			} else {
				$(".title2").html('已超出' + '<span>0</span>' + '字');
				var all = $(".title2 span").text();
				$(".title2 span").css("color", "red");
				$(".title2 span").text(Math.abs(140 - num));
			}
			var context = $("#textarea").val();
			var l = context.length;
			if (l <= 140) {
				$('#content').html($("#textarea").val());
			}
		}
		function subjectInput() {
			$('#subject').html($('#memotitle').val());
		}
		function onloadTimeAfter() {
			$("#timeAfter").empty();
			$('#timeAfter').append('<option>' + tafter[0] + '</option>');
			$('#timeAfter').append('<option>' + tafter[1] + '</option>');
			$('#timeAfter').append('<option>' + tafter[2] + '</option>');
			$('#timeAfter').append('<option>' + tafter[7] + '</option>');
			$('#timeAfter').append('<option>' + tafter[30] + '</option>');
			$('#timeAfter').append('<option>' + tafter[90] + '</option>');
			$('#timeAfter').append('<option>' + tafter[182] + '</option>');
			$('#timeAfter').append('<option>' + tafter[365] + '</option>');
		}
		function loadTimeInfoArr() {
			$("#timeInfo").empty();
			// 			var isToDay = $("#timeAfter").val();
			// 			var now = new Date();
			// 			var nowStr = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + d1.getDate();
			// 			var hours = d1.getHours();
			// 			console.log(hours);
			// 			if ((isToDay == '今天' && hours < 6) || (nowStr == d3 && hours < 6)) {
			// 				$('#timeInfo').append('<option>' + timeInfoArr[0] + '</option>');
			// 			}
			// 			if (isToDay != '今天' || nowStr != d3) {
			// 				$('#timeInfo').append('<option>' + timeInfoArr[0] + '</option>');
			// 			}
			$('#timeInfo').append('<option>' + timeInfoArr[0] + '</option>');
			$('#timeInfo').append('<option>' + timeInfoArr[1] + '</option>');
			$('#timeInfo').append('<option>' + timeInfoArr[2] + '</option>');
			$('#timeInfo').append('<option>' + timeInfoArr[3] + '</option>');
			$('#timeInfo').append('<option>' + timeInfoArr[4] + '</option>');
			$('#timeInfo').append('<option>' + timeInfoArr[5] + '</option>');
		}
		function timesArr() {
			$("#times").empty();
			$('#times').append('<option>01</option>');
			$('#times').append('<option>02</option>');
			$('#times').append('<option>03</option>');
			$('#times').append('<option>04</option>');
			$('#times').append('<option>05</option>');
		}
		function addTextInfo(timeInfo) {
			$('#memotitle').val(timeInfo);
			$('#textarea').val(timeInfo);
			$('#subject').html($('#memotitle').val());
			$('#content').html($("#textarea").val());
		}

		function addMemo() {
			var subject = $('#memotitle').val()
			var content = $('#textarea').val();
			var emailno = $('#emailNo').val();
			var phoneno = $('#phoneNo').val();
			var sendtime = dateTimes;
			var form = new FormData(); // FormData 对象
			form.append("subject", subject); // 
			form.append("content", content); // 
			form.append("emailno", emailno); // 
			form.append("phoneno", phoneno); // 
			form.append("sendtime", sendtime); //
			xhr = new XMLHttpRequest(); // XMLHttpRequest 对象
			xhr.open("post", "${base}memos/save", true); //post方式，url为服务器请求地址，true 该参数规定请求是否异步处理。
			xhr.onload = addComplete; //请求完成
			xhr.onerror = addFailed; //请求失败
			xhr.send(form); //
		}
		//上传成功响应
		function addComplete(evt) {
			//服务断接收完文件返回的结果
			var data = JSON.parse(evt.target.responseText);
			if (data.code == 200) {
				$('#memosList').datagrid('reload');
			} else if (data.code == 201) {
				layer.open({
					title : '提示',
					content : '过去的日子就让它过去吧！'
				});
			} else {
				layer.open({
					title : '提示',
					content : '添加备忘录失败，请重试！'
				});
			}

		}
		//失败
		function addFailed(evt) {
			alert("失败2");
		}
		$(function() {
			onloadTimeAfter();
			loadTimeInfoArr();
			timesArr();
			$("#textarea").focusin(function() {
				$(".title").addClass("hide");
				$(".title2").removeClass("hide")
			});
			$("#textarea").focusout(function() {
				$(".title").removeClass("hide");
				$(".title2").addClass("hide")
			});
			$('#cc').calendar({
				current : new Date(),
				onSelect : function(date) {
					onloadTimeAfter();
					loadTimeInfoArr();
					timesArr();
					dateTime = date.getFullYear() + "年" + (date.getMonth() + 1) + "日" + date.getDate() + "日";
					d2 = date;
					d3 = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
					var cd = d1.getFullYear() + "-" + (d1.getMonth() + 1) + "-" + d1.getDate();
					var ad = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
					var cd1 = new Date(cd);
					var ad1 = new Date(ad);
					var days = parseInt(ad1 - cd1) / 1000 / 60 / 60 / 24;
					if (days < 0) {
						layer.open({
							title : '提示',
							content : '过去的日子就让它过去吧！'
						});
					} else {
						var dstr = tafter[days];
						if (dstr == undefined) {
							$('#timeAfter').append('<option selected="selected">' + days + '天后</option>');
						} else {
							$("#timeAfter").val(dstr);
						}
					}
					timeInfo = $("#timeAfter").val() + $("#timeInfo").val() + $("#times").val();
					dateTimes = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " " + $("#times").val() + ":00:00";
					addTextInfo(timeInfo);
				}
			});
			$("#timeInfo").change(function() {
				var v = $("#timeInfo").val();
				var time = jt[v];
				console.log(d1 + ":" + d2);
				$('#times option').remove();
				for (var i = 0; i < time.length; i++) {
					$('#times').append('<option>' + time[i] + '</option>');
				}

				timeInfo = $("#timeAfter").val() + $("#timeInfo").val() + $("#times").val();
				dateTimes = d2.getFullYear() + "-" + (d2.getMonth() + 1) + "-" + d2.getDate() + " " + $("#times").val() + ":00:00";
				addTextInfo(timeInfo);
			});
			$("#times").change(function() {
				timeInfo = $("#timeAfter").val() + $("#timeInfo").val() + $("#times").val();
				console.log($("#timeInfo").val() + $("#times").val());
				dateTimes = d2.getFullYear() + "-" + (d2.getMonth() + 1) + "-" + d2.getDate() + " " + $("#times").val() + ":00:00";
				addTextInfo(timeInfo);
			});
			$("#timeAfter").change(function() {
				loadTimeInfoArr();
				timesArr();
				timeInfo = $("#timeAfter").val() + $("#timeInfo").val() + $("#times").val();
				dateTimes = d2.getFullYear() + "-" + (d2.getMonth() + 1) + "-" + d2.getDate() + " " + $("#times").val() + ":00:00";
				addTextInfo(timeInfo);
			});

			$('#memosList').datagrid({
				url : '${base}memos/getMemos',
				fit : true,
				striped : true,
				singleSelect : true,
				checkOnSelect : true,
				selectOnCheck : true,
				idField : 'id',
				border : false,
				fitColumns : true,
				loadMsg : '正在加载数据。。。',
				columns : [ [ {
					field : "id",
					title : "编号"
				}, {
					field : "usercode",
					title : "用户编号"
				}, {
					field : "subject",
					title : "备忘主题"
				}, {
					field : "content",
					title : "备忘内容"
				}, {
					field : "emailno",
					title : "邮箱地址"
				}, {
					field : "phoneno",
					title : "手机号码"
				}, {
					field : "sendtime",
					title : "发送时间"
				}, {
					field : "createtime",
					title : "创建时间"
				}, {
					field : "executeresult",
					title : "执行结果",
					formatter : function(value, row, index) {
						if (value == '0') {
							value = "未处理";
						} else if (value == '1,') {
							value = "短信发送成功";
						} else if (value == '02') {
							value = "邮件发送成功";
						}else if (value == '1,2') {
							value = "发送成功";
						}
						return value;
					}
				}, ] ],
				onDblClickRow : function(rowIndex, rowData) {
				}
			});

		});
	</script>
</body>
</html>
