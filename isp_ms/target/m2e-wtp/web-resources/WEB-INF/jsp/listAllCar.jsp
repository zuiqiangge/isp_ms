<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html>
	<head>
		<title>车辆信息管理</title>

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
		$(function(){
			CommonCud.init({
				 "addUrl": "ajaxAddCar.do"
			    ,"getUrl": "ajaxGetCarById.do"
			    ,"updateUrl": "ajaxUpdateCar.do"
			    ,"removeUrl": "ajaxRemoveCar.do"
			});
		})
		</script>
	</head>
	<body>
 	
        
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						车辆列表
					</h2>
			 		<ul class="nav navbar-right panel_toolbox">
						<!--
						<li>
							<a class="collapse-link"><i class="fa fa-chevron-up"></i>
							</a>
				  		</li>
				  		-->
						<li class="dropdown">
							
							<a href="#" class="dropdown-toggle" data-toggle="dropdown"
								role="button" aria-expanded="false"><i class="fa fa-wrench"></i>
							</a>
							<ul class="dropdown-menu" role="menu">
								<li>
									<a href="#"  class="addBtn" >新增车辆</a>
								</li>
							</ul>
						</li><!--
						<li> 
							<a class="close-link"><i class="fa fa-close"></i>
							</a>
						</li>-->
					</ul>
					<div class="clearfix"></div>
				</div>

				<div class="x_content">
				  <div class="row">
				  <c:forEach var="car" varStatus="s" items="${list}">
                         <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                             <div class="tile-stats">
                                 <div class="icon"><i class="fa fa-automobile"></i>
                                 </div>
                                 <div class="count"><c:out value="${car.carNo}" escapeXml="true"></c:out></div>
                                 <h3 class="txt_roleId" ><c:out value="${car.useUser}" escapeXml="true"></c:out></h3>
                                 <p>
										<a href="#" class="btn btn-info btn-xs updateBtn"><i class="fa fa-pencil"></i> 修改 </a>
	                                    <a href="#" class="btn btn-danger btn-xs deleteBtn"><i class="fa fa-trash-o"></i> 删除 </a>
										<input type="hidden" name="id" value="${car.id}" />
										<input type="hidden" name="id" value="${car.useUserId}" />
								 </p>
                             </div>
                         </div></c:forEach>
				</div>
			</div>
		</div> 
		<!-- 单个数据操作对话框 -->
		<div class="modal fade bs-common-edit-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
             <div class="modal-dialog modal-lg">
                 <div class="modal-content">

                     <div class="modal-header">
                         <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                         </button>
                         <h4 class="modal-title" >
                        	<input value="车辆信息"/>
                         </h4>
                     </div>
                     <div class="modal-body">
                     	<form class="form-horizontal form-label-left">
                             <div class="form-group">
                                 <label>车辆简介</label>
                                 <input type="text" name="description" class="form-control" placeholder="简介">
                             </div>
                             <div class="form-group">
                                 <label>车牌</label>
                                 <input type="text" name="carNo" class="form-control" placeholder="车牌">
                             </div>
                             <div class="form-group">
                                 <label>司机</label>
                                <input type="text" name="useUser" class="form-control" placeholder="司机">
                             </div>
                             <input name="id" type="hidden" />
                         </form>
                     </div>
                     <div class="modal-footer">
                     	 <input name="msg" type="hidden" />
                     	 <button type="button" class="btn btn-success">保存</button>
                         <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                     </div>
                 </div> 
             </div>
         </div>
	</body>
</html>