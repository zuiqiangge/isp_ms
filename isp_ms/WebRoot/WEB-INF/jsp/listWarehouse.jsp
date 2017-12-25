<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" 
%><!DOCTYPE html>
<html>
	<head>
		<title>历史申请</title>

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
		 function nextPage(){
		 	$($(".applys").html()).appendTo($(".applys"));
		 }	
		 </script>
	</head>
	<body>
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						历史申请列表
					</h2>
			 		<ul class="nav navbar-right panel_toolbox">
						 
					</ul>
					<div class="clearfix"></div>
				</div>

				<div class="x_content">
				 <ul class="messages applys"><c:forEach var="apply" items="${applyList}">
                     <li>
                         <div class="message_date">
                             <h3 class="date text-info"><fmt:formatDate value="${apply.date}" pattern="d'日'"/></h3>
                             <p class="month"><fmt:formatDate value="${apply.date}" pattern="yyyy'年'M'月'"/></p>
                         </div>
                         <div class="message_wrapper">
                             <h4 class="heading"><c:out value="${apply.contactUnit}" escapeXml="true"></c:out>，<c:out value="${apply.contacts}" escapeXml="true"></c:out></h4>
                             <blockquote class="message">电话：<c:out value="${apply.telephone}" escapeXml="true"></c:out></blockquote>
                             <blockquote class="message">地址：<c:out value="${apply.address}" escapeXml="true"></c:out></blockquote>
                             <blockquote class="message">物品类型：<c:choose>
                             		<c:when test="${apply.articleType eq 1}">
                             			纸张
                             		</c:when>
                             		<c:when test="${apply.articleType eq 2}">
                             			U 盘
                             		</c:when>
                             		<c:when test="${apply.articleType eq 3}">
                             			光盘
                             		</c:when>
                             		<c:when test="${apply.articleType eq 4}">
                             			移动硬盘
                             		</c:when>
                             		<c:when test="${apply.articleType eq 5}">
                             			笔记本
                             		</c:when>
                             		<c:otherwise><span class="label label-danger">未知</span></c:otherwise>
                             	</c:choose></blockquote>
                             <br>
                             <p class="url">
                             	<c:choose>
                             		<c:when test="${apply.sendType eq 1}">
                             			<span class="label label-warning">需派车</span>
                             		</c:when>
                             		<c:otherwise><span class="label label-success">对方自送</span></c:otherwise>
                             	</c:choose>
                               	<c:choose>
                             		<c:when test="${apply.state eq 0}">
                             			<span class="label label-warning">暂存</span> &nbsp;
                             			<a href="toUpdateApply.do?id=${apply.id}" class="btn btn-primary" >编辑</a>
                             		</c:when>
                             		<c:when test="${apply.state eq 1}">
                             			<span class="label label-success">等待领导批示</span>
                             		</c:when>
                             		<c:otherwise><span class="label label-info">申请完成</span></c:otherwise>
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