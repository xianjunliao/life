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
	var isClick = false;
	var istimeline = false;
	$(function() {
		$(".hide-ico").hide();
	});
	function overHere(id) {
		$("#" + id).attr("class", "icon-sound-hover");
		$("#" + id).attr("src", "${base}/static/images/voice3.png");
	}
	function leftHere(id) {
		if (isClick == false) {
			$("#" + id).attr("class", "icon-sound");
			$("#" + id).attr("src", "${base}/static/images/voice1.png");
		}
	}
	function playAutio(id) {
		isClick = true;
		var music = document.getElementById('playEnglish');
		$("#playEnglish").attr("src", "${base}learn/getVoice?id=" + id);
		$("#" + id).attr("class", "icon-sound-click");
		$("#" + id).attr("src", "${base}/static/images/sound3.gif");
		music.play();
		music.loop = false;
		music.addEventListener('ended', function() {
			$("#" + id).attr("class", "icon-sound");
			$("#" + id).attr("src", "${base}/static/images/voice1.png");
			isClick = false;
		}, false);
	}

	function playAutioShanBei(id, url) {
		isClick = true;
		var music = document.getElementById('playEnglish');
		$("#playEnglish").attr("src", url);
		$("#" + id).attr("class", "icon-sound-click");
		$("#" + id).attr("src", "${base}/static/images/sound3.gif");
		music.play();
		music.loop = false;
		music.addEventListener('ended', function() {
			$("#" + id).attr("class", "icon-sound");
			$("#" + id).attr("src", "${base}/static/images/voice1.png");
			isClick = false;
		}, false);
	}
	function timeDo(t) {
		var aa = $(".time-" + t + "-hide").css("display");
		if (aa == "none") {
			$(".time-" + t + "-hide").show();
			$(".time-" + t + "-show").hide();
			$(".time-" + t + "-learn-time").hide(500);
		} else {
			$(".time-" + t + "-hide").hide();
			$(".time-" + t + "-show").show();
			$(".time-" + t + "-learn-time").show(500);
		}
	}
	function openWordTypeDog(text, id, learnid) {
		$('.addEnglish').dialog('close');
		$('.addfocus').next('span').find('input').focus();
		$('.addWordssss').textbox('readonly', false);
		$('#' + id + 'word').textbox('setValue', text);
		if (text != null) {
			$('#wordword').textbox('readonly', true);
		}
		$('.timeClassId').val(learnid);
		$('#add' + id).dialog('open');

	}
	function submitForm() {
		$('#ff').form('submit', {
			type : "POST",
			dataType : "json",
			url : '${base}learn/addLearn',
			onSubmit : function() {
				progressLoad();
				var isValid = $(this).form('enableValidation').form('validate');
				if (!isValid) {
					progressClose();
				}
				return isValid;
			},
			success : function(data) {
				progressClose();
			}
		});
	}

	function chineseOverHere(id) {
		$("#" + id).show();
		$("#" + id + "update").show();
	}
	function chineseLeftHere(id) {
		$("#" + id).hide();
		$("#" + id + "update").hide();
	}
	function englishOverHere(id) {
		$("#" + id + "icon").show();
		$("#" + id + "iconUpdate").show();
	}
	function englishLeftHere(id) {
		$("#" + id + "icon").hide();
		$("#" + id + "iconUpdate").hide();
	}
	function deleteItv(id) {
		$.messager.confirm('提示', '确定删除吗?', function(r) {
			if (r) {
				$.ajax({
					type : 'POST',
					dataType : "json",
					url : '${base}learn/deleteItv?id=' + id,
					success : function(result) {
						if (result.code == 200) {
							location.reload();
						} else {
							$.messager.alert("提示", "删除失败！", "warning");
						}
					}
				});
			}
		});
	}
	function deletelvv(lid, wid) {
		$.messager.confirm('提示', '确定删除吗?', function(r) {
			if (r) {
				$.ajax({
					type : 'POST',
					dataType : "json",
					url : '${base}learn/deletelvv?lid=' + lid + '&wid=' + wid,
					success : function(result) {
						if (result.code == 200) {
							location.reload();
						} else {
							$.messager.alert("提示", "删除失败！", "warning");
						}
					}
				});
			}
		});

	}
	function updateWord(id, text, type) {
		$.messager.prompt('修改' + type, text, function(r) {
			if (r) {
				$.ajax({
					type : 'POST',
					dataType : "json",
					url : '${base}learn/updateWord?id=' + id + '&text=' + r,
					success : function(result) {
						if (result.code == 200) {
							location.reload();
						} else {
							$.messager.alert("提示", "修改失败！", "warning");
						}
					}
				});
			}
		});
	}
	function updateItv(id, text) {
		$.messager.prompt('修改释义', text, function(r) {
			if (r) {
				$.ajax({
					type : 'POST',
					dataType : "json",
					url : '${base}learn/updateItv?id=' + id + '&text=' + r,
					success : function(result) {
						if (result.code == 200) {
							location.reload();
						} else {
							$.messager.alert("提示", "修改失败！", "warning");
						}
					}
				});
			}
		});
	}
	
	function onlyShowToday(number){
		window.location.href = "${base}learn/showNow?number="+number;
	}
	
	function clearForm() {
		$('#ff').form('clear');
	}
