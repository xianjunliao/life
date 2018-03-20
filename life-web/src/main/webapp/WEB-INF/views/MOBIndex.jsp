<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../mobileHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script type="text/javascript">
	$(function() {
		$(".tabs-narrow li:eq(${idx})").addClass("tabs-selected");
	})
	function openit(id) {
		window.location.replace("${base}learn/dayLearns?id="+id);
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
</style>
</head>
<body>
	<div class="easyui-navpanel">
		<div class="easyui-tabs" data-options="tabHeight:60,fit:true,tabPosition:'bottom',border:false,pill:true,narrow:true,justified:true">
			<div style="padding: 10px; background-color: #f2f6f9;">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_ENGLISH.jpg' width="30px;" height="30px;" /><br>学海无涯
				</div>
				<div class="easyui-tabs" data-options="fit:true,border:false,pill:true,justified:true,tabWidth:80,tabHeight:35">
					<header>
						<div class="m-toolbar">
							<span class="m-title">学海无涯</span>
						</div>
					</header>
					<div title="每日词汇" style="padding: 10px">
						<div class="easyui-navpanel">
							<header>
								<div class="m-toolbar">
									<span class="m-title">学习记录</span>
								</div>
							</header>
							<ul class="m-list">
								<c:forEach items="${dayLearns}" var="dl">
									<li><a href="javascript:void(0)" onclick="openit(${dl.key.id})">${dl.key.headline} &nbsp;&nbsp;${dl.value}</a></li>
								</c:forEach>

							</ul>
						</div>
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
			<div style="padding: 10px; background-color: #f2f6f9;">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_MONEY.png' width="30px;" height="30px;" /><br>精打细算
				</div>
				<p>精打细算</p>
			</div>
			<div style="padding: 10px; background-color: #f2f6f9;">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_MEMO.png' width="30px;" height="30px;" /><br>备忘录 <span class="m-badge">0</span>
				</div>
				<p>备忘录</p>
			</div>
			<div style="padding: 10px; background-color: #f2f6f9;">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_MYSEIF.png' width="30px;" height="30px;" />
					<br>我
				</div>
				<div class="easyui-navpanel" style="background-color: #f2f6f9;">
					<header >
						<div class="m-toolbar" >
							<span class="m-title">我</span>
						</div>
					</header>
					<div style="background-color: #f2f6f9;height: auto;padding-top: 15px;">
						<ul class="m-list" style="background-color:white;">
							<li><a href="javascript:void(0)" onclick=""> <span style="float: left;"> <c:if test="${userInfo.headaddress==null }">
											<img src='${base}static/mobile/images/NV_MYSEIF.png' width="35px;" height="35px;" />
										</c:if> <c:if test="${userInfo.headaddress!=null }">
											<img src='${userInfo.headaddress}' width="35px;" height="35px;" />
										</c:if>
								</span> <span style="margin-left: 15px; font-size: 12px;">用户名： <c:if test="${userInfo.username!=null }">${ userInfo.username}</c:if></span> <br> <span style="margin-left: 15px; font-size: 12px;">手机号码：${ userInfo.phoneno}</span>
							</a></li>
						</ul>
						<ul class="m-list" style="margin-top: 20px; border-top: 1px #ddd solid;background-color:white;">
							<li><a href="javascript:void(0)" onclick="">学习统计</a></li>
							<li><a href="javascript:void(0)" onclick="">消费统计</a></li>
							<li><a href="javascript:void(0)" onclick="">收入统计</a></li>
						</ul>
						<ul class="m-list" style="margin-top: 20px; border-top: 1px #ddd solid;background-color:white;">
							<li><a href="javascript:void(0)" onclick="">设置</a></li>
						</ul>
						<div align="center" style="margin-top: 20px;">
							<a onclick="exit()" class="easyui-linkbutton c5" style="width: 30%">退出登陆</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
