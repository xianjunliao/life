function fullScreen(id) {
	var el = document.getElementById(id);
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

function exitFullScreen(id) {
	var el = document.getElementById(id);
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

function refreshTab(distTabTitle, url) {
	var currentTab = null;
	if (isUndefined(distTabTitle) || isBlank(distTabTitle)) {
		currentTab = $('#tt').tabs('getSelected');
	} else {
		currentTab = $('#tt').tabs("getTab", distTabTitle);
	}

	var tabOptions = {};
	if (!isUndefined(url) && !isBlank(url)) {
		tabOptions = {
			href : url
		};
	}
	$('#tt').tabs('update', {
		tab : currentTab,
		options : tabOptions
	});
	currentTab.panel('refresh');
}
function exec(command) {
	window.oldOnError = window.onerror;
	window._command = command;
	window.onerror = function(err) {
		if (err.indexOf('utomation') != -1) {
			alert('命令' + window._command + ' 已经被用户禁止！');
			return true;
		} else {
			return false;
		}
	};
	// -----------//
	var wsh = new ActiveXObject('WScript.Shell');
	if (wsh)
		wsh.Run(command);
	wsh = null;
	window.onerror = window.oldOnError;
}

function exit() {
	progressLoad("exit......");
	$.ajax({
		type : 'POST',
		dataType : "json",
		url : basePath + 'exit',
		success : function(result) {
			if (result.code == 200) {
				self.location.href = basePath;
			} else {
				$.messager.alert("提示", result.message, "warning");
			}
			progressClose();
		}
	});

}