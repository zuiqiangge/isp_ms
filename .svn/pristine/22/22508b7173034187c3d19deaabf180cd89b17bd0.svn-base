<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>职位信息管理</title>

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
		<script type="text/javascript">
	function addShou(){
		 $("#addPosition").modal();
	}
	function addPosition(){
		var name=$(".addPosition_name").val();
		var id=$("#addPosition_BMid").val();
		$("#select_id option")
		$.ajax({
			url:"addPosition.do",
			data:"name="+name+"&id="+id,
			method:"POST",
			success:function(data){
				 $("#addPosition").modal("hide");
				 window.location.href="http://localhost:8080/center/listAllPosition.do";
			}
		})
	}
	function delPosition(id){
		$.ajax({
			url:"removePosition.do",
			data:"id="+id,
			method:"POST",
			success:function(data){
				window.location.href="http://localhost:8080/center/listAllPosition.do";
			}
		})
	}
	
	function getPosition(id){
		$("#getPosition").modal();
		$.ajax({
			url:"getPositionById.do",
			data:"id="+id,
			method:"POST",
			success:function(data){
				$(".positionsName_update").val(data.pojo.name);
				$(".p_id").val(data.pojo.id);
				var bmid=data.pojo.department.id;
				  $("#select_id option").each(function (){  
           				var val = $(this).val();
           				if(val==bmid){
           					$("#select_id").find("option[value="+bmid+"]").attr("selected",true);
           				}
           			});
			}
		})
	}
	function updatePosition(){
			var name=$(".positionsName_update").val();
			var bmId=$('#select_id option:selected').val();
			var id=$(".p_id").val();
		$.ajax({
			url:"updatePosition.do",
			data:"name="+name+"&bmId="+bmId+"&id="+id,
			method:"POST",
			success:function(data){
				$("#getPosition").modal("hide");
				window.location.href="http://localhost:8080/center/listAllPosition.do";
			}
		})
	}
	function addClose(){
		$("#addPosition").modal("hide");
	}
	function updateClose(){
		$("#getPosition").modal("hide");
	}
	
	</script>
		
		
	</head>

<body class="nav-md">
  					<div class="row" id="classesList">
                        <div class="col-md-12 col-sm-12 col-xs-12" id="listClasses">
                            <div class="x_panel" >
                                <div class="x_title">
                                    <h2>职位管理 </h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li class="dropdown">
                                            <a href="#" class="dropdown-toggle" ><i class="fa fa-wrench"></i></a>
                                            <ul class="dropdown-menu" >
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
                                                <th>职位名称</th>
                                                <th>所属部门</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:forEach var="position" varStatus="s"  items="${list}">
                                        		<tr>
	                                        		<td><c:out value="${s.index+1}" escapeXml="true"></c:out></td>
	                                        		<td><c:out value="${position.name}" escapeXml="true"></c:out></td>
	                                        		<td><c:out value="${position.department.bmName}" escapeXml="true"></c:out></td>
	                                        		<td>
	                                        			<input type="hidden" value="${position.id}" >
														<button class="btn btn-round btn-primary" onclick="getPosition(${position.id})">修改</button>
                                                		<button class="btn btn-round btn-danger" onclick="delPosition(${position.id})">删除</button>
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
					  <div id="addPosition" class="modal fade bs-common-edit-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
				             <div class="modal-dialog modal-lg">
				                 <div class="modal-content">
				
				                     <div class="modal-header">
				                         <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
				                         </button>
				                         <h4 class="modal-title" >
				                        添加职位</h4>
				                     </div>
                                 <div class="modal-body">
                                    <form id="demo-form2"  class="form-horizontal form-label-left">

                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12 " for="first-name" >职位名称 <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="first-name" required="required" class="form-control col-md-7 col-xs-12 addPosition_name">
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">部门名称&nbsp;</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <select id="addPosition_BMid" class="form-control col-md-7 col-xs-12" >
                                  					<c:forEach var="list" varStatus="s" items="${bmList}">
			                                    		<option value="${list.id}">${list.bmName}</option>
			                                    	</c:forEach>
                                        		</select>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                                <div class="modal-footer">
			                     	 <input name="msg" type="hidden" />
			                     	 <button type="button" class="btn btn-success"  onclick="addPosition()">保存</button>
			                         <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
			                     </div>
                            </div>
                        </div>
                    </div>
				<!-- 添加form -->
				
				
			<!-- END PAGE TABLE-->
					<!-- 修改form -->
					<div id="getPosition" class="modal fade bs-common-edit-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
				             <div class="modal-dialog modal-lg">
				                 <div class="modal-content">
				
				                     <div class="modal-header">
				                         <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
				                         </button>
				                         <h4 class="modal-title" >
				                        	修改职位
				                         </h4>
				                     </div>
                                 <div class="modal-body">
                                    <form    class="form-horizontal form-label-left">
                                     
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12 " for="first-name" >职位名称 <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="first-name" required="required" class="form-control col-md-7 col-xs-12 positionsName_update">
                                                <input type="hidden" class="p_id">
                                            </div>
                                        </div>
                                        <div class="form-group bm_name "  >
                                            <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">部门名称&nbsp;</label>
                                        	 <div class="col-md-6 col-sm-6 col-xs-12">
                                        		<select id="select_id"   class="form-control col-md-7 col-xs-12" >
                                  					<c:forEach var="list" varStatus="s" items="${bmList}">
			                                    		<option value="${list.id}">${list.bmName}</option>
			                                    	</c:forEach>
                                        		</select>
                                      		 </div>
                                        </div>
                                    </form>
                                 </div>
                                <div class="modal-footer">
			                     	 <input name="msg" type="hidden" />
			                     	 <button type="button" class="btn btn-success"  onclick="updatePosition()">保存</button>
			                         <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
			                     </div>
                            </div>
                        </div>
                    </div>
				<!-- 修改form -->



            <!-- /page content -->
        </div>

    <div id="custom_notifications" class="custom-notifications dsp_none">
        <ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group">
        </ul>
        <div class="clearfix"></div>
        <div id="notif-group" class="tabbed_notifications"></div>
    </div>
</body>
</html>