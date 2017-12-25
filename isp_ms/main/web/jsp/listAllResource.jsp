<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html>
	<head>
		<title>权限项管理</title>

		<!-- bootstrap progress js -->
		<script src="js/progressbar/bootstrap-progressbar.min.js"></script>
		<script src="js/nicescroll/jquery.nicescroll.min.js"></script>
		<!-- icheck -->
		<script src="js/icheck/icheck.min.js"></script>
		<script src="js/common-cud.js" type="text/javascript"></script>
		<script type="text/javascript">
		$(function(){
			CommonCud.init({
				 "addUrl": "ajaxAddResource.do"
			    ,"getUrl": "ajaxGetResourceById.do"
			    ,"updateUrl": "ajaxUpdateResource.do"
			    ,"removeUrl": "ajaxRemoveResource.do"
			});
		})
		</script>
	</head>
	<body>

		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						权限项列表
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
									<a class="addBtn" href="#">新增权限</a>
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
									名称
								</th>
								<th class="column-title">
									链接路径
								</th>
								<th class="column-title">
									类型
								</th>
								<th class="column-title">
									描述
								</th>
								<th class="column-title">
									上级名称
								</th>
								<th class="column-title no-link last">
									<span class="nobr">操作</span>
								</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="resource" varStatus="s" items="${list}">
							<tr class="${s.index mod 2 ==0 ? 'even' : 'odd' } pointer">
								<td class=" ">
									<c:out value="${resource.name}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${resource.url}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${resource.type eq 1 ? '菜单' : 'ajax功能'}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${resource.remark}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:if test="${resource.parentId ne null}">
										<c:forEach var="temp_resource" varStatus="s" items="${list}">
										<c:if test="${temp_resource.id eq resource.parentId}"><c:out value="${temp_resource.name}" escapeXml="true"></c:out></c:if>
										</c:forEach>
									</c:if>
									<c:if test="${resource.parentId eq null}">无</c:if>
								</td>
								<td class=" last">
                                      <a href="#" class="btn btn-info btn-xs updateBtn"><i class="fa fa-pencil"></i> 修改 </a>
                                      <a href="#" class="btn btn-danger btn-xs deleteBtn"><i class="fa fa-trash-o"></i> 删除 </a>
										<input type="hidden" name="id" value="${resource.id}" />
								</td>
							</tr>
							</c:forEach>
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
                        	<input value="权限项"/>
                         </h4>
                     </div>
                     <div class="modal-body">
                     	<form class="form-horizontal form-label-left">
                             <div class="form-group">
                                 <label>名称</label>
                                 <input type="text" name="name" class="form-control" placeholder="名称">
                             </div>
                             <div class="form-group">
                                 <label>链接路径</label>
                                 <input type="text" name="url" class="form-control" placeholder="链接路径">
                             </div>
                             <div class="form-group">
                                 <label>类型</label>
                                 <select name="type"  class="form-control">
                                 	<option value="1" >菜单</option>
                                 	<option value="2" >ajax功能</option>
                                 </select>
                             </div>
                             <div class="form-group">
                                 <label>描述</label>
                                 <input type="text" name="remark" class="form-control" placeholder="描述">
                             </div>
                             <div class="form-group">
                                 <label>父级菜单</label>
                                  <select name="parentId"  class="form-control">
                                 	<option value="">无</option>
                                  	<c:forEach var="resource" varStatus="s" items="${list}">
										<option value="${resource.id}" >${resource.name}</option>
									</c:forEach>
                                 </select>
                             </div>
                             <div class="form-group">
                                 <label>排序号</label>
                                 <input type="text" name="orderIndex" class="form-control" placeholder="排序号">
                             </div>
                             <div class="form-group">
                                 <label>图标代码<a href="iconCodes.html" target="_blank">?</a></label>
                                 <input type="text" name="iconName" class="form-control" placeholder="图标代码">
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