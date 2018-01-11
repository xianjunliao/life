
/**
 * 判断字符串是否非空
 * 
 * @param distObj
 * @return 空格字符串也返回false
 */
function isBlank(distObj) {
	if (distObj == null || distObj == '') {
		return true;
	}
	return false;
}

/**
 * 判断是否为undefined
 * 
 * @param distObj
 * @return
 */
function isUndefined(distObj) {
	if (distObj === undefined || typeof distObj == 'undefined') {
		return true;
	}
	return false;
}

/**
 * 去首尾空格
 */
String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
};

/**
 * 数字验证
 */
function numberValidate(numberVal) {
	// /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/
	if (/^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test(numberVal)) {
		return true;
	} else {
		return false;
	}
}

/* ################### 表单 #################### */
/**
 * 表单提交
 */
function submit(formId, configs) {
	var _setting = {
		url : "",
		onSubmit : function(param) {
			return $(this).form('enableValidation').form('validate');
		},
		success : function(result) {
			// console.log(result);
			var data = eval('(' + result + ')');

			if (data.code == '200') {
				$.mytools.successAlert("保存成功");
			} else {
				$.mytools.errorAlert(data.message);
			}
		},
		error : function(e) {
			$.mytools.errorAlert("保存失败！");
			console.log(e);
		}
	};

	var options = $.extend(true, _setting, configs);

	$('#' + formId).form('submit', options);
}
/**
 * 表单重置
 */
function resetForm(formId) {
	$('#' + formId).form('reset');
}
/**
 * 清空表单
 */
function clearForm(formId) {
	$('#' + formId).form('clear');
}
/**
 * Post请求
 * add by anjun.tang
 */
function doPost(url,data,success,error,config) {
	return doAjax($.extend({url:url,type:"POST",data:data,success:success,error:error},config||{}));
}
/**
 * Post提交JSon格式的数据
 * add by anjun.tang
 */
function doPostJson(url,data,success,error,config) {
	return doAjax($.extend({url:url,type:"POST",data:JSON.stringify(data),contentType:"application/json;charset=utf-8",success:success,error:error},config||{}));
}
/**
 * GET请求
 * add by anjun.tang
 */
function doGet(url,data,success,error,config) {
	return doAjax($.extend({url:url,type:"GET",data:data,success:success,error:error},config||{}));
}
/**
 * 1. 获取全部表单数据：$("#fomID").formData();
 * 2. 获取指定表单数据：$("#fomID").formData("name");
 * 3. 设置填充表单数据：$("#fomID").formData(data);
 * add by anjun.tang
 */
$.fn.formData = function(data) {
	var $form=this, isArray=data instanceof Array;
	if(data&&typeof data=="string"||isArray){
		var reData={},list=isArray&&data||data.split(",");
		$.each(list,function(i,v){
			reData[v]=$form.find("[name='"+v+"']").val();
		});
		return !isArray&&list.length==1?reData[data]:reData;
	}else if(data && typeof data == "object"){
		for(var name in data){
			if(typeof(data[name])=="function") continue;
			var $input_value=$form.find("[name='"+name+"']");
			var $input_source=$input_value.parent().parent().find("[textboxname="+name+"]");
			if($input_source.length > 0){
				if($input_source.hasClass("easyui-textbox")){
					$input_source.textbox('setValue',data[name]);
				}
				if($input_source.hasClass("easyui-combobox")){
					var multi=$input_source.combobox("options").multiple;
					$input_source.combobox(multi&&"setValues"||"setValue",data[name]);
				}
			}else{
				$input_value.val(data[name]);
			}
		}
	}else{
		return $.serializeObject($form);
	}
}
/**
 * GET 和 Post 请求
 * add by anjun.tang
 */
function doAjax(config) {
	config.url=(!config.url.startsWith(webResourceRoot)&&webResourceRoot||"")+config.url;
	config.dataType="json";
	var config_success=config.success,config_error=config.error;
	config.success=function(reData){
		if(reData&&reData.code&&reData.code!="success"&&reData.code!="200"){
			return config_error&&!config_error(reData)||$.mytools.errorAlert("操作失败！");
		}else{
			return config_success&&!config_success(reData)||config.asyns&&$.mytools.successAlert("操作成功。");
		}
	};
	config.error=function(e){
		return config_error&&!config_error(reData)||$.mytools.errorAlert("操作失败！");
	};
	return $.ajax(config);
}
/**
 * 弹出一个页面
 * add by anjun.tang
 */
