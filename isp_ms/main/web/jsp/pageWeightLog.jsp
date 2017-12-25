<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" 
%><!DOCTYPE html>
<html>
	<head>
		<title>历史销后计量</title>

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
		 
		 function toValidate(id){
		 	 $("#weightLog_id").val(id);
		 	 $(".fakun-dialog").modal();
		 }
		 $(function(){
		 	$(".fakun-dialog .btn-success").click(function(){
		 		$.ajax({
		 			url:"ajaxValidateWeightLog.do"
		 			,data:$(".fakun-dialog form").serialize()
		 			,success:function(msg){
		 				if(msg != "反馈成功！"){
		 					CommonCud.alert(msg);
		 				}else{
		 					//weightLogBtn${weightLog.id}
		 					var $this = $(".weightLogBtn"+$("#weightLog_id").val())
		 					var $thisParent = $this.parent();
		 					$this.remove();$thisParent.append(' <span class="label label-info">已反馈</span>  ');
		 					$(".fakun-dialog").modal("hide");
		 				}
		 			}
		 		});
		 	});
		 });
		 </script>
	</head>
	<body>
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						历史销后计量列表
					</h2>
			 		<ul class="nav navbar-right panel_toolbox">
						<%
								pageContext.setAttribute("nowDate", new java.util.Date());
						%>
					</ul>
					<div class="clearfix"></div>
				</div>

				<div class="x_content">
				 <ul class="messages applys"><c:forEach var="weightLog" items="${list}">
                     <li>
                         <div class="message_date">
                             <h3 class="date text-info"><fmt:formatDate value="${weightLog.opDate}" pattern="H'点'"/></h3>
                             <c:if test="${nowDate.time/86400000 - weightLog.opDate.time/86400000  lt 1 }"><p class="month">今天</p></c:if>
                             <c:if test="${nowDate.time/86400000 - weightLog.opDate.time/86400000 ge 1 }"><p class="month">
                             		<fmt:formatDate value="${weightLog.opDate}" pattern="yyyy'年'M'月'd'日'"/></p></c:if>
                         </div>
                         <div class="message_wrapper">
                             <h4 class="heading"><c:out value="${weightLog.weight}" escapeXml="true"></c:out> 千克</h4>
                             <blockquote class="message">车牌：<c:out value="${weightLog.opUser}" escapeXml="true"></c:out></blockquote>
                             <blockquote class="message">联系方式：<c:out value="${weightLog.opContanct}" escapeXml="true" default="无"></c:out></blockquote>
                             <br>
                             <p class="url">
                             <c:if test="${weightLog.state eq 0 }">
                             	<a href="javascript:toValidate(${weightLog.id})"
											class="btn btn-primary weightLogBtn${weightLog.id}">反馈</a>  </c:if>
							  <c:if test="${weightLog.state eq 1 }">
								<span class="label label-info">已反馈</span> </c:if>		
                             </p>
                         </div>
                     </li></c:forEach>
                 </ul>
				</div>
				<!-- 
				<div class="row"  style="text-align: center;">
                      <button class="btn" onclick="nextPage()">加载下一页</button>
                </div> -->
			</div>
		</div> 
		
		
		<!-- 单个数据操作对话框 -->
		<div class="modal fade fakun-dialog in" tabindex="-1" role="dialog"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">
							反馈
						</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal form-label-left">
							<input type="hidden" id="weightLog_id" name="id" value="" />
							<div class="form-group">
								<label>
									重量(kg):
								</label>
								<input type="text" id="timerang" name="weight" class="form-control" />
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-success">
							保存
						</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal">
							关闭
						</button>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>