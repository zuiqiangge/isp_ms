<%@ page language="java"  pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>销毁管理系统 |  <sitemesh:write property='title' />  </title>
	
	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
	
    <!-- Bootstrap core CSS -->

    <link href="css/bootstrap.min.css" rel="stylesheet">

    <link href="fonts/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">

    <!-- Custom styling plus plugins -->
    <link href="css/custom.css" rel="stylesheet">
    
    <!-- green icheck thme -->
    <link href="css/icheck/flat/green.css" rel="stylesheet">
    
    <script src="js/jquery.min.js"></script>
    </script>
    <!--[if lt IE 9]>
        <script   type="text/javascript">
		if (window.location.protocol == 'file:')
		  alert("ERROR: Bootstrap's responsive CSS is disabled!\nSee getbootstrap.com/getting-started/#respond-file-proto for details.")
        </script>
    <![endif]-->
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
         <script src="${basePath}js/html5shiv.min.js" type="text/javascript"></script>
         <script src="${basePath}js/respond.min.js" type="text/javascript"></script>
    <![endif]-->
</head>
<body  class="nav-sm">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				 <div class="left_col">

                    <div class="navbar nav_title" style="border: 0;margin-top: 10px;">
                        <a href="index.do" class="site_title">
                       <span class="fa-stack " style="display: inline-block;" >
				          <i class="fa fa-cloud fa-stack-2x  fa-flip-horizontal"
				          style="display: inline-block;
							    color: #E7E7E7;
							    border: none;
							    font-size: 43px;
							    padding: 0 0;
							    margin: 0 0;
							    border-radius: 0;
							" 
				          ></i>
				          <i class="fa fa-close fa-stack-1x" 
				          style="display: inline-block;
							    color: #73879C;
							    font-size: 19px;
							    border: none;
							    padding: 0 0;
							    margin: 0 0;
							    border-radius: 0;
							" ></i>
				        </span><span> 销毁管理系统</span></a>
                    </div>
                    <div class="clearfix"></div>
      
                    <!-- menu prile quick info -->
                    <div class="profile">
                        <div class="profile_pic">
                            <img src="images/img.jpg" alt="..." class="img-circle profile_img">
                        </div>
                        <div class="profile_info">
                            <span>欢迎您,</span>
                            <h2>${loginUser.nickName }</h2>
                        </div>
                    </div>
                    <!-- /menu prile quick info -->

                    <br />
                    <!-- sidebar menu -->
                    <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">

                        <div class="menu_section">
                             <h3>导航</h3>
                             <ul class="nav side-menu">
                             	<c:forEach var="resource" items="${userResources}"><c:if test="${empty resource.parentId}">
                                <li><a href="${not empty resource.url ? resource.url : 'javascript:;'}" ><i class="fa ${ not empty resource.iconName ? resource.iconName : 'fa-windows' }"></i>${resource.name}
                                	<c:if test="${ not empty resource.childs }"><span class="fa fa-chevron-down"></span></c:if>
                                </a><c:if test="${ not empty resource.childs }">
                                    <ul class="nav child_menu" style="display: none">
                                    	<c:forEach var="subResource" items="${resource.childs}">
                                        <li><a href="${subResource.url}">${subResource.name}</a>
                                        </li></c:forEach>
                                    </ul></c:if>
                                </li></c:if></c:forEach>
                                <%--
                                <li><a href="index.do" ><i class="fa fa-home"></i> 欢迎首页 
                                </a>
                                </li>
                                <li><a><i class="fa fa-edit"></i> 销毁申请 <span class="fa fa-chevron-down"></span></a>
                                    <ul class="nav child_menu" style="display: none">
                                        <li><a href="toAddApply.do">提交申请</a>
                                        </li>
                                        <li><a href="allUsersApply.do">历史申请</a>
                                        </li>
                                        <li><a href="allLingdaoList.do">需批示申请</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a><i class="fa fa-desktop"></i> 车辆调度 <span class="fa fa-chevron-down"></span></a>
                                    <ul class="nav child_menu" style="display: none">
                                        <li><a href="isMonitorDestroyList.do?sendType=1">派车</a>
                                        </li>
                                        <li><a href="listAllCar.do">车辆信息管理</a>
                                        </li>
                                    </ul>
                                </li><!--
                                <li><a><i class="fa fa-table"></i> 监销调度 <span class="fa fa-chevron-down"></span></a>
                                    <ul class="nav child_menu" style="display: none">
                                        <li><a href="toJsp.jsp?path=listSuperviseApply.jsp">派人监销</a>
                                        </li>
                                    </ul>
                                </li>-->
                                <li><a><i class="fa fa-bar-chart-o"></i> 销毁登记 <span class="fa fa-chevron-down"></span></a>
                                    <ul class="nav child_menu" style="display: none">
                                        <li><a href="toAddDestroy.do">作业登记</a>
                                        </li>
                                        <!-- 
                                       <li><a href="allWarehouseList">监销上报</a>
                                        </li> -->
                                    </ul>
                                </li>
                                <li><a><i class="fa fa-bug"></i> 销后计量 <span class="fa fa-chevron-down"></span></a>
                                    <ul class="nav child_menu" style="display: none">
                                        <li><a href="toLogWeight.do">计量登记</a>
                                        </li>
                                        <li><a href="pageWeightLog.do">历史计量</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a><i class="fa fa-windows"></i> 统计报表 <span class="fa fa-chevron-down"></span></a>
                                    <ul class="nav child_menu" style="display: none">
                                        <li><a href="toJsp.jsp?path=count1.jsp">库存量统计</a>
                                        </li>
                                        <li><a href="toJsp.jsp?path=count2.jsp">销毁类型统计</a>
                                        </li>
                                        <li><a href="toJsp.jsp?path=count3y.jsp">监督量统计</a>
                                        </li>
                                        <li><a href="toJsp.jsp?path=count3y.jsp">申请量统计</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a><i class="fa fa-laptop"></i> 系统管理 </a>
                                	 <ul class="nav child_menu" style="display: none">
                                        <li><a href="listAllUsers.do">用户信息管理</a>
                                        </li>
                                        <li><a href="listAllResource.do">权限项管理</a>
                                        </li>
                                        <li><a href="listAllPosition.do">职位管理</a>
                                        </li>
                                        <li><a href="listAllDepartment.do">部门管理</a>
                                        </li>
                                    </ul>
                                </li> --%>
                            </ul>
                        </div>

                    </div>
                    <!-- /sidebar menu -->
					<script type="text/javascript">
					  // toggle full screen
			         function toggleFullScreen(){
				          if (!document.fullscreenElement && 
				              !document.mozFullScreenElement && !document.webkitFullscreenElement) {
				            if (document.documentElement.requestFullscreen) {
				              document.documentElement.requestFullscreen();
				            } else if (document.documentElement.mozRequestFullScreen) {
				              document.documentElement.mozRequestFullScreen();
				            } else if (document.documentElement.webkitRequestFullscreen) {
				              document.documentElement.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
				            }
				          } else {
				            if (document.cancelFullScreen) {
				              document.cancelFullScreen();
				            } else if (document.mozCancelFullScreen) {
				              document.mozCancelFullScreen();
				            } else if (document.webkitCancelFullScreen) {
				              document.webkitCancelFullScreen();
				            }
				         }
			         }
					</script>
                    <!-- /menu footer buttons -->
                    <div style="display: none;"  class="sidebar-footer hidden-small">
                        <a href="javascript:$('.side-menu li a:contains(系统管理)').trigger('click');" data-toggle="tooltip" data-placement="top" title="设置">
                            <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
                        </a>
                        <a href="javascript:toggleFullScreen();" data-toggle="tooltip" data-placement="top" title="全屏">
                            <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
                        </a>
                        <a href="javascript:toggleFullScreen();" data-toggle="tooltip"  data-placement="top"  title="退出全屏">
                            <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
                        </a>
                        <a href="logout.do" data-toggle="tooltip" data-placement="top" title="注销">
                            <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
                        </a>
                    </div>
                    <!-- /menu footer buttons -->
                </div>
				
			</div>
			
			<!-- top navigation -->
            <div class="top_nav">
 
                <div class="nav_menu">
                    <nav class="" role="navigation">
                        <div class="nav toggle">
                            <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                        </div>
 						<h1 id="top_title" >销毁管理系统</h1>
                        <ul class="nav navbar-nav navbar-right">
                            <li class="">
                                <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    <img src="images/img.jpg" alt="">${loginUser.nickName }
                                    <span class=" fa fa-angle-down"></span>
                                </a>
                                <ul class="dropdown-menu dropdown-usermenu animated fadeInDown pull-right">
                                    <li><a href="toResetPwd.do">修改密码</a>
                                    </li>
