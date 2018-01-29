var flag = false;
var info = 'Do not go gentle into that good night,Old age should burn and rave at close of day,Rage rage against the dying of the light.Though wise men at their end know dark is right,Because their words had forked no lightning they,Do not go gentle into that good night.Good men,the last wave by, crying how bright,Their frail deeds might have danced in a green bay,Rage rage against the dying of the light.Wild men who caught and sang the sun in flight,And learn,too late,they grieved it on its way,Do not go gentle into that good night.Grave men, near death,who see with blinding sight,Blind eyes could blaze like meteors and be gay,Rage, rage against the dying of the light.And you, my,father,there on the sad height,Curse,bless me now with your fierce tears,I pray,Do not go gentle into that good night.Rage rage against the dying of the light.';
$(function() {
	$('#code').textbox().next('span').find('input').focus()
	$('#inputCode').keydown(function(e) {
		if (e.keyCode == 13) {
			var v = $('#code').val();
			if (v == null || '' == v || v == undefined) {
				$.messager.alert("提示 ", "请输入你的编码！", "warning");
			} else {
				enter(v);
			}
		}
	});
	$('#stop').hide();
	var nextAudio = document.getElementById('nextAudio');
	var test = document.getElementById('test');
	var play = document.getElementById('play');
	var stop = document.getElementById('stop');
	var play_info = document.getElementById('play_info');
	var sixPoints = document.getElementById('sixPoints');
	var myAuto = document.getElementById('audio');
	var myAuto2 = document.getElementById('audio2');
	var addCode = document.getElementById('addCode');
	welcomeTo(1000, info, 80);
	myAuto.onended = function() {
		myAuto2.currentTime = 0;
		myAuto2.play();
		flag = true;
		$('#infoPlaying').html("正在播放中");
		$('#songName').html("Cornfield Chase");
	}
	myAuto2.onended = function() {
		myAuto.currentTime = 0;
		myAuto.play();
		$('#infoPlaying').html("正在播放中");
		$('#songName').html("Do Not Go Gentle Into That Good Night");
		flag = false;
	}
	nextAudio.onclick = function() {

		$('#play').hide();
		$('#stop').show();
		if (flag) {
			myAuto2.pause();
			myAuto.play();
			myAuto.currentTime = 0;
			$('#songName').html("Do Not Go Gentle Into That Good Night");
			flag = false;
		} else {
			myAuto.pause();
			myAuto2.currentTime = 0;
			myAuto2.play();
			$('#songName').html("Cornfield Chase");
			flag = true;
		}
		$('#infoPlaying').html("正在播放中");
	}
	play.onclick = function() {
		$('#play').hide();
		$('#stop').show();
		if (flag) {
			myAuto2.play();
		} else {
			myAuto.play();
		}
		$('#infoPlaying').html("正在播放中");
		$('#sixPoints').html("......");
	}
	stop.onclick = function() {
		$('#play').show();
		$('#stop').hide();
		if (flag) {
			myAuto2.pause();
		} else {
			myAuto.pause();
		}
		$('#infoPlaying').html("播放已停止");
		$('#sixPoints').html(".");
	}
	test.onclick = function() {
		window.open(basePath + "login");
	}
	addCode.onclick = function() {
		var v = $('#code').val();
		if (v == null || '' == v || v == undefined) {
			$.messager.alert("提示 ", "请输入你需要创建的编码！", "info");
		} else {
			addUserCode(v)
		}
	}
});

function showMsg(msg) {

	$.messager.show({
		msg : msg,
		showType : 'show',
		style : {
			width : 150,
			height : 35,
			left : '',
			right : 0,
			top : '',
			bottom : -document.body.scrollTop - document.documentElement.scrollTop
		}
	});
}
function welcomeTo(waitTime, userMotto, intervalTime) {

	var t = waitTime;
	var d = [];
	var timer = setTimeout("enterCode('',18)", t);
	for (i = 0; i < userMotto.length; i++) {
		if (i == 0) {
			d.push('<br />')
			d.push('&nbsp;&nbsp;&nbsp;&nbsp;')
		}
		if (userMotto.charAt(i - 1) == '.' || userMotto.charAt(i - 1) == '?' || userMotto.charAt(i - 1) == '!') {
			d.push('<br />')
			d.push('<br />')
			d.push('&nbsp;&nbsp;&nbsp;&nbsp;')
		}
		d.push(userMotto.charAt(i));
	}
	var arr = new Array();
	var size = 18;
	for (j = 0; j < d.length; j++) {

		arr.push(d[j]);
		setTimeout("enterCode('" + arr.join("") + "'," + size + ")", t);
		t += intervalTime;

	}
}
function enterCode(code, size) {
	$('#info').css('font-size', size);
	$('#info').html(code);
	$("div").scrollTop($('#text').outerHeight());
}

function intoWorld() {
	var v = $('#code').val();
	if (v == null || '' == v || v == undefined) {
		$.messager.alert("提示", "请输入你的编码！", "warning");
	} else {
		enter(v);
	}
}

function enter(v) {
	progressLoad("login......");
	$.ajax({
		type : 'POST',
		dataType : "json",
		url : basePath + 'enter?code=' + v,
		success : function(result) {
			if (result.code == 200) {
				self.location.href = basePath + "house";
			} else {
				$.messager.alert("提示", result.message, "warning");
			}
			progressClose();
		}
	});

}

function addUserCode(v) {
	progressLoad("login......");
	$.ajax({
		type : 'POST',
		dataType : "json",
		url : basePath + 'add?code=' + v,
		success : function(result) {
			if (result.code == 200) {
				$.messager.alert("提示", result.message, "info");
			} else {
				$.messager.alert("提示", result.message, "warning");
			}
			progressClose();
		}
	});

}

function exitHouse() {
	exit();
}