function openDialogPage(pageName,pageUrl,callback,configs) {
	//每次弹出同一个页面时，dialogID必须相同
	var dialogid="DialogPage_"+pageName,$dialog=null;
	var operation={
		title:"请选择",
		href:(!pageUrl.startsWith(basePath)&&basePath||"")+pageUrl,
		width:1000,height:600,
		buttons:[
			{text:"保存",iconCls:"icon-save",handler:function(){
				return !eval(pageName)["clickSaveButton"](callback,$dialog)&&$dialog.dialog("close");
			}},
			{text:"取消",iconCls:"icon-cancel",handler:function(){
				$dialog.dialog("close");
			}
		}],
		onLoad:function(){
			Bcs.PageLoad.load_all($dialog);
		}
	};
	if(!callback)operation.buttons.splice(0,1);
	$dialog=createDialog(dialogid,$.extend(operation,configs));
}
/**
 * 创建JS命名空间和对象
 * add by anjun.tang
 */
function createPageObject(pageName,initFn){
	var pageObj=null;
	$.each(pageName.split("."),function(i,n){
		pageObj=(pageObj=(pageObj||window))&&pageObj[n]||(pageObj[n]={});
	});
	return initFn&&$.extend(pageObj,new initFn(pageObj))||pageObj;
}
/**
 * 字符串参数替换方法{#name}
 * add by anjun.tang
 */
String.prototype.replaceData = function(data,failByNull){
	var arr = "string,number".indexOf(typeof data)>-1&&!(failByNull=false)&&arguments||data instanceof Array&&data;
	var i=0,re,value,name,newData=this.toString(),nameList=[],jq=data instanceof $,success=true,patt=new RegExp("\\{#\(\\w+\)\\}","g");
	while((re=patt.exec(this))!=null){
		nameList.push(name=re[1]);
		success=success&&data&&"string,number".indexOf(typeof (value=arr?[i++]:jq?data.formData(re[1]):data[re[1]]))>-1&&!failByNull||!!value;
		success&&(newData=newData.replace(re[0],value));
	}
	return data?newData:nameList;
};
/**
 * 扩展组件加载和渲染
 * add by anjun.tang
 */
