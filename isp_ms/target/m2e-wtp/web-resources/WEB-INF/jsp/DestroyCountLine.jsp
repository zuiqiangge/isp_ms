<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html>
	<head>
		<title></title>
		
		<!-- chart js -->
    	<script src="js/chartjs/chart.min.js"></script>
		
		<!-- bootstrap progress js -->
		<script src="js/progressbar/bootstrap-progressbar.min.js" type="text/javascript"></script>
		<script src="js/nicescroll/jquery.nicescroll.min.js" type="text/javascript"></script>
		<!-- icheck -->
		<script src="js/icheck/icheck.min.js" type="text/javascript"></script>
		<script src="js/common-cud.js" type="text/javascript"></script>
		
		<!-- echart -->
	    <script src="js/echart/echarts-all.js" type="text/javascript"></script>
	    <script src="js/echart/green.js" type="text/javascript"></script>
		
		<!-- daterangepicker -->
	    <script type="text/javascript" src="js/moment.min.js"></script>
	    <script type="text/javascript" src="js/datepicker/daterangepicker.js"></script>
			
		
		<script type="text/javascript">
		 var optionSet1 = {
                startDate: moment().subtract(7, 'days'),
                endDate: moment(),
                minDate: '2015-01-01',
                maxDate: moment().format('YYYY-MM-DD'),
                dateLimit: {
                    days: 60
                },
                showDropdowns: true,
                showWeekNumbers: true,
                timePicker: false,
                timePickerIncrement: 1,
                timePicker12Hour: true,
                ranges: {
                    '今日': [moment(), moment()],
                    '昨日': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    '最近七天': [moment().subtract(6, 'days'), moment()],
                    '最近 30 天': [moment().subtract(29, 'days'), moment()],
                    '本月': [moment().startOf('month'), moment().endOf('month')],
                    '最后一个月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                },
                opens: 'left',
                buttonClasses: ['btn btn-default'],
                applyClass: 'btn-small btn-primary',
                cancelClass: 'btn-small',
                format: 'YYYY-MM-DD',
                separator: ' to ',
                locale:myLocales['zh']
            };
            var cb = function (start, end, label) {
                $('#reportrange span').html(start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD'));
            	
            	destroyWire(start.format('YYYY-MM-DD') ,end.format('YYYY-MM-DD'));
            	
            };
            
           $("#reportrange span").html( moment().subtract(7, 'days').format('YYYY-MM-DD')+" - "+moment().format('YYYY-MM-DD'));
            $('#reportrange').daterangepicker(optionSet1, cb);
            $('#reportrange').on('show.daterangepicker', function () {
                console.log("show event fired");
            });
            $('#reportrange').on('hide.daterangepicker', function () {
                console.log("hide event fired");
            });
            $('#reportrange').on('apply.daterangepicker', function (ev, picker) {
                console.log("apply event fired, start/end dates are " + picker.startDate.format('MMMM D, YYYY') + " to " + picker.endDate.format('MMMM D, YYYY'));
            });
            $('#reportrange').on('cancel.daterangepicker', function (ev, picker) {
                console.log("cancel event fired");
            });
            $('#options1').click(function () {
                $('#reportrange').data('daterangepicker').setOptions(optionSet1, cb);
            });
            $('#options2').click(function () {
                $('#reportrange').data('daterangepicker').setOptions(optionSet2, cb);
            });
            $('#destroy').click(function () {
                $('#reportrange').data('daterangepicker').remove();
            });
		
		destroyWire(moment().subtract(7, 'days').format('YYYY-MM-DD') ,moment().format('YYYY-MM-DD'));
		
        function destroyWire(date,time){  
        	$("#wire").css({"width":$("#wire").parent().width()*0.92+"px"});
            var wire = echarts.init(document.getElementById('wire'), theme);
            var text="时间："+date+" ~ "+time;
        	$.ajax({
					url:"echartsWire.do",
					method: "POST",
					data:"date="+date+"&time="+time,
					cache: false,
					success:function(data){
						var wireDate=[];
						var wireCount=[];
						if(data!=null){
							for(var i=0;i<data.length;i++){
								wireDate.push(data[i][0]);
								wireCount.push(data[i][1])
							}
							
							wire.setOption({
					            title: {
				                text: '每日销毁量',
				                subtext: text
				            	},
					            tooltip: {
					                trigger: 'axis'
					            },
					            toolbox: {
					                show: true,
					                feature: {
					                    restore: {
					                        show: true
					                    },
					                    saveAsImage: {
					                        show: true
					                    }
					                }
					            },
					            calculable: true,
					            xAxis: [
					                {
					                    type: 'category',
					                    boundaryGap: false,
					                    data: wireDate
					            }
					        ],
					            yAxis: [
					                {
					                    type: 'value'
					            }
					        ],
					            series: [
					                {
					                    type: 'line',
					                    smooth: true,
					                    itemStyle: {
					                        normal: {
					                            areaStyle: {
					                                type: 'default'
					                            }
					                        }
					                    },
					                    data: wireCount
					            }
					        ]
					        });
						}
					}
					
			});
        
        }
         
        
         
    </script>
		
	</head>
	<body>
                <!-- 数据 -->
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="dashboard_graph">

                            <div class="row x_title">
                                <div class="col-md-6">
                                    <h3>最近七天销毁量 </h3>
                                </div>
                                <div class="col-md-6">
                                    <div id="reportrange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
                                        <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                                        <span>2015-10-1 - 2015-10-7</span> <b class="caret"></b>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div id="placeholder33" style="height: 260px; display: none" class="demo-placeholder"></div>
                                <div   style="width: 100%;">
                                    <div id="wire"  class="demo-placeholder" ></div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                
                <br/>
	</body>
</html>