$(function() {
	$('#code').textbox().next('span').find('input').focus()
	$('#inputCode').keydown(function(e) {
		if (e.keyCode == 13) {
			var v = $('#code').val();
			self.location.href = basePath + "house?userCode="+v;
		}
	});
	var myAuto = document.getElementById('audio');
	myAuto.play();
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
function welcomeTo(waitTime,userMotto,intervalTime) {
	var t = waitTime;
	var d = [];
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
	self.location.href = basePath + "house?userCode="+v;

}

function exitHouse() {
	window.location.href =  basePath + "delUser";
}