createPageObject("Bcs.PageLoad",function(pageObj){
	var add_function=function(function1,function2){
		return (!function1!=!function2)&&(function1||function2)||function(a,b,c){
			function1(a,b,c);function2(a,b,c);
		};
	};
	var CL_SetParentOnChange=function($this,options,bcs_cl){
		var parentList=(bcs_cl.queryParams&&JSON.stringify(bcs_cl.queryParams)||""+bcs_cl.url||"").replaceData();
		$.each(parentList,function(i,v){
			var $parent=bcs_cl.$form.find("select[bcs-cl][comboname="+v+"]");
			if($parent){
				var parent_options=$parent.combobox("options");
				parent_options.clearData=add_function(parent_options.clearData,function(){
					options.clearData();//级联清除
				});
				parent_options.onSelect=add_function(parent_options.onSelect,function(record){
					var clear = (clear=$this.combobox("getData"))&&(clear=clear.length>0)&&options.clearData()||clear;
					CL_LoadData($this);
				});
			}else{
				var input_parent=bcs_cl.$form.find("[name="+v+"]");
				input_parent.on("change",add_function(parent_options.onSelect,function(record){
					options.clearData();CL_LoadData($this);
				}));
			}
		});
		return parentList&&parentList.length>0;
	};
	//全部加载
	pageObj.load_all=function(dom){
		this.load_cl(dom);
	};
	//bcs-cl下拉列表框加载
	pageObj.load_cl=function bcsclLaod(dom){
		var $dom=$bcs_cl_list=$(dom||document),flList=$dom.filter("select[bcs-cl]"),$bcs_cl_list=flList.length>0&&flList||$dom.find("select[bcs-cl]");
		$bcs_cl_list.each(function(i,v){
			var $this=$(v);
			var options=$this.combobox("options");
			if(options.bcs_cl)return;//已经加载过了
			eval("var bcs_cl={"+$this.attr("bcs-cl")+"};");
			var $form=bcs_cl.$form=$this.parents("form");
			if(bcs_cl.codeNo){
				options.valueField="itemNo",options.textField="itemName";
			}
			//clearData
			options.clearData=add_function(options.clearData,function(){
				return $this.combobox("clear");
			});
			//bcs_cl.setData
			bcs_cl.setFormData=function(record){
				var obj={};
				$.each(bcs_cl.setData,function(i,v){
					obj[v.split(":")[1]||v.split(":")[0]]=record[v.split(":")[0]]
				});
				$form.formData(obj);
			};
			//bcs_cl.onSelect
			options.onSelect=add_function(options.onSelect,function(record){
				if($this.attr("comboname") == "brandid"){
					debugger;
				};
				bcs_cl.setData&&bcs_cl.setFormData(record);
				$this.parent().find("[name="+$this.attr("comboname")+"]").val(record[options.valueField]);
				bcs_cl.onSelect&&bcs_cl.onSelect(record);
			});
			//bcs_cl.onChange
			options.onChange=add_function(options.onChange,function(newValue,oldValue){
				bcs_cl.onChange&&bcs_cl.onChange(newValue,oldValue);
			});
			//输入框点击事件
			$this.parent().find("[id^=_easyui_textbox_input]").on("click",function(e){
				$this.parent().find(".combo-arrow").click();
			});
			//bcs_cl.delay 加载数据
			var isParentParams=CL_SetParentOnChange($this,options,bcs_cl);
			bcs_cl.delay=isParentParams||bcs_cl.delay==true;//默认值false为：立即加载
			if($this.attr("comboname") == "brandid"){
				debugger;
			};
			if(!bcs_cl.delay){
				CL_LoadData($this,options,bcs_cl);
			}
			options.bcs_cl=bcs_cl;//加载完成
		});
	}
	//bcs-cl下拉列表框加载数据
	var CL_LoadData=function($this,options,bcs_cl){
		options=options||$this.combobox("options");
		bcs_cl=bcs_cl||options.bcs_cl;
		//bcs_cl.returnList
		var loadData=function(returnList){
			if($this.attr("comboname") == "brandid"){
				debugger;
			};
			return returnList&&$this.combobox("loadData",bcs_cl.returnList?eval("returnList."+bcs_cl.returnList):returnList);
		};
		//bcs_cl.data
		var data=(data=bcs_cl.data)&&(typeof data=="function"&&data()||data);
		//bcs_cl.url 并处理#{name}参数
		var url=bcs_cl.url&&bcs_cl.url.replaceData(bcs_cl.$form)||bcs_cl.codeNo&&"/codelibrary/getCodeLibraryList?codeNo="+bcs_cl.codeNo;
		//bcs_cl.queryParams 并处理#{name}参数
		var success=true,queryParams=bcs_cl.queryParams&&JSON.parse(success=JSON.stringify(bcs_cl.queryParams).replaceData(bcs_cl.$form,true));
		//bcs_cl.method
		data&&loadData(data)||url&&success&&(bcs_cl.method||doGet)(url,queryParams,loadData);
	};
});
$(function(){
	Bcs.PageLoad.load_all();
});
/* ################### 表格 #################### */
/**
 * 加载数据表格
 * 
 * @param domId
 * @param configs
 * @returns
 */
function loadDataGrid(domId, configs) {
	var _setting = {
		url : "",
		method : "POST",
		cls : "theme-datagrid",
		cache : false,
		width : $(window).width() - 5,
		height : $(window).height() - 35,
		rownumbers : true,// 显示序号
		pagination : true,
		pageSize : 20,
		collapsible : true,
		queryParams : {},
		loader:function(param,success,error){
			var opts = $(this).datagrid("options");
			if(!opts.url){
				return false;
			}
			
			$.ajax({
				url:opts.url,
				type:opts.method,
				dataType:'json',
				contentType:'application/json;charset=utf-8',
				data:JSON.stringify(param),
				success:function(data){
					success(data);
				},
				error:function(data,type, err){
					$.mytools.errorAlert("系统处理异常，请联系系统管理员！");
					console.log("分页查询异常->type:"+ type +", message:"+ err);
					error.apply(this, arguments);
				}
			});
		}
	};

	var options = $.extend(true, _setting, configs);

	$('#' + domId).datagrid(options);
}

/**
 * 查询数据并更新表格数据
 * 
 * @param domId
 * @param queryParams
 *            查询参数，json对象
 * @returns
 */
function searchAndReloadGrid(domId, queryParams) {
	$('#' + domId).datagrid({
		queryParams : queryParams
	});
}

/**
 * datagrid自适应窗口大小改变
 * 
 * @param domId
 *            表格ID
 * @param correctedWidth
 *            修正宽度
 * @param correctedHeight
 *            修正高度
 * @returns
 */
