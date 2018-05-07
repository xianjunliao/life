$(function() {
});

function showStatistics() {
	$("#finance-total-pie").show(500);
	$("#finance-total-line").show(600);
	getInitValue();
	initPie(b, e, o);
	initLine(b, e, o);
}

function initPie(b, e, o) {
	var myChart = echarts.init(document.getElementById('finance-total-pie'), "shine");
	// app.title = '堆叠柱状图';
	$.ajax({
		type : 'POST',
		dataType : "json",
		data : {
			beginday : b,
			endday : e,
			order : o
		},
		url : base + "finance/getSum",
		success : function(result) {
			if (result.code = 200) {
				option = {
					title : {
						text : '支出方式饼图',
						x : 'center'
					},
					tooltip : {
						trigger : 'item',
						formatter : "{a} <br/>{b} : ￥ {c} ({d}%)"
					},
					legend : {
						orient : 'vertical',
						left : 'left',
						data : [ '微信', '支付宝', '借记卡', '现金', '信用卡', 'Apply Pay', '饭卡' ]
					},
					series : [ {
						name : '支出方式',
						type : 'pie',
						radius : '55%',
						center : [ '50%', '60%' ],
						data : result.data,
						itemStyle : {
							emphasis : {
								shadowBlur : 10,
								shadowOffsetX : 0,
								shadowColor : 'rgba(0, 0, 0, 0.5)'
							}
						}
					} ]
				};
				myChart.setOption(option);
			} else {
				$("#finance-total-pie").html("<b>null</b>");
			}

		}
	});

	// 使用刚指定的配置项和数据显示图表。

}

function initLine(b, e, o) {
	var myChart = echarts.init(document.getElementById('finance-total-line'), "shine");
	$.ajax({
		type : 'POST',
		dataType : "json",
		data : {
			beginday : b,
			endday : e,
			order : o
		},
		url : base + "finance/getDaySum",
		success : function(result) {
			if (result.code = 200) {
				var d = result.data;
				var len = d.length;
				var dk = [];
				var dv0 = [];
				var dv1 = [];
				var dv2 = [];
				var dv3 = [];
				var dv4 = [];
				var dv5 = [];
				var dv6 = [];
				var dv7 = [];

				for (var i = 0; i < len; i++) {
					dk[i] = d[i].name;
					dv0[i] = d[i].value0;
					dv1[i] = d[i].value1;
					dv2[i] = d[i].value2;
					dv3[i] = d[i].value3;
					dv4[i] = d[i].value4;
					dv5[i] = d[i].value5;
					dv6[i] = d[i].value6;
					dv7[i] = d[i].value7;
				}

				var option = {
					title : {
						text : '日支出趋势图'
					},
					tooltip : {
						trigger : 'axis',
						axisPointer : {
							type : 'cross',
							label : {
								backgroundColor : '#6a7985'
							}
						}
					},
					legend : {
						data : [ '微信', '支付宝', '借记卡', '现金', '信用卡', 'Apply Pay', '饭卡' ]
					},
					toolbox : {
						feature : {
							saveAsImage : {}
						}
					},
					grid : {
						left : '3%',
						right : '4%',
						bottom : '3%',
						containLabel : true
					},
					xAxis : [ {
						type : 'category',
						boundaryGap : false,
						data : dk
					} ],
					yAxis : [ {
						type : 'value'
					} ],
					series : [ {
						name : '总支出额',
						type : 'line',
						stack : '每日支出总额',
						areaStyle : {
							normal : {}
						},
						label : {
							normal : {
								show : true,
								position : 'top'
							}
						},
						data : dv0
					}, {
						name : '支付宝支出额',
						type : 'line',
						stack : '总量',
						areaStyle : {
							normal : {}
						},
						data : dv1
					}, {
						name : '微信支出额',
						type : 'line',
						stack : '总量',
						areaStyle : {
							normal : {}
						},
						data : dv2
					}, {
						name : '饭卡支出额',
						type : 'line',
						stack : '总量',
						areaStyle : {
							normal : {}
						},
						data : dv3
					}, {
						name : '信用卡支出额',
						type : 'line',
						stack : '总量',
						areaStyle : {
							normal : {}
						},
						data : dv4
					}, {
						name : '借记卡支出额',
						type : 'line',
						stack : '总量',
						areaStyle : {
							normal : {}
						},
						data : dv5
					}, {
						name : 'Apply Pay支出额',
						type : 'line',
						stack : '总量',
						areaStyle : {
							normal : {}
						},
						data : dv6
					}, {
						name : '现金支出额',
						type : 'line',
						stack : '总量',
						areaStyle : {
							normal : {}
						},
						data : dv7
					} ]
				};

				myChart.setOption(option);
			}
		}
	});

}
