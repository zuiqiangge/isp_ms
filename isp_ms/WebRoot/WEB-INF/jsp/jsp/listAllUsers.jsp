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
									<a href="#">新增用户</a>
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
									用户名
								</th>
								<th class="column-title">
									登录名
								</th>
								<th class="column-title">
									角色
								</th>
								<th class="column-title">
									最后一次登录时间
								</th>
								<th class="column-title">
									状态
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
							<c:forEach var="user" varStatus="s" items="${list}">
							<tr class="${s.index mod 2 ==0 ? 'even' : 'odd' } pointer">
								<td class=" ">
									<c:out value="${user.userName}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${user.userName}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${user.role}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${user.userName}" escapeXml="true"></c:out>
								</td>
								<td class=" ">
									<c:out value="${user.userName}" escapeXml="true"></c:out>
								</td>
								<td class=" last">
									<a href="#">查看</a>
								</td>
							</tr>
							</c:forEach>
						</tbody>

					</table>
				</div>
			</div>
		</div> 
	</body>
</html>