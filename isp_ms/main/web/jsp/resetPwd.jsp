<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><!DOCTYPE html>
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
<script src="js/md5.js"></script>
   
<script type="text/javascript">

	function check(){
    		//$(":input[name='userName']").val("fsdfsfs")
    		$(":input[name='repassword']").val(hex_md5($(":input[name='repassword']").val()));
    		$(":input[name='passWord']").val(hex_md5($(":input[name='passWord']").val()));
    		$(":input[name='userName']").val(hex_md5($(":input[name='userName']").val()));
    		return true;
    	}
	//验证密码复杂度
	function checkPass(s) {

		if (s.length < 8) {
			return 0;
		}
		var ls = 0;
		if (s.match(/([a-z])+/)) {
			ls++;

		}
		if (s.match(/([0-9])+/)) {
			ls++;
		}
		if (s.match(/([A-Z])+/)) {
			ls++;

		}
		if (s.match(/[^a-zA-Z0-9]+/)) {
			ls++;

		}
		return ls

	}
	function checkPwd(pwd){
		if (checkPass(pwd.value) < 3) {
			alert("密码复杂度不够，请重新设置！");
			pwd.value="";
			return false;
		}
	}
	
	
	$(function() {
		//CommonCud
		$("form .btn-success").click(function() {
			check();
			if ($("#repassword").val() != $("form [name=passWord]").val()) {
				CommonCud.alert("两次新密码输入不一致，请重新输入！");
				return false;
			}
			$.ajax({
				url : "resetPwd.do",
				data : $("form").serialize(),
				success : function(msg) {
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
				<h2>修改密码</h2>
				<div class="clearfix"></div>
			</div>

			<div class="x_content">
				<form class="form-horizontal form-label-left" onsubmit="return check()">
					<div class="form-group">
						<label>旧密码</label> <input type="password" name="userName"
							class="form-control" placeholder="请输入旧密码">
					</div>
					<div class="form-group">
						<label>新密码</label> <input type="password" name="passWord"
							class="form-control" placeholder="请输入新密码"
							onblur="checkPwd(this)">
					</div>
					<div class="form-group">
						<label>重复新密码</label> <input type="password" id="repassword" name="repassword"
							class="form-control" placeholder="请输入新密码">
					</div>
					<div class="clearfix"></div>
					<button type="button" class="btn btn-success">提交</button>
				</form>
			</div>
		</div>
	</div>

</body>
</html>