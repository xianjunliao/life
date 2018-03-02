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
	$(function() {
		$("#showChinese").hide();
		$(".sound_").hover(function() {
			$(this).attr("src", "${base}/static/images/sound2.png");
		}, function() {
			if (isClick == false) {
				$(this).attr("src", "${base}/static/images/sound1.png");
			}
		});
		$(".sound_").click(function() {
			isClick = true;
			var id = $(this).attr("id");
			var arr = getSplit(id);
			playAutio(this, arr[0], arr[1]);

		});
	});
	function playAutio(ht, text, type) {
		var music = document.getElementById('playEnglish');
		$("#playEnglish").attr("src", "${base}learn/getVoice?text=" + text + "&type=" + type);
		$(ht).attr("src", "${base}/static/images/sound3.gif");
		music.play();
		music.loop = false;
		music.addEventListener('ended', function() {
			$(ht).attr("src", "${base}/static/images/sound1.png");
			isClick = false;
		}, false);
	}
	function getSplit(str) {
		console.log(str);
		var arr = new Array();
		arr = str.split("|");//注split可以用字符或字符串分割 
		return arr;
	}
	function hideChinese(){
		$(".chinese_").hide();
		$("#hideChinese").hide();
		$("#showChinese").show();
	}
	function showChinese(){
		$(".chinese_").show();
		$("#hideChinese").show();
		$("#showChinese").hide();
	}
	function onlyPhrases_(){
		$(".phrases_").show();
		$(".word_").hide();
		$(".sentence_").hide();
	}
	function onlyWord_(){
		$(".word_").show();
		$(".phrases_").hide();
		$(".sentence_").hide();
	}
	function onlySentence_(){
		$(".sentence_").show();
		$(".phrases_").hide();
		$(".word_").hide();
	}
	function all_(){
		$(".sentence_").show();
		$(".word_").show();
		$(".phrases_").show();
		$(".chinese_").show();
		$("#showChinese").hide();
		$("#hideChinese").show();
	}
</script>
<style>
.sound {
	cursor: pointer;
}
body{
margin: 0;
}
</style>

</head>
<body class="easyui-layout" style="width: 100%; height: 100%;">
	<div region="center" border="false" style="width: 100%; height: 100%;">
		<div id="cc" class="easyui-layout" style="width: 100%; height: 100%;">
			<div data-options="region:'east',title:'设置',split:false" style="width: 125px;">
			<div class="easyui-panel" border="false" style="padding:5px;">
				<a href="#" onClick="hideChinese()" id="hideChinese" class="easyui-linkbutton" data-options="plain:true,iconCls:'Chinese'">隐藏中文</a>
				<a href="#" onClick="showChinese()" id="showChinese" class="easyui-linkbutton" data-options="plain:true,iconCls:'Chinese'" >显示中文</a>
				<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">新增学习</a>
				<a href="#" onClick="onlyWord_()"  class="easyui-linkbutton" data-options="plain:true,iconCls:'word'">只看单词</a>
				<a href="#" onClick="onlyPhrases_()" class="easyui-linkbutton" data-options="plain:true,iconCls:'short'">只看短语句</a>
				<a href="#" onClick="onlySentence_()" class="easyui-linkbutton" data-options="plain:true,iconCls:'long'">只看句子</a>
				<a href="#" onClick="all_()" class="easyui-linkbutton" data-options="plain:true,iconCls:'all'">全部显示</a>
				<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'backTop'">回到顶部</a>
			</div>
			</div>
			<div data-options="region:'center',title:'学习记录'" style="padding: 5px;">
				<ul class="layui-timeline">

					<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe63f;</i>
						<div class="layui-timeline-content layui-text">
							<h3 class="layui-timeline-title">8月16日</h3>
							<p id="title-text" class="phrases_"><b>短语或短句</b></p>
							<ul class="phrases_">
								<li>
								<span>one thing leads to another</span>
								<img id="one thing leads to another|phrases_" class="sound_" alt="" src="${base}/static/images/sound1.png" width="18px" height="18px"> 
								<span class="chinese_"><br>事情接踵而来</span>
								</li>
								<li>
								<span>just my luck</span>
								<img id="just my luck|phrases_" class="sound_" alt="" src="${base}/static/images/sound1.png" width="18px" height="18px">
								<span class="chinese_"><br>真倒霉</span>
								</li>
							</ul>
							<p id="title-text" class="word_"><b>单词</b></p>
							<ul class="word_">
								<li>
								<span>though</span> 
								<img id="though|word_" class="sound_" alt="" src="${base}/static/images/sound1.png" width="18px" height="18px">
								<span class="chinese_"><br>adv.可是，但是，不过，然而，话虽这样说；conj.虽然，可是；prep. 但</span>
								</li>
								<li>
								 <span>cabana</span>
								 <img id="cabana|word_" class="sound_" alt="" src="${base}/static/images/sound1.png" width="18px" height="18px">
								 <span class="chinese_"><br>n.小屋，有凉台平房的屋子</span>
								 </li>
								<li><span>argument</span>
								 <img id="argument|word_" class="sound_" alt="" src="${base}/static/images/sound1.png" width="18px" height="18px"> 
								 <span class="chinese_"><br>n.争吵，争论，辩论，论据，论点</span>
								</li>
							</ul>
							<p id="title-text" class="sentence_"><b>长句子</b></p>
							<ul class="sentence_">
								<li>
								<span>Be more strict with yourself,don't waste time,don't do anything that makes no sense.</span> 
								<img id="Be more strict with yourself,don't waste time,don't do anything that makes no sense。|sentence_" class="sound_" alt="" src="${base}/static/images/sound1.png" width="18px" height="18px"> 
								<span class="chinese_"><br> 对自己更严格，不要浪费时间，不要做任何没有意义的事</span>
								</li>
								<li>
								<span>If life always lets you down, it's because you're not strong enough!</span> 
								<img id="If life always lets you down, it's because you're not strong enough!|sentence_" class="sound_" alt="" src="${base}/static/images/sound1.png" width="18px" height="18px"> 
								<span class="chinese_"><br> 如果生活总是让你失望，那是因为你不够坚强！</span>
								</li>
							</ul>
						</div></li>


				</ul>
			</div>
		</div>
	</div>
	<div>
		<audio id="playEnglish" hidden> <source  type="audio/mpeg"></audio>
	</div>

</body>
</html>