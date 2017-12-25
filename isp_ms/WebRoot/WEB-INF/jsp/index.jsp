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
            	
				destroyTypeBarPie(start.format('YYYY-MM-DD') ,end.format('YYYY-MM-DD'));
				
				carBar(start.format('YYYY-MM-DD') ,end.format('YYYY-MM-DD'));
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
		
		$.ajax({
			url:"ajaxListDestroys.do"
			,success:function(list){
				$.each(list,function(i,destroyTask){
					$("#lastDestroysList").append(
						' <div>'
                        +'      <p>'+destroyTask.apply.contactUnit+'，'+destroyTask.apply.contacts+'</p>'
                         +'      <div class="">'
                         +'          <div class="progress progress_sm" style="width: 76%;">'
                         +'              <div class="progress-bar bg-green" role="progressbar"  style="width: '+(destroyTask.stateType==2?100:50)+'%;"></div>'
                         +'          </div>'
                         +'      </div>'
                         +'  </div>'
					);
				});
			}
		});
		
		destroyWire(moment().subtract(7, 'days').format('YYYY-MM-DD') ,moment().format('YYYY-MM-DD'));
		
		destroyTypeBarPie(moment().subtract(7, 'days').format('YYYY-MM-DD'),moment().format('YYYY-MM-DD'));
		
		carBar(moment().subtract(7, 'days').format('YYYY-MM-DD'),moment().format('YYYY-MM-DD'));
		
		
		$.ajax({
			url:"ajaxCountData.do"
			,success:function(data){
				 $.each(data,function(i,d){
				 	$(".sysCountInfo .tile_stats_count:eq("+i+") .count").html(d[0]);
				 	$(".sysCountInfo .tile_stats_count:eq("+i+") .count_bottom .green").html('<i class="fa fa-sort-asc"></i>'+((d[1]/d[0])*100).toFixed(2)+"%");;
				 });
			}
		});
		
		
        function destroyTypeBarPie(date,time){
        	var bing = echarts.init(document.getElementById('bing'), theme);
        	var pieType=[];
        	var pieSum=[];
        	var barData=[];
        	var text="时间："+date+" ~ "+time;
        		$.ajax({
					url:"echartsPie.do",
					method: "POST",
					data:"date="+date+"&time="+time,
					cache: false,
					success:function(data){
						if(data!=null){
							var pieList=data;
							for(var i=0;i<pieList.length;i++){
								if(pieList[i][0]==0){
	                    	 		pieList[i][0]="纸介质";
	                    	 	}else if(pieList[i][0]==1){
	                    	 		pieList[i][0]="U盘";
	                    	 	}else if(pieList[i][0]==2){
	                    	 		pieList[i][0]="移动硬盘";
	                    	 	}else if(pieList[i][0]==3){
	                    	 		pieList[i][0]="光盘";
	                    	 	}else if(pieList[i][0]==4){
	                    	 		pieList[i][0]="其它磁介质";
	                    	 	}
								pieType.push(pieList[i][0]);
								pieSum.push(pieList[i][1]);
							}
						 var index =0 ;
						 var pieData = [] ; 
						 
                    	 for(var m=0;m<pieList.length;m++){
                    	 	var type = pieList[m][0];
                    	 	if(pieList[m][0]==0){
                    	 		pieList[m][0]="纸介质";
                    	 	}else if(pieList[m][0]==1){
                    	 		pieList[m][0]="U盘";
                    	 	}else if(pieList[m][0]==2){
                    	 		pieList[m][0]="移动硬盘";
                    	 	}else if(pieList[m][0]==3){
                    	 		pieList[m][0]="光盘";
                    	 	}else if(pieList[m][0]==4){
                    	 		pieList[m][0]="其它磁介质";
                    	 	}
                    	 	
                    	  	pieData[ index++ ] = {  name: pieList[m][0]   , value: pieList[m][1]  } 
                    	  	//alert(pieData[m].name);
                    	 }
				       bing.setOption({
				      		title: {
			                text: '销毁物品类型',
			                subtext: text
			            	},
			            	tooltip: {
				                trigger: 'item',
				                formatter: "{a} <br/>{b} : {c} ({d}%)"
				            },
				            legend: {
				                x: 'center',
				                y: 'bottom',
				                data: pieType
				            },
				            toolbox: {
				                show: true,
				                feature: {
				                    magicType: {
				                        show: true,
				                        type: ['pie', 'funnel']
				                    },
				                    restore: {
				                        show: true
				                    },
				                    saveAsImage: {
				                        show: true
				                    }
				                }
				            },
				            calculable: true,
				            series: [
				                {
				                    type: 'pie',
				                    radius: [25, 90],
				                    center: ['50%', 170],
				                    roseType: 'area',
				                    x: '50%', // for funnel
				                    max: 40, // for funnel
				                    sort: 'ascending', // for funnel
				                    data:pieData
				                    
				            }
				        ]
				        });
							
						}
					}
				});
        	
        }
        
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
        
        function carBar(date,time){
        	var bar = echarts.init(document.getElementById('bar'), theme);
        	var car_no=[];
        	var car_number=[];
        	var car_data=[];
        	var car_num=[];
        	var text="时间："+date+" ~ "+time;
        	$.ajax({
					url:"echartsBar.do",
					method: "POST",
					data:"date="+date+"&time="+time,
					cache: false,
					success:function(data){
						var index=0;
						if(data!=null){
							for(var i=0;i<data.length;i++){
								car_no.push(data[i][0]);
								car_number.push(data[i][1]);
								var d = [];
								for(var j=0;j<i;j++){
									d.push(0);
								}
								d.push( data[i][1] );
								car_data[ index++ ] = { 
														name: data[i][0],
							                   			type: 'bar',
							                   			stack: 'asf',
							                   			itemStyle : { normal: {label : {formatter:" xxx "}}},
							                    		data:  d
								 						} 
							}
		       bar.setOption({
	            title: {
	                text: '车辆调度数量统计图',
	                subtext: text
	            },
	            //theme : theme,
	            tooltip: {
	                trigger: 'axis'
	            },
	            legend: {
	                data: car_no
	            },
	            toolbox: {
	                show: false
	            },
	            calculable: false,
	            xAxis: [
	                {
	                    type: 'category',
	                    data: car_no
	            }
	        ],
	            yAxis: [
	                {
	                    type: 'value'
	            }
	        ],
	            series: car_data/*[ 
	            	{ 
	            		name: "量",
                 		type: 'bar',
                  		data:  car_number
					 } 
					 
				]*/
	        });
						}
					}
        	})
 	}
                    
        
        
         
    </script>
		
	</head>
	<body>
		<div class="row tile_count sysCountInfo">
                    <div class="animated flipInY col-md-3 col-sm-6 col-xs-6 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> 申请记录总数量</span>
                            <div class="count">加载中......</div>
                            <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>加载中...... </i> 来至七天内</span>
                        </div>
                    </div>
                    <div class="animated flipInY col-md-3 col-sm-6 col-xs-6 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-clock-o"></i> 销毁记录总数量</span>
                            <div class="count">加载中......</div>
                             <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>加载中...... </i> 来至七天内</span>
                        </div>
                    </div>
                    <div class="animated flipInY col-md-3 col-sm-6 col-xs-6  tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> 销后记总量(kg)</span>
                            <div class="count green">加载中......</div>
                             <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>加载中...... </i> 来至七天内</span>
                        </div>
                    </div>
                    <div class="animated flipInY col-md-3  col-sm-6 col-xs-6 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> 派车记录总数量 </span>
                            <div class="count">加载中......</div>
                             <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>加载中...... </i> 来至七天内</span>
                        </div>
                    </div>
                </div>
                
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

                            <div class="col-md-9 col-sm-9 col-xs-12">
                                <div id="placeholder33" style="height: 260px; display: none" class="demo-placeholder"></div>
                                <div   style="width: 100%;">
                                    <div id="wire"  class="demo-placeholder" ></div>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-3 col-xs-12 bg-white">
                                <div class="x_title">
                                    <h2>最近销毁记录</h2>
                                    <div class="clearfix"></div>
                                </div>

                                <div id="lastDestroysList" class="col-md-12 col-sm-12 col-xs-6">
                                     
                                </div>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                
                <br/>
                
           <div class="row">

                    <div class="col-md-4 col-sm-4 col-xs-12">
                        <div class="x_panel  tile ">
                           <div class="x_title">
                               <h2>最近七天销毁物品类型饼状图</h2>
                               <ul class="nav navbar-right panel_toolbox">
                               </ul>
                               <div class="clearfix"></div>
                           </div>
                           <div class="x_content">

                               <div id="bing" style="height: 350px;"  ></div>

                           </div>
                       </div>
                    </div>

                    <div class="col-md-8 col-sm-8 col-xs-12">
                        <div class="x_panel tile overflow_hidden">
                                <div class="x_title">
                                    <h2>最近七天车辆调度量统计图</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">

                                    <div id="bar" style="height:350px;"></div>

                                </div>
                         </div>
                    </div>
                    
                </div>     
	</body>
</html>