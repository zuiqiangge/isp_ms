<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="fmt"
	uri="http://java.sun.com/jsp/jstl/fmt"%><!DOCTYPE html>
<html>
<head>
<title>用户日志管理</title>

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

<link type="text/css" rel="stylesheet"
	href="js/DataTables-1.10.13/media/css/jquery.dataTables.min.css" />
<script type="text/javascript"
	src="js/DataTables-1.10.13/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
	var listTable;
	function queryByCondition(){
		
		//var formData = new FormData($("#conditionForm")[0]);
		var data = getFormJson($("#conditionForm"));
		/* var param = {
        "userId": 1
    	};
		alert(param); */
		listTable.settings()[0].ajax.data =data;
    	listTable.ajax.reload();
	}
	
	
	//将form中的值转换为键值对。
function getFormJson(frm) {
    var o = {};
    var a = $(frm).serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });

    return o;
}

	function getUserName(userId) {
		//alert(userId);
		var name = "";
		/* $.ajax({
			async : false,
			dataType : 'json',
			type : "GET",
			url : "ajaxGetUsersById.do?id=" + userId,
			success : function(msg) {
				alert(msg.userName);
				name = msg.userName;
			}
		}); */
		return "fdsf";
	}
	$(document).ready(function() {
		//格式化日期方法
		Date.prototype.Format = function(fmt) { //author: meizz 
		var o = {
								"M+" : this.getMonth() + 1, //月份 
								"d+" : this.getDate(), //日 
								"h+" : this.getHours(), //小时 
								"m+" : this.getMinutes(), //分 
								"s+" : this.getSeconds(), //秒 
								"q+" : Math.floor((this.getMonth() + 3) / 3), //季度 
								"S" : this.getMilliseconds()
							//毫秒 
							};
							if (/(y+)/.test(fmt))
								fmt = fmt.replace(RegExp.$1, (this
										.getFullYear() + "")
										.substr(4 - RegExp.$1.length));
							for ( var k in o)
								if (new RegExp("(" + k + ")").test(fmt))
									fmt = fmt
											.replace(
													RegExp.$1,
													(RegExp.$1.length == 1) ? (o[k])
															: (("00" + o[k])
																	.substr(("" + o[k]).length)));
							return fmt;
						}
						//格式化日志列表
						listTable = $('#logList')
								.DataTable(
										{
											"serverSide" : true,
											"dom" : 'tflip',
											'searching' : false,
											"lengthMenu" : [10,15,20],
											"ordering" : false,
											"columns" : [
													{
														"data" : "userId",
														"render" : function(
																data, type,
																row, meta) {
															return data!=null?data.nickName:"";
														}
													},
													{
														"data" : "sysDesc"
													},
													{
														"data" : "detailsInfo"
													},
													{
														"data" : "methodUrl"
													},
													{
														"data" : "opTime",
														"render" : function(
																data, type,
																row, meta) {
															return new Date(
																	data.time)
																	.Format("yyyy-MM-dd hh:mm:ss");
														}
													}

											],
											"ajax" : {
												'url' : "getAllLogList.do"
											},
											'language' : {
												'emptyTable' : '没有数据',
												'loadingRecords' : '加载中...',
												'processing' : '查询中...',
												'lengthMenu' : '每页 _MENU_行',
												'zeroRecords' : '没有数据',
												'paginate' : {
													'first' : '第一页',
													'last' : '最后一页',
													'next' : '下一页',
													'previous' : '上一页'
												},
												"info" : "显示页 _PAGE__of__PAGES_页   共 _TOTAL_ 项",
												'infoEmpty' : '没有数据'
											}
										});
					});
</script>
</head>
<body>
	
	<form class="form-inline" role="form" id="conditionForm">
					用户:<select class="form-control" name="userId.id">
						<c:choose>
							<c:when test="${currentUser.role==1||currentUser.role==2}">
								<c:forEach var="user" items="${users}">
									<option value=${user.id}>${user.nickName}</option>
								</c:forEach>
							</c:when>
							<c:otherwise>
									<option value=${currentUser.id}>${currentUser.nickName}</option>
							</c:otherwise>
						</c:choose>
					</select> 
					摘要:<select class="form-control" name="sysDescId">
						<c:forEach var="zy" items="${zys}">
								<option value=${zy.sysDescId}>${zy.sysDesc}</option>
						</c:forEach>
					</select> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					<button type="button" class="btn btn-default"
						onclick="queryByCondition()">检索</button>
				</form>
				
	<table class="table" id="logList">
		<thead>
			<tr>
				<th>用户</th>
				<th>摘要</th>
				<th>具体描述</th>
				<th>url</th>
				<th>操作时间</th>
			</tr>
		</thead>
		<tbody>

		</tbody>
	</table>

	<!--添加ip模态框-->
	<div class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" id="add">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加ip</h4>
				</div>
				<div class="modal-body">
					<div class="x_content" id="editContent">
						<div class="input-group">
							<span class="input-group-addon">ip地址</span> <input type="text"
								id="ip" name="ip" class="form-control"
								placeholder="xxxx.xx.xxx.xx">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="add()">提交更改</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>