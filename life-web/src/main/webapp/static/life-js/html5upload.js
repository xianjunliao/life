/**
 * User: zhy Date: 14-6-16 Time: 下午11:06
 */
var ZhangHongyang = {};
var fileList = {};
var file = null;
ZhangHongyang.html5upload = (function() {
	var _ID_UPLOAD_BOX = "first-socre";
	var _CLASS_PROGRESS = "progress";
	var _CLASS_PERCENTAGE = "percentage";

	var _tip_no_drag = "点击选择或拖拽图片文件到此处！";
	var _tip_drag_over = "释放鼠标添加！";

	var _uploadEle = null;

	/**
	 * 初始化对象与事件
	 * 
	 * @private
	 */
	function _init() {
		_uploadEle = document.getElementById(_ID_UPLOAD_BOX);
		_uploadEle.ondragenter = _onDragEnter;
		_uploadEle.ondragover = _onDragOver;
		_uploadEle.ondragleave = _onDragLeave;
		_uploadEle.ondrop = _onDrop;
		_setStatusNoDrag();

	}
	;

	/**
	 * 正在拖拽状态
	 * 
	 * @private
	 */
	function _setDragOverStatus() {
		if (_checkContatinsElements())
			return;
		$(".empty-add").text(_tip_drag_over);
		$("#msg-upload").html("");

	}

	/**
	 * 初始化状态
	 * 
	 * @private
	 */
	function _setStatusNoDrag() {
		if (_checkContatinsElements())
			return;
		$(".empty-add").text(_tip_no_drag);
		$("#msg-upload").html("");
		$("#musicname").css({
			"border" : "1px #a9a9a9 solid"
		});
	}

	/**
	 * 上传文件
	 * 
	 * @private
	 */
	function _setDropStatus() {
		if (_checkContatinsElements())
			return;
		$(".empty-add").text(_tip_no_drag);
	}

	/**
	 * 判断是否已经上传文件了
	 * 
	 * @private
	 */
	function _checkContatinsElements() {
		// for ( var i in fileList) {
		// ary.push(fileList[i]);
		// }

		return false;

	}
	/**
	 * 当ondragenter触发
	 * 
	 * @private
	 */
	function _onDragEnter(ev) {
		if (_checkContatinsElements())
			return;
		_setDragOverStatus();
	}
	/**
	 * 当ondargmove触发
	 * 
	 * @private
	 */
	function _onDragOver(ev) {
		// ondragover中必须组织事件的默认行为，默认地，无法将数据/元素放置到其他元素中。
		if (_checkContatinsElements())
			return;
		ev.preventDefault();
		$("#msg-upload").html("");
		$("#musicname").css({
			"border" : "1px #a9a9a9 solid"
		});

	}
	/**
	 * 当dragleave触发
	 * 
	 * @private
	 */
	function _onDragLeave(ev) {
		_setStatusNoDrag();
		$("#msg-upload").html("");
		$("#musicname").css({
			"border" : "1px #a9a9a9 solid"
		});
	}

	/**
	 * ondrop触发
	 * 
	 * @private
	 */
	function _onDrop(ev) {
		if (_checkContatinsElements())
			return;
		// drop 事件的默认行为是以链接形式打开，所以也需要阻止其默认行为。
		ev.preventDefault();
		_setDropStatus();
		// 拿到拖入的文件
		var files = ev.dataTransfer.files;
		var len = files.length;
		for (var i = 0; i < len; i++) {
			// 页面上显示需要上传的文件
			_showUploadFile(files[i]);
		}
	}
	/**
	 * 页面上显示需要上传的文件
	 * 
	 * @private
	 */
	function _showUploadFile(file) {
		if (_checkContatinsElements())
			return;
		var reader = new FileReader();
		// 判断文件类型
		if (file.type.match(/image*/)) {
			fileList[file.name] = file;
			reader.onload = function(e) {
				var textHtml = "<div id=" + file.lastModified + " title=" + file.name + " class='stand-img-add newpage'><img  name='attachment' src='" + e.target.result
						+ "'width='100%' height='100%'/><div title='删除' onclick='deleteImg(" + file.lastModified + ")' class='delete-img'></div></div>";
				$("#first-socre").after(textHtml);
				initWH(".stand-img-add");
				// 上传文件到服务器
				// _uploadToServer(formData, li, progress, percentage);

			};
			reader.readAsDataURL(file);
		} else {
			$("#msg-upload").html("此" + file.name + "不是图片文件！");
		}
	}

	/**
	 * 上传文件到服务器
	 * 
	 * @private
	 */
	function _uploadToServer(formData, li, progress, percentage) {
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "http://localhost:8080/strurts2fileupload/uploadAction", true);
		xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest', 'Content-Type', 'multipart/form-data;');

		// HTML5新增的API，存储了上传过程中的信息
		xhr.upload.onprogress = function(e) {
			var percent = 0;
			if (e.lengthComputable) {
				// 更新页面显示效果
				percent = 100 * e.loaded / e.total;
				progress.height(percent);
				percentage.text(percent + "%");
				percent >= 100 && li.addClass("done");
			}
		};
		xhr.send(formData);
	}

	// 把init方法公布出去
	return {
		init : _init
	}

})();
