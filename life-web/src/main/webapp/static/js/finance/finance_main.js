var queryType = 0;
$(function() {
	$("#finance-record-items").show();
	$("#finance-record-total").hide();
	var b = $("#beginday").val();
	var e = $("#endday").val();
	initList(b, e, "desc");
});

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
			$("#finance-total-pie").hide(200);
			$("#finance-record-rows").show(300);
			$("#finance-record-total-rows").show();
		}
	});
}

function showOperation(id) {

	if (id == "setting") {
		$("#record-title").text("新增固定消费记录");
		$(".filed-hide").hide();
		$(".finance-operation").show();
		$('#finance-operation-form')[0].reset();
		return;
	}
	$("#record-title").text("新增记录");
	$("#comfrimBut").text("确认新增");
	$('#finance-operation-form')[0].reset();
	// $("#financeday").attr("type", "date");
	$(".life-input-date").val(getNowDateStr());
	if (id != null) {
		$("#record-title").text("修改记录");
		$("#comfrimBut").text("确认修改");
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : base + "finance/getRow?id=" + id,
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
	} else if (title == '新增固定消费记录') {
		actionUrl = base + "finance/addFixed"
	}
	$.ajax({
		type : 'POST',
		dataType : "json",
		data : $("#finance-operation-form").serialize(),
		url : actionUrl,
		success : function(result) {
			if (result.code = 200) {
				goQuery(0);
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

function goQuery(t) {
	if(t==5){
		$("#finance-total-pie").show(500);
		return ;
	}
	var txt = $("#finance-order").text();
	var o = "desc";
	if (txt == '升序') {
		o = "desc";
	} else {
		o = "asc";
	}
	
	var b = $("#beginday").val();
	var e = $("#endday").val();
	queryType = t;
	$(".finance-settings-type").removeClass("finance-settings-type-this");
	$("#query" + queryType).addClass("finance-settings-type-this");
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
		var row = "<tr class='record-tables-tr' onclick='showOperation(\"" + obj.id + "\")'>" + col + "</tr>";
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

function createTotalHead() {
	var s = "日汇总";
	if (queryType == 0) {
		$("#finance-record-items").show();
		$("#finance-record-total").hide();
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
	$("#finance-record-total-head").empty();
	$("#finance-record-total-head").append(head);

}

function createNullRow() {
	var col = "<td colspan='10' align='left'> <b>你还一条消费记录都没有！点击本行<a onclick='showOperation(null)'>添加</a></b></td>";
	var row = "<tr class='record-tables-tr' onclick='showOperation(null)'>" + col + "</tr>";
	$("#finance-record-rows").append(row);
	$("#finance-record-rows").show(300);

}

function setValue(obj) {
	$("#financeday").val(obj.financeday);
	$("#financename").val(obj.financename);
	$("#financemoney").val(obj.financemoney.toFixed(2));
	$("#financetype").val(obj.financetype);
	$("#financemode").val(obj.financemode);
	$("#recordId").val(obj.id);
	$("#financeremarks").val(obj.financeremarks);
}

function totalMoney(m, o, b) {
	$(".totalm").text(m.toFixed(2));
	$(".totalo").text(o.toFixed(2));
	$(".totalb").text(b.toFixed(2));

}