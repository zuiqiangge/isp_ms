<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html>
	<head>
		<title>销毁</title>

		<!-- bootstrap progress js -->
		<script src="js/progressbar/bootstrap-progressbar.min.js"></script>
		<script src="js/nicescroll/jquery.nicescroll.min.js"></script>
		<!-- icheck -->
		<script src="js/icheck/icheck.min.js"></script>
		<script src="js/common-cud.js" type="text/javascript"></script>
		
		 <script type="text/javascript" src="js/wizard/jquery.smartWizard.js"></script>
		<script type="text/javascript">
			$(function(){
	            // Smart Wizard 	
	            $('#wizard').smartWizard({
	            	"labelNext":"下一步"
	            	,labelPrevious:"上一步"
	            	,labelFinish:"完成"
	            	,transitionEffect: 'slide'
	            	,includeFinishButton : false 
	            	,onShowStep:function($stepA,stepInfo){
	            		 $(".actionBar .customBtn").remove();
	            		 if(stepInfo.toStep==1){
			            	$(".stepContainer").css({"height":"310px","overflowY":"hidden"});
					        $(".actionBar").css({"paddingRight":"30%"}).find(" .buttonDisabled").remove();
					        $('<a href="#" class="btn btn-success customBtn"> 暂 存 </a>').insertBefore(".actionBar .btn");
					     }else if(stepInfo.toStep==2){
					     	$(".stepContainer").css({"height":"470px","overflowY":"hidden"}).find(" .buttonDisabled").remove();
					     	$('<a href="#" class="btn btn-danger customBtn"> 驳回 </a>').insertBefore(".actionBar .btn");
					     }else if(stepInfo.toStep==3){
					     	$(".stepContainer").css({"height":"350px","overflowY":"hidden"}).find(" .buttonDisabled").remove();
					     }
	            	}
            	});
			});
		</script>
	</head>
	<body>

		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						销毁作业
					</h2>
			 		 
					<div class="clearfix"></div>
				</div>

				<div class="x_content">
					 <div id="wizard" class="form_wizard wizard_horizontal">
                                        <ul class="wizard_steps">
                                            <li>
                                                <a href="#step-1">
                                                    <span class="step_no">1</span>
                                                    <span class="step_descr">
                                           	 第一步<br />
                                            <small>物品清点</small>
                                        </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#step-2">
                                                    <span class="step_no">2</span>
                                                    <span class="step_descr">
                                           	第二步<br />
                                            <small>称重或者扫描</small>
                                        </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#step-3">
                                                    <span class="step_no">3</span>
                                                    <span class="step_descr">
                                            第三步<br />
                                            <small>完成销毁</small>
                                        </span>
                                                </a>
                                            </li>
                                        </ul>
                                        <div id="step-1">
                                            <form class="form-horizontal form-label-left">

                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">单位: <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="first-name" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">联系人:  <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="last-name" name="last-name" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">送货方式 <span class="required">*</span></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <div id="gender" class="btn-group" data-toggle="buttons">
                                                           <label class="btn btn-primary active">
                                                                <input autocomplete="off" type="radio" name="gender" value="female" checked="checked"> 派车
                                                            </label>
                                                             <label class="btn btn-default" >
                                                                <input autocomplete="off" type="radio" name="gender" value="male"> &nbsp; 自送 &nbsp;
                                                            </label>
                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">物品类型 <span class="required">*</span></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <div  class="btn-group" data-toggle="buttons">
                                                            <label class="btn btn-primary active" >
                                                                <input autocomplete="off" type="radio" name="gender2" value="1"> &nbsp; 纸张 &nbsp;
                                                            </label>
                                                            <label class="btn btn-default" >
                                                                <input autocomplete="off" type="radio" name="gender2" value="2" checked="checked"> U盘
                                                            </label>
                                                             <label class="btn btn-default" >
                                                                <input autocomplete="off" type="radio" name="gender2" value="3"  > 光盘
                                                            </label>
                                                            <label class="btn btn-default">
                                                                <input autocomplete="off" type="radio" name="gender2" value="4" > 移动硬盘
                                                            </label>
                                                             <label class="btn btn-default" >
                                                                <input autocomplete="off" type="radio" name="gender2" value="5"  > 笔记本
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">是否监销 <span class="required">*</span></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <div id="gender" class="btn-group" data-toggle="buttons">
                                                           <label class="btn btn-primary active">
                                                                <input autocomplete="off" type="radio" name="gender" value="female" checked="checked"> &nbsp; 是 &nbsp;
                                                            </label>
                                                             <label class="btn btn-default" >
                                                                <input autocomplete="off" type="radio" name="gender" value="male"> &nbsp; 否 &nbsp;
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注1: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="last-name" name="last-name" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注2: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="last-name" name="last-name" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
<!--                                                 <div class="form-group">-->
<!--                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">预计时间端: -->
<!--                                                    </label>-->
<!--                                                    <div class="col-md-6 col-sm-6 col-xs-12">-->
<!--                                                        <input type="text" id="last-name" name="last-name" required="required" class="form-control col-md-7 col-xs-12">-->
<!--                                                    </div>-->
<!--                                                 </div>-->
                                            </form>
                                        </div>
                                        <div id="step-2">
                                             <form class="form-horizontal form-label-left">

                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">单位: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <label class="form-control col-md-7 col-xs-12" > 什么什么单位</label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">联系人: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" >  什么人</label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">送货方式 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                       <label class="form-control col-md-7 col-xs-12" >  自送 </label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">物品类型 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                             <label class="form-control col-md-7 col-xs-12" >  U盘</label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注1: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12" > 备注1：备注1： 反季节as放假啊发安杰书店发</label>  
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注2: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12" >  备注2：备注2： 反vzfdadf</label>  
                                                    </div>
                                                </div>
												 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">监销人: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                         <input type="text"  required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
												 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">批示: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <textarea required="required" class="form-control col-md-7 col-xs-12"></textarea>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
