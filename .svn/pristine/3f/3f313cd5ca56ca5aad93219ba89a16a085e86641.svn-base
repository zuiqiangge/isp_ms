<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html>
	<head>
		<title>修改权限</title>

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
		
		<!-- BEGIN PAGE LEVEL SCRIPTS -->
		 <link href="css/jquery-nestable/jquery.nestable.css" rel="stylesheet">
		<script src="js/jquery-nestable/jquery.nestable.js"></script>  
		
		<script type="text/javascript">
		$(function(){
			function add2Form(e){
				//resouceId
            	$("form").find("input").remove();
            	var data = ( $('#nestable_list_2').nestable('serialize'));
            	for(i=0;i<data.length;i++){
            		if(data[i].children){
            			for(j=0;j<data[i].children.length;j++){
	            			$("form").append("<input type='hidden' name='resouceId' value='"+data[i].children[j].id+"' />");
	            		}
            		}
            		$("form").append("<input type='hidden' name='resouceId' value='"+data[i].id+"' />");
            	}
			}
			$('#nestable_list_1').nestable({
                group: 1
                ,maxDepth:2
                ,noChangeSelf:true
            }).on('change',add2Form);
            
            $('#nestable_list_2').nestable({
               	group: 1
                ,maxDepth:2
                 ,noChangeSelf:true
            }).on('change',add2Form);
            
            $(".btn-success").click(function(){
            	 $.ajax({
            	 	url:"grantUser.do"
            	 	,data:$("form").serialize()
            	 	,success:function(data){
            	 		CommonCud.commonAlert(data,function(){location.href=location.href;});
            	 	}
            	 });
            });	
		})
		</script>
	</head>
	<body>
		<div class="col-md-12 col-sm-12 col-xs-12">
			 <div class="row">
			 	<div class="col-md-12 col-xs-12">
			 		<div class="x_panel">
			 			<div class="x_content">
			 				<form  class="form-horizontal form-label-left"  >
			 					<div class="form-group">
			 						<label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">要设置的角色:
                                            </label>
                                     <div class="col-md-6 col-sm-6 col-xs-12">
                                            <select  id="last-name" name="roleId" required="required" class="form-control col-md-7 col-xs-12" type="text">
                                            	<option value="">请选择角色</option>
                                            	<c:forEach var="role" items="${roles}"><c:if test="${role.id ne 1}">
                                            	<option value="${role.id}">${role.name}</option>
                                            	</c:if></c:forEach>
                                            </select>
                                     </div>      
			 					</div>
							</form>
			 			</div>
			 		</div>
			 	</div>
			 </div>
			 <div class="row">
			 	 <div class="col-md-6 col-xs-12">
			 		<div class="x_panel">
						<div class="x_title">
							<h2>
								全部权限
							</h2>
							<div class="clearfix"></div>
						</div>
						<div class="x_content">
								<div class="dd" id="nestable_list_1">
									<ol class="dd-list dd-nodrag">
										<c:forEach var="resource" items="[Resource {targetPath: null, filtering: false, FileSet {directory: D:\\workspace\\destroy-center\\main\\java\\src, PatternSet [includes: {}, excludes: {**/*.java}]}}, Resource {targetPath: null, filtering: false, FileSet {directory: D:\\workspace\\destroy-center\\base\\java\\src, PatternSet [includes: {}, excludes: {**/*.java}]}}, Resource {targetPath: null, filtering: false, FileSet {directory: D:\\workspace\\destroy-center\\user\\java\\src, PatternSet [includes: {}, excludes: {**/*.java}]}}, Resource {targetPath: null, filtering: false, FileSet {directory: D:\\workspace\\destroy-center\\userinfo\\java\\src, PatternSet [includes: {}, excludes: {**/*.java}]}}, Resource {targetPath: null, filtering: false, FileSet {directory: D:\\workspace\\destroy-center\\loggin\\java\\src, PatternSet [includes: {}, excludes: {**/*.java}]}}, Resource {targetPath: null, filtering: false, FileSet {directory: D:\\workspace\\destroy-center\\apply\\java\\src, PatternSet [includes: {}, excludes: {**/*.java}]}}, Resource {targetPath: null, filtering: false, FileSet {directory: D:\\workspace\\destroy-center\\dispatch\\java\\src, PatternSet [includes: {}, excludes: {**/*.java}]}}, Resource {targetPath: null, filtering: false, FileSet {directory: D:\\workspace\\destroy-center\\archive\\java\\src, PatternSet [includes: {}, excludes: {**/*.java}]}}, Resource {targetPath: null, filtering: false, FileSet {directory: D:\\workspace\\destroy-center\\warehouse\\java\\src, PatternSet [includes: {}, excludes: {**/*.java}]}}]">
										<li class="dd-item" data-id="${resource.id}">
											<div class="dd-handle">${resource.name}</div>
											<c:if test="${not empty resource.childs}"><ol class="dd-list">
											<c:forEach var="child" items="${resource.childs}">
												<li class="dd-item" data-id="${child.id}">
													<div class="dd-handle">${child.name}</div>
												</li>
											</c:forEach></ol></c:if>
										</li></c:forEach>
								</ol>
							</div>
						</div>
			 		</div>
			 	 </div>
			 	 <div class="col-md-6 col-xs-12">
			 		<div class="x_panel">
						<div class="x_title">
							<h2>
								你想给的权限
							</h2>
							<div class="clearfix"></div>
						</div>
						<div class="x_content">
							<div class="dd"  id="nestable_list_2" >
								<div class="dd-empty"></div>
							</div>
						</div>
			 		</div>
			 	 </div>
			 </div>
			  <div class="row">
			 	<div class="col-md-12 col-xs-12">
			 		<div class="x_panel">
			 			<div class="x_content">
			 				<div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-5">
                                 <button type="submit" class="btn btn-success">提交</button>
                             </div>
			 			</div>
			 		</div>
			 	</div>
			 </div>
		</div> 
		
	</body>
</html>