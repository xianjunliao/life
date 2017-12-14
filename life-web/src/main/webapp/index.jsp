<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<style>
</style>
<script type="text/javascript">
	$(function() {
		$('#main').hide();
		$('#code').textbox().next('span').find('input').focus()
		$('#entrance').keydown(
				function(e) {
					if (e.keyCode == 13) {
						var v = $('#code').val();
						$.ajax({
							//提交数据的类型 POST GET
							type : "POST",
							//提交的网址
							url : "${base}/entrance/enterCode",
							//提交的数据
							data : {
								code : v
							},
							//返回数据的格式
							datatype : "json",//"xml", "html", "script", "json", "jsonp", "text".
							success : function(data) {
								if (data != null && data != "") {
									result = $.parseJSON(data);
									$('#entrance').dialog('close');
									$('#main').show();
									playMp3(result.userMusic);
									ing(v);
									welcomeTo(result);
								} else {
									showMsg("Your code is wrong !");
									$('#code').textbox().next('span').find(
											'input').select();
								}
							},
							//调用出错执行的函数
							error : function() {
								//请求出错处理
							}
						});
					}
				});
	});

	function showMsg(msg) {

		$.messager.show({
			msg : msg,
			showType : 'show',
			style : {
				width : 150,
				height : 35,
				left : '',
				right : 0,
				top : '',
				bottom : -document.body.scrollTop
						- document.documentElement.scrollTop
			}
		});
	}
	function welcomeTo(m) {
		var t = m.waitTime;
		var d = [];
		for (i = 0; i < m.userMotto.length; i++) {
			if (i == 0) {
				d.push('<br />')
				d.push('&nbsp;&nbsp;&nbsp;&nbsp;')
			}
			if (m.userMotto.charAt(i - 1) == '.'
					|| m.userMotto.charAt(i - 1) == '?'
					|| m.userMotto.charAt(i - 1) == '!') {
				d.push('<br />')
				d.push('<br />')
				d.push('&nbsp;&nbsp;&nbsp;&nbsp;')
			}
			d.push(m.userMotto.charAt(i))
		}
		var arr = new Array();
		var size = 18;
		for (j = 0; j < d.length; j++) {
			arr.push(d[j]);
			setTimeout("enterCode('" + arr.join("") + "'," + size + ")", t);
			t += m.intervalTime;
		}
	}
	function enterCode(code, size) {

		$('#times').css('font-size', size);
		$('#times').html("<b>" + code + "</b>");
		$("div").scrollTop($('#times').outerHeight());
	}
	function ing(v) {
		$('#world')
				.append(
						'&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="intoWorld('+v+')" style="height: 30px; margin-bottom: 3px; text-decoration: underline; font-size: 18px"><b>into your world</b></a>');
	}
	function playMp3(songName) {
		$('#audios')
				.append(
						'&nbsp;&nbsp;&nbsp;&nbsp;<audio style="height: 30px;" id="audio" src="${base}/music/'+songName+'"></audio>');
		var myAuto = document.getElementById('audio');
		myAuto.controls = true;
		myAuto.play();
	}

	function intoWorld(v) {
		self.location.href = "${base}entrance/main";

	}
</script>
</head>
<body style="margin: 0px;">
	<div id="entrance" class="easyui-dialog" title="" data-options="iconCls:'icon-save',closable: true,border:false " style="width: 370px; height: 45px; padding: 5px">
		<input class="easyui-textbox" id="code" data-options="prompt:'Please enter your code...'" style="width: 358px; height: 34px">
	</div>
	<!-- 	<div style="margin: 5px;"></div> -->
	<div id="main" class="easyui-layout" style="width: 100%; height: 100%;">
		<div data-options="region:'south',split:false,border:false" style="width: 100%; height: 30px; overflow: hidden;">
			<div id="but" style="float: left;"></div>
			<div id="music" style="float: right;">
				<table>
					<tr>
						<td><div id="world"></div></td>
						<td><div id="audios"></div></td>
					</tr>
				</table>
			</div>
		</div>
		<div data-options="region:'center',title:'',iconCls:'icon-ok',border:false">
			<div>
				<table style="width: 100%; height: 100%;">
					<!-- 					<tr> -->
					<!-- 						<td></td> -->
					<!-- 					</tr> -->
					<tr>
						<td><div id="times">
								<b>Please waiting......</b>
							</div></td>
					</tr>
					<tr>
						<td><span id="ing"></span></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
