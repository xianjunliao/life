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
			form.on('submit(updateOver)', function(data) {
				var user = data.field;
				var action = data.form.action;
				console.log(user);
				var rightCount = $(".right").length
				if (rightCount >= 3) {
					$.ajax({
						url : action,
						data : user,
						type : "POST",
						dataType : "json",
						success : function(result) {
							if (result.code == 200) {
								$("#errorMsg").html('<span style="color: green"><b>更新成功，正在上传头像。。。！<b></span>');
								UpladFile();
							} else {
								$("#errorMsg").html('<span style="color: red"><b>' + result.message + '<b></span>');
							}
						}
					});
				} else {
					$("#errorMsg").html('<span style="color: red">请完善必填项！</span>');
				}
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
				console.log(file);
				console.log(file.getType());
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
		var textHtml = "<img name='attachment' src='"+imgRUL+"'width='55px' height='55px' style='border-radius: 50%;'/>";
		$("#headImg").empty();
		$("#headImg").html(textHtml);
	}
	function ahclick(id) {
		$("#" + id).click();
	}
	function UpladFile() {
		var fileObj = document.getElementById("attachment").files[0]; // js 获取文件对象
		if (fileObj != undefined) {
			var userCode = $("#usercode").val();
			var url = "${base}user/updateUploadImg" // 接收上传文件的后台地址 
			var form = new FormData(); // FormData 对象
			form.append("file", fileObj); // 文件对象
			xhr = new XMLHttpRequest(); // XMLHttpRequest 对象
			xhr.open("post", url, true); //post方式，url为服务器请求地址，true 该参数规定请求是否异步处理。
			xhr.onload = uploadComplete; //请求完成
			xhr.onerror = uploadFailed; //请求失败
			xhr.send(form); //开始上传，发送form数据
		} else {
			$("#errorMsg").html('<span style="color: green"><b>个人信息更新成功！<b></span>');
			parent.location.href=basePath+"login";
		}

	}
	//上传成功响应
	function uploadComplete(evt) {
		//服务断接收完文件返回的结果
		var data = JSON.parse(evt.target.responseText);
		if (data.code == 200) {
			$("#errorMsg").html('<span style="color: green"><b>上传头像成功！<b></span>');
			parent.location.href=basePath+"login";
		} else {
			$("#errorMsg").html('<span style="color: red"><b>' + result.message + '<b></span>');
		}

	}
	//上传失败
	function uploadFailed(evt) {
		$("#errorMsg").html('<span style="color: red"><b>头像上传失败<b></span>');
	}
	//取消上传
	function cancleUploadFile() {
		xhr.abort();
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
</script>
</head>
<body>
	<div class="container">
		<section id="content">
			<form class="layui-form" id="updateForm" method="post" action="${base}user/update" enctype="multipart/form-data">
				<h1>完善个人信息</h1>
				<div>
					<input type="hidden" id="usercode" name="usercode" value="${userModel.usercode}" /> <input type="text" autofocus="autofocus" placeholder="请输入用户名" required="" onblur="checkUserName()" oninput="checkUserName()" value="${userModel.username}" id="username" name="username" />
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
					<input type="password" placeholder="请输入密码" required="" id="password" name="password" onblur="checkPassword()" oninput="checkPassword()" value="${userModel.password}" />
					<div class="check_img" id="passwordImg">
						<c:if test="${userModel.password==null}">
							<img title="请输入密码！" src="${base}static/images/info.png" />
						</c:if>
						<c:if test="${userModel.password!=null}">
							<img title="请输入密码！" class="right" src="${base}static/images/right.png" />
						</c:if>
					</div>
				</div>
				<div>
					<input type="password" placeholder="再次输入密码" required="" id="rePassword" onblur="checkRePassword()" oninput="checkRePassword()" value="${userModel.password}" />
					<div class="check_img" id="rePasswordImg">
						<c:if test="${userModel.password==null}">
							<img title="请输入密码！" src="${base}static/images/info.png" />
						</c:if>
						<c:if test="${userModel.password!=null}">
							<img title="请输入密码！" class="right" src="${base}static/images/right.png" />
						</c:if>
					</div>
				</div>
				<div>
					<input type="text" placeholder="手机号码" lay-verify="phone" id="phoneNo" name="phoneno" value="${userModel.phoneno}" />
					<div class="check_img">
						<img title="请输入手机号码！" src="${base}static/images/right2.png" />
					</div>
				</div>
				<div>
					<input type="text" placeholder="邮箱地址" lay-verify="email" id="emailAddress" name="emailaddress" value="${userModel.emailaddress}" />
					<div class="check_img">
						<img title="请输入邮箱地址！" src="${base}static/images/right2.png" />
					</div>
				</div>
				<div>
					<div id="headImg" style="width: 55px; height: 55px; border: 1px solid #ccc; float: left; margin: 0px 0px 10px 20px;border-radius: 10%;">
						<c:if test="${userModel.headaddress==null}">
							<img style="width: 55px; height: 55px;border-radius: 50%;" name="headImg" src="${base}static/images/default_head.png">
						</c:if>
						<c:if test="${userModel.headaddress!=null}">
							<img style="width: 55px; height: 55px;border-radius: 50%;" name="headImg" src="${userModel.headaddress}">
						</c:if>
					</div>
					<div style="float: left;">
						<input type="file" id="attachment" style="display: none;" onchange="getPhoto(this)" accept="image/*" /> <input type="text" id="path" style="display: none;" onfocus="jQuery('#attachment').click()" />
						<button style="margin: 20px 0px 0px 10px" class="layui-btn layui-btn-xs" value="本地浏览图片" onclick="ahclick('attachment')">更新头像</button>
						<div class="check_img">
							<img title="更新头像！" src="${base}static/images/right2.png" />
						</div>
					</div>

				</div>
				<div>
					<textarea placeholder="自我介绍"  required="" id="selfIntroduction" name="selfintroduction" rows="5" cols="5">${userModel.selfintroduction}</textarea>
					<div class="check_img">
						<img title="请输入自我介绍！" src="${base}static/images/right2.png" />
					</div>
				</div>
				<div>
					<input type="submit" lay-submit lay-filter="updateOver" value="确认修改" />
				</div>
			</form>
			<div id="errorMsg" class="button"></div>
		</section>
		<!-- content -->
	</div>
	<!-- container -->
</body>
</html>
