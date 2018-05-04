var queryType = 0;
var b, e, o;
$(function() {
	$("#finance-record-items").show();
	$("#finance-record-total").hide();
	$("#finance-record-fixed").hide();

	getInitValue();
	goQuery(0);
});

function getInitValue() {
	var txt = $("#finance-order").text();
	o = "desc";
	if (txt == '升序') {
		o = "desc";
	} else {
		o = "asc";
	}
	b = $("#beginday").val();
	e = $("#endday").val();
}

function goQuery(t) {
	queryType = t;
	$(".finance-settings-type").removeClass("finance-settings-type-this");
	$("#query" + queryType).addClass("finance-settings-type-this");
	if (t == 0) {
		$("#updateFixed").hide();
		$("#deleteFixed").hide();
		$("#addFixed").hide();
		$("#updateRecord").show();
		$("#deleteRecord").show();
		$("#addRecord").show();
	}
	if (t == 6) {
		$("#finance-total-pie").hide();
		$("#finance-total-line").hide();
		$("#finance-record-items").hide();
		$("#finance-record-total").hide();
		$("#finance-record-fixed").show();
		$("#addFixed").show();
		$("#updateFixed").show();
		$("#deleteFixed").show();
		$("#updateRecord").hide();
		$("#deleteRecord").hide();
		$("#addRecord").hide();
		createFixedHead();
		initListFixed();
		return;
	}
	getInitValue();
	initList(b, e, o);

}

function initListFixed() {
	$.ajax({
		type : 'POST',
		dataType : "json",
		url : base + "finance/getListFixed",
		success : function(result) {
			if (result.code = 200) {
				var len = result.data.length;
				$("#finance-record-fixed-rows").empty();
				if (len == 0) {

					return;
				}
				for (var d = 0; d < len; d++) {
					createFiexdRow(result.data[d]);
				}

			} else {

			}
		}
	});

}

function initList(b, e, o) {

	$("#finance-record-total-rows").hide();
	$("#finance-record-rows").hide(300);
	$.ajax({
		type : 'POST',
		dataType : "json",
		data : {
			beginday : b,
			endday : e,
			order : o,
			queryType : queryType
		},
		url : base + "finance/getList",
		success : function(result) {
			if (result.code = 200) {
				createHead();
				var len = result.data.length;
				$("#finance-record-rows").empty();
				$("#finance-record-total-rows").empty();
				if (len == 0) {
					createNullRow();
					return;
				}
				var summ = 0.00;
				var sumo = 0.00;
				var sumb = 0.00;
				createTotalHead();
				for (var d = 0; d < len; d++) {
					createRow(result.data[d]);
					var t = result.data[d].financetype;
					sumb += result.data[d].financemoney;
					if (t != null && t == '支出') {
						summ += result.data[d].financemoney;
					} else {
						sumo += result.data[d].financemoney;
					}
				}
				totalMoney(summ, sumo, sumb);
			} else {

			}
			$("#finance-record-rows").show(300);
			$("#finance-record-total-rows").show();
			showStatistics();
		}
	});
}

function showOperation(id) {
	if (id == "setting") {
		$("#record-title").text("新增固定记录");
		$(".filed-hide").hide();
		$(".filed-show").show();
		$(".finance-operation").show();
		$('#finance-operation-form')[0].reset();
		return;
	}
	$(".filed-hide").show();
	$(".filed-show").hide();
	$("#record-title").text("新增记录");
	$("#comfrimBut").text("确认新增");
	$('#finance-operation-form')[0].reset();
	// $("#financeday").attr("type", "date");
	$(".life-input-date").val(getNowDateStr());
	if (id != null) {
		var url = base + "finance/getRow?id=" + id;
		if (queryType == 6) {
			url = base + "finance/getRowFixed?id=" + id;
			$(".filed-hide").hide();
			$(".filed-show").show();
		} else {
			$(".filed-hide").show();
			$(".filed-show").hide();
		}
		$("#record-title").text("修改记录");
		$("#comfrimBut").text("确认修改");
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : url,
			success : function(result) {
				if (result.code = 200) {
					setValue(result.data)
				} else {

				}
			}
		});
	}
	$(".finance-operation").show();

}

function recordSubmit() {
	var title = $("#record-title").text();
	var actionUrl = base + "finance/addRecord"
	if (title == '修改记录') {
		actionUrl = base + "finance/updateRecord"
	} else if (title == '新增固定记录') {
		actionUrl = base + "finance/addFixed"
	}
	$.ajax({
		type : 'POST',
		dataType : "json",
		data : $("#finance-operation-form").serialize(),
		url : actionUrl,
		success : function(result) {
			if (result.code = 200) {
				goQuery(queryType);
			} else {

			}
		}
	});
}

function goOrder(obj) {
	var t = $(obj).text();
	var o = "desc";
	if (t == '升序') {
		$(obj).text("降序");
		o = "asc";
	} else {
		$(obj).text("升序");
		o = "desc";
	}
	var b = $("#beginday").val();
	var e = $("#endday").val();
	initList(b, e, o);

}

