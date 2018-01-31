<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../headerH5.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link rel="stylesheet" href="${base}static/css/register2.css">
<script type="text/javascript">
	var basePath = "${base}";
	var imgurl = "";
	$(function() {
		layui.use('form', function() {
			var form = layui.form;
			//监听提交
			form.on('submit(registerOver)', function(data) {
				var user = data.field;
				var action = data.form.action;
				$.ajax({
					url : action,
					data : user,
					type : "POST",
					dataType : "json",
					success : function(result) {
						if (result.code == 200) {
							$("#errorMsg").html('<span style="color: green"><b>注册成功，请选择登录方式！<b></span>');
						} else {
							$("#errorMsg").html('<span style="color: red"><b>' + result.message + '<b></span>');
						}
					}
				});
				return false;
			});
			form.on('submit(registerLast)', function(data) {
				window.location.replace(basePath + "register");
				return false;
			});
		});
	});
	function getPhoto(node) {
		$('#path').val($('#attachment').val());
		var imgURL = "";
		try {
			var file = null;
			if (node.files && node.files[0]) {
				file = node.files[0];
			} else if (node.files && node.files.item(0)) {
				file = node.files.item(0);
			}
			//Firefox 因安全性问题已无法直接通过input[file].value 获取完整的文件路径
			try {
				imgURL = file.getAsDataURL();
			} catch (e) {
				imgRUL = window.URL.createObjectURL(file);
			}
		} catch (e) {
			if (node.files && node.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					imgURL = e.target.result;
				};
				reader.readAsDataURL(node.files[0]);
			}
		}
		creatImg(imgRUL);
		return imgURL;
	}

	function creatImg(imgRUL) {
		var textHtml = "<img src='"+imgRUL+"'width='55px' height='55px'/>";
		$("#headImg").empty();
		$("#headImg").html(textHtml);
	}
	function ahclick(id) {
		$("#" + id).click();
	}
</script>
</head>
<body>
	<div class="container">
		<section id="content">
			<form  class="layui-form" id="register2Form" method="post" action="${base}user/addFull">
				<h1>账号密码注册</h1>
				<div>
				    <input type="text" name="usercode" value="${usercode}" style="display: none;"/>
				    <input type="text" name="username" value="${username}" style="display: none;"/>
				    <input type="text" name="password" value="${password}" style="display: none;"/>
					<input type="text" autofocus="autofocus" placeholder="手机号码" lay-verify="phone" id="phoneNo" name="phoneno"/>
				</div>
				<div>
					<input type="text" placeholder="邮箱地址" lay-verify="email" id="emailAddress" name="emailAddress" />
				</div>
<!-- 				<div> -->
<!-- 										<input type="file" placeholder="头像图片" required="" id="headAddress" onchange="getPhoto(this)" /> -->
<!-- 					<div id="headImg" style="width: 55px; height: 55px; border: 1px solid #ccc; float: left; margin: 0px 0px 10px 20px;"> -->
<%-- 						<img style="width: 55px; height: 55px;" src="${base}static/images/default_head.png"> --%>
<!-- 					</div> -->
<!-- 					<div style="float: left;"> -->
<!-- 						<input type="file" name="attachment" id="attachment" style="display: none;" onchange="getPhoto(this)" /> <input type="text" name="path" id="path" style="display: none;" onfocus="jQuery('#attachment').click()" /> -->
<!-- 						<button style="margin: 20px 0px 0px 10px" class="layui-btn layui-btn-xs" value="上传头像" onclick="ahclick('attachment')">上传头像</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<div>
					<textarea placeholder="自我介绍" required="" id="selfIntroduction" name="selfIntroduction" rows="5" cols="5"></textarea>
				</div>
				<div> 
					<input type="submit" lay-submit lay-filter="registerOver" value="完成注册" /> <input type="button"  lay-submit lay-filter="registerLast" value="上一步" /> <a href="${base }fullLogin">账号密码登录</a> <a href="${base }login">身份编码登录</a>
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
