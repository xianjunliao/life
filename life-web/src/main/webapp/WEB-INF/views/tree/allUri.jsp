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
		$("#deleteButton").hide();
		$("#toTop").hide();
		$("#toUpdate").hide();
		$("#toLike").hide();
		$("#url-operation-window").mousedown(function(e) { //e鼠标事件  
			$(this).css("cursor", "move");//改变鼠标指针的形状  

			var offset = $(this).offset();//DIV在页面的位置  
			var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
			var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
			$(document).bind("mousemove", function(ev) { //绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
				$("#url-operation-window").stop();//加上这个之后  

				var _x = ev.pageX - x;//获得X轴方向移动的值  
				var _y = ev.pageY - y;//获得Y轴方向移动的值  

				$("#url-operation-window").animate({
					left : _x + "px",
					top : _y + "px"
				}, 10);
			});
		});

		$(document).mouseup(function() {
			$("#url-operation-window").css("cursor", "default");
			$(this).unbind("mousemove");
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
	function toTopClick(v) {
		var topNum = '1';
		if (v == '置顶') {
			topNum = '1';
		} else {
			topNum = '0';
		}
		var id = $("#webId").val();
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}tree/toTop?id=' + id + "&isTop=" + topNum,
			success : function(result) {
				location.href = "${base}tree/getAllUri";
			}
		});

	}
	function toLikeClick(v) {
		var likeNum = '1';
		if (v == '收藏') {
			likeNum = '1';
		} else {
			likeNum = '0';
		}
		var id = $("#webId").val();
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}tree/toLike?id=' + id + "&isLike=" + likeNum,
			success : function(result) {
				location.href = "${base}tree/getAllUri";
			}
		});

	}
	function goOver(id, url, mode, text, top, like) {
		if (url == null || url == '') {
			return;
		}
		var X = $("#" + id).offset().top;
		var Y = $("#" + id).offset().left;
		var yw = $("#" + id).height();
		$("#url-operation-window").hide();
		$("#url-preview").css("display", "block");
		$("#url-preview").css("left", Y);
		$("#url-preview").css("top", X + yw + 12);
		$("#url-preview").css("position", "absolute");
		$(".url-hide").hide();
		$("#url-address").text(url);
		$("#toUpdate").show();
		$("#subAddUrl").hide();
		$("#websiteName").val(text);
		$("#websiteAddress").val(url);
		$("#webId").val(id);
		$("#subAddUrl").val("修改");
		$("#subAddUrl").hide();
		$("#deleteButton").show();
		if (top == '0') {
			$("#toLike").show();
			$("#toTop").val("置顶");
		} else {
			$("#toLike").hide();
			$("#toTop").val("不置顶");
			$("#" + id).removeClass("url-top");
		}
		if (like == '0') {
			$("#toLike").val("收藏");
			$("#toTop").show();
		} else {
			$("#toTop").hide();
			$("#toLike").val("不收藏");
			$("#" + id).removeClass("url-like");
		}
		

		$("#" + id).addClass("url-select");
	}

	function goOut(id, top, like) {
		if (top == '1') {
			$("#" + id).addClass("url-top");
		}
		if (like == '1') {
			$("#" + id).addClass("url-like");
		}
		$("#" + id).removeClass("url-select");
	}

	function openAddUrl() {
		$("#url-operation-window").removeClass("url-window-toolbar ");
		$(".url-hide").show();
		$("#toTop").hide();
		$("#toUpdate").hide();
		$("#toLike").hide();
		$("#deleteButton").hide();
		$("#websiteName").val(null);
		$("#websiteAddress").val(null);
		$("#webId").val(null);
		$("#subAddUrl").val("新增");
		$("#subAddUrl").show();
		setDivCenter("#url-operation-window");
		$("#websiteAddress").focus();

	}
	function openUpdateWid() {
		$(".url-hide").show();
		$("#toUpdate").hide();
		$("#subAddUrl").val("修改");
		$("#subAddUrl").show();
		$("#url-operation-window").removeClass("url-window-toolbar ");
		setDivCenter("#url-operation-window");
	}
	function operationGoOut() {
		$("#url-operation").css("display", "none");
		$("#url-preview").css("display", "none");
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
		var dh=$(divName).height();
		$(divName).css({
			position : 'absolute',
			'top' : top + scrollTop-dh,
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

	function clearForm() {
		setDivCenter("#url-operation-window");
		$("#websiteAddress").val("");
		$("#websiteName").val("");
		$("#toTop").hide();
		$("#toLike").hide();
		$("#deleteButton").hide();
		$("#subAddUrl").val("新增");
		$("#websiteAddress").focus();
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
	/* 	z-index: 9999; */
	padding: 2px;
	font-size: 8;
	/* 	font-weight: 700; */
	color: #e47b7b;
	font-size: 8;
}

#url-operation {
	text-align: center;
	z-index: 9999;
	color: #b1b0b0;
}

.url-add {
	font-size: 18 !important;
	background-color: #f9f9db !important;
	left: 50%;
	bottom: 30px;
	position: absolute;
}

.url-remove-update {
	cursor: pointer;
	font-size: 12;
	margin: 2px;
}

#cut-off-rule {
	height: 2px;
	width: 100%;
	background-color: #d7e0e8;
	margin-top: 20px;
	margin-bottom: 5px;
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
	opacity: 0.8;
}

.url-window-toolbar {
	padding: 0px 0px 3px 0px !important;
	opacity: 0.9;
}

.url-input {
	border: 1px #e0bcbc solid;
	width: 280px;
	height: 25px;
	margin: 3px 5px 2px 5px;
}

.url-input-button {
	width: 50px;
	height: 20px;
	background-color: #80b7e8;
	border-radius: 20px;
	margin: 2px 5px 0px 5px;
	line-height: 22px;
	cursor: pointer;
}

.url-tool-button {
	/* 	width: 25px; */
	/* 	height: 25px; */
	/* 	border-radius: 50%; */
	/* 	line-height: 25px; */
	padding: 1px;
	font-size: 8 !important;
	cursor: pointer;
	font-size: 8 !important;
}

.url-top {
	background-color: #bd9393;
	box-shadow: 1px 1px 20px #bd9393;
}

.url-like {
	background-color: #f7cbc6;
	box-shadow: 1px 1px 20px #f7cbc6;
}

#url-address {
	padding: 2px 2px 2px 5px;
	float: left;
}
</style>

