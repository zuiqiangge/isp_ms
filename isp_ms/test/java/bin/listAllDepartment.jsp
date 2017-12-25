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
                   		<div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2><small>列表</small></h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                            <ul class="dropdown-menu" role="menu">
                                                <li><a href="#" onclick="addShou()">添加</a>
                                                </li>
                                            </ul>
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
	                                        			<button class="btn btn-round btn-primary" onclick="getBM(${department.id})">修改</button>
	                                        			<button  class="btn btn-round btn-danger" onclick="deleteBM(${department.id})">删除</button>
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
					  <div id="addClasses" class="modal fade bs-common-edit-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
				             <div class="modal-dialog modal-lg">
				                 <div class="modal-content">
				
				                     <div class="modal-header">
				                         <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
				                         </button>
				                         <h4 class="modal-title" >
				                        部门添加</h4>
				                     </div>
                                 <div class="modal-body">
                                    <form id="demo-form2"  class="form-horizontal form-label-left">

                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">部门名称 <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="first-name " required="required" class="form-control col-md-7 col-xs-12 bm_name">
                                            </div>
                                        </div>

                                    </form>
                                </div>
                                <div class="modal-footer">
			                     	 <input name="msg" type="hidden" />
			                     	 <button type="button" class="btn btn-success"  onclick="addDepartment()">保存</button>
			                         <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
			                     </div>
                            </div>
                        </div>
                    </div>
				<!-- 添加form -->
				
				
				<!-- END PAGE TABLE-->
					<!-- 修改form -->
					<div id="updateClasses" class="modal fade bs-common-edit-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
				             <div class="modal-dialog modal-lg">
				                 <div class="modal-content">
				
				                     <div class="modal-header">
				                         <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
				                         </button>
				                         <h4 class="modal-title" >
				                        	部门修改
				                         </h4>
				                     </div>
                                 <div class="modal-body">
                                    <form    class="form-horizontal form-label-left">
                                    
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">部门名称 <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="first-name " required="required" class="form-control col-md-7 col-xs-12 bm_name_udate">
                                                <input type="hidden" class="id_update" value=""/>
                                            </div>
                                        </div>
                                    </form>
                                    </div>
                                <div class="modal-footer">
			                     	 <input name="msg" type="hidden" />
			                     	 <button type="button" class="btn btn-success"  onclick="updateDepartment()">保存</button>
			                         <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
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
		    $("#addClasses").modal();
	}


		function addDepartment(){
				var name=$(".bm_name").val();
				$.ajax({
					url:"addDepartment.do",
					method: "POST",
					data:"bm_name="+name,
					cache: false,
					success:function(data){
						$("#addClasses").modal("hide");
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
					$("#updateClasses").modal();
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
					$("#updateClasses").modal("hide");
					window.location.href="http://localhost:8080/center/listAllDepartment.do";
				}
			});
		}
		
		function updateClose(){
			$("#updateClasses").modal("hide");
		}
		function addClose(){
			$("#addClasses").modal("hide");
		}
	
	</script>

</body>
</html>