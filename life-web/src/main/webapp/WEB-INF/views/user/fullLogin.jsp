<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../headerH5.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link rel="stylesheet" href="${base}static/css/fullLogin.css">
<script type="text/javascript">
	var basePath = "${base}";
	var user = "${user}";
	$(function() {
		layui.use('form', function() {
			var form = layui.form;
			//监听提交
			form.on('submit(LoginNow)', function(data) {
				var user = data.field;
				var action = data.form.action;
				$.ajax({
					url : action,
					data : user,
					type : "POST",
					dataType : "json",
					success : function(result) {
						if (result.code == 200) {
							window.location.replace(basePath + "house");
						} else if (result.code == 202) {
							$("#errorMsg").html('<span style="color: red"><b>' + result.message + '<b></span>');
						} else {
							$("#errorMsg").html('<span style="color: red"><b>' + result.message + '<b></span>');
						}
					}
				});
				return false;
			});

		});
	});
</script>
</head>
<body>
	<div class="container">
		<section id="content">
			<form class="layui-form" id="register3Form" method="post" action="${base}user/checkUserLogin">
				<h1>账号密码登录</h1>
				<div>
					<input type="text" autofocus="autofocus" placeholder="请输入用户名" required="" id="username" name="username" />
				</div>
				<div>
					<input type="password" placeholder="请输入密码" required="" id="password" name="password"/>
				</div>
				<div></div>
				<div>
					<input type="submit" value="登录" lay-submit lay-filter="LoginNow" /> <a href="${base }regSkip?step=register">账号密码注册</a><a href="${base }login">身份编码登录</a>
				</div>
			</form>
			<!-- form -->
			<div id="errorMsg" class="button"></div>
			<!-- button -->
		</section>
		<!-- content -->
	</div>
	<!-- container -->
</body>
</html>
