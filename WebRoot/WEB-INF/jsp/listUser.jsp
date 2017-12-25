<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="fmt"
	uri="http://java.sun.com/jsp/jstl/fmt"%><!DOCTYPE html>
<html>
<head>
<title>用户列表</title>



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
	//跳转编辑
	function toEdit(id) {
		$("#edit").modal('show');

		$.ajax({
			dataType : 'json',
			type : "GET",
			url : "get.do?id=" + id,
			success : function(user) {
				$("#sex").val(0);
				$("#name").val(user.name);
				if (user.sex == 1)
					$("#sex").val(1);
				if (user.sex == 0)
					$("#sex").val(0);
				$("#age").val(user.age);
				$("#id").val(user.id);
				//$("#editImg").attr("src",user.photo);
			}
		});

	}
</script>
</head>
<body>
	<div class="btn-group btn-group-lg">
		<button type="button" class="btn btn-default tooltip-test"
			onclick="luru()" data-toggle="tooltip" title="添加">
			<span class="glyphicon glyphicon-plus-sign"></span>
		</button>
	</div>
	<table id="example" class="tabindex" width="100%" border="0"
		cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<th width="10%" bgcolor="#f8f8f8" scope="col"><div align="left">名称</div></th>
				<th width="10%" bgcolor="#f8f8f8"><div align="left">性别</div></th>
				<th width="20%" bgcolor="#f8f8f8"><span class="titlab">年龄</span></th>
				<th width="20%" bgcolor="#f8f8f8"><span class="titlab">照片</span></th>
				<th width="15%" bgcolor="#f8f8f8"><span class="titlab">操作</span></th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<!--列表图片展示模态窗口-->
	<div class="modal fade" id="img" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<div class="x_content" id="editContent">
						<img alt="照片" id="listImg" src="">
					</div>
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>

	<!--录入模态窗体-->
	<form id="formluru" method="post" action="addUser.do"
		enctype="multipart/form-data">
		<div class="modal fade" id="luru" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">录入窗口</h4>
					</div>
					<div class="modal-body">
						<div class="x_content" id="editContent">
							<ul class="list-group">
								<li class="list-group-item">
									<div class="input-group">
										<span class="input-group-addon">名称</span> <input type="text"
											class="form-control" name="name"> <span
											class="input-group-addon">性别</span> <select name="sex"
											class="form-control">
											<option value="1">男</option>
											<option value="0">女</option>
										</select>
									</div>
								</li>
								<li class="list-group-item">
									<div class="input-group">
										<span class="input-group-addon">年龄&nbsp;&nbsp;&nbsp;</span> <input
											type="text" class="form-control" name="age">

									</div>
								</li>
								<li class="list-group-item">
									<div class="input-group">
										<span class="input-group-addon">&nbsp;&nbsp;&nbsp;&nbsp;照片</span>
										<input type="file" class="form-control" name="photo"
											id="photo" accept=".jpg,.bpm,.gif,.png" onchange="checkFileSize(this)">
									</div>
								</li>
							</ul>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-success" onclick="add()">
							提交更改</button>
					</div>
				</div>
			</div>
		</div>
	</form>



	<!--编辑模态框-->
	<form id="formedit">
		<input type="hidden" name="id" id="id">
		<div class="modal fade" id="edit" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">编辑窗口</h4>
					</div>
					<div class="modal-body">
						<div class="x_content" id="editContent">
							<ul class="list-group">
								<li class="list-group-item">
									<div class="input-group">
										<span class="input-group-addon">名称</span> <input type="text"
											class="form-control" id="name" name="name"> <span
											class="input-group-addon">性别</span> <select name="sex"
											id="sex" class="form-control">
											<option value="1">男</option>
											<option value="0">女</option>
										</select>
									</div>
								</li>
								<li class="list-group-item">
									<div class="input-group">
										<span class="input-group-addon">年龄&nbsp;&nbsp;&nbsp;</span> <input
											type="text" class="form-control" name="age" id="age" >

									</div>
								</li>

								<li class="list-group-item">
									<div class="input-group">
										<span class="input-group-addon">&nbsp;&nbsp;&nbsp;&nbsp;照片</span>
										<input type="file" class="form-control" name="photo"
											id="photo" accept=".png,.gif,.jpg,.bpm" onchange="checkFileSize(this)">

									</div>
								</li>
							</ul>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-success" onclick="edit()">
							修改</button>
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" id="id" name="id">
	</form>


	<script language="JavaScript" type="text/javascript">
		var table;

		$(document)
				.ready(
						function() {
							table = $('#example')
									.DataTable(
											{
												"serverSide" : true,
												"dom" : 'tflip',
												'searching' : false,
												"lengthMenu" : [ 2, 4, 6 ],
												"ordering" : false,
												"columns" : [
														{
															"data" : "name"
														},
														{
															"data" : "sex",
															"render" : function(
																	data, type,
																	row, meta) {
																if (data == 1)
																	return "男";
																if (data == 0)
																	return "女";
															}
														},
														{
															"data" : "age"
														},
														{
															"data" : "photo",
															"render" : function(
																	data, type,
																	row, meta) {
																return "<p onclick='showImg(\""
																		+ data
																		+ "\")'>点击查看</p>";
															}
														},
														{
															"data" : "id",
															"render" : function(
																	data, type,
																	row, meta) {
																return "<button type='button' onclick='toEdit("
																		+ data
																		+ ")' class='btn btn-default btn-sm'><span class='glyphicon glyphicon-user'>编辑</span></button><button type='button' onclick='del("
																		+ data
																		+ ")' class='btn btn-default btn-sm'><span class='glyphicon glyphicon-user'>删除</span></button>";
															}
														}

												],
												"ajax" : {
													'url' : "getUserList.do"
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
													"sInfo" : "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
													'infoEmpty' : '没有数据'
												}
											});
						});

		//展示列表图片
		function showImg(photo) {
			$('#img').modal('show');
			$('#listImg').attr("src", photo);
		}
	
		//限制文件大小
		function checkFileSize(target){
			var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
			var fileSize = 0;
			if (isIE && !target.files) {
				var filePath = target.value;
				var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
				var file = fileSystem.GetFile(filePath);
				fileSize = file.Size;
			} else {
				fileSize = target.files[0].size;
			}
	
			var size = fileSize / 1024 * 1024;
			if (size > (1024 * 200)) {
				//document.all.submit_upload.disabled = true;
				alert("文件大小不能超过200KB");
				return false;
			} else {
				return true;
			}
		}
		//跳转录入
		function luru(id) {
			$('#luru').modal('show');
		}

		//添加
		function add() {
			var target = $("#formluru").find("input[name='photo']");
			if(checkFileSize(target.get(0))){
			
				var formData = new FormData($( "#formluru" )[0]);  
				 $.ajax({  
				      url: 'addUser.do' ,  
				      type: 'POST',  
				      data: formData,  
				      async: false,  
				      cache: false,  
				      contentType: false,  
				      processData: false,  
				      success: function (returndata) {  
				    	 $('#luru').modal('hide');
				    	table.ajax.reload();
				      },  
				 });
			}

		}
		//编辑
		function edit() {
			/* var arr = $("#formedit").serializeArray();
			var data = $.param(arr);
			$.ajax({
			type: "POST",
			url: "updateUser.do",
			data:data,
			success: function(msg){
				$("#edit").modal('hide');
				table.ajax.reload();
			}
			}); */
			var target = $("#formedit").find("input[name='photo']");
			if(checkFileSize(target.get(0))){
				var formData = new FormData($("#formedit")[0]);
				$.ajax({
					url : 'updateUser.do',
					type : 'POST',
					data : formData,
					async : false,
					cache : false,
					contentType : false,
					processData : false,
					success : function(returndata) {
						$("#edit").modal('hide');
						table.ajax.reload();
					}
				});
			}
		}

		//删除
		function del(id) {
			if (confirm("是否确定删除？")) {

				$.ajax({
					type : "GET",
					url : "delUser.do?id=" + id,
					success : function(msg) {

						table.ajax.reload();
					}
				})
			}
		}
	</script>
</body>

</html>