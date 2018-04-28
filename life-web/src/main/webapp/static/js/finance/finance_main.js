$(function() {
	initList();
});

function initList() {

	$.ajax({
		type : 'POST',
		dataType : "json",
		url : base + "finance/getList",
		success : function(result) {
			if (result.code = 200) {

				var len = result.data.length;
				$("#finance-record-rows").empty();
				if (len == 0) {
					createNullRow();
				}
				var summ = 0.00;
				for (var d = 0; d < len; d++) {
					createRow(result.data[d]);
					summ += result.data[d].financemoney;
				}
				totalMoney(summ);
			} else {

			}
		}
	});
}

function showOperation(id) {
	$("#record-title").text("新增记录");
	$("#comfrimBut").text("确认新增");
	$('#finance-operation-form')[0].reset();
//	$("#financeday").attr("type", "date");
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
	}
	$.ajax({
		type : 'POST',
		dataType : "json",
		data : $("#finance-operation-form").serialize(),
		url : actionUrl,
		success : function(result) {
			if (result.code = 200) {
				initList();
			} else {

			}
		}
	});
}

function createRow(obj) {
	var col = "<td>" + obj.financeyear + "</td>";
	col += "<td>" + obj.financequarter + "</td>";
	col += "<td>" + obj.financemonth + "</td>";
	col += "<td>" + obj.financeweek + "</td>";
	col += "<td>" + obj.financeday + "</td>";
	col += "<td>" + obj.financename + "</td>";
	col += "<td>" + obj.financetype + "</td>";
	col += "<td>" + obj.financemode + "</td>";
	col += "<td align='right'>" + obj.financemoney + "</td>";
	col += "<td align='left'>" + obj.financeremarks + "</td>";
	var row = "<tr class='record-tables-tr' onclick='showOperation(\"" + obj.id + "\")'>" + col + "</tr>";
	$("#finance-record-rows").append(row);

}

function createNullRow() {
	var col = "<td colspan='10' align='left'> <b>你还一条消费记录都没有！点击本行<a onclick='showOperation(null)'>添加</a></b></td>";
	var row = "<tr class='record-tables-tr' onclick='showOperation(null)'>" + col + "</tr>";
	$("#finance-record-rows").append(row);

}

function setValue(obj) {
	$("#financeday").val(obj.financeday);
	$("#financename").val(obj.financename);
	$("#financemoney").val(obj.financemoney);
	$("#financetype").val(obj.financetype);
	$("#financemode").val(obj.financemode);
	$("#recordId").val(obj.id);
	$("#financeremarks").val(obj.financeremarks);
}

function totalMoney(m) {
	$("#totalm").text(m);
}