</script>
<style>
.sound {
	cursor: pointer;
}

body {
	margin: 0;
}

.icon-sound {
	height: 17px;
	width: 19px;
	background-color: #cbf5cb;
}

.icon-sound-hover {
	height: 17px;
	width: 19px;
	background-color: #cbf5cb;
}

.icon-sound-click {
	width: 22px;
	height: 21px;
	background-color: #cbf5cb;
}

.fixed_div {
	position: absolute;
	z-index: 2008;
	bottom: 20px;
	width: 450px;
	height:50px;
	top: 2px;
	left: 50%;
	transform: translateX(-50%);
	border-radius: 15%;
}
</style>

</head>
<body class="easyui-layout" style="width: 100%; height: 100%;">
	<div region="center" border="false" style="width: 100%; height: 100%;">
		<div id="cc" class="easyui-layout" style="width: 100%; height: 100%;">
			<div data-options="region:'center'" style="padding: 5px;">
				<c:forEach items="${timeClass}" var="learn">
					<ul class="layui-timeline time-${learn.key.id}">
						<li class="layui-timeline-item"><i onclick="timeDo('${learn.key.id}')" title="展开" class="layui-icon layui-timeline-axis hide-ico time-${learn.key.id}-hide">&#xe63f;</i> <i title="隐藏" onclick="timeDo('${learn.key.id}')" class="layui-icon layui-timeline-axis show-ico time-${learn.key.id}-show">&#xe643;</i>
							<div class="layui-timeline-content layui-text">
								<h3 class="layui-timeline-title" onclick="timeDo('${learn.key.id}')">${learn.key.headline}</h3>
								<c:forEach items="${learns}" var="len">
									<c:if test="${len.key.id==learn.key.id }">
										<c:forEach items="${len.value}" var="lv">
											<p id="title-text" class="${lv.key.itemNo} time-${learn.key.id}-learn-time">
												<c:forEach items="${wordTypes }" var="wt">
													<b> <c:if test="${lv.key.itemNo==wt.itemNo }">
														 ${wt.itemName} &nbsp;&nbsp;<i onclick="openWordTypeDog(null,'${wt.itemNo}','${learn.key.id }')" class="layui-icon" style="font-size: 14px; color: #1E9FFF; cursor: pointer;">&#xe654;</i>
														</c:if>
													</b>
												</c:forEach>
											</p>
											<ul class="${lv.key.itemNo} time-${learn.key.id}-learn-time">
												<c:forEach items="${lv.value}" var="lvv">
													<li style="width: 100%; list-style-type: none;">
														<div onmouseover="englishOverHere('${lvv.id}')" onmouseout="englishLeftHere('${lvv.id}')" style="background-color: #cbf5cb; cursor: pointer; height: 23px;">
															<a style="line-height: 23px;" onmouseover="englishOverHere('${lvv.id}')" onmouseout="englishLeftHere('${lvv.id}')"> 
															<span title="${lvv.definition}" style="line-height: 23px;">${lvv.word}</span> &nbsp;&nbsp; 
															<c:if test="${lvv.usPronunciation!=null}"><span>美：${lvv.usPronunciation}</span>&nbsp;</c:if>
															<img id="${lvv.id}" onclick="playAutio('${lvv.id}')" onmouseover="overHere('${lvv.id}')" onmouseout="leftHere('${lvv.id}')" class="icon-sound" border="0" src="${base}/static/images/voice1.png" width="19" height="17" /> &nbsp; 
															<c:if test="${lvv.ukPronunciation!=null}"><span>英：${lvv.ukPronunciation}</span>&nbsp;
															<img id="sb${lvv.id}" onclick="playAutioShanBei('sb${lvv.id}','${lvv.ukAudio}')" onmouseover="overHere('sb${lvv.id}')" onmouseout="leftHere('sb${lvv.id}')" class="icon-sound" border="0" src="${base}/static/images/voice1.png" width="19" height="17" />&nbsp; 
															</c:if>
															<i id="${lvv.id}icon" title="删除" onclick="deletelvv('${learn.key.id }','${lvv.id}')" class="layui-icon" style="font-size: 14px; color: #f2711c; cursor: pointer; display: none; float: right;">&#xe640;</i> <c:if test="${lifeUserModel.userrole=='1'}">
															<i id="${lvv.id}iconUpdate" title="修改" onclick="updateWord('${lvv.id }','${lvv.word}','${lv.key.itemName}')" class="layui-icon" style="font-size: 14px; color: #f2711c; cursor: pointer; display: none; float: right;">&#xe639;</i>
																</c:if>
															</a>
														</div> 
														<c:forEach items="${interpretayion }" var="it">
															<c:if test="${it.key==lvv.id}">
																<c:forEach items="${it.value}" var="itv">
																	<c:if test="${itv.wordinterpretation!=null }">
																		<div style="background-color: #e3f9e3; cursor: pointer;" onmouseover="chineseOverHere('${itv.id}')" onmouseout="chineseLeftHere('${itv.id}')">
																			<a onmouseover="chineseOverHere('${itv.id}')" onmouseout="chineseLeftHere('${itv.id}')"><span class="chinese_"> <c:if test="${lvv.type=='word'}">${itv.wordtype}</c:if>${itv.wordinterpretation}</span> <i id="${itv.id}" onclick="deleteItv('${itv.id}')" title="删除" class="layui-icon" style="font-size: 14px; color: #f2711c; cursor: pointer; display: none; float: right;">&#xe640;</i>
																				<c:if test="${lifeUserModel.userrole=='1' }">
																					<i id="${itv.id}update" title="修改" onclick="updateItv('${itv.id}','${itv.wordinterpretation}')" class="layui-icon" style="font-size: 14px; color: #f2711c; cursor: pointer; display: none; float: right;">&#xe639;</i>
																				</c:if> <br> </a>
																		</div>
																	</c:if>
																</c:forEach>
																<c:if test="${lvv.type!='article'}">
																	<div style="background-color: #f9fbf9; cursor: pointer;" align="center">
																		<i onclick="openWordTypeDog('${lvv.word}','${lvv.type}','${learn.key.id }')" class="layui-icon" style="font-size: 8px; color: red; cursor: pointer; left: 50%;">&#xe654;</i> <br>
																	</div>
																</c:if>
															</c:if>
														</c:forEach>
													</li>
												</c:forEach>
											</ul>
										</c:forEach>
									</c:if>
								</c:forEach>
								<c:if test="${learn.value==0}">
									<c:forEach items="${wordTypes }" var="wt">
										<p id="title-text" class="${wt.itemNo} time-${learn.key.id}-learn-time">
											<b> ${wt.itemName} &nbsp;&nbsp;<i onclick="openWordTypeDog(null,'${wt.itemNo}','${learn.key.id }')" class="layui-icon" style="font-size: 14px; color: #1E9FFF; cursor: pointer;">&#xe654;</i></b>
										</p>
									</c:forEach>
								</c:if>
							</div></li>
					</ul>
				</c:forEach>
				<ul class="layui-timeline time-29991231">
					<li class="layui-timeline-item"><i onclick="timeDo('29991231')" class="layui-icon layui-timeline-axis hide-ico time-29991231-hide">&#xe63f;</i> <i onclick="timeDo('29991231')" class="layui-icon layui-timeline-axis show-ico time-29991231-show">&#xe643;</i></li>
				</ul>
			</div>
		</div>
	</div>
	<div>
		<audio id="playEnglish" hidden> <source type="audio/mpeg"></audio>
	</div>
	<c:forEach items="${wordTypes }" var="wt">
		<div id="add${wt.itemNo}" class="easyui-dialog addEnglish" title="新增${wt.itemName }或${wt.itemName }的释义" style="width: 475px; height: auto; padding: 10px;" data-options="closed:true">
			<div style="padding: 10px 60px 20px 60px">
				<form id="ff${wt.itemNo}" method="post" style="width: 360px;">
					<input type="hidden" name="wordType" value="${wt.itemNo}" /> <input type="hidden" class="timeClassId" name="timeClass" />
					<table style="width: 340px; height: 165px;">
						<tr>
							<td>${wt.itemName}:</td>
							<c:if test="${wt.itemNo =='article'}">
								<td><input class="easyui-textbox addfocus" autofocus="autofocus" data-options="multiline:true,required:true" id="${wt.itemNo}word" name="word" style="width: 300px; height: 150px"></td>
							</c:if>
							<c:if test="${wt.itemNo !='article'}">
								<td><input class="easyui-textbox addWordssss addfocus" autofocus="autofocus" type="text" id="${wt.itemNo}word" name="word" data-options="required:true" style="width: 290px; height: 30px;"></input></td>
							</c:if>
						</tr>
						<c:if test="${wt.itemNo=='word'}">
							<tr>
								<td>词性:</td>
								<td><select class="easyui-combobox" name="partOfSpeech" style="width: 290px; height: 30px;" data-options="prompt:'请选择'">
										<c:forEach items="${partOfSpeech }" var="pos">
											<option value="${pos.itemNo }">${pos.itemName }</option>
										</c:forEach>
								</select></td>
							</tr>
						</c:if>
						<c:if test="${wt.itemNo !='article'}">
							<tr>
								<td>释义:</td>
								<td><input class="easyui-textbox" type="text" id="${wt.itemNo}wordInterpretayion" name="wordInterpretayion" data-options="required:true" style="width: 290px; height: 60px;"></input></td>
							</tr>
						</c:if>
						<c:if test="${wt.itemNo =='article'}">
							<tr>
								<td>释义:</td>
								<td><input class="easyui-textbox" autofocus="autofocus" data-options="multiline:true"  id="${wt.itemNo}wordInterpretayion" name="wordInterpretayion" style="width: 300px; height: 150px"></td>
							</tr>
						</c:if>
					</table>
				</form>
				<div style="text-align: center; padding: 5px">
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm('${wt.itemNo}')">新增</a>
					<c:if test="${wt.itemNo =='word'}">
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="translateShanBei('${wt.itemNo}')" >扇贝翻译</a>
					</c:if>
					<c:if test="${wt.itemNo !='word'}">
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="translateBaidu('${wt.itemNo}')">百度翻译</a>
					</c:if>
				</div>
			</div>
		</div>
	</c:forEach>
	<script type="text/javascript">
		function submitForm(id) {
			$('#ff' + id).form('submit', {
				type : "POST",
				dataType : "json",
				url : '${base}learn/addLearn',
				onSubmit : function() {
					progressLoad();
					var isValid = $(this).form('enableValidation').form('validate');
					if (!isValid) {
						progressClose();
					}
					return isValid;
				},
				success : function(data) {
					progressClose();
					location.reload();
				}
			});
		}
		function translateShanBei(id){
			var text=$("#"+id+"word").textbox("getValue");
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : '${base}learn/translate?type=sb&text=' + text,
				success : function(result) {
					if (result.code == 200) {
						$("#"+id+"wordInterpretayion").textbox("setValue",result.data)
					} else {
						$.messager.alert("提示", "获取扇贝翻译失败！", "warning");
					}
				}
			});
			
		}
		function translateBaidu(id){
			var text=$("#"+id+"word").textbox("getValue");
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : '${base}learn/translate?type=bd&text=' + text,
				success : function(result) {
					if (result.code == 200) {
						$("#"+id+"wordInterpretayion").textbox("setValue",result.data)
					} else {
						$.messager.alert("提示", "获取百度翻译失败！", "warning");
					}
				}
			});
			
		}
	</script>
<div class="fixed_div">
<div class="easyui-panel" style="padding:5px;">
<!-- 		<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">新增今日学习</a> -->
<i  class="layui-icon" style="font-size: 16px; color: #1E9FFF; cursor: pointer;">&#xe61f;新增今日学习</i>
<i  onclick="onlyShowToday(1)" class="layui-icon" style="font-size: 16px; color: #1E9FFF; cursor: pointer;">&#xe643;只显示今日</i>
<i  class="layui-icon" style="font-size: 16px; color: #1E9FFF; cursor: pointer;">&#xe621;只显示单词</i>
<i  onclick="onlyShowToday(5)" class="layui-icon" style="font-size: 16px; color: #1E9FFF; cursor: pointer;">&#x1002;刷新</i>
<!-- 		<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-reload'">只显示今日</a> -->
<!-- 		<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'">只显示英文</a> -->
<!-- 		<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-print'">刷新</a> -->
	</div>

</div>
</body>
</html>