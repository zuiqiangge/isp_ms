<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html lang="zh">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>登录 </title>
	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
	
    <!-- Bootstrap core CSS -->

    <link href="css/bootstrap.min.css" rel="stylesheet">

    <link href="fonts/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">

    <!-- Custom styling plus plugins -->
    <link href="css/custom.css" rel="stylesheet">
    <link href="css/icheck/flat/green.css" rel="stylesheet">


    <script src="js/jquery.min.js"></script>

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

<body style="background:#F7F7F7;">
    
    <div class="">
        <a class="hiddenanchor" id="toregister"></a>
        <a class="hiddenanchor" id="tologin"></a>

        <div id="wrapper">
        	 <h1><span class="fa-stack "  >
				          <i class="fa fa-cloud fa-stack-2x  fa-flip-horizontal"  style="color: #73879C;"></i>
				          <i class="fa fa-close fa-stack-1x" style="color: #E7E7E7;" ></i>
				        </span> 销毁管理系统</h1>
            <div id="login" class="animate form" style="top:20px;">
                <section class="login_content">
                    <form action="login.do" method="post">
                        <h1>登录</h1>
                        <div>
                            <input type="text" class="form-control" name="userName" placeholder="请输入用户名" required="" />
                        </div>
                        <div>
                            <input type="password" class="form-control" name="passWord" placeholder="请输入密码" required="" />
                        </div>
                        <div>
                            <a class="btn btn-default submit" href="#" onclick="$(this).parents('form').submit()">登录</a>
                        </div>
                        <div class="clearfix"></div>
                        <div class="separator">
                            <div class="clearfix"></div>
                            <br />
                            <div>
                                <p>©2015 All Rights Reserved. 鹏越惊虹</p>
                            </div>
                        </div>
                    </form>
                    <!-- form -->
                </section>
                <!-- content -->
            </div>
        </div>
    </div>
	<c:if test="${not empty  loginErrorMsg}">
	<script type="text/javascript" src="js/notify/pnotify.core.js"></script>
	<script type="text/javascript" src="js/notify/pnotify.buttons.js"></script>
	<script type="text/javascript" src="js/notify/pnotify.nonblock.js"></script>
	<script type="text/javascript" >
        var permanotice, tooltip, _alert;
        $(function () {
            new PNotify({
                title: "系统提示：",
                type: "dark",
                text: "${loginErrorMsg}",
                nonblock: {
                    nonblock: true
                },
                before_close: function (PNotify) {
                    // You can access the notice's options with this. It is read only.
                    //PNotify.options.text;
                    // You can change the notice's options after the timer like this:
                    //PNotify.update({
                    //    title: PNotify.options.title + " - Enjoy your Stay",
                    //    before_close: null
                    //});
                    PNotify.queueRemove();
                    return false;
                }
            });
        });
	</script>
	</c:if>

</body>

</html>