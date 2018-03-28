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
				$("#" + id).addClass("url-select");
				window.open(url);
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
		$("#url-preview").css("top", X + h + 12);
		$("#url-preview").css("position", "absolute");
		$("#" + id).addClass("url-select");

		$("#url-operation").css("display", "block");
		$("#url-operation").css("left", Y + yw + 12);
		$("#url-operation").css("top", X - 1);
		$("#url-operation").css("position", "absolute");
		$("#url-operation").html("<div class='url-remove-update' onclick='urlDelete(" + id + ")'>删</div><div class='url-remove-update' onclick='urlUpdate(" + id + ")'>改</div>");
		$("#url-preview").html("<span>" + url + "</span>");
		$("#websiteName").val(text);
		$("#websiteAddress").val(url);
		$("#webId").val(id);
		$("#subAddUrl").val("修改");
	}

	function goOut(id) {
		$("#url-preview").css("display", "none");
		$("#" + id).removeClass("url-select");
	}

	function openAddUrl() {
		$("#websiteName").val(null);
		$("#websiteAddress").val(null);
		$("#webId").val(null);
		$("#subAddUrl").val("新增");
		setDivCenter("#url-operation-window");
		$("#websiteAddress").focus();

	}
	function operationGoOut() {
		$("#url-operation").css("display", "none");
	}
	function urlDelete(id) {
		$.messager.confirm('提示', '确定删除吗?', function(r) {
			if (r) {
				var url = '${base}tree/deleteNew?id=' + id;
				$.ajax({
					//几个参数需要注意一下
					type : "POST",//方法类型
					dataType : "json",//预期服务器返回的数据类型
					url : url,//url
					success : function(result) {
						if (result.code == 200) {
							location.href = "${base}tree/getAllUri";
						}
					},
					error : function() {
						location.href = "${base}tree/getAllUri";
					}
				});
			}
		});

	}
	function urlUpdate(id) {
		setDivCenter("#url-operation-window");
		$("#websiteAddress").focus();
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

	function setDivCenterUpdate(id, divName) {
		var X = $("#" + id).offset().top;
		var Y = $("#" + id).offset().left;
		var h = $("#" + id).height();
		$(divName).css("left", Y);
		$(divName).css("top", X + h + 12);
		$(divName).css("position", "absolute");
		$(divName).show(300);
	}

	function addOrUpdate() {
		var address = $("#websiteAddress").val();
		if (address == '') {
			$.messager.alert("提示", "网站地址不能为空！", "warning");
		} else {
			var sub = $("#subAddUrl").val();
			var url = '${base}tree/addTreeNew';
			if (sub == "新增") {
				url = '${base}tree/addTreeNew';
			}
			if (sub == "修改") {
				url = '${base}tree/update';
			}
			$.ajax({
				//几个参数需要注意一下
				type : "POST",//方法类型
				dataType : "json",//预期服务器返回的数据类型
				url : url,//url
				data : $('#url-add-update').serialize(),
				success : function(result) {
					if (result.code == '200') {
						location.href = "${base}tree/getAllUri";
					} else {
						$.messager.alert("提示", "操作异常！", "warning");
					}
				},
				error : function() {
					$.messager.alert("提示", "操作异常！", "warning");
				}
			});
		}
	}
</script>
<style>
.url-go {
	height: 22px;
	min-width: 60px;
	background-color: #a8a9a9;
	float: left;
	margin: 5px 20px 20px 5px;
	font-weight: 700;
	font-size: 12;
	line-height: 22px;
	cursor: pointer;
	box-shadow: 1px 1px 20px #a8a9a9;
	text-align: center;
	padding: 5px;
	border-radius: 2px;
}

.go-website.hot {
	float: none !important;
	min-height: 70px;
}

.go-website.rule {
	float: none !important;
	min-height: 5px;
}

.go-website.else {
	float: none !important;
	min-height: 70px;
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
	/* 		float: left; */
}

.url-table {
	/* 	width: 100%; */
	
}

.url-lable {
	font-size: 12px;
	color: #7C858D;
	margin: 5px;
	/* 	float: left; */
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
	margin: 3px 5px 2px 5px;
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
		<div class="go-website hot">
			<c:if test="${hotTrees.size()>0 }">
				<div class="url-lable">经常访问的</div>
				<c:forEach items="${hotTrees}" var="hu" varStatus="ui">
					<div id="${hu.id}" class="url-go" onmouseout="goOut('${hu.id}')" onmouseover="goOver('${hu.id}','${hu.url}','${hu.readMode}','${hu.text}')" onclick="goUrl('${hu.id}','${hu.url}')">${hu.text}</div>
				</c:forEach>
			</c:if>
		</div>
		<div class="go-website rule">
			<c:if test="${hotTrees.size()>0 }">
				<div id="cut-off-rule"></div>
			</c:if>
		</div>
		<div class="go-website else">
			<c:if test="${urls.size()>0 }">
				<c:if test="${hotTrees.size()>0 }">
					<div class="url-lable">其他的</div>
				</c:if>
				<c:forEach items="${urls}" var="u" varStatus="ui">
					<div id="${u.id}" class="url-go" onmouseout="goOut('${u.id}')" onmouseover="goOver('${u.id}','${u.url}','${u.readMode}','${u.text}')" onclick="goUrl('${u.id}','${u.url}')">${u.text}</div>
				</c:forEach>
				<div id="url-go-add" title="新增网站收藏" class="url-go url-add" onclick="openAddUrl()">+</div>
			</c:if>
			<c:if test="${urls.size()==0 }">
				<table class="url-table">
					<tr>
						<td><div id="url-go-add" title="新增网站收藏" class="url-go url-add" onclick="openAddUrl()">+</div></td>
					</tr>
				</table>
			</c:if>
		</div>
	</div>
	<div id="url-preview"></div>
	<div id="url-operation" onmouseout="operationGoOut()"></div>
	<div id="url-operation-window" class="url-window">
		<div>
			<form action="" method="post" id="url-add-update">
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
						<td colspan="2"><input class="url-input-button" type="button" id="subAddUrl" onclick="addOrUpdate()" value="新增" /><input class="url-input-button" type="button" id="closeButton" onclick="$('#url-operation-window').hide(200)"
							value="关闭" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>