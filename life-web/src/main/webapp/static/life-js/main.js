$(function() {
	$('#code').textbox().next('span').find('input').focus()
	$('#inputCode').keydown(function(e) {
		if (e.keyCode == 13) {
			var v = $('#code').val();
			self.location.href = basePath + "house?userCode="+v;
		}
	});
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
function welcomeTo(m) {
	var t = m.waitTime;
	var d = [];
	for (i = 0; i < m.userMotto.length; i++) {
		if (i == 0) {
			d.push('<br />')
			d.push('&nbsp;&nbsp;&nbsp;&nbsp;')
		}
		if (m.userMotto.charAt(i - 1) == '.' || m.userMotto.charAt(i - 1) == '?' || m.userMotto.charAt(i - 1) == '!') {
			d.push('<br />')
			d.push('<br />')
			d.push('&nbsp;&nbsp;&nbsp;&nbsp;')
		}
		d.push(m.userMotto.charAt(i))
	}
	var arr = new Array();
	var size = 18;
	for (j = 0; j < d.length; j++) {
		arr.push(d[j]);
		setTimeout("enterCode('" + arr.join("") + "'," + size + ")", t);
		t += m.intervalTime;
	}
}
function enterCode(code, size) {

	$('#times').css('font-size', size);
	$('#times').html("<b>" + code + "</b>");
	$("div").scrollTop($('#times').outerHeight());
}
function playMp3(songName) {
	// console.log(songName);
	var url = basePath + "static/music/" + songName;
	// $('#audio').attr('src', url);
	$('#audios').append('<audio id="audio" style="height: 18px;margin-top: 5px;padding-top: 8px" src="' + url + '">'+songName+'</audio>');
	var myAuto = document.getElementById('audio');
	myAuto.controls = true;
	myAuto.play();
}

function intoWorld() {
	var v = $('#code').val();
	self.location.href = basePath + "house?userCode="+v;

}

function exitHouse() {
	window.location.href =  basePath + "delUser";
}

function cornfield() {
	var url = basePath + "static/video/Cornfield Chase.mp4"
	var x = document.createElement("VIDEO");
	x.setAttribute("width", "100%");
	x.setAttribute("height", "100%");
	x.setAttribute("controls", "controls");
	x.setAttribute("src", url);
	x.play();
	$('#cornfield').append(x);
	$('#xjcy').hide();
//	var myAuto = document.getElementById('chase');
//	myAuto.play();
}