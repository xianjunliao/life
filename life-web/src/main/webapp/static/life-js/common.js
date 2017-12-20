function fullScreen(el) {
	var rfs = el.requestFullScreen || el.webkitRequestFullScreen || el.mozRequestFullScreen || el.msRequestFullScreen, wscript;

	if (typeof rfs != "undefined" && rfs) {
		rfs.call(el);
		return;
	}

	if (typeof window.ActiveXObject != "undefined") {
		wscript = new ActiveXObject("WScript.Shell");
		if (wscript) {
			wscript.SendKeys("{F11}");
		}
	}
}

function exitFullScreen(el) {
	var el = document, cfs = el.cancelFullScreen || el.webkitCancelFullScreen || el.mozCancelFullScreen || el.exitFullScreen, wscript;

	if (typeof cfs != "undefined" && cfs) {
		cfs.call(el);
		return;
	}

	if (typeof window.ActiveXObject != "undefined") {
		wscript = new ActiveXObject("WScript.Shell");
		if (wscript != null) {
			wscript.SendKeys("{F11}");
		}
	}
}

function refresh() {
	window.location.reload();
	setTimeout(refresh, 100);
}

function reurl() {
	url = location.href; // 把当前页面的地址赋给变量 url
	var times = url.split("?"); // 分切变量 url 分隔符号为 "?"
	if (times[1] != 1) { // 如果?后的值不等于1表示没有刷新
		url += "?1"; // 把变量 url 的值加入 ?1
		self.location.replace(url); // 刷新页面
	}
}

