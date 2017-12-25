<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>部门信息管理</title>

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
                   		<div class="col-md-6 col-sm-6 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Basic Tables <small>basic table subtitle</small></h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                        <li class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                            <ul class="dropdown-menu" role="menu">
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
                                                <th>部门名称</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:forEach var="department" varStatus="s"  items="${list}">
                                        		<tr>
	                                        		<td>
	                                        			<c:out value="${s.index+1}" escapeXml="true"></c:out>
	                                        			<input type="hidden" value="${department.id}">
	                                        		</td>
	                                        		<td><c:out value="${department.bmName}" escapeXml="true"></c:out></td>
	                                        		<td>
	                                        			<button class="btn btn-success" onclick="getBM(${department.id})">修改</button>
	                                        			<button  class="btn btn-primary" onclick="deleteBM(${department.id})">删除</button>
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
					<div class="row addClasses" id="addClasses" style="display:none" >
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>部门添加</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                                        </li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
                                    <form id="demo-form2"  class="form-horizontal form-label-left">

                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">部门名称 <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="first-name " required="required" class="form-control col-md-7 col-xs-12 bm_name">
                                            </div>
                                        </div>
                                        <div class="ln_solid"></div>
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                            	<button type="submit" class="btn btn-success" onclick="addDepartment()">Submit</button>
                                                <button  class="btn btn-primary" onclick="addClose()">Cancel</button>
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
					<div class="row addClasses" id="updateClasses" style="display: none" >
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>部门修改</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                                        </li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br />
                                    <form id="demo-form2"  class="form-horizontal form-label-left">

                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">部门名称 <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="first-name " required="required" class="form-control col-md-7 col-xs-12 bm_name_udate">
                                                <input type="hidden" class="id_update" value=""/>
                                            </div>
                                        </div>
                                        <div class="ln_solid"></div>
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                            	<button type="submit" class="btn btn-success" onclick="updateDepartment()">Submit</button>
                                                <button  class="btn btn-primary" onclick="updateClose()">Cancel</button>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
				<!-- 添加form -->
				



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


		function addDepartment(){
				var name=$(".bm_name").val();
				$.ajax({
					url:"addDepartment.do",
					method: "POST",
					data:"bm_name="+name,
					cache: false,
					success:function(data){
						$("#addClasses").css("display","none");
						window.location.href="http://localhost:8080/center/listAllDepartment.do";
					}
				});
  		}
  	
  		function deleteBM(id){
			$.ajax({
				url:"removeDepartment.do",
				method: "POST",
				data:"bm_id="+id,
				cache: false,
				success:function(data){
					window.location.href="http://localhost:8080/center/listAllDepartment.do";
				}
			});
  		}
  		function getBM(id){
		  		var divcss = {
			  	  display:''
				};
  			$.ajax({
				url:"getDepartmentById.do",
				method: "POST",
				data:"bm_id="+id,
				cache: false,
				success:function(data){
					$("#updateClasses").css(divcss);
					$(".bm_name_udate").val(data.pojo.bmName);
					$(".id_update").val(data.pojo.id);
				}
			});
  		}
		
		
		function updateDepartment(){
			var name=$(".bm_name_udate").val();
			var id=$(".id_update").val();
			  $.ajax({
				url:"updateDepartment.do",
				method: "POST",
				data:"name="+name+"&id="+id,
				cache: false,
				success:function(data){
					$("#updateClasses").css("display:none");
					window.location.href="http://localhost:8080/center/listAllDepartment.do";
				}
			});
		}
		
		function updateClose(){
			$("#updateClasses").css("display:none");
		}
		function addClose(){
			$("#addClasses").css("display","none");
		}
	
	</script>

</body>
</html>