function datagridWindowResizeFit(domId, correctedWidth, correctedHeight) {
	if (isUndefined(correctedWidth) || isBlank(correctedWidth)) {
		correctedWidth = 0;
	}
	if (isUndefined(correctedHeight) || isBlank(correctedHeight)) {
		correctedHeight = 0;
	}

	$(window).resize(function() {
		$('#' + domId).datagrid('resize', {
			width : $(window).width() - correctedWidth,
			height : $(window).height() - correctedHeight
		}).datagrid('resize', {// 浏览器有动画的，最好设置2次
			width : $(window).width() - correctedWidth,
			height : $(window).height() - correctedHeight
		});
	});
}
/**
 * 删除表格行
 * @param gridId 表格ID
 * @param rowIndex 行下标
 * @param configs ajax相关配置，
 * @returns
 */
function delGridRow(gridId, rowIndex, configs){
	var setting = {
		url : "",
		async : true,// true异步请求,false同步请求,注：同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行
		cache : false,
		type : "GET",
		dataType : "text",
		beforeSend : function() {
			$.messager.progress();
		},
		complete : function() {
			$.messager.progress('close');
		},
		success:function(data){
			var result = JSON.parse(data);
			if(result.code == "200") {
				$.mytools.successAlert("删除成功", function(){
					// 删除行
					$('#'+ gridId).datagrid('deleteRow',rowIndex);
				});
			} else {
				$.mytools.errorAlert("删除失败！");
				console.log("delete error->"+data);
			}
		},
		error:function(e){
			$.mytools.errorAlert("删除失败！");
			console.log("delete error->"+e);
		}
	};
	var n = $.extend(true, setting, configs);
	$.ajax(n);
}
/* ################### 树形  #################### */
function createTree(treeId, configs){
	var _setting = {
		url:"",
        idFiled:"id",
        textFiled:"text",
        parentField:"pid",
        onSelect:function(node){},
        loadFilter:function (data, parent) {
		    var opt = $(this).data().tree.options;
		    var idFiled, textFiled, parentField;
		    if (opt.parentField) {
		        idFiled = opt.idFiled || 'id';
		        textFiled = opt.textFiled || 'text';
		        parentField = opt.parentField;
		         
		        var i, l, treeData = [], tmpMap = [];
		         
		        for (i = 0, l = data.length; i < l; i++) {
		            tmpMap[data[i][idFiled]] = data[i];
		        }
		         
		        for (i = 0, l = data.length; i < l; i++) {
		            if (tmpMap[data[i][parentField]] && data[i][idFiled] != data[i][parentField]) {
		                if (!tmpMap[data[i][parentField]]['children'])
		                    tmpMap[data[i][parentField]]['children'] = [];
		                data[i]['text'] = data[i][textFiled];
		                tmpMap[data[i][parentField]]['children'].push(data[i]);
		            } else {
		                data[i]['text'] = data[i][textFiled];
		                treeData.push(data[i]);
		            }
		        }
		        return treeData;
		    }
		    return data;
		}
	};
	
	var options = $.extend(true, _setting, configs);
	
	$('#' + treeId).tree(options);
}
/* ################### 工具 #################### */
;
(function($) {
	/* alert提示框 */
	function alertMessage(title, msg, iconType, callback) {
		if (title == null || title == "") {
			title = "消息提示";
		}
		if (msg == null || msg == "") {
			msg = "";
		}
		if (iconType == null || iconType == "") {
			iconType = "alert";
		}
		if (typeof callback != 'function') {
			callback = function() {
			};
		}
		var _setting = {
			title : title,
			msg : msg,
			icon : iconType,// alert,error,question,info,warning,success,danger
			fn : callback
		};
		$.messager.alert(_setting);
	}
	;

	$.mytools = {
		ajax : function(configs) {
			var setting = {
				url : "",
				async : true,// true异步请求,false同步请求,注：同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行
				cache : false,
				type : "POST",
				dataType : "text",
				beforeSend : function() {
					$.messager.progress();
				},
				complete : function() {
					$.messager.progress('close');
				}
			};
			var n = $.extend(true, setting, configs);
			$.ajax(n);
		},
		basicAlert : function(msg, callback) {
			alertMessage("消息提示", msg, "alert", callback);
		},
		successAlert : function(msg, callback) {
			alertMessage("消息提示", msg, "success", callback);
		},
		infoAlert : function(msg, callback) {
			alertMessage("消息提示", msg, "info", callback);
		},
		errorAlert : function(msg, callback) {
			alertMessage("消息提示", msg, "error", callback);
		},
		warningAlert : function(msg, callback) {
			alertMessage("消息提示", msg, "warning", callback);
		},
		dangerAlert : function(msg, callback) {
			alertMessage("消息提示", msg, "danger", callback);
		},
		questionAlert : function(msg, callback) {
			alertMessage("消息提示", msg, "question", callback);
		}
	};
})(jQuery);

