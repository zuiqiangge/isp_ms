<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>班次信息管理</title>

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
	</head>

<body class="nav-md">
  					<div class="row" id="classesList">
                        <div class="col-md-6 col-sm-6 col-xs-12" id="listClasses">
                            <div class="x_panel" >
                                <div class="x_title">
                                    <h2>排班管理 </h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                        <li class="dropdown">
                                            <a href="#" class="dropdown-toggle" ><i class="fa fa-wrench"></i></a>
                                            <ul class="dropdown-menu" >
                                                <li><a href="#" onclick="addShou()">添加</a>
                                                </li>
                                                <li><a href="#">导入</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                                        </li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>序号</th>
                                                <th>班次名称</th>
                                                <th>上班时间</th>
                                                <th>下班时间</th>
                                                <th>班次类型</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:forEach var="classes" varStatus="s"  items="${pojo}">
                                        		<tr>
	                                        		<td><c:out value="${s.index+1}" escapeXml="true"></c:out></td>
	                                        		<td><c:out value="${classes.name}" escapeXml="true"></c:out></td>
	                                        		<td><c:out value="${classes.start_time}" escapeXml="true"></c:out></td>
	                                        		<td><c:out value="${classes.end_time}" escapeXml="true"></c:out></td>
	                                        		<td><c:out value="${classes.type}" escapeXml="true"></c:out></td>
	                                        		<td>
	                                        			<input type="hidden" value="${classes.id}" >
														<button class="btn btn-success" onclick="getClasses(${classes.id})">Update</button>
                                                		<button class="btn btn-primary" onclick="delClasses(${classes.id})">Delete</button>
													</td>
	                                        	</tr>
                                        	</c:forEach>
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>

			<!-- END PAGE TABLE-->
					<!-- 添加form -->
					<div class="row addClasses" id="addClasses" style="display:none;">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>添加班次</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li>
                                        	<a class="close-link"><i class="fa fa-close"></i></a>
                                        </li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
                                    <form id="demo-form2"  class="form-horizontal form-label-left">

                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12 " for="first-name" >班次名称 <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="first-name" required="required" class="form-control col-md-7 col-xs-12 classesName">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12 " for="last-name">上班时间 <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="last-name" name="last-name" required="required" class="form-control col-md-7 col-xs-12 classesStartTime">
                                            </div>
                                        </div>
                                       <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">下班时间 <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input id="birthday" class="date-picker form-control col-md-7 col-xs-12 classesEndTime" required="required" type="text">
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">班次类型&nbsp;</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input id="middle-name" class="form-control col-md-7 col-xs-12 classesType" type="text" name="middle-name">
                                            </div>
                                        </div>

                                        <div class="ln_solid"></div>
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                           	 	<button type="submit" class="btn btn-success" onclick="addClasses()">Submit</button>
                                                <button type="submit" class="btn btn-primary" onclick="addClose()" >Cancel</button>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
				<!-- 添加form -->
				
				
			<!-- END PAGE TABLE-->
					<!-- 修改form -->
					<div class="row addClasses" id="updateClasses" style="display:none;">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>修改班次</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li>
                                        	<a class="close-link"><i class="fa fa-close"></i></a>
                                        </li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
                                    <form id="demo-form2"  class="form-horizontal form-label-left">

                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12 " for="first-name" >班次名称 <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="first-name" required="required" class="form-control col-md-7 col-xs-12 classesName_update">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12 " for="last-name">上班时间 <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            	<input type="hidden" class="classes_id"> 
                                                <input type="text" id="last-name" name="last-name" required="required" class="form-control col-md-7 col-xs-12 classesStartTime_update">
                                            </div>
                                        </div>
                                       <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">下班时间 <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input id="birthday" class="date-picker form-control col-md-7 col-xs-12 classesEndTime_update" required="required" type="text">
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">班次类型&nbsp;</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input id="middle-name" class="form-control col-md-7 col-xs-12 classesType_update" type="text" name="middle-name">
                                            </div>
                                        </div>

                                        <div class="ln_solid"></div>
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                           	 	<button type="submit" class="btn btn-success" onclick="updateClasses()">Submit</button>
                                                <button class="btn btn-primary" onclick="updateClose()">Cancel</button>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
				<!-- 修改form -->



            <!-- /page content -->
        </div>

    </div>

    <div id="custom_notifications" class="custom-notifications dsp_none">
        <ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group">
        </ul>
        <div class="clearfix"></div>
        <div id="notif-group" class="tabbed_notifications"></div>
    </div>

    <script src="js/bootstrap.min.js"></script>

    <!-- chart js -->
    <script src="js/chartjs/chart.min.js"></script>
    <!-- bootstrap progress js -->
    <script src="js/progressbar/bootstrap-progressbar.min.js"></script>
    <script src="js/nicescroll/jquery.nicescroll.min.js"></script>
    <!-- icheck -->
    <script src="js/icheck/icheck.min.js"></script>

    <script src="js/custom.js"></script>
	
	<script type="text/javascript">
	function addShou(){
		 $("#addClasses").css("display","");
	}
	function addClasses(){
		var name=$(".classesName").val();
		var startTime=$(".classesStartTime").val();
		var endTime=$(".classesEndTime").val();
		var type=$(".classesType").val();
		$.ajax({
			url:"addClasses.do",
			data:"name="+name+"&startTime="+startTime+"&endTime="+endTime+"&type="+type,
			method:"POST",
			success:function(data){
				$("#addClasses").css("display","none");
			}
		})
	}
	function delClasses(id){
		$.ajax({
			url:"delClasses.do",
			data:"id="+id,
			method:"POST",
			success:function(data){
				alert("删除成功");
			}
		})
	}
	
	function getClasses(id){
		$("#updateClasses").css("display","");
		$.ajax({
			url:"getClasses.do",
			data:"id="+id,
			method:"POST",
			success:function(data){
				$(".classesName_update").val(data.pojo.name);
				$(".classesStartTime_update").val(data.pojo.start_time);
				$(".classesEndTime_update").val(data.pojo.end_time);
				$(".classesType_update").val(data.pojo.type);
				$(".classes_id").val(id);
			}
		})
	}
	function updateClasses(){
			var name=$(".classesName_update").val();
			var startTime=$(".classesStartTime_update").val();
			var endTime=$(".classesEndTime_update").val();
			var type=$(".classesType_update").val();
			var id=$(".classes_id").val();
		$.ajax({
			url:"updateClasses.do",
			data:"name="+name+"&startTime="+startTime+"&endTime="+endTime+"&type="+type+"&id="+id,
			method:"POST",
			success:function(data){
				$("#updateClasses").css("display","none");
			}
		})
	}
	
	function updateClose(){
		$("#updateClasses").css("display","none");
	}
	
	function addClose(){
		$("#addClasses").css("display","none");
	}
	
	</script>

</body>
</html>