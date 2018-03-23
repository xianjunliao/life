<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../mobileHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script type="text/javascript">
	$(function() {
		var index=${idx};
		 $('#all-tabs').tabs('select',index);
	})
	function openit(id) {
		window.location.replace("${base}learn/dayLearns?id="+id);
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
	
</script>
<style>
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
	box-shadow: 1px 1px 20px #333333;
	-moz-box-shadow: 2px 2px 20px #333333;
	-webkit-box-shadow: 2px 2px 20px #333333;
	background-color: white;
	background-color: white
}

a {
	font-weight: 700;
}
</style>
</head>
<body>
	<div class="easyui-navpanel" style="opacity: 0.8;">
		<div class="easyui-tabs" id="all-tabs" data-options="tabHeight:60,fit:true,tabPosition:'bottom',border:false,pill:true,narrow:true,justified:true">
			<div id="learnFull" class="list-ul" style="padding: 10px 10px 10px 10px; background-color: #f2f6f9;">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_ENGLISH.jpg' width="30px;" height="30px;" /><br>学海无涯
				</div>
				<div class="easyui-tabs list-ul" data-options="fit:true,border:false,pill:true,justified:true,tabWidth:80,tabHeight:35">
					<header>
						<div class="m-toolbar">
							<span class="m-title">学海无涯</span>
						</div>
					</header>
					<div title="每日词汇" style="padding: 10px 10px 20px 10px;">

						<ul class="m-list">
							<c:forEach items="${dayLearns}" var="dl">
								<li><a href="javascript:void(0)" onclick="openit(${dl.key.id})">${dl.key.headline} &nbsp;&nbsp;${dl.value}</a></li>
							</c:forEach>
						</ul>

					</div>
					<div title="单词速记" style="padding: 10px">
						<a href="javascript:void(0)" onclick="openDCSJ(this)">单词速记</a>
					</div>
					<div title="句子常读" style="padding: 10px">
						<a href="javascript:void(0)" onclick="openDCSJ(this)">句子常读</a>
					</div>
					<div title="美文欣赏" style="padding: 10px">
						<a href="javascript:void(0)" onclick="openDCSJ(this)">美文欣赏</a>
					</div>
				</div>
			</div>
			<div id="moneyMore" style="padding: 10px; background-color: #f2f6f9;">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_MONEY.png' width="30px;" height="30px;" /><br>精打细算
				</div>
				<p>精打细算</p>
			</div>
			<div id="dontForget" style="padding: 10px; background-color: #f2f6f9;">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_MEMO.png' width="30px;" height="30px;" /><br>备忘录 <span class="m-badge">0</span>
				</div>
				<p>备忘录</p>
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
								</span> 
								<span style="margin-left: 15px; font-size: 12px;"><c:if test="${userInfo.username!=null }">昵称：${ userInfo.username}</c:if>
								<c:if test="${userInfo.username==null }"><span style="color: gray;">创建昵称</span></c:if>
								</span> <br> <span style="margin-left: 15px; font-size: 12px;">
								 <c:if test="${userInfo.phoneno!=null }">手机号码：${ userInfo.phoneno}</c:if>
								 <c:if test="${userInfo.phoneno==null }"><span style="color: gray;">添加手机号码</span></c:if></span>
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
