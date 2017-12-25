<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="fmt"
	uri="http://java.sun.com/jsp/jstl/fmt"%><!DOCTYPE html>
<html>
	<head>
		<title>需派车列表</title>

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
		<!-- daterangepicker -->
		<script type="text/javascript" src="js/moment.min2.js"></script>
		<script type="text/javascript" src="js/datepicker/daterangepicker.js"></script>
		<!-- input mask -->
		<script src="js/input_mask/jquery.inputmask.js"></script>

		<script src="js/common-cud.js" type="text/javascript"></script>

		<script type="text/javascript">
			$(function(){
				//fix modal force focus
				$.fn.modal.Constructor.prototype.enforceFocus = function () {
				  var that = this;
				  $(document).on('focusin.modal', function (e) {
				     if ($(e.target).is('#reservation')) {//fix 这里的class 样式 看select2 的。ps:select2 开发人员真是多变。。。低版本不是这个class 高版本就是这个了。。
				        return true;
				     }
					if($(".modal:visible").length>=2){
						return true;
					}
				     if(that.$element[0] !== e.target && !that.$element.has(e.target).length) {
				        that.$element.focus();
				     }
				  });
				};
            	
            	$(":input").inputmask();
				var inputDate = '';
				$('#reservation').daterangepicker({
					locale:myLocales.zh
					,singleDatePicker: true
					,format: 'YYYY/MM/DD'
				}, function (start, end, label) {
	            });
	            $(".daterangepicker.dropdown-menu").css({"zIndex": 99999});
	            
				$(".paiche-dialog .btn-success").click(function(){
					if($("#reservation").val()==""){
						CommonCud.alert("请现在日期!!");
						return false;
					}
					if($("#timerang").val()==""){
						CommonCud.alert("请输入时间!!");
						return false;
					}
					var dateStr = $("#reservation").val();
					var startAndEnd = $("#timerang").val().split(/\s+到\s+/);
					
					if(!/(([01]\d)|(2[0-4])):[0-5]\d/i.test(startAndEnd[0])
						|| !/(([01]\d)|(2[0-4])):[0-5]\d/i.test(startAndEnd[1])
						|| startAndEnd[0] > startAndEnd[1]
					){
						CommonCud.alert("请输入正确的时间段!!");
						return false;
					}
					$.ajax({
						url:"addCarAndClasses.do"
						,data:$(".paiche-dialog form").serialize()+"&startTime="+dateStr+" "+startAndEnd[0]+":00"+"&endTime="+dateStr+" "+startAndEnd[1]+":00"
						,success:function(){
							CommonCud.alert("派车成功！",function(){
								location.href=location.href;
							});
						}
						,error:function(){
							CommonCud.alert("派车失败！");
						}
					});
				});
				
			});
			function toDispatch(id){
				$("#apply_id").val(id);
				$(".paiche-dialog").modal();
			}
			
			function removeCls(id,i){
				CommonCud.commonConfirm("你确定要取消这个排班吗?", function(result) {
                   	$.ajax({
							url: "delClasses.do?id="+id
							,method:"POST"
							,success:function(data){
									CommonCud.commonAlert("取消成功！",function(){
										$(i).parents("blockquote").remove();
									});
							},error:function(){
									CommonCud.commonAlert("取消失败!");
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
						需派车申请列表
					</h2>
					<ul class="nav navbar-right panel_toolbox">

					</ul>
					<div class="clearfix"></div>
				</div>

				<div class="x_content">

					<ul class="messages applys">
						<c:forEach var="apply" items="${applyList}">
							<li>
								<div class="message_date">
									<h3 class="date text-info">
										<fmt:formatDate value="${apply.date}" pattern="d'日'" />
									</h3>
									<p class="month">
										<fmt:formatDate value="${apply.date}" pattern="yyyy'年'M'月'" />
									</p>
								</div>
								<div class="message_wrapper">
									<h4 class="heading">
										<c:out value="${apply.contactUnit}" escapeXml="true"></c:out>
										，
										<c:out value="${apply.contacts}" escapeXml="true"></c:out>
									</h4>
									<blockquote class="message">
										电话：
										<c:out value="${apply.telephone}" escapeXml="true"></c:out>
									</blockquote>
									<blockquote class="message">
										地址：
										<c:out value="${apply.address}" escapeXml="true"></c:out>
									</blockquote>
									<blockquote class="message">
										销毁物品简述：
										<c:out value="${apply.articleDesc}" escapeXml="true"></c:out>
									</blockquote>
									<c:forEach var="c" items="${apply.dispaths}">
										<blockquote class="message">
											派车安排时间： ${c.start_time} 到 ${c.end_time}
											<i style="cursor: pointer;" class="fa red fa-close"
												onclick="removeCls(${c.id},this)"></i>
										</blockquote>
									</c:forEach>
									<br>
									<p class="url">
										<a href="javascript:toDispatch(${apply.id})"
											class="btn btn-primary">派车</a>
									</p>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>

		<!-- 单个数据操作对话框 -->
		<div class="modal fade paiche-dialog in" tabindex="-1" role="dialog"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">
							派车
						</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal form-label-left">
							<input type="hidden" id="apply_id" name="apply_id" value="" />
							<div class="form-group">
								<label>
									车辆:
								</label>
								<select name="car_id" class="form-control">
									<c:forEach var="car" items="${carList}">
										<option value="<c:out value="${car.id}" />">
											<c:out value="${car.useUser}" />
											-
											<c:out value="${car.carNo}" />
										</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label>
									安排日期：
								</label>
								<%
									pageContext.setAttribute("nowDate", new java.util.Date());
								%>
								<input type="text" id="reservation" class="form-control active"
									value="<fmt:formatDate value="${nowDate}" pattern="yyyy/MM/dd"/>">
							</div>
							<div class="form-group">
								<label>
									安排时间段：
								</label>
								<input type="text" id="timerang" class="form-control"
									data-inputmask="'mask' : '99:99 到 99:99'">
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