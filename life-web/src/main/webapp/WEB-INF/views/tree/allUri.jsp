<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript">
	$(function() {
		$(".url-go").bind("contextmenu", function() {
			return false;
		});
	});

	function goUrl(id, url) {

		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}tree/visits?id=' + id,
			success : function(result) {
				if (result.code == 200) {
					$("#" + id).addClass("url-select");
					window.open(url);
				}
			}
		});

	}
	function goOver(id, url, mode, text) {
		if (url == null || url == '') {
			return;
		}
		var X = $("#" + id).offset().top;
		var Y = $("#" + id).offset().left;
		var h = $("#" + id).height();
		var yw = $("#" + id).width();
		$("#url-preview").css("display", "block");
		$("#url-preview").css("left", Y);
		$("#" + id).addClass("url-select");
		$("#url-preview").css("top", X + h + 12);
		$("#url-preview").css("position", "absolute");

		$("#url-operation").css("display", "block");
		$("#url-operation").css("left", Y + yw + 5);
		$("#url-operation").css("top", X - 1);
		$("#url-operation").css("position", "absolute");
		$("#url-operation").html("<div class='url-remove-update' onclick='urlDelete(" + id + ")'>删</div><div class='url-remove-update' onclick='urlUpdate(" + id + ")'>改</div>");
		$("#url-preview").html("<span>" + url + "</span>");
		$("#websiteName").val(text);
		$("#websiteAddress").val(url);
		$("#websiteId").val(id);
		$("#subAddUrl").val("修改");
	}

	function goOut(id) {
		$("#url-preview").css("display", "none");
		$("#" + id).removeClass("url-select");

	}

	function openAddUrl() {
		$("#websiteName").val(null);
		$("#websiteAddress").val(null);
		$("#websiteId").val(null);
		$("#subAddUrl").val("新增");
		setDivCenter("#url-operation-window");
		$("#websiteName").focus();

		// 		window.location.href = "${base}house";
	}
	function operationGoOut() {
		$("#url-operation").css("display", "none");
	}
	function urlDelete(id) {
		$("#" + id).hide(500);
		$("#url-operation").css("display", "none");
	}
	function urlUpdate(id) {
		setDivCenter("#url-operation-window");
		$("#websiteName").focus();
		$("#subAddUrl").val("修改");
		console.log(id);
	}
	function setDivCenter(divName) {
		var top = ($(window).height() - $(divName).height()) / 2;
		var left = ($(window).width() - $(divName).width()) / 2;
		var scrollTop = $(document).scrollTop();
		var scrollLeft = $(document).scrollLeft();
		$(divName).css({
			position : 'absolute',
			'top' : top + scrollTop,
			left : left + scrollLeft
		}).show(300);
	}
</script>
<style>
.url-go {
	height: 25px;
	min-width: 60px;
	max-width: 120px;
	background-color: #a8a9a9;
	/* 	float: left; */
	margin: 10px 20px 10px 10px;
	font-weight: 700;
	font-size: 12;
	line-height: 25px;
	cursor: pointer;
	box-shadow: 1px 1px 20px #a8a9a9;
	text-align: center;
	padding: 2px;
	border-radius: 2px;
}

.url-select {
	background-color: #a4d2f5;
	box-shadow: 1px 1px 20px #a4d2f5 !important;
}

#url-preview {
	text-align: center;
	box-shadow: 1px 1px 20px #333333;
	z-index: 9999;
	padding: 2px;
	font-weight: 700;
	color: #e47b7b;
}

#url-operation {
	text-align: center;
	z-index: 9999;
	color: #b1b0b0;
	font-size: 6;
}

.url-add {
	font-size: 18 !important;
	background-color: #f9f9db !important;
}

.url-remove-update {
	cursor: pointer;
}

#cut-off-rule {
	height: 2px;
	width: 100%;
	background-color: #d7e0e8;
	margin-top: 20px;
	margin-bottom: 5px;
}

.url-table {
	/* 	width: 100%; */
	
}

.url-lable {
	font-size: 12px;
	color: #7C858D;
	margin: 5px;
}

.url-window {
	font-family: "STKaiti";
	font-size: 12;
	display: none;
	background-color: #d7e0e8;
	text-align: center;
	padding: 10px 10px 5px 10px;
	box-shadow: 10px 10px 50px #d7e0e8;
}

.url-input {
	border: 1px #e0bcbc solid;
	width: 280px;
	height: 25px;
	margin: 1px 5px 2px 5px;
}

.url-span {

}

.url-input-button {
	width: 80px;
	height: 20px;
	background-color: #80b7e8;
	border-radius: 20px;
	margin: 5px 5px 0px 5px;
	line-height: 22px;
	cursor: pointer;
}
</style>

</head>
<body id="bodyShow" class="easyui-layout" style="width: 100%; height: 100%;" onmouseup="operationGoOut()">
	<div region="center" border="true" style="width: 100%; height: 100%;">
		<c:if test="${hotTrees.size()>0 }">
			<table class="url-table">
				<tr>
					<td><div class="url-lable">经常访问的</div></td>
				</tr>
				<tr>
					<c:forEach items="${hotTrees}" var="hu">
						<td><div id="${hu.id}" class="url-go" onmouseout="goOut('${hu.id}')" onmouseover="goOver('${hu.id}','${hu.url}','${hu.readMode}','${hu.text}')" onclick="goUrl('${hu.id}','${u.url}')">${hu.text}</div></td>
					</c:forEach>
				</tr>
			</table>
		</c:if>
		<div id="cut-off-rule"></div>
		<c:if test="${urls.size()>0 }">
			<table class="url-table">
				<tr style="margin-top: 30px;">
					<td><div class="url-lable">其他的</div></td>
				</tr>
				<tr>
					<c:forEach items="${urls}" var="u">
						<td><div id="${u.id}" class="url-go" onmouseout="goOut('${u.id}')" onmouseover="goOver('${u.id}','${u.url}','${u.readMode}','${u.text}')" onclick="goUrl('${u.id}','${u.url}')">${u.text}</div></td>
					</c:forEach>
					<td><div id="url-go-add" title="新增网站收藏" class="url-go url-add" onclick="openAddUrl()">+</div></td>
				</tr>
			</table>
		</c:if>
		<c:if test="${urls.size()==0 }">
			<table class="url-table">
				<tr>
					<td><div id="url-go-add" title="新增网站收藏" class="url-go url-add" onclick="openAddUrl()">+</div></td>
				</tr>
			</table>
		</c:if>
	</div>
	<div id="url-preview"></div>
	<div id="url-operation" onmouseout="operationGoOut()"></div>
	<div id="url-operation-window" class="url-window">
		<div>
			<form action="">
				<input type="hidden" name="id" id="webId">
				<table>
					<tr>
						<td><span class="url-span">网站名称:</span></td>
						<td><input class="url-input" type="text" id="websiteName" name="text" /></td>
					</tr>
					<tr>
						<td><span class="url-span">网站地址:</span></td>
						<td><input class="url-input" type="text" id="websiteAddress" name="url" /></td>
					</tr>
					<tr align="center">
						<td colspan="2"><input class="url-input-button" type="button" id="subAddUrl" name="url" value="新增" /><input class="url-input-button" type="button" id="closeButton" onclick="$('#url-operation-window').hide(200)" value="关闭" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>

</body>
</html>