<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html>
	<head>
		<title>角色信息管理</title>

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
				 "addUrl": "ajaxAddRole.do"
			    ,"getUrl": "ajaxGetRoleById.do"
			    ,"updateUrl": "ajaxUpdateRole.do"
			    ,"removeUrl": "ajaxRemoveRole.do"
			});
		})
		</script>
	</head>
	<body>

		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						角色列表
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
									<a href="#"  class="addBtn" >新增角色</a>
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
									角色名
								</th>
								<th class="column-title">
									类型
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
							<c:forEach var="role" varStatus="s" items="${list}">
							<c:if test="${role.isSys ne 1 or loginUser.id == 1}">
								<tr class="${s.index mod 2 ==0 ? 'even' : 'odd' } pointer">
								<td class=" ">
									<c:out value="${role.name}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${role.isSys eq 1 ? '系统内置' : '用户定义' }" escapeXml="true"></c:out>
								</td>
								<td class=" last">
										<a href="#" class="btn btn-info btn-xs updateBtn"><i class="fa fa-pencil"></i> 修改 </a>
	                                    <a href="#" class="btn btn-danger btn-xs deleteBtn"><i class="fa fa-trash-o"></i> 删除 </a>
									<input type="hidden" name="id" value="${role.id}" />
								</td>
							</tr>
							</c:if></c:forEach>
						</tbody>
					</table>
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
                        	<input value="角色信息"/>
                         </h4>
                     </div>
                     <div class="modal-body">
                     	<form class="form-horizontal form-label-left">
                             <div class="form-group">
                                 <label>名称</label>
                                 <input type="text" name="name" class="form-control" placeholder="名称">
                             </div>
                             <c:choose>
                             	<c:when test="${loginUser.id eq 1}">
		                             <div class="form-group">
		                                 <label>类型</label>
		                                  <select name="isSys"  class="form-control">
		                                  	<option value="2" >用户定义</option>
		                                 	<option value="1" >系统内置</option>
		                                 </select>
		                             </div>	
                             	</c:when>
                             	<c:otherwise>
                             	  <input name="isSys"  type="hidden" value="2" />
                             	</c:otherwise>
                             </c:choose>
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