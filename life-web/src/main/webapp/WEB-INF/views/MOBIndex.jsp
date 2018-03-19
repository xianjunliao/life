<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../mobileHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script type="text/javascript">
	$(function() {
	})
	function openit(id) {
		window.location.replace("${base}learn/dayLearns?id="+id);
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
			<div style="padding: 10px">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_ENGLISH.jpg' width="30px;" height="30px;" /><br>学海无涯
				</div>
				<div class="easyui-tabs" data-options="fit:true,border:false,pill:true,justified:true,tabWidth:80,tabHeight:35">
					<div title="每日词汇记" style="padding: 10px">
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
			<div style="padding: 10px">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_MONEY.png' width="30px;" height="30px;" /><br>精打细算
				</div>
				<p>精打细算</p>
			</div>
			<div style="padding: 10px">
				<div class="panel-header tt-inner">
					<img src='${base}static/mobile/images/NV_MEMO.png' width="30px;" height="30px;" /><br>备忘录 <span class="m-badge">12</span>
				</div>
				<p>备忘录</p>
			</div>
			<div style="padding: 10px">
				<div class="panel-header tt-inner">
					<c:if test="${userInfo.headaddress==null }">
						<img src='${base}static/mobile/images/NV_MYSEIF.png' width="30px;" height="30px;" />
					</c:if>
					<c:if test="${userInfo.headaddress!=null }">
						<img src='${userInfo.headaddress}' width="30px;" height="30px;" />
					</c:if>
					<br>个人中心
				</div>
				<p>个人中心</p>
			</div>
		</div>
	</div>
</body>
</html>
