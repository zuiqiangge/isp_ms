<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html>
	<head>
		<title>用户信息管理</title>

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
				 "addUrl": "ajaxAddUsers.do?realPassWord=123456"
			    ,"getUrl": "ajaxGetUsersById.do"
			    ,"updateUrl": "ajaxUpdateUsers.do"
			    ,"removeUrl": "ajaxRemoveUsers.do"
			});
			
			$.ajax({
				url:"listAllRole.do"
				,"success":function(doc){
					$(doc).find(".x_content tbody tr").each(function(i,tr){
						var id = $(tr).find("[name=id]").val();
						var name = $(tr).find("td").first().text();
						$("#roleSelect").append('<option value="'+id+'" >'+name+'</option>');
					});
					$(".txt_roleId").each(function(i,ele){
						var id = $(this).text();
						$(this).html($("#roleSelect [value="+id+"]").text());
					});
				}
				,error:function(){
					CommonCud.alert("加载角色列表失败！");
				}
			});
		})
		</script>
	</head>
	<body>

		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						用户列表
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
									<a href="#"  class="addBtn" >新增用户</a>
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
				  <c:forEach var="user" varStatus="s" items="${list}"><c:if test="${loginUser.id eq user.id or user.id gt 1}">
                         <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
                             <div class="tile-stats">
                                 <div class="icon"><i class="fa fa-user"></i>
                                 </div>
                                 <div class="count"><c:out value="${user.nickName}" escapeXml="true"></c:out></div>
                                 <h3 class="txt_roleId" ><c:out value="${user.role}" escapeXml="true"></c:out></h3>
                                 <p>最后登录时间：<c:out value="${not empty user.lastLoginTime ? user.lastLoginTime : '无'}" escapeXml="true"></c:out></p>
                                 <p>帐号：<c:out value="${user.userName}" escapeXml="true"></c:out> &nbsp; 身份：<c:out value="${user.isLeader eq  1 ? '领导' : '普通'}" escapeXml="true"></c:out></p>
                                 <p>
										<a href="#" class="btn btn-info btn-xs updateBtn"><i class="fa fa-pencil"></i> 修改 </a>
	                                    <a href="#" class="btn btn-danger btn-xs deleteBtn"><i class="fa fa-trash-o"></i> 删除 </a>
										<input type="hidden" name="id" value="${user.id}" />
								 </p>
                             </div>
                         </div></c:if></c:forEach>
				<%--  
					<table
						class="table table-striped responsive-utilities jambo_table bulk_action">
						<thead>
							<tr class="headings">
								<th class="column-title">
									用户名
								</th>
								<th class="column-title">
									角色
								</th>
								<th class="column-title">
									最后一次登录时间
								</th>
								<th class="column-title no-link last">
									<span class="nobr">操作</span>
								</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="user" varStatus="s" items="${list}">
							<tr class="${s.index mod 2 ==0 ? 'even' : 'odd' } pointer">
								<td class=" ">
									<c:out value="${user.userName}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${user.role}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${user.lastLoginTime}" escapeXml="true"></c:out>
								</td>
								<td class=" last">
									<c:if test="${loginUser.id eq user.id or user.id gt 1}">
										<a href="#" class="btn btn-info btn-xs updateBtn"><i class="fa fa-pencil"></i> 修改 </a>
	                                    <a href="#" class="btn btn-danger btn-xs deleteBtn"><i class="fa fa-trash-o"></i> 删除 </a>
										<input type="hidden" name="id" value="${user.id}" />
									</c:if>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					 --%>
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
                        	<input value="用户信息"/>
                         </h4>
                     </div>
                     <div class="modal-body">
                     	<form class="form-horizontal form-label-left">
                             <div class="form-group">
                                 <label>登录名</label>
                                 <input type="text" name="userName" class="form-control" placeholder="登录名">
                             </div>
                             <div class="form-group">
                                 <label>姓名</label>
                                 <input type="text" name="nickName" class="form-control" placeholder="姓名">
                             </div>
                             <div class="form-group only-add-show">
                                 <label>密码</label>
                                 <input type="text" disabled="disabled" value="默认密码：123456" class="form-control" >
                             </div>
                             <div class="form-group">
                                 <label>角色</label>
                                 <select name="role" id="roleSelect"  class="form-control">
                                 </select>
                             </div>
                             <div class="form-group">
                                 <label>身份</label>
                                 <select name="isLeader" id="isLeader"  class="form-control">
                                 	<option value="0">普通</option>
                                 	<option value="1">领导</option>
                                 </select>
                             </div>
                             <div class="form-group">
                                 <label>部门</label>
                                 <select name="bmId" id="bmId"  class="form-control">
                                 	<c:forEach var="department" items="${departmentList}">
                                 	<option value="${department.id}">${department.bmName}</option></c:forEach>
                                 </select>
                             </div>
                             <div class="form-group">
                                 <label>职位</label>
                                 <select name="positionId" id="positionId"  class="form-control">
                                 	<c:forEach var="position" items="${positionList}">
                                 	<option value="${position.id}">${position.name}</option></c:forEach>
                                 </select>
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