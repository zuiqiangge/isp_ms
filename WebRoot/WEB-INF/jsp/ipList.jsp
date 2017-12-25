<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="fmt"
	uri="http://java.sun.com/jsp/jstl/fmt"%><!DOCTYPE html>
<html>
<head>
<title>ip地址管理</title>

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
	//点击查询按钮---根据条件异步查询列表
	function queryByCondition() {
		var arr = $("#conditionForm").serializeArray();
		var data = $.param(arr);
		$.ajax({
			dataType : "json",
			type : "POST",
			url : "getListByCondition.do",
			data : data,
			success : function(msg) {
				//条件查询成功后,录入查询条件日志
				saveApplyCondition(data);
				writeLi(msg);
			}
		});
	}

	//查询时录入查询条件日志
	function saveApplyCondition(data) {
		$.ajax({
			type : "POST",
			url : "saveApplyCondition.do",
			data : data,
			success : function(msg) {
			}
		});
	}
	//导出excel
	function exportApplies() {
		var ids = [];
		$("input[name='id']").each(function() {
			ids.push($(this).val());
		});
		$.ajax({
			//async : false,
			dataType : "text",
			type : "POST",
			url : "exportApply.do",
			data : "ids=" + ids,
			success : function(msg) {
				if (msg == 1)
					alert("导出成功!文件已导出在c:根目录下");
				else
					alert("导出失败!请联系开发人员!");
			}
		});
	}

	//加载时执行方法
	$(function() {
		//getList();
	});

	//获取列表方法
	function getList() {
		$.ajax({
			async : false,
			dataType : "json",
			type : "GET",
			url : "getUserApplyData.do",
			success : function(msg) {
				//alert("初始化陈宫");
				writeLi(msg);
			}
		});
	}
	
	//添加ip
	function add(){
		var ip = $("#ip").val();
		$.ajax({
			async : false,
			dataType : "text",
			type : "POST",
			url : "addIp.do?ip="+ip,
			success : function(msg) {
				if(msg==1){
					$("#add").modal('hide')
					location.href="toIpList.do"
				}
			}
		});	
	}
	
	
	//删除ip
	function del(id){
		var falg = confirm("是否确定删除id为"+id+"的ip记录?");
		if(falg){
			$.ajax({
			async : false,
			dataType : "text",
			type : "POST",
			url : "delIp.do?id="+id,
			success : function(msg) {
				//if(msg==1){
					//$("#add").modal('hide')
					location.href="toIpList.do"
				//}
			}
		});	
		}
			
		//alert(falg);
	}
</script>
</head>
<body>
	<div class="btn-toolbar" role="toolbar">
		<div class="btn-group">
			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#add">添加ip</button>
		</div>

	</div>
	<table class="table">
		<thead>
			<tr>
				<th>ip地址</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="ip" items="${ipList}">
				<tr>
					<td><h1>${ip.ip}</h1></td>
					<td>
						 <button type="button" class="btn btn-default btn-sm" onclick="del(${ip.id})">
          					<span class="glyphicon glyphicon-minus"></span>删除
        				</button>
					</td>
				</tr>
			</c:forEach>
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
					<h4 class="modal-title" id="myModalLabel">
					添加ip
				</h4>
				</div>
				<div class="modal-body">
					<div class="x_content" id="editContent">
        					<div class="input-group">
            				<span class="input-group-addon">ip地址</span>
            					<input type="text" id="ip" name="ip" class="form-control" placeholder="xxxx.xx.xxx.xx">
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