$(function() {
	$('#code').textbox().next('span').find('input').focus()
	$('#inputCode').keydown(function(e) {
		if (e.keyCode == 13) {
			var v = $('#code').val();
			$.ajax({
				type : "POST",
				url : basePath + "enterCode",
				data : {
					code : v
				},
				datatype : "json",
				success : function(data) {
					if (data != null && data != "") {
						$("#code").textbox('setValue','Your code:'+v);
						$('#code').textbox('textbox').attr('readonly',true); 
						$('#code').textbox().next('span').width(100);
						result = $.parseJSON(data);
						playMp3(result.userMusic);
						welcomeTo(result);
					} else {
						showMsg("Your code is wrong !");
						$('#code').textbox().next('span').find('input').select();
					}
				}
			});
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
	self.location.href = basePath + "house";

}

function exitHouse() {
	window.location.href =  basePath + "delUser";
}