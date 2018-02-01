<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../headerH5.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link rel="stylesheet" href="${base}static/css/register.css">
<script type="text/javascript">
	var basePath = "${base}";
	var user = "${user}";

	$(function() {

	});
</script>
</head>
<body>
	<div class="container">
		<section id="content">
			<form action="">
				<h1>账号密码注册</h1>
				<div>
					<input type="password" autofocus="autofocus" placeholder="请输入身份编码" required="" id="username" />
				</div>
				<div>
					<input type="text"  placeholder="请输入用户名" required="" id="username" />
				</div>
				<div>
					<input type="password" placeholder="请输入密码" required="" id="password" />
				</div>
				<div>
					<input type="password" placeholder="再次输入密码" required="" id="password" />
				</div>
				<div>
					<input type="submit" value="注册" /> <input type="submit" value="下一步" /> <a href="${base }fullLogin">账号密码登录</a> <a href="${base }login">身份编码登录</a>
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