<!--                                        <div id="step-3">-->
<!--                                             <form class="form-horizontal form-label-left">-->
<!---->
<!--                                                <div class="form-group">-->
<!--                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">单位: -->
<!--                                                    </label>-->
<!--                                                    <div class="col-md-6 col-sm-6 col-xs-12">-->
<!--                                                        <label class="form-control col-md-7 col-xs-12" > 什么什么单位</label>    -->
<!--                                                    </div>-->
<!--                                                </div>-->
<!--                                                <div class="form-group">-->
<!--                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">联系人: -->
<!--                                                    </label>-->
<!--                                                    <div class="col-md-6 col-sm-6 col-xs-12">-->
<!--                                                        		<label class="form-control col-md-7 col-xs-12" >  什么人</label>    -->
<!--                                                    </div>-->
<!--                                                </div>-->
<!--                                                 <div class="form-group">-->
<!--                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">物品类型 :</label>  -->
<!--                                                    <div class="col-md-6 col-sm-6 col-xs-12">-->
<!--                                                             <label class="form-control col-md-7 col-xs-12" >  U盘</label>    -->
<!--                                                    </div>-->
<!--                                                </div>-->
<!--                                                 <div class="form-group">-->
<!--                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注1: -->
<!--                                                    </label>-->
<!--                                                    <div class="col-md-6 col-sm-6 col-xs-12">-->
<!--                                                      	<label class="form-control col-md-7 col-xs-12" > 备注1：备注1： 反季节as放假啊发安杰书店发</label>  -->
<!--                                                    </div>-->
<!--                                                </div>-->
<!--                                                 <div class="form-group">-->
<!--                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注2: -->
<!--                                                    </label>-->
<!--                                                    <div class="col-md-6 col-sm-6 col-xs-12">-->
<!--                                                      	<label class="form-control col-md-7 col-xs-12" >  备注2：备注2： 反vzfdadf</label>  -->
<!--                                                    </div>-->
<!--                                                </div>-->
<!--												 <div class="form-group">-->
<!--                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">司机: -->
<!--                                                    </label>-->
<!--                                                    <div class="col-md-6 col-sm-6 col-xs-12">-->
<!--                                                         <input type="text"  required="required" class="form-control col-md-7 col-xs-12">-->
<!--                                                    </div>-->
<!--                                                </div>-->
<!--                                            </form>-->
<!--                                        </div>-->
                                        <div id="step-3">
                                            <h2 class="StepTitle" align="center" >已经完成请求！以下是申请信息。</h2>
                                            <form class="form-horizontal form-label-left">

                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">单位: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <label class="form-control col-md-7 col-xs-12" > 什么什么单位</label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">联系人: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" >  什么人</label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">物品类型 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                             <label class="form-control col-md-7 col-xs-12" >  U盘</label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注1: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12" > 备注1：备注1： 反季节as放假啊发安杰书店发</label>  
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注2: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12" >  备注2：备注2： 反vzfdadf</label>  
                                                    </div>
                                                </div>
												 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">司机: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                         <input type="text"  required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                            </form>
                                        </div>

                                    </div>
                                    <!-- End SmartWizard Content -->
				</div>
			</div>
		</div> 
		
	</body>
</html>