/* ################### 弹窗 #################### */
/**
 * 打开目标弹窗
 * 
 * @param domId
 * @returns
 */
function openDialog(domId) {
	$('#' + domId).dialog('open');
}
/**
 * 关闭目标弹窗
 * 
 * @param domId
 * @returns
 */
function closeDialog(domId) {
	$('#' + domId).dialog('close');
}
/**
 * 创建弹窗, 当DOM不存在会根据domId创建一个
 * 
 * @param domId
 * @param configs
 * @returns
 */
function createDialog(domId, configs) {
	if ($('#' + domId).length == 0) {
		$(document.body).append(
				"<div id='" + domId + "' style='width:40%;height:30%;'></div>");
		console.log('createDialog->创建div:' + $("#"+domId).html());
	}

	var _setting = {
		title : "",
		closed : false,
		cache : false,
		href : "",
		fit : false,
		maximizable : true,
		modal : true
	};

	var options = $.extend(true, _setting, configs);

	return $('#' + domId).dialog(options);
}


/**
 * 刷新弹窗
 * 
 * @param domId
 * @param newUrl
 * @returns
 */
function refreshDialog(domId, newUrl) {
	if (!isUndefined(newUrl) && isBlank(newUrl)) {
		$('#' + domId).dialog('refresh', newUrl);
	} else {
		$('#' + domId).dialog('refresh');
	}
}

/**
 * 
 * @requires jQuery
 * 
 * 将form表单元素的值序列化成对象
 * 
 * @returns object
 */
$.serializeObject = function(form) {
    var o = {};
    $.each(form.serializeArray(), function(index) {
        if (o[this['name']]) {
            o[this['name']] = o[this['name']] + "," + this['value'];
        } else {
            o[this['name']] = this['value'];
        }
    });
    return o;
};

/**
 * 
 * @requires jQuery
 * 
 * 页面加载加载进度条启用
 * **/
function progressLoad(){  
    $("<div class=\"datagrid-mask\" style=\"position:absolute;z-index: 9999;\"></div>").css({display:"block",width:"100%",height:$(window).height()}).appendTo("body");  
    $("<div class=\"datagrid-mask-msg\" style=\"position:absolute;z-index: 9999;\"></div>").html("正在处理，请稍候。。。").appendTo("body").css({display:"block",left:($(document.body).outerWidth(true) - 190) / 2,top:($(window).height() - 45) / 2});  
}

function progressLoadById(id,msg){  
    $("<div class=\"datagrid-mask\" style=\"position:absolute;z-index: 9999;\"></div>").css({display:"block",width:"100%",height:$(window).height()}).appendTo("#"+id);  
    $("<div class=\"datagrid-mask-msg\" style=\"position:absolute;z-index: 9999;\"></div>").html(msg).appendTo("#"+id).css({display:"block",left:($(document.body).outerWidth(true) - 190) / 2,top:($(window).height() - 45) / 2});  
}
/**
 * 
 * @requires jQuery
 * 
 * 页面加载加载进度条关闭
 * **/
function progressClose(){
    $(".datagrid-mask").remove();  
    $(".datagrid-mask-msg").remove();
}

function getCodeLibrary(domid,codeno,itemno){
	  if(isUndefined(itemno)){
		  itemno = "";
	  }
	  $.ajax({
	  	type : "post",
	  	url:"/bcs-web/codelibrary/dealArray?codeno="+codeno+"&itemno="+itemno,
	  	dataType : "text",
	  	error : function() {
	  	alert("系统忙，请稍后再试！");
	  	return false;
	  },
	  success : function(text) {
	  var certtype = $("#"+domid);
	  var str = '';
	  var data1 = eval("("+text+")");
	  var data2 = data1.data;
	  for(var i=0;i<data2.length;i++){
		  
		str += '<option value="'+data2[i].itemno+'">'+data2[i].itemname+'</option>';
	  }
	  	certtype.append(str);
	  }
	  });
	  }

/**
 * 
 * 接收一个以逗号分割的字符串，返回List，list里每一项都是一个字符串
 * 
 * @returns list
 */
$.stringToList = function(value) {
    if (value != undefined && value != '') {
        var values = [];
        var t = value.split(',');
        for ( var i = 0; i < t.length; i++) {
            values.push('' + t[i]);/* 避免他将ID当成数字 */
        }
        return values;
    } else {
        return [];
    }
};