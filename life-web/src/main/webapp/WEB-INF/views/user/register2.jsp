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
	function endReg() {
		var v = $("#headAddress").val();
		console.log(v);
		$("#headImg").attr("src", v);
	}
</script>
</head>
<body>
	<div class="container">
		<section id="content">
			<form action="">
				<h1>账号密码注册</h1>
				<div>
					<input type="text" autofocus="autofocus" placeholder="手机号码" required="" id="phoneNo" />
				</div>
				<div>
					<input type="text" placeholder="邮箱地址" required="" id="emailAddress" />
				</div>
				<div>
					<input type="file" placeholder="头像图片" required="" id="headAddress" onchange="endReg()" /> <img id="headImg" width="24px" height="24px">
				</div>
				<div>
					<textarea placeholder="自我介绍" required="" id="selfIntroduction" rows="5" cols="5"></textarea>
				</div>
				<div>
					<input type="submit" value="完成注册" onclick="endReg()" /> <a href="${base }fullLogin">账号密码登录</a> <a href="${base }login">身份编码登录</a>
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
