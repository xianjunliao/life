$(function() {
});

function showOperation() {
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
				alert("新增成功!");
			} else {

			}
		}
	});
}