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
		var v = $("#usercode").val();
		if (v == null || v == "" || v == undefined) {
			$("#usercodeImg").html('<img src="${base}static/images/wrong.png"/>');
			$("#errorMsg").html('<span style="color: red">身份编码不能为空！</span>');
		} else {
			var index = layer.load();
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : basePath + 'enter?code=' + v,
				success : function(result) {
					if (result.code == 200) {
						window.location.replace(basePath + "main");
					} else if (result.code == 202) {
						$("#errorMsg").html('<span style="color: red">' + result.message + '</span>');
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
							btn : [ '确定', '继续注册', '取消' ],
							btn3 : function(index, layero) {
								//按钮【按钮三】的回调
							}
						}, function(index, layero) {
							enter();
						}, function(index) {
							var s = "register";
							var url = basePath + "regSkip?step=" + s;
							window.location.replace(url);
						});
					} else {
						$("#errorMsg").html('<span style="color: red">' + result.message + '</span>');
						$("#usercodeImg").html('<img src="${base}static/images/wrong.png"/>');
						layer.close(index);
					}

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
		if (v == null || v == "" || v == undefined) {
			$("#usercodeImg").html('<img src="${base}static/images/wrong.png"/>');
			$("#errorMsg").html('<span style="color: red">身份编码不能为空！</span>');
		} else {
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : basePath + 'enter?code=' + v,
				success : function(result) {
					if (result.code == 200) {
						window.location.replace(basePath + "main");
					} else if (result.code == 202) {
						$("#errorMsg").html('<span style="color: red">' + result.message + '</span>');
					} else {
						$("#errorMsg").html('<span style="color: red">' + result.message + '</span>');
						$("#usercodeImg").html('<img src="${base}static/images/wrong.png"/>');
					}
				}
			});
		}
	}
</script>
</head>
<body onload="autoLogin()">
	<div class="container">
		<section id="content">
			<div class="form">
				<h1>身份编码登录</h1>
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
					<input type="submit" value="登录" onclick="enter()" /> <input type="submit" value="快速注册" onclick="addUserCode()" /><a href="${base }fullLogin">账号密码登录</a> <a href="${base }regSkip?step=register">账号密码注册</a>
				</div>
			</div>
			<!-- form -->
			<div id="errorMsg" class="button"></div>
			<!-- button -->
		</section>
		<!-- content -->
	</div>
	<!-- container -->
</body>
</html>
