<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html>
	<head>
		<title>已派车列表</title>

		<div id="custom_notifications" class="custom-notifications dsp_none">
			<ul class="list-unstyled notifications clearfix"
				data-tabbed_notifications="notif-group">
			</ul>
			<div class="clearfix"></div>
			<div id="notif-group" class="tabbed_notifications"></div>
		</div>

		<!-- chart js -->
		<script src="js/chartjs/chart.min.js"></script>
		<!-- bootstrap progress js -->
		<script src="js/progressbar/bootstrap-progressbar.min.js"></script>
		<script src="js/nicescroll/jquery.nicescroll.min.js"></script>
		<!-- icheck -->
		<script src="js/icheck/icheck.min.js"></script>
		<script src="js/common-cud.js" type="text/javascript"></script>
		 <script type="text/javascript">
		 function nextPage(){
		 	$($(".applys").html()).appendTo($(".applys"));
		 }	
		 </script>
	</head>
	<body>
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						已派车申请列表
					</h2>
			 		<ul class="nav navbar-right panel_toolbox">
						 
					</ul>
					<div class="clearfix"></div>
				</div>

				<div class="x_content">
				   
				 <ul class="messages applys">
                     <li>
                         <div class="message_date">
                             <h3 class="date text-info">24</h3>
                             <p class="month">9月</p>
                         </div>
                         <div class="message_wrapper">
                             <h4 class="heading">保密局，李全城</h4>
                             <blockquote class="message">备注1：关于什么事放假啊斯蒂芬垃圾是备注的</blockquote>
                             <blockquote class="message">备注2：关于什么事放假啊斯蒂芬垃圾是备注的</blockquote>
                             <blockquote class="message">已安排司机：关于什么事放假啊斯蒂芬垃圾是备注的</blockquote>
                             <blockquote class="message">已安排车辆：关于什么事放假啊斯蒂芬垃圾是备注的</blockquote>
                             <br>
                             <p class="url">
                                <a href="#" class="btn btn-default" >调换</a>
                             </p>
                         </div>
                     </li>
                     <li>
                         <div class="message_date">
                             <h3 class="date text-error">21</h3>
                             <p class="month">9月</p>
                         </div>
                         <div class="message_wrapper">
                             <h4 class="heading">Brian Michaels</h4>
                             <blockquote class="message">Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua butcher retro keffiyeh dreamcatcher synth.</blockquote>
                             <blockquote class="message">Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua butcher retro keffiyeh dreamcatcher synth.</blockquote>
                             <br>
                             <p class="url">
                                  <a href="#" class="btn btn-default" >调换</a>
                             </p>
                         </div>
                     </li>
                     <li>
                         <div class="message_date">
                             <h3 class="date text-info">24</h3>
                             <p class="month">9月</p>
                         </div>
                         <div class="message_wrapper">
                             <h4 class="heading">保密局，李全城</h4>
                             <blockquote class="message">Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua butcher retro keffiyeh dreamcatcher synth.</blockquote>
                             <br>
                             <p class="url">
                              	 <a href="#" class="btn btn-default" >安排</a>
                             </p>
                         </div>
                     </li>
                 </ul>
				</div>
				<div class="row"  style="text-align: center;">
                      <button class="btn" onclick="nextPage()">加载下一页</button>
                </div>
			</div>
		</div> 
	</body>
</html>