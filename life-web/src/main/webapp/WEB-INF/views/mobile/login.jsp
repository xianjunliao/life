<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../mobileHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script type="text/javascript">
	function enter() {
		var v = $("#usercode").val();
		if (v == null || v == "" || v == undefined) {
			$("#dlg1-msg").html('<span style="color: red">请输入身份编码！！！</span>');
			$('#dlg1').dialog('open').dialog('center');
		} else {
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : '${base}enter?code=' + v,
				success : function(result) {
					if (result.code == 200) {
						window.location.replace("${base}learn/mob");
					} else if (result.code == 202) {
						$("#dlg1-msg").html('<span style="color: red">' + result.message + '</span>');
						$('#dlg1').dialog('open').dialog('center');
					} else {
						$("#dlg1-msg").html('<span style="color: red">' + result.message + '</span>');
						$('#dlg1').dialog('open').dialog('center');
					}
				}
			});
		}
	}

	function addUserCode() {
		var v = $("#usercode").val();
		if (v == null || v == "" || v == undefined) {
			$("#dlg1-msg").html('<span style="color: red">请输入身份编码！！！</span>');
			$('#dlg1').dialog('open').dialog('center');
			return;
		}
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}add?code=' + v,
			success : function(result) {
				if (result.code == 200) {
					enter();
				} else {
					$("#dlg1-msg").html('<span style="color: red">' + result.message + '</span>');
					$('#dlg1').dialog('open').dialog('center');
				}
			}
		});

	}
	function autoLogin() {
		var v = getCookie("usercode");
		if (v != null) {
			$("#usercode").passwordbox("setValue", v);
			$("#loginButton").click();
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
</script>
<style>
.easyui-navpanel{
  font-family: "STKaiti";
  width: 100%;
  height:auto;
  background:url("${base}static/mobile/images/bj1.jpg") no-repeat;
  background-size: 100%;
}
</style>
</head>
<body onload="autoLogin()">
	<div class="easyui-navpanel" style="">
		<header>
			<div class="m-toolbar">
				<span class="m-title">欢迎来到Free Life网站，请登录或注册。</span>
			</div>
		</header>
		<div style="margin: 20px auto; width: 168px; height: 50px; border-radius: 5px; overflow: hidden;opacity:0.4;">
			<img src="${base}static/mobile/images/299497.png" style="margin: 0; width: 168px; height: 50px;">
		</div>
		<div style="padding: 0 20px;">
			<div style="margin-bottom: 10px;opacity:0.6;">
				<input class="easyui-passwordbox" data-options="prompt:'请输入网址的身份编码...',iconCls:'icon-man'" id="usercode" style="width: 100%; height: 38px">
			</div>
			<div style="opacity:0.8;text-align: center; margin-top: 30px">
				<a onclick="enter()" id="loginButton" class="easyui-linkbutton" style="width: 100%; height: 40px"><span style="font-size: 16px">确定登陆</span></a>
			</div>
			<div style="opacity:0.8;text-align: center; margin-top: 30px">
				<a onclick="addUserCode()" class="easyui-linkbutton" plain="true" outline="true" style="width: 160px; height: 35px"><span style="font-size: 16px">点击注册并登陆</span></a>
			</div>
			<div style="text-align: left; margin-top: 30px;" >
				<span>1.本网站需身份编码才可登录，点击‘注册并登陆’按钮可直接注册和进入本网站。 </span><br>
				<span>2.本着快乐生活，自由生活的憧憬，本网站的主要功能有辅助用户学习英语、消费收入管理、重要事件备忘等等。 </span><br>
				<span>3.使用过程中遇到任何问题可联系站长；电话：15889303913 邮箱：xianjun_liao@126.com </span><br>
				<span>4.本网站会一直处于频繁更新版本中（用户产生的数据不会丢失和更改），欢迎随时使用体验。 </span><br>
			</div>
		</div>
	</div>
	<div id="dlg1" class="easyui-dialog" style="padding: 20px 6px; width: 80%;" data-options="inline:true,modal:true,closed:true,title:'Information'">
		<div id="dlg1-msg"></div>
		<div class="dialog-button">
			<a href="javascript:void(0)" class="easyui-linkbutton" style="width: 100%; height: 35px" onclick="$('#dlg1').dialog('close')">OK</a>
		</div>
	</div>
</body>
</html>
