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
	<div class="easyui-layout" style="width: 99%; height: 98%; margin: 5px 5px 5px 5px; overflow: hidden;border-radius:5px;">
		<div data-options="region:'west',title:'备忘录',split:false,border:true,collapsible:false" style="width: 575px; height: 100%; padding: 10px;">
			<div class="easyui-layout" style="width: 100%; height: 100%;">
				<div data-options="region:'north',border:false" style="height: 315px;">
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
								</select> <select id="times" style="width: 96px; height: 30px; line-height: 30px; border: 1px solid #ccc; font-size: inherit;">
								</select>
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
							<input id="getMan" type="text" style="width: 180px; height: 20px; float: left;" name="emailNo" required lay-verify="required" placeholder="请输入邮箱" autocomplete="off" class="layui-input"></input>
						</div>
						<div>
							<div style="float: left;">或</div>
							<input id="getMan1" type="text" style="width: 180px; height: 20px; float: left; margin-right: 10px;" name="phoneNo" required lay-verify="required" placeholder="手机号码" autocomplete="off" class="layui-input"></input>
							<div style="margin-left: 10px; height: 20px;">
								<button class="layui-btn layui-btn-xs">
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
		<div data-options="region:'center',iconCls:'icon-ok',border:true">1111111</div>
	</div>
	<script>
		var d1 = new Date();
		var d2 = new Date();
		var jt = {
			'早上' : [ '6点', '7点', '8点', '9点' ],
			'上午' : [ '10点', '11点' ],
			'中午' : [ '12点' ],
			'下午' : [ '1点', '2点', '3点', '4点', '5点' ],
			'晚上' : [ '6点', '7点', '8点', '9点', '10点', '11点', '12点' ],
			'凌晨' : [ '1点', '2点', '3点', '4点', '5点' ]
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
			var isToDay = $("#timeAfter").val();
			var hours = d1.getHours();
			console.log(hours);
			if (isToDay == '今天' && hours < 6) {
				$('#timeInfo').append('<option>' + timeInfoArr[0] + '</option>');
			}
			if (isToDay != '今天') {
				$('#timeInfo').append('<option>' + timeInfoArr[0] + '</option>');
			}
			$('#timeInfo').append('<option>' + timeInfoArr[1] + '</option>');
			$('#timeInfo').append('<option>' + timeInfoArr[2] + '</option>');
			$('#timeInfo').append('<option>' + timeInfoArr[3] + '</option>');
			$('#timeInfo').append('<option>' + timeInfoArr[4] + '</option>');
		}
		function timesArr() {
			$("#times").empty();
			$('#times').append('<option>1点</option>');
			$('#times').append('<option>2点</option>');
			$('#times').append('<option>3点</option>');
			$('#times').append('<option>4点</option>');
			$('#times').append('<option>5点</option>');
		}
		function addTextInfo(timeInfo) {
			$('#memotitle').val(timeInfo);
			$('#textarea').val(timeInfo);
			$('#subject').html($('#memotitle').val());
			$('#content').html($("#textarea").val());
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
					timesArr();
					dateTime = date.getFullYear() + "年" + (date.getMonth() + 1) + "日" + date.getDate() + "日";
					d2 = date;
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
				addTextInfo(timeInfo);
			});
			$("#times").change(function() {
				timeInfo = $("#timeAfter").val() + $("#timeInfo").val() + $("#times").val();
				addTextInfo(timeInfo);
			});
			$("#timeAfter").change(function() {
				loadTimeInfoArr();
				timesArr();
				timeInfo = $("#timeAfter").val() + $("#timeInfo").val() + $("#times").val();
				addTextInfo(timeInfo);
			});
		});
	</script>
</body>
</html>
