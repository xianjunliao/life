<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../headerH5.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<style>
</style>
<script type="text/javascript">
	function getPhoto(node) {
		// 		$('#path').val($('#attachment').val());
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
		var textHtml = "<img name='attachment' onClick='ahclick()' src='" + imgRUL + "'width='100px' height='100px' style='border-radius: 50%;cursor: pointer;'/>";
		$("#headImg").empty();
		$("#headImg").html(textHtml);
	}
	function ahclick() {
		$("#attachment").click();
	}
	function UpladFile() {
		var fileObj = document.getElementById("attachment").files[0]; // js 获取文件对象
		if (fileObj != undefined) {
			var url = "${base}user/updateUploadImg" // 接收上传文件的后台地址 
			var form1 = new FormData(); // FormData 对象
			form1.append("file", fileObj); // 文件对象
			xhr = new XMLHttpRequest(); // XMLHttpRequest 对象
			xhr.open("post", url, true); //post方式，url为服务器请求地址，true 该参数规定请求是否异步处理。
			xhr.onload = uploadComplete; //请求完成
			xhr.onerror = uploadFailed; //请求失败
			xhr.send(form1); //开始上传，发送form数据
		} else {
// 			$("#errorMsg").html('<span style="color: green"><b>个人信息更新成功！<b></span>');
// 			top.location.href = basePath + "login";
		}

	}
	//上传成功响应
	function uploadComplete(evt) {
		//服务断接收完文件返回的结果
		var data = JSON.parse(evt.target.responseText);
		if (data.code == 200) {
			top.location.href = "${base}login";
		} else {
			layer.alert('上传失败', {
				icon : 5
			});
		}

	}
	//上传失败
	function uploadFailed(evt) {
		layer.alert('上传失败', {
			icon : 5
		});
	}
	//取消上传
	function cancleUploadFile() {
		xhr.abort();
	}
</script>
</head>
<body>
	<div style="margin-top: 25px;">
		<div id="headImg" style="width: 100px; height: 100px; border: 1px solid #ccc; margin: 0px 0px 10px 20px; border-radius: 10%; float: left;">
			<c:if test="${userModel.headaddress==null}">
				<img onClick="jQuery('#attachment').click()" style="width: 100px; height: 100px; border-radius: 50%; cursor: pointer;" src="${base}static/images/default_head.png">
			</c:if>
			<c:if test="${userModel.headaddress!=null}">
				<img onClick="jQuery('#attachment').click()" style="width: 100px; height: 100px; border-radius: 50%; cursor: pointer;" src="${userModel.headaddress}">
			</c:if>
		</div>
		<div style="float: left;">
			<input type="file" id="attachment" style="display: none;" onchange="getPhoto(this)" accept="image/*" />
			<button onclick="UpladFile()" class="layui-btn layui-btn-lg" style="margin-top: 30px; margin-left: 20px;">
				<i class="layui-icon">&#xe62f;</i>确认上传
			</button>
		</div>
	</div>
</body>
</html>
