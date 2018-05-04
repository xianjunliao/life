$(function() {
});

function showStatistics() {
	$("#finance-total-pie").show(500);
	$("#finance-total-line").show(600);
	getInitValue();
	initPie(b,e,o);
	initLine(b,e,o);
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
				var dv = [];
				for (var i = 0; i < len; i++) {
					dk[i] = d[i].name;
					dv[i] = d[i].value;
				}

				var option = {
					color : [ '#3398DB' ],
					title : {
						text : '日支出趋势图'
					},
					tooltip : {
						trigger : 'axis',
						axisPointer : { // 坐标轴指示器，坐标轴触发有效
							type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
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
						data : dk,
						axisTick : {
							alignWithLabel : true
						}
					} ],
					yAxis : [ {
						type : 'value'
					} ],
					series : [ {
						type : 'bar',
						barWidth : '60%',
						data : dv,
					} ]
				};

				myChart.setOption(option);
			}
		}
	});

}
