<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="fmt"
	uri="http://java.sun.com/jsp/jstl/fmt"%><!DOCTYPE html>
<html>
<head>
<title>待批示申请</title>
<style>
.dw {
	position: absolute;
	width: 200px;
	height: 100px;
	top: 50px;
	left: 70%;
	background:#AAAAAA;
	cursor: move;
}
</style>
<script type="text/javascript">
	
	$(function(){  
		
    $(window).scroll(function(){  
      var yy = $(this).scrollTop();//获得滚动条top值  
       if ($(this).scrollTop() < 30) {  
            $("#dd").css({"position":"absolute",top:"30px",left:"70%"}); //设置div层定位，要绝对定位  
       }else{  
            $("#dd").css({"position":"absolute",top:yy+"px",left:"70%"});  
       }   
    }); 
      
}); 
	
	
	function etrust(){
		var chk_value =[]; 
		$('input[name="isEntrust"]:checked').each(function(){ 
			chk_value.push($(this).val());
		});
		var userId = ($("#entrustUser").val());
		$.ajax({
			async:false,
			dataType:"text",
   			type: "POST",
   			url: "EntrustForElse.do",
   			data: "applyids="+chk_value+"&userId="+userId,
   			success: function(msg){
     			if(msg==1){
     				alert("委托成功");
     				window.location.reload();
     			}
     			else
     				alert("委托失败!");
   			}
		});
	}
</script>
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
<script src="js/icheck/icheck.min.js">
	</script>
<script src="js/common-cud.js" type="text/javascript">
	
</script>

</head>
<body>
	<div class="col-md-12 col-sm-12 col-xs-12">
		<div class="x_panel">
			<div class="x_title">
				<h2>待批示申请列表</h2>
				<ul class="nav navbar-right panel_toolbox">

				</ul>
				<div class="clearfix"></div>
			</div>

			<div class="x_content">
				<ul class="messages applys">
					<c:if test="${empty lingdao}">
						<li>
							<div class="message_date"></div>
							<div class="message_wrapper">
								<h4 class="heading">暂无需批示申请列表</h4>
							</div>
						</li>
					</c:if>
					<c:forEach var="apply" items="${lingdao}">
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
									上报领导：
									<c:out value="${apply.name}" escapeXml="true"></c:out>
								</blockquote>
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
								<br>
								<p class="url">
									<c:choose>
										<c:when test="${apply.sendType eq 1}">
											<span class="label label-warning">需派车</span>
										</c:when>
										<c:otherwise>
											<span class="label label-success">对方自送</span>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${apply.state eq 1}">
											<a href="toUpdateApply.do?id=${apply.id}"
												class="btn btn-primary">批示</a>
										</c:when>
										<c:when test="${apply.state eq 3}">
											<span class="label label-info">申请完成</span>
										</c:when>
									</c:choose>
									<input type="checkbox" name="isEntrust" style="width:10;height:10"
										value="${apply.id}">是否委託
								</p>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="row"  style="text-align: center;">
                      <button class="btn" onclick="aa()">加载下一页</button>
                </div>
			<form class="form-inline dw" role="form" id="dd">
				<div class="form-group">
					<select id="entrustUser" >
						<c:forEach var="user" items="${users}">
							<c:if test="${user.id!=currentUser.id}">
								<option value=${user.id}>${user.nickName}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<button onclick="etrust()" class="btn btn-default">委託</button>
			</form>

		</div>
	</div>
</body>

</html>