<!--                                    <li>-->
<!--                                        <a href="javascript:;">-->
<!--                                            <span class="badge bg-red pull-right">50%</span>-->
<!--                                            <span>Settings</span>-->
<!--                                        </a>-->
<!--                                    </li>-->
                                    <li><a href="logout.do"><i class="fa fa-sign-out pull-right"></i>注销</a>
                                    </li>
                                </ul>
                            </li>

                        </ul>
                    </nav>
                </div>
			 
			</div>
            <!-- /top navigation -->
			<!-- page content -->
            <div class="right_col" role="main">
            	<div class="x">
            	
            		<!-- page title -->
            		 <div class="page-title">
                        <div class="title_left">
                            <h3>
			                    <sitemesh:write property='title' /> 
			                </h3>
                        </div>
                        <div class="title_right">
                            <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                               <!--
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Search for...">
                                    <span class="input-group-btn">
			                            <button class="btn btn-default" type="button">Go!</button>
			                        </span>
                                </div> 
                                --> 
                            </div>
                        </div>
            		</div><div class="clearfix"></div>
            		<!-- end  page title -->
            		<div class="row">
  	 					<sitemesh:write property='body' />
  	 				</div>
  	 			</div>
  	 			<!-- footer content -->
                <footer>
                    <div class="">
                        <p class="pull-right"> Copyright © 2015 鹏越惊虹. All Rights Reserved
                            | <span class="lead"> 销毁管理系统</span>
                        </p>
                    </div>
                    <div class="clearfix"></div>
                </footer>
                <!-- /footer content -->
    		</div>
		</div>    
    </div>
    <script src="${basePath}js/bootstrap.js" type="text/javascript"></script>
     <script type="text/javascript">
    //设置 ajax 
    //设置AJAX的全局默认选项
	jQuery.ajaxSetup( {
	    type: "POST" , // 默认使用POST方式
	    cache: false, //默认不缓存
	    global: true, //触发全局 AJAX 事件
	    beforeSend: function(jqXHR){ // 发送ajax之前的处理函数
	        // jqXHR 是经过jQuery封装的XMLHttpRequest对象
	        jQuery(".bs-ajax-modal-sm").last().modal();
	    },
	    complete : function(jqXHR){// 发送ajax无论成功或失败,当请求完成之后调用这个函数
	    	jQuery(".bs-ajax-modal-sm").last().modal("hide");
	    }
	} );
	var myLocales = {
		"zh":{
			applyLabel:"确定"
			,cancelLabel:"取消"
			,customRangeLabel:"自定义范围"
			,daysOfWeek:[
				"日"
				,"一"
				,"二"
				,"三"
				,"四"
				,"五"
				,"六"
			]
			,fromLabel:"从"
			,monthNames:[
				"一月"
				,"二月"
				,"三月"
				,"四月"
				,"五月"
				,"六月"
				,"七月"
				,"八月"
				,"九月"
				,"十月"
				,"十一月"
				,"十二月"
			]
			,toLabel:"到"
			,weekLabel:"周"
		  }
	};
	</script>
   	<sitemesh:write property='head' />
   	<script src="${basePath}js/custom.js" type="text/javascript"></script>
   	
     <div class="modal fade bs-confirm-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
         <div class="modal-dialog modal-sm">
             <div class="modal-content">
                 <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
                     </button>
                     <h4 class="modal-title" >系统提示</h4>
                 </div>
                 <div class="modal-body">
                 </div>
                 <div class="modal-footer">
                 	<button type="button" class="btn btn-success" data-dismiss="modal">确定</button>
                 	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                 </div>
             </div>
         </div>
     </div>
     
     <div class="modal fade bs-alert-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
         <div class="modal-dialog modal-sm">
             <div class="modal-content">

                 <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
                     </button>
                     <h4 class="modal-title" >系统提示</h4>
                 </div>
                 <div class="modal-body">
                 </div>
                 <div class="modal-footer">
                 	<button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                 </div>
             </div>
         </div>
     </div>
   	
   	<div class="modal fade bs-ajax-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
         <div class="modal-dialog modal-sm">
             <div class="modal-content">
                 <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
                     </button>
                     <h4 class="modal-title" >系统提示</h4>
                 </div>
                 <div class="modal-body">
                 	 <i style="font-size: 30px;" class="fa fa-spinner fa-spin"></i>
                 	 网络通信中。。。(完成后将自动关闭)
                 </div>
                 <div class="modal-footer">
                 </div>
             </div>
         </div>
     </div>
</body>
</html>