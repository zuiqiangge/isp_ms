<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" 
%><!DOCTYPE html>
<html>
	<head>
		<title>库存列表</title>

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
		  function warehouseDestroy(id){
		  	CommonCud.confirm("您确定已经销毁了吗？",function(){
		  		$.ajax({
		  			url: "ajaxUpdateWarehouse.do?id="+id 
		  			,success:function(){
		  				location.href= location.href;
		  			}
		  		});
		  	});
		  }
		  
		 </script>
	</head>
	<body>
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						库存列表
					</h2>
			 		<ul class="nav navbar-right panel_toolbox">
						 
					</ul>
					<div class="clearfix"></div>
				</div>

				<div class="x_content">
				 <ul class="messages applys"><c:forEach var="warehouse" items="${list}">
                     <li>
                         <div class="message_date">
                             <h3 class="date text-info"><fmt:formatDate value="${warehouse.enterDate}" pattern="d'日'"/></h3>
                             <p class="month"><fmt:formatDate value="${warehouse.enterDate}" pattern="yyyy'年'M'月'"/></p>
                         </div>
                         <div class="message_wrapper">
                             <h4 class="heading"><c:out value="${warehouse.registerPerson}" escapeXml="true"></c:out></h4>
                             <blockquote class="message">条码：<c:out value="${warehouse.labelNumber}" escapeXml="true"></c:out></blockquote>
                             <br>
                             <p class="url">
                               	<c:choose>
                             		<c:when test="${warehouse.destroyState eq 0}">
                             			<span class="label label-warning">未进行销毁</span> &nbsp;
                             			<a href="javascript:warehouseDestroy(${warehouse.id})" class="btn btn-primary" >进行销毁</a>
                             		</c:when>
                             		<c:when test="${warehouse.destroyState eq 1}">
                             			<span class="label label-success">已进行销毁操作</span>
                             		</c:when>
                             		<c:otherwise><span class="label label-info">未知状态</span></c:otherwise>
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