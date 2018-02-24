<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../headerH5.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link rel="stylesheet" href="${base}static/css/update.css">
<script type="text/javascript">
	var basePath = "${base}";
	var user = "${user}";
	var imgurl = "";
	$(function() {
		layui.use('form', function() {
			var form = layui.form;
			//监听提交
			form.on('submit(updateUserOver)', function(data) {
				var user = data.field;
				var action = data.form.action;
				$.ajax({
					url : action,
					data : user,
					type : "POST",
					dataType : "json",
					success : function(result) {
						if (result.code == 200) {
							$("#errorMsg").html('<span style="color: green"><b>更新成功，请按F5<span style="cursor: pointer;	text-decoration: underline;" onclick="sx()">刷新</span>界面！<b></span>');
							
						} else {
							$("#errorMsg").html('<span style="color: red"><b>' + result.message + '<b></span>');
						}
					}
				});
				return false;
			});
		});
	});
	function sx(){
		parent.location.href = basePath + "login";
	}
	function checkUserName() {
		var value = $("#username").val();
		if (value.length < 3) {
			$("#errorMsg").html('<span style="color: red">用户名长度必须大于等于3!  示例：stephen</span>');
			$("#usernameImg").html('<img src="${base}static/images/wrong.png"/>');
		} else {
			$("#errorMsg").html('<span style="color: green">用户名格式输入正确！</span>');
			$("#usernameImg").html('<img class="right" src="${base}static/images/right.png"/>');
		}
	}
	function checkPassword() {
		var value = $("#password").val();
		var password = $("#rePassword").val();
		if (value != password) {
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
	}
	function checkRePassword() {
		var value = $("#rePassword").val();
		var password = $("#password").val();
		if (value != password) {
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
	}
	function updateHeadClick() {

		layer.open({
			title : [ '更新头像', 'font-size:18px;' ],
			type : 2,
			content :[ basePath + "updateHeadImg",'no'] //这里content是一个普通的String
		});
	}
</script>
</head>
<body>
	<div class="container">
		<section id="content">
			<form class="layui-form" id="updateForm" method="post" action="${base}user/update" enctype="multipart/form-data">
				<h1>完善个人信息</h1>
				<div>
					<input type="hidden" id="usercode" name="usercode" value="${userModel.usercode}" /> <input type="text" autofocus="autofocus" placeholder="请输入用户名" value="${userModel.username}" id="username" name="username" />
					<div class="check_img" id="usernameImg">
						<c:if test="${userModel.username==null}">
							<img title="请输入用户名！" src="${base}static/images/info.png" />
						</c:if>
						<c:if test="${userModel.username!=null}">
							<img title="请输入用户名！" class="right" src="${base}static/images/right.png" />
						</c:if>
					</div>
				</div>
				<div>
					<input type="text" placeholder="手机号码" id="phoneNo" name="phoneno" value="${userModel.phoneno}" />
					<div class="check_img">
						<img title="请输入手机号码！" src="${base}static/images/right2.png" />
					</div>
				</div>
				<div>
					<input type="text" placeholder="邮箱地址" id="emailAddress" name="emailaddress" value="${userModel.emailaddress}" />
					<div class="check_img">
						<img title="请输入邮箱地址！" src="${base}static/images/right2.png" />
					</div>
				</div>
				<div>
					<textarea placeholder="自我介绍" id="selfIntroduction" name="selfintroduction" rows="5" cols="5">${userModel.selfintroduction}</textarea>
					<div class="check_img">
						<img title="请输入自我介绍！" src="${base}static/images/right2.png" />
					</div>
				</div>
				<div>
					<input type="submit" lay-submit lay-filter="updateUserOver" value="确认修改" /><input type="button" onclick="updateHeadClick()" value="更新头像" />
				</div>
			</form>
			<div id="errorMsg" class="button"></div>
		</section>
		<!-- content -->
	</div>
	<!-- container -->
</body>
</html>
