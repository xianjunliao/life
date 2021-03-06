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
	var flag = false;
	var errorMsg = "请填写注册信息！";
	$(function() {
		layui.use('form', function() {
			var form = layui.form;
			//监听提交
			form.on('submit(registerNow)', function(data) {
				var user = data.field;
				var action = data.form.action;
				var rightCount = $(".right").length
				if (rightCount == 4) {
					$.ajax({
						url : action,
						data : user,
						type : "POST",
						dataType : "json",
						success : function(result) {
							if (result.code == 200) {
								clean();
								$("#errorMsg").html('<span style="color: green"><b>注册成功，请选择登录方式或点击下一步完善更多注册信息！<b></span>');
							} else if (result.code == 202) {
								$("#errorMsg").html('<span style="color: red">身份编码已存在，不能重复注册！</span>');
								$("#usercodeImg").html('<img src="${base}static/images/wrong.png"/>');
							} else if (result.code == 203) {
								$("#errorMsg").html('<span style="color: red">用户名已存在，不能重复注册！</span>');
								$("#usernameImg").html('<img src="${base}static/images/wrong.png"/>');
							} else {
								$("#errorMsg").html('<span style="color: red"><b>' + result.message + '<b></span>');
							}
						}
					});

				} else {
					$("#errorMsg").html('<span style="color: red">请完善注册信息！</span>');
				}
				return false;
			});
			form.on('submit(registerNext)', function(data) {
				var rightCount = $(".right").length;
				var usercode = $("#usercode").val();
				var username = $("#username").val();
				var password = $("#password").val();
				var step = usercode + ":" + username + ":" + password;
				if (rightCount == 4) {
					$.ajax({
						url : basePath + 'user/getDES?str=' + step,
						type : "POST",
						dataType : "json",
						success : function(result) {
							if (result.code == 200) {
								clean();
								var s = "register2";
								var url = basePath + "regSkip?step=" + s + "&str=" + result.data;
								window.location.replace(url);
							}
							else if (result.code == 202) {
								$("#errorMsg").html('<span style="color: red">身份编码已存在，不能重复注册！</span>');
								$("#usercodeImg").html('<img src="${base}static/images/wrong.png"/>');
							}
							else if (result.code == 203) {
								$("#errorMsg").html('<span style="color: red">用户名已存在，不能重复注册！</span>');
								$("#usernameImg").html('<img src="${base}static/images/wrong.png"/>');
							}
							else if (result.code == 209) {
								$("#errorMsg").html('<span style="color: red"><b>系统异常！<b></span>');
							} else {
								$("#errorMsg").html('<span style="color: red"></span>');
							}
						}
					});

				} else {
					$("#errorMsg").html('<span style="color: red">请完善注册信息！</span>');
				}
				return false;
			});
		});
	});
	function clean() {
		$("#usercode").val("");
		$("#username").val("");
		$("#password").val("");
		$("#rePassword").val("");
		$("#usercodeImg").html('<img src="${base}static/images/info.png"/>');
		$("#usernameImg").html('<img src="${base}static/images/info.png"/>');
		$("#passwordImg").html('<img src="${base}static/images/info.png"/>');
		$("#rePasswordImg").html('<img src="${base}static/images/info.png"/>');
		$("#errorMsg").html('');
	}
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
		finallyCheck();
	}

	function checkUserName() {
		var value = $("#username").val();
		if (value == null || value == '') {
			$("#errorMsg").html('<span style="color: red">用户名不能为空!</span>');
			$("#usernameImg").html('<img src="${base}static/images/wrong.png"/>');
		} else if (value.length < 3) {
			$("#errorMsg").html('<span style="color: red">用户名长度必须大于等于3!  示例：stephen</span>');
			$("#usernameImg").html('<img src="${base}static/images/wrong.png"/>');
		} else {
			$("#errorMsg").html('<span style="color: green">用户名格式输入正确！</span>');
			$("#usernameImg").html('<img class="right" src="${base}static/images/right.png"/>');
		}
		finallyCheck();
	}
	function checkPassword() {
		var value = $("#password").val();
		var password = $("#rePassword").val();
		if (value == null || value == '') {
			$("#errorMsg").html('<span style="color: red">密码不能为空!</span>');
			$("#passwordImg").html('<img src="${base}static/images/wrong.png"/>');
		} else if (value != password) {
			$("#errorMsg").html('<span style="color: red">两次输入的密码不一致!</span>');
			$("#passwordImg").html('<img src="${base}static/images/wrong.png"/>');
		} else if (value.length < 6) {
			$("#errorMsg").html('<span style="color: red">必须输入8位以上长度的密码!  示例：woshiyigemima</span>');
			$("#passwordImg").html('<img src="${base}static/images/wrong.png"/>');
		} else {
			$("#errorMsg").html('<span style="color: green">密码格式输入正确！</span>');
			$("#passwordImg").html('<img class="right" src="${base}static/images/right.png"/>');
			$("#rePasswordImg").html('<img class="right" src="${base}static/images/right.png"/>');
		}
		finallyCheck();
	}
	function checkRePassword() {
		var value = $("#rePassword").val();
		var password = $("#password").val();
		if (value == null || value == '') {
			$("#errorMsg").html('<span style="color: red">确认密码不能为空!</span>');
			$("#rePasswordImg").html('<img src="${base}static/images/wrong.png"/>');
		} else if (value != password) {
			$("#errorMsg").html('<span style="color: red">两次输入的密码不一致!</span>');
			$("#rePasswordImg").html('<img src="${base}static/images/wrong.png"/>');
		} else if (value.length < 8) {
			$("#errorMsg").html('<span style="color: red">必须输入8位以上长度的密码!  示例：woshiyigemima</span>');
			$("#rePasswordImg").html('<img src="${base}static/images/wrong.png"/>');
		} else {
			$("#errorMsg").html('<span style="color: green">确认密码格式输入正确！</span>');
			$("#rePasswordImg").html('<img class="right" src="${base}static/images/right.png"/>');
			$("#passwordImg").html('<img class="right" src="${base}static/images/right.png"/>');
		}
		finallyCheck();
	}
	function finallyCheck() {
		var rightCount = $(".right").length;
		if (rightCount == 4) {
			$("#errorMsg").html('<span style="color: green">注册信息填写完毕，请点击注册或下一步完善更多注册信息！</span>');
		}
	}