</head>
<body id="bodyShow" class="easyui-layout" style="width: 100%; height: 100%;" onmouseup="operationGoOut()">
	<div region="center" border="true" style="width: 100%; height: 100%;">
		<c:if test="${likeTrees.size()>0 }">
			<div class="go-website hot">
				<div class="url-lable">最喜欢的</div>
				<c:forEach items="${likeTrees}" var="hu" varStatus="ui">
					<div id="${hu.id}" class="url-go <c:if test="${hu.toLike=='1' }">url-like</c:if>" onmouseout="goOut('${hu.id}','${hu.toTop}','${hu.toLike}')" onmouseover="goOver('${hu.id}','${hu.url}','${hu.readMode}','${hu.text}','${hu.toTop}','${hu.toLike}')" onclick="goUrl('${hu.id}','${hu.url}')">${hu.text}</div>
				</c:forEach>
			</div>
			<div class="go-website rule">
				<div id="cut-off-rule"></div>
			</div>
		</c:if>
		<c:if test="${topTrees.size()>0 }">
			<div class="go-website hot">
				<div class="url-lable">置顶的</div>
				<c:forEach items="${topTrees}" var="hu" varStatus="ui">
					<div id="${hu.id}" class="url-go <c:if test="${hu.toTop=='1' }">url-top</c:if>" onmouseout="goOut('${hu.id}','${hu.toTop}','${hu.toLike}')" onmouseover="goOver('${hu.id}','${hu.url}','${hu.readMode}','${hu.text}','${hu.toTop}','${hu.toLike}')" onclick="goUrl('${hu.id}','${hu.url}')">${hu.text}</div>
				</c:forEach>
			</div>
			<div class="go-website rule">
				<div id="cut-off-rule"></div>
			</div>
		</c:if>
		<c:if test="${hotTrees.size()>0 }">
			<div class="go-website hot">
				<div class="url-lable">经常访问的</div>
				<c:forEach items="${hotTrees}" var="hu" varStatus="ui">
					<div id="${hu.id}" class="url-go <c:if test="${hu.toLike=='1' }">url-like</c:if>" onmouseout="goOut('${hu.id}','${hu.toTop}','${hu.toLike}')" onmouseover="goOver('${hu.id}','${hu.url}','${hu.readMode}','${hu.text}','${hu.toTop}','${hu.toLike}')" onclick="goUrl('${hu.id}','${hu.url}')">${hu.text}</div>
				</c:forEach>
			</div>
			<div class="go-website rule">
				<div id="cut-off-rule"></div>
			</div>
		</c:if>
		<div class="go-website else">
			<c:if test="${urls.size()>0 }">
				<c:if test="${hotTrees.size()>0 or topTrees.size()>0  or likeTrees.size()>0  }">
					<div class="url-lable">其他的</div>
				</c:if>
				<c:forEach items="${urls}" var="u" varStatus="ui">
					<div id="${u.id}" class="url-go" onmouseout="goOut('${u.id}','${u.toTop}','${u.toLike}')" onmouseover="goOver('${u.id}','${u.url}','${u.readMode}','${u.text}','${u.toTop}','${u.toLike}')" onclick="goUrl('${u.id}','${u.url}')">${u.text}</div>
				</c:forEach>
				<div id="url-go-add" title="新增网站收藏" class="url-go url-add" onclick="openAddUrl()">+</div>
				<input type="hidden" id="maxClickCount" value="${urls.get(0).clickCount}">
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
	<div id="url-preview">
		<div style="float: left;">
			<input class="url-tool-button" type="button" id="toTop" onclick="toTopClick($(this).val())" value="置顶" /> <input class="url-tool-button" type="button" id="toLike" onclick="toLikeClick($(this).val())" value="收藏" /> <input class="url-tool-button" type="button" id="toUpdate" onclick="openUpdateWid()" value="修改" /> <input class="url-tool-button" id="deleteButton" type="button"
				onclick="urlDelete($('#webId').val())" value="删除" />
		</div>
		<div id="url-address"></div>
	</div>

	<div id="url-operation" onmouseout="operationGoOut()"></div>
	<div id="url-operation-window" class="url-window">
		<div>
			<form action="" method="post" id="url-add-update">
				<input type="hidden" name="id" id="webId">
				<table>
					<tr class="url-hide">
						<td><span class="url-span">网站地址:</span></td>
						<td><input class="url-input" type="text" id="websiteAddress" name="url" /></td>
					</tr>
					<tr class="url-hide">
						<td><span class="url-span">网站名称:</span></td>
						<td><input class="url-input" type="text" id="websiteName" name="text" /></td>
					</tr>
					<tr align="center">
						<td colspan="2"><input class="url-input-button" type="button" id="subAddUrl" onclick="addOrUpdate()" value="新增" /> <input class="url-input-button url-hide" type="button" id="toClean" onclick="clearForm()" value="清空" /> <input class="url-input-button url-hide" type="button" id="closeButton" onclick="$('#url-operation-window').hide(200)" value="关闭" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>