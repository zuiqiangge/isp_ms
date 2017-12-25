<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html>
	<head>
		<title>修改密码</title>

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
		$(function(){
			//CommonCud
			$("form .btn-success").click(function(){
				if($("#repassword").val() !=  $("form [name=passWord]").val()){
					CommonCud.alert("两次新密码输入不一致，请重新输入！");
					return false;
				}
				$.ajax({
					url:"resetPwd.do"
					,data:$("form").serialize()
					,success:function(msg){
						CommonCud.alert(msg);
					}
				});
			});
		})
		</script>
	</head>
	<body>

		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						修改密码
					</h2>
					<div class="clearfix"></div>
				</div>

				<div class="x_content">
					 <form class="form-horizontal form-label-left" >
                             <div class="form-group">
                                 <label>旧密码</label>
                                 <input type="password" name="userName" class="form-control" placeholder="请输入旧密码">
                             </div>
                             <div class="form-group">
                                 <label>新密码</label>
                                 <input type="password" name="passWord" class="form-control" placeholder="请输入新密码">
                             </div>
                             <div class="form-group">
                                 <label>重复新密码</label>
                                 <input type="password" id="repassword" class="form-control" placeholder="请输入新密码">
                             </div>
                             <div class="clearfix"></div>
                             <button type="button" class="btn btn-success">提交</button>
                         </form>
				</div>
			</div>
		</div> 
		
	</body>
</html>