</script>
</head>
<body>
	<div class="container">
		<section id="content">
			<form class="layui-form" id="register1Form" method="post" action="${base}user/fullUser">
				<h1>账号密码注册</h1>
				<div>
					<input type="text" name="regStep" id="regStep" value="1" style="display: none;" /> <input type="password" autofocus="autofocus" onblur="checkUserCode()" oninput="checkUserCode()" value="${usercodeShow}" placeholder="请输入身份编码" required="" id="usercode" name="usercode" />
					<div class="check_img" id="usercodeImg">
						<img title="请输入身份编码！" src="${base}static/images/info.png" />
					</div>
				</div>
				<div>
					<input type="text" placeholder="请输入用户名" onblur="checkUserName()" oninput="checkUserName()" value="${username}" required="" id="username" name="username" />
					<div class="check_img" id="usernameImg">
						<img title="请输入用户名！" src="${base}static/images/info.png" />
					</div>
				</div>
				<div>
					<input type="password" placeholder="请输入密码" onblur="checkPassword()" oninput="checkPassword()" required="" id="password" name="password" />
					<div class="check_img" id="passwordImg">
						<img title="请输入密码！" src="${base}static/images/info.png" />
					</div>
				</div>
				<div>
					<input type="password" placeholder="再次输入密码" onblur="checkRePassword()" oninput="checkRePassword()" required="" id="rePassword" name="rePassword" />
					<div class="check_img" id="rePasswordImg">
						<img title="请再次输入密码！" src="${base}static/images/info.png" />
					</div>
				</div>
				<div>
					<input type="submit" lay-submit lay-filter="registerNow" value="注册" /> <input type="button" lay-submit lay-filter="registerNext" value="下一步" /> <a href="${base }fullLogin">账号密码登录</a> <a href="${base }login">身份编码登录</a>
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
