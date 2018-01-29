<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../headerH5.jsp"%>
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
	var v;
	function enter() {
		var index = layer.load();
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : basePath + 'enter?code=' + v,
			success : function(result) {
				if (result.code == 200) {
					window.location.replace(basePath + "house");
				} else {
					layer.msg(result.message);
				}
				layer.close(index);
			}
		});

	}
	function addUserCode() {
		var index = layer.load();
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : basePath + 'add?code=' + v,
			success : function(result) {
				if (result.code == 200) {
					layer.close(index);
					layer.confirm('注册成功，确定直接登入吗？', {
						btn : [ '确定', '完善身份信息', '取消' ],
						btn3 : function(index, layero) {
							//按钮【按钮三】的回调
						}
					}, function(index, layero) {
						enter();
					}, function(index) {
						layer.msg("开发中。。。");
					});
				} else {
					layer.msg(result.message);
					layer.close(index);
				}

			}
		});

	}
	function userInput() {
		v = $("#userCode").val();
	}
</script>
</head>
<body>
	<div class="container">
		<section id="content">
			<div class="form">
				<h1>登录</h1>
				<div>
					<!--<input type="text" placeholder="Username" required="" id="username" />-->
				</div>
				<div>
					<input type="text" placeholder="请输入你在该网站的身份编码..." autofocus="autofocus" oninput="userInput()" required="" id="userCode" />
				</div>
				<div>
					<input type="submit" value="登录" onclick="enter()" /> <input type="submit" value="注册" onclick="addUserCode()" /> <a href="#">忘记身份编码？</a>
				</div>
			</div>
			<!-- form -->
			<div class="button"></div>
			<!-- button -->
		</section>
		<!-- content -->
	</div>
	<!-- container -->
</body>
</html>
