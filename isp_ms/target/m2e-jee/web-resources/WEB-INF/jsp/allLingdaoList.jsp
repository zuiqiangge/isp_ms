<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" 
%><!DOCTYPE html>
<html>
	<head>
		<title>待批示申请</title>

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
	</head>
	<body>
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						待批示申请列表
					</h2>
			 		<ul class="nav navbar-right panel_toolbox">
						 
					</ul>
					<div class="clearfix"></div>
				</div>

				<div class="x_content">
				 <ul class="messages applys"><c:if test="${empty lingdao}">
					 <li>
	                         <div class="message_date">
	                         </div>
	                         <div class="message_wrapper"><h4 class="heading">暂无需批示申请列表</h4></div>
					 </li>
				 </c:if><c:forEach var="apply" items="${lingdao}">
                     <li>
                         <div class="message_date">
                             <h3 class="date text-info"><fmt:formatDate value="${apply.date}" pattern="d'日'"/></h3>
                             <p class="month"><fmt:formatDate value="${apply.date}" pattern="yyyy'年'M'月'"/></p>
                         </div>
                         <div class="message_wrapper">
                             <h4 class="heading"><c:out value="${apply.contactUnit}" escapeXml="true"></c:out>，<c:out value="${apply.contacts}" escapeXml="true"></c:out></h4>
                             <blockquote class="message">上报领导：<c:out value="${apply.telephone}" escapeXml="true"></c:out></blockquote>
                             <blockquote class="message">电话：<c:out value="${apply.telephone}" escapeXml="true"></c:out></blockquote>
                             <blockquote class="message">地址：<c:out value="${apply.address}" escapeXml="true"></c:out></blockquote>
                             <blockquote class="message">销毁物品简述：<c:out value="${apply.articleDesc}" escapeXml="true"></c:out></blockquote>
                             <br>
                             <p class="url">
                             	<c:choose>
                             		<c:when test="${apply.sendType eq 1}">
                             			<span class="label label-warning">需派车</span>
                             		</c:when>
                             		<c:otherwise><span class="label label-success">对方自送</span></c:otherwise>
                             	</c:choose>
                               	<c:choose>
                             		<c:when test="${apply.state eq 1}">
                             			<a href="toUpdateApply.do?id=${apply.id}" class="btn btn-primary" >批示</a>
                             		</c:when>
                             		<c:when test="${apply.state eq 3}">
                             			<span class="label label-info">申请完成</span>
                             		</c:when>
                             	</c:choose>
                             </p>
                         </div>
                     </li></c:forEach>
                 </ul>
				</div>
				<%--<div class="row"  style="text-align: center;">
                      <button class="btn" onclick="nextPage()">加载下一页</button>
                </div>--%>
			</div>
		</div> 
	</body>
</html>