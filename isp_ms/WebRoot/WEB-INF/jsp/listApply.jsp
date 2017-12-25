<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="fmt"
	uri="http://java.sun.com/jsp/jstl/fmt"%><!DOCTYPE html>
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
	
	function showList(){
		window.parent.open ('ListApplyCondition.do', 'newwindow', 'height=300, width=750, top=300, left=500, toolbar=no, menubar=no');
	}
	function nextPage() {
		$($(".applys").html()).appendTo($(".applys"));
	}


	function exportApplies() {
		var ids=[];
		$("input[name='id']").each(function(){
			ids.push($(this).val());
		});
		
		
		
		$.ajax({
			async : false,
			dataType : "text",
			type : "POST",
			url : "exportApply.do",
			data:"ids="+ids,
			success : function(msg) {
				if (msg == 1)
					alert("导出成功!文件已导出在c:根目录下");
				else
					alert("导出失败!请联系开发人员!");
			}
		});
	}
</script>
</head>
<body>
	<div class="col-md-12 col-sm-12 col-xs-12">
		<div class="x_panel">
			<div class="x_title">
				<h2>历史申请列表</h2>
				&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-default btn-sm"
					onclick="exportApplies()">
					<span class="glyphicon glyphicon-save"></span>导出
				</button>
				<!--条件输入框-->
				<form class="form-inline" role="form" action="getListByCondition.do">
					上报领导:<select class="form-control" name="submitUserId">
						<c:forEach var="user" items="${users}">
							<c:if test="${user.id!=currentUser.id}">
								<option value=${user.id}>${user.nickName}</option>
							</c:if>
						</c:forEach>
					</select> 
					单位名称:<input type="text" class="form-control" id="submitUserId" name="submitUserId"> 
					联系人:<input type="text" class="form-control" id="contactUnit" name="contactUnit">
					联系电话:<input type="text" class="form-control" id="telephone" name="telephone"><br/> 
					单位地址:<input type="text" class="form-control" id="address" name="address"> 
					<br/>
					送货方式:
					<div id="gender" class="btn-group" data-toggle="buttons">
						<label class="btn btn-primary active"> <input
							autocomplete="off" type="radio" name="sendType" value="1"
							checked="checked"> 派车
						</label> <label class="btn btn-default"> <input autocomplete="off"
							type="radio" name="sendType" value="0"> 自送
						</label>
					</div>


					是否监销:
					<div id="gender" class="btn-group" data-toggle="buttons">
						<label class="btn btn-primary active"> <input
							autocomplete="off" type="radio" name="nowDestroy" value="0"
							checked="checked">&nbsp; 否&nbsp;
						</label> <label class="btn btn-default"> <input
							autocomplete="off" type="radio" name="nowDestroy" value="1">&nbsp;
							是&nbsp;
						</label>
					</div>
					<button type="submit" class="btn btn-default">检索</button>
					<!--条件查询历史-->
					<button type="button" class="btn btn-default btn-sm" style="align:'right'" onclick="showList()">
          <span class="glyphicon glyphicon-list"></span>条件查询历史
        </button>
				</form>
			
				<ul class="nav navbar-right panel_toolbox">

				</ul>
				<div class="clearfix"></div>
			</div>

			<div class="x_content">
				<ul class="messages applys">
					<c:forEach var="apply" items="${applyList}">
						<li>
							<input type="hidden" name="id" value="${apply.id}">
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
										<c:when test="${apply.state eq 0}">
											<span class="label label-warning">暂存</span> &nbsp;
                             			<a
												href="toUpdateApply.do?id=${apply.id}"
												class="btn btn-primary">编辑</a>
										</c:when>
										<c:when test="${apply.state eq 1}">
											<span class="label label-success">等待领导批示</span>
										</c:when>
										<c:otherwise>
											<span class="label label-info">申请完成</span>
										</c:otherwise>
									</c:choose>
								</p>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
			<%--<div class="row"  style="text-align: center;">
                      <button class="btn" onclick="nextPage()">加载下一页</button>
                </div>--%>
		</div>
	</div>
</body>
</html>