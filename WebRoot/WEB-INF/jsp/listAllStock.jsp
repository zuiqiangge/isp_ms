<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html>
	<head>
		<title>卸车入库</title>

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
		
		 <!-- daterangepicker -->
		 <script src="js/input_mask/jquery.inputmask.js"></script>
		<script type="text/javascript" src="js/moment.min2.js"></script>
		<script type="text/javascript" src="js/datepicker/daterangepicker.js"></script>
		
		<!-- easyui -->
	
		<script type="text/javascript">
		
		
		$(function(){
			CommonCud.init({
				 "addUrl": "ajaxAddStock.do"
			    ,"getUrl": "ajaxGetStockById.do"
			    ,"updateUrl": "ajaxUpdateStock.do"
			    ,"removeUrl": "ajaxRemoveStock.do"
			});
			$(":input").inputmask();
				var inputDate = '';
				$('#reservation').daterangepicker({
					locale:myLocales.zh
					,singleDatePicker: true
					,format: 'YYYY/MM/DD'
				}, function (start, end, label) {
	            });
	             $(".daterangepicker.dropdown-menu").css({"zIndex": 99999});
			
		})
		
	    function showHid(){
	      $("#hid").append("<input type='hidden' name='id'/>");
	      
	     
	    }
	    
		/*function insertStock(){
		var contactUnit=$("#contactUnit").val();
		var type=$("#type").val();
		var num=$("#num").val();
		var stockDate=$("#stockDates").val();
		var batch=$("#batch").val();
		var userId=$("#userId").val();
		var orders=$("#orders").val();

		$.ajax({
			url:"ajaxAddStock.do",
			data:"contactUnit="+contactUnit+"&type="+type+"&num="+num+"&stockDate="+stockDate+"&batch="+batch+"&userId="+userId+"&orders="+orders,
			method:"POST",
			success:function(data){
				 $("#insertStock").modal("hide");
				 window.location.href="http://localhost:8080/destroy_center/listAllStockByOrder.do";
			}
		})
	}*/
		
		
		function aa(order){
			$("#insertStock").modal();
			$("#orders").val(order);
			
			
		}
		</script>
	</head>
	<body>

		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					
				<!--条件输入框-->
				<form  class="form-inline" role="form" action="listAllStockByOrder.do">
					人员:<select class="form-control" name="userid">
						<c:forEach var="user" items="${user}">
							
								<option value="${user.id}">${user.nickName}</option>
							
						</c:forEach>
					</select> &nbsp;&nbsp;
					单位名称:<input type="text" class="form-control" id="submitUserId" name="contactUnit"> &nbsp;&nbsp;
					类型:
					<div class="form-group">
		                                 
		                                  <select name="type"  class="form-control">
		                                  	<option value="6">请选择类型</option>
		                                  	<optgroup label="纸介质">
		                                  	  <option value="0">纸介质</option>
		                                  	</optgroup>
                                 	        <optgroup  label="磁介质">
                                 	        	<option value="1">U盘</option>
			                                 	<option value="2">移动硬盘</option>
			                                 	<option value="3">光盘</option>
			                                 	<option value="4">其它磁介质</option>
                                 	        </optgroup>
                                 	        
		                                 	
		                                 </select>
		                             </div>	
					
					&nbsp;&nbsp;
					入库日期:<input type="text" class="form-control" id="reservation" name="stockDates"> &nbsp;&nbsp;
					批次:<input type="text" class="form-control" id="address" name="batch"> &nbsp;&nbsp;
					
					


					
					<button type="submit" class="btn btn-default">检索</button>
					</form>
					
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
									<a href="#"  class="addBtn" >入库</a>
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
					<table
						class="table table-striped responsive-utilities jambo_table bulk_action">
						<thead>
							<tr class="headings">
								<th class="column-title">
									RFID号
								</th>
								<th class="column-title">
									单位
								</th>
								
								<th class="column-title">
									类型
								</th>
								<th class="column-title">
									数量/重量
								</th>
								<th class="column-title">
									入库日期
								</th>
								<th class="column-title">
									批次
								</th>
								<th class="column-title">
									人员
								</th>
								<th class="column-title">
									order
								</th>
								
								<th class="column-title no-link last">
									<span class="nobr">操作</span>
								</th>
								<th class="bulk-actions" colspan="7">
									<a class="antoo" style="color: #fff; font-weight: 500;">Bulk
										Actions ( <span class="action-cnt"> </span> ) <i
										class="fa fa-chevron-down"></i>
									</a>
								</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="stock" varStatus="s" items="${list}">
							
								<tr class="${s.index mod 2 ==0 ? 'even' : 'odd' } pointer">
								<td class=" ">
									<c:out value="${stock.id}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${stock.contactUnit}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${stock.type}" escapeXml="true"></c:out>
								</td>
								
								<td class=" ">
									<c:out value="${stock.num}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${stock.stockDate}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${stock.batch}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${stock.userId}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${stock.orders}" escapeXml="true"></c:out>
								</td>
								
								
								
								
								
								<!--<td class=" ">
									<c:out value="${role.isSys eq 1 ? '系统内置' : '用户定义' }" escapeXml="true"></c:out>
								</td>
								--><td class=" last">
										<a href="javascript:void(0)" class="btn btn-info btn-xs updateBtn" onclick="showHid()"><i class="fa fa-pencil"></i> 修改 </a>
	                                    <a href="#" class="btn btn-danger btn-xs deleteBtn"><i class="fa fa-trash-o"></i> 删除 </a>
	                                    <a href="#" class="btn btn-info btn-xs" onclick="aa(${stock.orders})"><i class="fa fa-pencil"></i> 插入 </a>
	                                    <a href="#" class="btn btn-danger btn-xs deleteBtn"><i class="fa fa-trash-o"></i> 复制 </a>
									<input type="hidden" name="id" value="${stock.id}" />
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div> 
		
		<a href="listAllStock.do">排序</a>
		
		<!-- 单个数据操作对话框  添加-->
		<div id="addStock" class="modal fade bs-common-edit-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
             <div class="modal-dialog modal-lg">
                 <div class="modal-content">

                     <div class="modal-header">
                         <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                         </button>
                             <h4 class="modal-title" >
                        	<input value="入库信息"/>
                         </h4>
                     </div>
                     <div class="modal-body">
                     	<form class="form-horizontal form-label-left">
                             <div class="form-group">
                                 <label>客户</label>
                                 <input type="text" name="contactUnit" id="contactUnit" class="form-control" placeholder="客户">
                             </div>
                             
		                             <div class="form-group">
		                                 <label>类型</label>
		                                  <select name="type" id="type"  class="form-control">
		                                  	
		                                  	<optgroup label="纸介质">
		                                  	  <option value="0">纸介质</option>
		                                  	</optgroup>
                                 	        <optgroup  label="磁介质">
                                 	        	<option value="1">U盘</option>
			                                 	<option value="2">移动硬盘</option>
			                                 	<option value="3">光盘</option>
			                                 	<option value="4">其它磁介质</option>
                                 	        </optgroup>
                                 	        
		                                 	
		                                 </select>
		                             </div>	
                             	
                             	
                             <div class="form-group">
                                 <label>数量/重量</label>
                                 <input type="text" name="num" id="num" class="form-control" placeholder="数量/重量">
                                 
                             </div>
                             
                          <div class="form-group">
								<label>
									入库日期：
								</label>
								
								<input name="stockDate" type="date" id="stockDate" id="reservation6" class="form-control active">
							</div>
							
                               <div class="form-group">
                                 <label>批次</label>
                                
                                 <input type="text" name="batch" id="batch" class="form-control" placeholder="批次">
                             </div>
                               <div class="form-group">
                                 <label>人员</label>
                                 <select name="userId" id="userId"  class="form-control">
                                 	<c:forEach var="user" items="${user}">
                                 	<option value="${user.id}">${user.nickName}</option></c:forEach>
                                 </select>
                             </div>
                            <span id="hid"></span>
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
         
        <!-- END PAGE TABLE-->
					<!-- 插入form -->
					 		 <div id="insertStock" style="display: none;" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
				             <div class="modal-dialog modal-lg">
				                 <div class="modal-content">
				
				                     <div class="modal-header">
				                         <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
				                         </button>
				                         <h4 class="modal-title" >
				                        插入入库信息</h4>
				                     </div>
                                 <div class="modal-body">
                                    <form id="demo-form2" action="addStock.do" method="POST"  class="form-horizontal form-label-left">
                                       
                                         	
                                                                  
                                        <div class="form-group">
                                 <label>客户</label>
                                 <input type="text" name="contactUnit" id="contactUnit" class="form-control" placeholder="客户">
                             </div>
                             
		                             <div class="form-group">
		                                 <label>类型</label>
		                                  <select name="type" id="type"  class="form-control">
		                                  	
		                                  	<optgroup label="纸介质">
		                                  	  <option value="0">纸介质</option>
		                                  	</optgroup>
                                 	        <optgroup  label="磁介质">
                                 	        	<option value="1">U盘</option>
			                                 	<option value="2">移动硬盘</option>
			                                 	<option value="3">光盘</option>
			                                 	<option value="4">其它磁介质</option>
                                 	        </optgroup>
                                 	        
		                                 	
		                                 </select>
		                             </div>	
                             	
                             	
                             <div class="form-group">
                                 <label>数量/重量</label>
                                 <input type="text" name="num" id="num" class="form-control" placeholder="数量/重量">
                                 
                             </div>
                             
                          <div class="form-group">
								<label>
									入库日期：
								</label>
								
								<input name="stockDate" type="date" id="stockDates" class="form-control active">
							</div>
							
                               <div class="form-group">
                                 <label>批次</label>
                                
                                 <input type="text" name="batch" id="batch" class="form-control" placeholder="批次">
                             </div>
                               <div class="form-group">
                                 <label>人员</label>
                                 <select name="userId" id="userId"  class="form-control">
                                 	<c:forEach var="user" items="${user}">
                                 	<option value="${user.id}">${user.nickName}</option></c:forEach>
                                 </select>
                             </div>
                                        
                                 <input name="orders" type="text" id="orders"/>       
                                  <div class="modal-footer">
			                     	 <input name="msg" type="hidden" />
			                     	 <button type="submit" class="btn btn-success">保存</button>
			                         <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
			                     </div>

                                    </form>
                                </div>
                               
                            </div>
                        </div>
                    </div>
					
	</body>
</html>