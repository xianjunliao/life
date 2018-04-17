<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../mobileHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<script type="text/javascript">
	$(function() {
		var idx = "${idx}";
		initDays();
		$('#all-tabs').tabs('select', idx);
		$('#all-tabs').tabs({
			onSelect : function(title, index) {
				if (index == 0) {
					initDays();
				}
			}
		});
	})
	function openit(id) {
		window.location.replace("${base}learn/dayLearns?id=" + id + "&tabIndex=0");
	}

	function setingUrl() {
		window.location.replace("${base}mobile/seting");
	}
	function exit() {
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}exit',
			success : function(result) {
				self.location.href = '${base }mobLogin';
			}
		});
	}
	function initDays(v) {
		$("#word-days").empty();
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}learn/getDays',
			success : function(result) {
				if (result.code == 200) {
					$("#word-days").hide(300);
					var days = result.data;
					for (var i = 0; i < days.length; i++) {
						var id = days[i].id;
						var headline = days[i].headline;
						var wordSum = days[i].wordSum;
						var phraseSum = days[i].phraseSum;
						var sentenceSum = days[i].sentenceSum;
						var articleSum = days[i].articleSum;
						$("#word-days").append('<li class="word-li" id="word-li'+id+'"><a href="javascript:void(0)" onclick="openit(' + id + ')">' + headline + ' &nbsp;&nbsp;单词<b style="color: red;">' + wordSum + '</b>个,词组<b style="color: red;">' + phraseSum + '</b>个,句子<b style="color: red;">' + sentenceSum + '</b>个,文章<b style="color: red;">' + articleSum + '</b>篇</a></li>');
					}
					if (v == null) {

					}
					$("#word-days").show(800);
				}
			}
		});
	}
</script>
<style>
.word-li {
	
}

html, body {
	height: 100%;
	overflow: hidden;
}

.tt-inner {
	display: inline-block;
	line-height: 12px;
	padding-top: 5px;
}

p {
	line-height: 150%;
}

body {
	font-family: "STKaiti";
	width: 100%;
	height: 100%;
	background: url("${base}static/mobile/images/20180321_110947_3856.jpg")
		no-repeat;
	background-size: 100%;
}

.list-ul {
	padding: 0px;
	margin: 0px;
	background-color: white;
	border: 1px #white solid !important;
	box-shadow: inset 1px 1px 20px #333333;
	-moz-box-shadow: 2px 2px 20px #333333;
	-webkit-box-shadow: 2px 2px 20px #333333;
	background-color: white;
}

a {
	font-weight: 700;
}

.subjct-tip {
	box-shadow: inset 0px 0px 3px 3px #eab2b2;
	position: absolute;
	top: 0px;
	width: 100%;
	height: 40px !important;
	line-height: 30px;
	z-index: 9999;
	background-color: #c1f3e7;
}

.content-panel {
	margin-top: 40px;
}

.subjct-title {
	line-height: 40px !important;
}
</style>
</head>
<body>
	<div class="easyui-navpanel" style="opacity: 0.8;">
		<div class="easyui-tabs" id="all-tabs" data-options="tabHeight:60,fit:true,tabPosition:'bottom',border:false,pill:true,narrow:true,justified:true">
			<div id="learnFull" class="list-ul" style="padding: 10px 10px 10px 10px; background-color: #f2f6f9;">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_ENGLISH.jpg' width="30px;" height="30px;" /><br>每日英语
				</div>
				<div class="easyui-navpanel" data-options="fit:true,border:false" style="background-color: white !important;">
					<div>
						<header class="subjct-tip">
							<div class="m-toolbar">
								<span class="m-title subjct-title">每日英语</span>
							</div>
						</header>
						<div class="content-panel" id="big-div">
							<ul class="m-list" id="word-days">
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div id="moneyMore" style="padding: 10px; background-color: #f2f6f9;">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_MONEY.png' width="30px;" height="30px;" /><br>精打细算
				</div>
				<div class="easyui-navpanel" data-options="fit:true,border:false">
					<div>
						<header class="subjct-tip">
							<div class="m-toolbar">
								<span class="m-title subjct-title">精打细算</span>
							</div>
						</header>
						<div class="content-panel"></div>
					</div>
				</div>
			</div>
			<div id="dontForget" style="padding: 10px; background-color: #f2f6f9;">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_MEMO.png' width="30px;" height="30px;" /><br>备忘录 <span class="m-badge">0</span>
				</div>
				<div class="easyui-navpanel" data-options="fit:true,border:false,selected:0">
					<div>
						<header class="subjct-tip">
							<div class="m-toolbar">
								<span class="m-title subjct-title">备忘录</span>
							</div>

						</header>
						<div class="content-panel"></div>
					</div>
				</div>
			</div>
			<div id="myself" style="padding: 10px; background-color: #f2f6f9;" class="list-ul">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_MYSEIF.png' width="30px;" height="30px;" /> <br>个人中心
				</div>
				<div class="easyui-navpanel" style="background-color: #f2f6f9; opacity: 0.9; box-shadow: 1px 1px 1px #333333;">
					<ul class="m-toolbar m-list list-ul">
						<li>我</li>
					</ul>
					<div style="background-color: #f2f6f9; height: auto; padding-top: 15px;">
						<ul class="m-list list-ul">
							<li><a href="javascript:void(0)" onclick=""> <span style="float: left;"> <c:if test="${userInfo.headaddress==null }">
											<img src='${base}static/mobile/images/NV_MYSEIF.png' width="35px;" height="35px;" />
										</c:if> <c:if test="${userInfo.headaddress!=null }">
											<img src='${userInfo.headaddress}' width="35px;" height="35px;" />
										</c:if>
								</span> <span style="margin-left: 15px; font-size: 12px;"><c:if test="${userInfo.username!=null }">昵称：${ userInfo.username}</c:if> <c:if test="${userInfo.username==null }">
											<span style="color: gray;">创建昵称</span>
										</c:if> </span> <br> <span style="margin-left: 15px; font-size: 12px;"> <c:if test="${userInfo.phoneno!=null }">手机号码：${ userInfo.phoneno}</c:if> <c:if test="${userInfo.phoneno==null }">
											<span style="color: gray;">添加手机号码</span>
										</c:if></span>
							</a></li>
						</ul>
						<ul class="m-list list-ul" style="margin-top: 20px;">
							<li><a href="javascript:void(0)" onclick="">学习统计</a></li>
							<li><a href="javascript:void(0)" onclick="">消费统计</a></li>
							<li><a href="javascript:void(0)" onclick="">收入统计</a></li>
						</ul>
						<ul class="m-list list-ul" style="margin-top: 120px;">
							<li><a href="javascript:void(0)" onclick="setingUrl()">设置</a></li>
						</ul>
						<div align="center" style="margin-top: 20px;">
							<a onclick="exit()" class="easyui-linkbutton c5 list-ul" style="width: 30%">退出登陆</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
