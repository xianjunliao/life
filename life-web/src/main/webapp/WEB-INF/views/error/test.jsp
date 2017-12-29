<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<html>
<head>
<title>musicPlayer</title>
<link type="text/css" rel="stylesheet" href="${base}static/songs/song.css">
<style type="text/css">
.page-info {
	padding: 8px 15px;
	background: #fcea9e;
	border-bottom: 1px solid #b6bac0;
	font: normal 16px Georgia;
}

.page-info h1 {
	float: left;
}

.page-info a {
	font-weight: bold;
	color: #222;
}

.return-article {
	float: right;
}

.return-article h2 {
	display: inline;
}

.main {
	padding: 20px;
	height: 1000px;
	color: #444;
}

.wrap {
	float: right;
	padding: 15px;
	background: #FFFFE1;
	border: 1px solid paleGoldenrod;
	border-radius: 4px;
}

.f-list {
	padding: 20px 0;
	line-height: 36px;
	font-size: 14px;
	font-weight: bold;
}

.f-list a {
	margin: 0 5px 0 0;
	padding: 0 10px 0 0;
	background:
		url(http://www.feelcss.com/wp-content/themes/fengchao/images/external_link.png)
		no-repeat scroll right top transparent;
	color: #006600;
	text-decoration: none;
}

.f-list a:hover {
	text-decoration: underline;
}

cite {
	display: block;
}
</style>
</head>
<body>
	<!--播放器开始 { -->
	<div id="musicPlayerWrap" class="m-player-wrap" style="left: 0px;">
		<div id="musicPlayer" class="m-player">
			<div id="musicInfo" class="m-info">
				<img src="${base}static/images/xjcy2.jpg" alt="" id="albumFrontCover" class="album-front-cover">
				<div class="front-cover-mask" title=""></div>
				<div id="infoWrap" class="info-wrap">
					<dl>
						<dt id="musicName" title="汉斯·季默">星际穿越-Cornfield Chase</dt>
						<dd id="musicSinger" title="汉斯·季默">汉斯·季默</dd>
						<dd id="albumName" title="星际穿越-Cornfield Chase">星际穿越-Cornfield Chase</dd>
					</dl>

					<div id="musicFunction" class="m-function clearfix">
						<a href="javascript:void(0);" id="albumLists" class="album-lists album-lists-hover" title="关闭专辑列表"></a> <a href="javascript:void(0);" id="lyrics" class="lyrics lyrics-hover" title="关闭歌词"></a>
						<a href="javascript:void(0);" id="favorites" class="favorites" title="打开收藏夹"></a>
					</div>
				</div>
			</div>
			<div id="broadcastControl" class="broadcast-control clearfix">
				<div class="broadcast-control-l"></div>
				<div class="broadcast-control-m">
					<a href="javascript:void(0);" id="play" class="m-play" title="播放" style="display: block;"></a> <a href="javascript:void(0);" id="pause" class="m-pause hidden" title="暂停" style="display: none;"></a> <a href="javascript:void(0);" id="next" class="m-next" title="下一曲"></a> <a href="javascript:void(0);" id="prev" class="m-prev" title="上一曲"></a>

					<div class="play-progress-rate">
						<span id="playTime" class="play-time">0:00</span>
						<div id="progressRateBg" class="progress-rate-bg">
							<div id="progressRateColor" class="progress-rate-color" style="width: 0;"></div>
						</div>
						<span id="surplusTime" class="surplus-time">-0:00</span>
					</div>

					<a href="javascript:void(0);" id="nowVolume" class="volume volume-active now-volume"></a> <a href="javascript:void(0);" id="nowMute" class="mute mute-active now-volume hidden"></a> <a href="javascript:void(0);" id="nowPlayManner" class="now-manner list-cycle list-cycle-active" title="列表循环"></a>

					<div id="volumeControl" class="volume-wrap hidden">
						<a href="javascript:void(0);" id="volume" class="volume" title="点击设为静音"></a> <a href="javascript:void(0);" id="mute" class="mute hidden" title="点击开启声音"></a>
						<div id="volumeSizeBg" class="volume-size-bg" title="音量调节">
							<div id="volumeSizeColor" class="volume-size-color" data-volume="" data-height="" style="height: 0;"></div>
						</div>
					</div>

					<div id="playMannerControl" class="play-manner-wrap hidden" style="display: none;">
						<a href="javascript:void(0);" id="orderPlay" class="order-play" title="顺序播放"></a> <a href="javascript:void(0);" id="shufflePlay" class="shuffle-play" title="随机播放"></a> <a href="javascript:void(0);" id="singleCycle" class="single-cycle" title="单曲循环"></a> <a href="javascript:void(0);" id="listCycle" class="list-cycle" title="列表循环"></a>
					</div>

				</div>
				<div class="broadcast-control-r"></div>
			</div>
		</div>
		<div id="musicPlayerSwitch" class="m-player-switch off" title="隐藏播放器">
			<a href="javascript:void(0);" id="playerSwitchBtn" class="switch-off"></a>
		</div>

		<div id="lrcWrap" class="lrc-wrap">
			<div id="loadLrc" class="load-lrc hidden" style="display: block;">歌曲载入中...</div>
			<div id="lrcBox" class="lrc-box" style="margin-top: 0px;">
				<p class="lrc-line" data-timeline="0">
					<span class="mr15">星际穿越-Cornfield Chase</span>作者：汉斯·季默
				</p>
<!-- 				<p class="lrc-line" data-timeline="12">我的小时候 吵闹任性时侯</p> -->
<!-- 				<p class="lrc-line" data-timeline="16">我的外婆 总会唱歌哄我</p> -->
<!-- 				<p class="lrc-line" data-timeline="21">夏天的午后 老老的歌安慰我</p> -->
<!-- 				<p class="lrc-line" data-timeline="25">那首歌好像这样唱的</p> -->
<!-- 				<p class="lrc-line" data-timeline="31">天黑黑 欲落雨</p> -->
<!-- 				<p class="lrc-line" data-timeline="38">天黑黑 黑黑</p> -->
<!-- 				<p class="lrc-line" data-timeline="45">离开小时候 有了自己的生活</p> -->
<!-- 				<p class="lrc-line" data-timeline="50">新鲜的歌 新鲜的念头</p> -->
<!-- 				<p class="lrc-line" data-timeline="54">任性和冲动 无法控制的时候</p> -->
<!-- 				<p class="lrc-line" data-timeline="58">我忘记 还有这样的歌</p> -->
<!-- 				<p class="lrc-line" data-timeline="63">天黑黑 欲落雨</p> -->
<!-- 				<p class="lrc-line" data-timeline="70">天黑黑 黑黑</p> -->
<!-- 				<p class="lrc-line" data-timeline="76">我爱上让我奋不顾身的一个人</p> -->
<!-- 				<p class="lrc-line" data-timeline="80">我以为 这就是我所追求的世界</p> -->
<!-- 				<p class="lrc-line" data-timeline="85">然而横冲直撞被误解被骗</p> -->
<!-- 				<p class="lrc-line" data-timeline="89">是否成人的世界背后 总有残缺</p> -->
<!-- 				<p class="lrc-line" data-timeline="93">我走在 每天必须面对的分岔路</p> -->
<!-- 				<p class="lrc-line" data-timeline="98">我怀念 过去单纯美好的小幸福</p> -->
<!-- 				<p class="lrc-line" data-timeline="102">爱总是让人哭 让人觉得不满足</p> -->
<!-- 				<p class="lrc-line" data-timeline="107">天空很大却看不清楚 好孤独</p> -->
<!-- 				<p class="lrc-line" data-timeline="130">我爱上让我奋不顾身的一个人</p> -->
<!-- 				<p class="lrc-line" data-timeline="134">我以为 这就是我所追求的世界</p> -->
<!-- 				<p class="lrc-line" data-timeline="139">然而横冲直撞被误解被骗</p> -->
<!-- 				<p class="lrc-line" data-timeline="143">是否成人的世界背后 总有残缺</p> -->
<!-- 				<p class="lrc-line" data-timeline="147">我走在 每天必须面对的分岔路</p> -->
<!-- 				<p class="lrc-line" data-timeline="152">我怀念 过去单纯美好的小幸福</p> -->
<!-- 				<p class="lrc-line" data-timeline="156">爱总是让人哭 让人觉得不满足</p> -->
<!-- 				<p class="lrc-line" data-timeline="160">天空很大却看不清楚 好孤独</p> -->
<!-- 				<p class="lrc-line" data-timeline="171">天黑的时候 我又想起那首歌</p> -->
<!-- 				<p class="lrc-line" data-timeline="175">突然期待 下起安静的雨</p> -->
<!-- 				<p class="lrc-line" data-timeline="180">原来外婆的道理早就唱给我听</p> -->
<!-- 				<p class="lrc-line" data-timeline="185">下起雨 也要勇敢前进…</p> -->
<!-- 				<p class="lrc-line" data-timeline="190">我相信 一切都会平息</p> -->
<!-- 				<p class="lrc-line" data-timeline="195">我现在 好想回家去</p> -->
<!-- 				<p class="lrc-line" data-timeline="203">天黑黑 欲落雨</p> -->
<!-- 				<p class="lrc-line" data-timeline="210">天黑黑 黑黑</p> -->
			</div>
		</div>
		<audio id="musicEngine" src="static/music/Cornfield Chase.mp3"></audio>
	</div>


	<!--播放器结束 } -->


	<script type="text/javascript" src="${base}static/songs/song.js"></script>
	<div id="musicList" class="music-list" style="left: 0px;">
		<div class="list-title">
			<strong id="listName">专辑列表</strong><span id="cutoverList" class="cutover-list">返回</span>
			<div id="closeList" class="close-list" title="关闭列表"></div>
		</div>
		<ul id="listWrap" class="list-wrap song" data-temp="0">
			<li class="s-l playIng"><span class="s-name" title="天黑黑 (原唱：孙燕姿)">天黑黑 (原唱：孙燕姿)</span><span class="s-album" title="活出生命LIVE演唱会">活出生命LIVE演唱会</span><span class="s-time">03:47</span>
			<div name="addFavorites" class="add-favorites hidden" title="喜欢"></div></li>
			<li class="s-l"><span class="s-name" title="听海 (原唱：张惠妹)">听海 (原唱：张惠妹)</span><span class="s-album" title="活出生命LIVE演唱会">活出生命LIVE演唱会</span><span class="s-time">04:47</span>
			<div name="addFavorites" class="add-favorites hidden" title="喜欢"></div></li>
			<li class="s-l"><span class="s-name" title="情人 (原唱：Beyond)">情人 (原唱：Beyond)</span><span class="s-album" title="活出生命LIVE演唱会">活出生命LIVE演唱会</span><span class="s-time">07:49</span>
			<div name="addFavorites" class="add-favorites hidden" title="喜欢"></div></li>
			<li class="s-l"><span class="s-name" title="爱我别走 (原唱：张震岳)">爱我别走 (原唱：张震岳)</span><span class="s-album" title="活出生命LIVE演唱会">活出生命LIVE演唱会</span><span class="s-time">05:14</span>
			<div name="addFavorites" class="add-favorites hidden" title="喜欢"></div></li>
			<li class="s-l"><span class="s-name" title="梦见铁达尼">梦见铁达尼</span><span class="s-album" title="Glass Cloud">Glass Cloud</span><span class="s-time">04:36</span>
			<div name="addFavorites" class="add-favorites hidden" title="喜欢"></div></li>
			<li class="s-l"><span class="s-name" title="很难">很难</span><span class="s-album" title="Glass Cloud">Glass Cloud</span><span class="s-time">04:18</span>
			<div name="addFavorites" class="add-favorites hidden" title="喜欢"></div></li>
			<li class="s-l"><span class="s-name" title="There You'll Be">There You'll Be</span><span class="s-album" title="Pearl Harbor">Pearl Harbor</span><span class="s-time">03:41</span>
			<div name="addFavorites" class="add-favorites hidden" title="喜欢"></div></li>
			<li class="s-l"><span class="s-name" title="Tennessee">Tennessee</span><span class="s-album" title="Pearl Harbor">Pearl Harbor</span><span class="s-time">03:40</span>
			<div name="addFavorites" class="add-favorites hidden" title="喜欢"></div></li>
			<li class="s-l"><span class="s-name" title="Brothers">Brothers</span><span class="s-album" title="Pearl Harbor">Pearl Harbor</span><span class="s-time">04:04</span>
			<div name="addFavorites" class="add-favorites hidden" title="喜欢"></div></li>
			<li class="s-l"><span class="s-name" title="And Then I Kissed Him">And Then I Kissed Him</span><span class="s-album" title="Pearl Harbor">Pearl Harbor</span><span class="s-time">05:36</span>
			<div name="addFavorites" class="add-favorites hidden" title="喜欢"></div></li>
			<li class="s-l"><span class="s-name" title="Maria">Maria</span><span class="s-album" title="Missy Higgins">Missy Higgins</span><span class="s-time">02:06</span>
			<div name="addFavorites" class="add-favorites hidden" title="喜欢"></div></li>
			<li class="s-l"><span class="s-name" title="Vincent">Vincent</span><span class="s-album" title="Missy Higgins">Missy Higgins</span><span class="s-time">03:07</span>
			<div name="addFavorites" class="add-favorites hidden" title="喜欢"></div></li>
		</ul>
	</div>
</body>
</html>