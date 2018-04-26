<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../headerH5.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link rel="stylesheet" href="${base}static/css/login.css">
<script type="text/javascript">
	var basePath = "${base}";
	var user = "${user}";

	function enter() {
		var index = layer.load();
		var v = $("#usercode").val();
		var isAuto=$("#autoLogin").is(':checked');
		if (v == null || v == "" || v == undefined) {
			$("#usercodeImg").html('<img src="${base}static/images/wrong.png"/>');
			$("#errorMsg").html('<span style="color: red">身份编码不能为空！</span>');
			layer.close(index);
		} else {

			$.ajax({
				type : 'POST',
				dataType : "json",
				url : basePath + 'enter?code=' + v+'&isAuto='+isAuto,
				success : function(result) {
					if (result.code == 200) {
						window.location.replace(basePath + result.data);
					} else if (result.code == 202) {
						layer.confirm(result.message + '，确定注册吗？', {
							btn : [ '确定注册', '取消' ],
							btn3 : function(index, layero) {
								//按钮【按钮三】的回调
							}
						}, function(index, layero) {
							addUserCode();
						});
					} else {
						$("#errorMsg").html('<span style="color: red">' + result.message + '</span>');
						$("#usercodeImg").html('<img src="${base}static/images/wrong.png"/>');
					}
					layer.close(index);
				}
			});
		}
	}
	function addUserCode() {
		var rightCount = $(".right").length;
		if (rightCount > 0) {
			var index = layer.load();
			var v = $("#usercode").val();
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : basePath + 'add?code=' + v,
				success : function(result) {
					if (result.code == 200) {
						layer.close(index);
						layer.confirm('注册成功，确定直接登入吗？', {
							btn : [ '确定', '取消' ],
							btn3 : function(index, layero) {
								//按钮【按钮三】的回调
							}
						}, function(index, layero) {
							enter();
						});
					} else {
						$("#errorMsg").html('<span style="color: red">' + result.message + '</span>');
						$("#usercodeImg").html('<img src="${base}static/images/wrong.png"/>');
						layer.close(index);
					}
					layer.close(index);
				}
			});
		}
	}
	$(function() {
		$('#usercode').keydown(function(e) {
			if (e.keyCode == 13) {
				enter();
			}
		});
	});
	function checkUserCode() {
		var value = $("#usercode").val();
		if (value == null || value == '') {
			$("#errorMsg").html('<span style="color: red">身份编码不能为空！</span>');
			$("#usercodeImg").html('<img src="${base}static/images/wrong.png"/>');
		} else if (value.length < 3) {
			$("#errorMsg").html('<span style="color: red">身份编码长度必须大于等于3！  示例：aaa</span>');
			$("#usercodeImg").html('<img src="${base}static/images/wrong.png"/>');
		} else {
			$("#errorMsg").html('<span style="color: green">身份编码格式输入正确！</span>');
			$("#usercodeImg").html('<img class="right" src="${base}static/images/right.png"/>');
		}
	}
	function getCookie(name) {
		var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
		if (arr = document.cookie.match(reg)) {
			return unescape(arr[2]);
		} else {
			return null;
		}
	}
	function autoLogin() {
		var v = getCookie("usercode");
		if (v != null) {
			$("#usercode").val(v);
			$("#loginButton").click();
		}
	}
</script>
</head>
<body onload="autoLogin()">
	<div class="container">
		<section id="content">
			<div class="form">
				<h2>
					欢迎来到<b style="font-weight: 900; color: black !important;">Free Life</b>网站
				</h2>
				<div>
					<!--<input type="text" placeholder="Username" required="" id="username" />-->
				</div>
				<div>
					<input type="password" placeholder="请输入你在该网站的身份编码..." autofocus="autofocus" oninput="checkUserCode()" onblur="checkUserCode()" required="" id="usercode" />
					<div class="check_img" id="usercodeImg">
						<img title="请输入身份编码！" src="${base}static/images/info.png" />
					</div>
				</div>
				<div>
					<input id="loginButton" type="submit" value="登录" onclick="enter()" /> <input type="submit" value="快速注册" onclick="addUserCode()" />
					<%-- 					<a href="${base }fullLogin">账号密码登录</a> <a href="${base }regSkip?step=register">账号密码注册</a> --%>
					<input type="checkbox" id="autoLogin" style="margin-top:-1px; vertical-align: middle;padding-top: 10px;" />自动登陆(有效期10天)</input>
				</div>
			</div>
			<!-- form -->
			<div id="errorMsg" class="button"></div>
			<div style="text-align: left; margin-top: 5px; padding-left: 30px; padding-right: 40px; margin-bottom: 5px; font-weight: 700;">
				<span>1.本网站需要身份编码才可登录，点击‘快速注册’按钮可直接注册和进入本网站。 </span><br> <span>2.本网站目前可使用的功能有【网址导航】、【每日英语】、【乐谱谱架】、【自由云】、【备忘录】。 </span><br> <span>3.本网站目前部分的功能还在开发中,使用过程中遇到任何问题可联系站长,联系邮箱：xianjun_liao@126.com。</span>
			</div>
			<!-- button -->
		</section>
		<!-- content -->
	</div>
	<!-- container -->
</body>
</html>