function createRow(obj) {
	if (queryType == 0) {
		var col = "<td>" + obj.financeyear + "</td>";
		col += "<td>" + obj.financequarter + "</td>";
		col += "<td>" + obj.financemonth + "</td>";
		col += "<td>" + obj.financeweek + "</td>";
		col += "<td>" + obj.financeday + "</td>";
		col += "<td>" + obj.financename + "</td>";
		col += "<td>" + obj.financetype + "</td>";
		col += "<td>" + obj.financemode + "</td>";
		col += "<td align='right'>" + obj.financemoney.toFixed(2) + "</td>";
		col += "<td align='left'>" + obj.financeremarks + "</td>";
		var row = "<tr class='record-tables-tr' id='" + obj.id + "' onclick='selectThis(\"" + obj.id + "\")'>" + col + "</tr>";
		$("#finance-record-rows").append(row);
	} else if (queryType == 1) {
		createTotalRow(null, obj.financeday, obj.financemoney, obj.financetype);
	} else if (queryType == 2) {
		createTotalRow(obj.financeyear, obj.financemonth, obj.financemoney, obj.financetype);
	} else if (queryType == 3) {
		createTotalRow(obj.financeyear, obj.financequarter, obj.financemoney, obj.financetype);
	} else if (queryType == 4) {
		createTotalRow(null, obj.financeyear, obj.financemoney, obj.financetype);
	}

}

function createFiexdRow(obj) {
	var col = "<td>" + obj.financename + "</td>";
	col += "<td>" + obj.financetype + "</td>";
	col += "<td>" + obj.financemode + "</td>";
	col += "<td>" + obj.financemoney.toFixed(2) + "</td>";
	col += "<td>" + obj.executetype + "</td>";
	col += "<td>" + obj.executedate + "</td>";
	var row = "<tr class='record-tables-tr' id='" + obj.id + "' onclick='selectThis(\"" + obj.id + "\")'>" + col + "</tr>";
	$("#finance-record-fixed-rows").append(row);
}

function selectThis(id) {
	$(".record-tables-tr").removeClass("record-tables-tr-this");
	$("#" + id).addClass("record-tables-tr-this");

}

function updateRecord() {
	var l = $(".record-tables-tr-this").length;
	if (l >= 1) {
		var id = $(".record-tables-tr-this").attr("id");
		showOperation(id);
	} else {
		alert("请选择需要修改的记录！");
	}
}

function deleteRecord() {

	var l = $(".record-tables-tr-this").length;
	if (l >= 1) {
		var id = $(".record-tables-tr-this").attr("id");
		var url = base + "finance/delete?id=" + id + "&type=" + queryType;
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : url,
			success : function(result) {
				if (result.code = 200) {
					goQuery(queryType);
				} else {
					alert("删除失败，请重试！");
				}
			}
		});
	} else {
		alert("请选择需要删除的记录！");
	}
}

function createTotalRow(y, d, m, t) {
	var col;
	if (y != null) {
		col = "<td>" + y + "</td><td>" + d + "</td>";
	} else {
		col = "<td>" + d + "</td>";
	}
	col += "<td>" + t + "</td><td align='right'>" + m.toFixed(2) + "</td>";
	var row = "<tr class='record-tables-tr'>" + col + "</tr>";
	$("#finance-record-total-rows").append(row);
}
function createHead() {
	$("#finance-record-head").empty();
	var head = "<tr><th>年份</th>";
	head += "<th>季度</th>";
	head += "<th>月份</th>";
	head += "<th>星期</th>";
	head += "<th>日期</th>";
	head += "<th>名称</th>";
	head += "<th>类型</th>";
	head += "<th>方式</th>";
	head += "<th>额度</th>";
	head += "<th>备注</th></tr>";
	$("#finance-record-head").append(head);
}
function createTotalHead() {
	var s = "日汇总";
	if (queryType == 0) {
		$("#finance-record-items").show();
		$("#finance-record-total").hide();
		$("#finance-record-fixed").hide();
		return;
	} else if (queryType == 1) {
		s = "日汇总";
		var head = "<tr><td>" + s + "</td><td>消费类型</td>";
		head += "<td align='right'>金额</td></tr>";

	} else if (queryType == 2) {
		s = "月份";
		var head = "<tr><td>年份</td><td>" + s + "</td><td>消费类型</td>";
		head += "<td align='right'>金额</td></tr>";
	} else if (queryType == 3) {
		s = "季度";
		var head = "<tr><td>年份</td><td>" + s + "</td><td>消费类型</td>";
		head += "<td align='right'>金额</td></tr>";
	} else if (queryType == 4) {
		s = "年汇总";
		var head = "<tr><td>" + s + "</td><td>消费类型</td>";
		head += "<td align='right'>金额</td></tr>";
	}
	$("#finance-record-items").hide();
	$("#finance-record-total").show();
	$("#finance-record-fixed").hide();
	$("#finance-record-total-head").empty();
	$("#finance-record-total-head").append(head);

}

function createFixedHead() {
	$("#finance-record-fixed-head").empty();
	var head = "<tr><th>名称</th>";
	head += "<th>类型</th>";
	head += "<th>方式</th>";
	head += "<th>金额</th>";
	head += "<th>执行方式</th>";
	head += "<th>执行时间</th>";
	$("#finance-record-fixed-head").append(head);
}

function createNullRow() {
	var col = "<td colspan='10' align='left'> <b>你还一条消费记录都没有！点击本行<a onclick='showOperation(null)'>添加</a></b></td>";
	var row = "<tr class='record-tables-tr' onclick='showOperation(null)'>" + col + "</tr>";
	$("#finance-record-rows").append(row);
	$("#finance-record-rows").show(300);

}

function setValue(obj) {
	if (queryType == 0) {
		$("#financeday").val(obj.financeday);
		$("#financeremarks").val(obj.financeremarks);
	}
	if (queryType == 6) {
		$("#executetype").val(obj.executetype);
		$("#executedate").val(obj.executedate);
	}
	$("#financename").val(obj.financename);
	$("#financemoney").val(obj.financemoney.toFixed(2));
	$("#financetype").val(obj.financetype);
	$("#financemode").val(obj.financemode);
	$("#recordId").val(obj.id);
}

function totalMoney(m, o, b) {
	$(".totalm").text(m.toFixed(2));
	$(".totalo").text(o.toFixed(2));
	$(".totalb").text(b.toFixed(2));

}