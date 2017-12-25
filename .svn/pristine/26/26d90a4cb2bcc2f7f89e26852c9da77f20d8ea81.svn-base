<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" 
%><!DOCTYPE html>
<html>
	<head>
		<title>查询条件列表</title>

		

		<!-- chart js -->
		<script src="js/chartjs/chart.min.js"></script>
		<!-- bootstrap progress js -->
		<script src="js/progressbar/bootstrap-progressbar.min.js"></script>
		<script src="js/nicescroll/jquery.nicescroll.min.js"></script>
		<!-- icheck -->
		<script src="js/icheck/icheck.min.js"></script>
		<script src="js/common-cud.js" type="text/javascript"></script>
		 <script type="text/javascript">
		
		 </script>
	</head>
	<body>
		<table class="table">
   <thead>
      <tr>
         <th>上报领导</th><th>单位名称</th><th>联系人</th><th>联系电话</th><th>单位地址</th><th>送货方式</th><th>是否监销</th>
      </tr>
   </thead>
   <tbody>
     <c:forEach var="history" items="${conditions}">
     	<tr>
     		<td>${history.submitName}</td>
     		<td>${history.contactUnit}</td>
     		<td>${history.contact}</td>
     		<td>${history.telephone}</td>
     		<td>${history.address}</td>
     		<td>
     			<div id="gender" class="btn-group" data-toggle="buttons">
						<label class="btn btn-primary active"> <input
							autocomplete="off" type="radio" name="sendType" value="1"
							
							<c:if test="${history.sendType==1}">
								checked="checked"
							</c:if>
							> 派车
						</label> <label class="btn btn-default"> <input autocomplete="off"
							type="radio" name="sendType" value="0"
							<c:if test="${history.sendType==0}">
								checked="checked"
							</c:if>
							> 自送
						</label>
				</div>
     		</td>
     		<td>${history.nowDestory}
     			<div id="gender" class="btn-group" data-toggle="buttons">
						<label class="btn btn-primary active"> <input
							autocomplete="off" type="radio" name="nowDestroy" value="0"
							<c:if test="${history.nowDestory==0}">
								checked="checked"
							</c:if>
							>&nbsp; 否&nbsp;
						</label> <label class="btn btn-default"> <input
							autocomplete="off" type="radio" name="nowDestroy" value="1"
							<c:if test="${history.nowDestory==1}">
								checked="checked"
							</c:if>
							>&nbsp;
							是&nbsp;
						</label>
					</div>
     		</td>
     	</tr>
     </c:forEach>
   </tbody>
</table>
	</body>
</html>