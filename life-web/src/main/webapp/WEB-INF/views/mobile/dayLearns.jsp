<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../mobileHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script type="text/javascript">
	function back() {
		window.location.replace("${base}learn/mob?idx=0");
	}
</script>
<style>
.hh-inner {
	position: relative;
	line-height: 20px;
	background: #fff;
	font-weight: bold;
	margin: -5px;
	padding: 5px;
}
</style>
</head>
<body>

	<div class="easyui-navpanel">
		<header>
			<div class="m-toolbar">
				<span class="m-title">${learn.headline}的学习情况</span>
				<div class="m-left">
					<a href="javascript:void(0)" class="easyui-linkbutton m-back" plain="true" outline="true" onclick=" back()">返回</a>
				</div>
			</div>
		</header>
		<div class="easyui-accordion" data-options="fit:true,border:false,selected:0">
			<c:forEach items="${wordTypes}" var="wt">
				<div>
					<header>
						<div class="hh-inner">
							<span style="font-size: 16px; color: green;">${wt.itemName }</span> <span class="m-badge" style="float: right">26/51</span>
						</div>
					</header>
					<ul class="m-list">
						<c:forEach items="${words}" var="wd">
							<c:if test="${wd.type==wt.itemNo}">
								<c:if test="${wd.type=='word'}">
									<li style="text-align: left;"><b>${wd.word}</b>&nbsp;&nbsp;&nbsp;&nbsp;美:${wd.usPronunciation}&nbsp;&nbsp; 英：${wd.ukPronunciation} &nbsp;&nbsp;&nbsp;&nbsp;释义：${wd.definition } </li>
								</c:if>
								<c:if test="${wd.type!='word'}">
									<li style="text-align: left;"><b>${wd.word}</b>&nbsp;&nbsp;&nbsp;&nbsp;释义：${wd.definition }</li>
								</c:if>
							</c:if>
						</c:forEach>
					</ul>
					<div style="text-align: center;">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加${wt.itemName }</a> <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除${wt.itemName }</a> <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改${wt.itemName }</a>
					</div>

				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>
