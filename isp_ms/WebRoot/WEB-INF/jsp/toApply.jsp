<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html>
	<head>
		<title>申请</title>

		<!-- bootstrap progress js -->
		<script src="js/progressbar/bootstrap-progressbar.min.js"></script>
		<script src="js/nicescroll/jquery.nicescroll.min.js"></script>
		<!-- icheck -->
		<script src="js/icheck/icheck.min.js"></script>
		<script src="js/common-cud.js" type="text/javascript"></script>
		
		 <script type="text/javascript" src="js/wizard/jquery.smartWizard.js"></script>
		 
		 <!-- daterangepicker -->
		<script type="text/javascript" src="js/moment.min2.js"></script>
		<script type="text/javascript" src="js/datepicker/daterangepicker.js"></script>
		
		
		<script type="text/javascript">
			function toggleInput(id,isVisable){
				if(isVisable){
					$("#"+id).show();
				}else{
					$("#"+id).hide();
				}
			}
		
		
			$(function(){
				//初始化时间控件
				$('#reservation,#reservation2').daterangepicker({
						locale:myLocales.zh
						,singleDatePicker: true
						,format: 'YYYY-MM-DD'
					}, function (start, end, label) {
	            });
				
			
				var isSubmited = false;
				function validateFormInput(){//验证表单
					if($("#submitUserId").val()==""){
						CommonCud.alert("请选择上报领导！");
						return false;
					}
					if($("#contactUnit").val()==""){
						CommonCud.alert("请输入单元名称！",function(){
							$("#contactUnit")[0].select();
						});
						return false;
					}
					if($("#contacts").val()==""){
						CommonCud.alert("请输入联系人名称！",function(){
							$("#contacts")[0].select();
						});
						return false;
					}
					if($("#telephone").val()==""){
						CommonCud.alert("请输入联系电话！",function(){
							$("#telephone")[0].select();
						});
						return false;
					}
					if(!/(^(1\d{10})$|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8}))$)/i.test($("#telephone").val())){
						CommonCud.alert("请输入正确格式联系电话或者手机号！",function(){
							$("#telephone")[0].select();
						});
						return false;
					}
					
					if($("#articleDesc").val()==""){
						CommonCud.alert("请输入销毁物品简述！",function(){
							$("#articleDesc")[0].select();
						});
						return false;
					}
					
					if($("#reservation").is(":visible") && $.trim($("#reservation").val()) == ""  ){
						CommonCud.alert("请输入送达日期！",function(){
							$("#reservation")[0].click();
						});
						return false;
					}
					
					if($("#reservation2").is(":visible") && $.trim($("#reservation2").val()) == ""  ){
						CommonCud.alert("请输入计划日期！",function(){
							$("#reservation2")[0].click();
						});
						return false;
					}
					
					
					return true;
				}
				
				
	            // Smart Wizard 	
	            $('#wizard').smartWizard({
	            	"labelNext":"下一步"
	            	,labelPrevious:"上一步"
	            	,labelFinish:"完成"
	            	,transitionEffect: 'slide'
	            	,includeFinishButton : false 
	            	,onLeaveStep: function($stepA,stopObj/*{fromStep:1,toStep:2}*/){
	            		var method = stopObj.fromStep < stopObj.toStep ? "goForward" : "goBackward";
	            		if(isSubmited && method == "goBackward" ){
	            			CommonCud.alert("您已经提交申请了，不可以再回退修改！点击“提交新的”开始登记新的申请。");
	            			return false;
	            		}
	            		if(method == "goBackward" || isSubmited){
	            			return true;
	            		}
	            		if(!isSubmited && validateFormInput() ){
	            			$.ajax({
	            				url:"ajaxAddApply.do?state=1"
	            				,data:$("#step-"+stopObj.fromStep+" form").serialize()
		            			,success:function(data){
		            				isSubmited = true;
		            				function display(pojo,name,fn){
		            					$("#"+name+"__lable").html(fn?fn(pojo[name]):(pojo[name]?pojo[name]:"无"));
		            				}
		            				
		            				display(data,'contactUnit');
		            				display(data,'contacts');
		            				display(data,'address');
		            				display(data,'telephone');
		            				display(data,'sendType',function(type){
		            					return type==1 ? "派车" : "自送";
		            				});
		            				display(data,'articleType',function(type){
		            					return type==1 ? "纸质" :  /*type==2 ?*/ "磁介" ;
		            				});
		            				display(data,'articleDesc');
		            				display(data,'explain');
		            				display(data,'explain2');
		            				
		            				$('#wizard').smartWizard(method);
		            			}
		            			,error:function(){
		            				CommonCud.alert("提交失败，请检查输入内容！");
		            			}
		            		});
	            		}
	            		return isSubmited;//返回真 就继续下一步；
	            	}
	            	,onShowStep:function($stepA,stepInfo){
	            		 $(".actionBar .customBtn").remove();
	            		 if(stepInfo.toStep==1){
			            	$(".stepContainer").css({"height":"530px","overflowY":"hidden"});
					        $(".actionBar").css({"paddingRight":"30%"}).find(" .buttonDisabled").remove();
					        if(isSubmited){
					        	$('<a href="toAddApply.do" class="btn btn-danger customBtn"> 提交新的 </a>').insertBefore(".actionBar .btn");
					        }else{
					        	$('<a href="javascript:;" class="btn btn-success customBtn"> 暂 存 </a>').insertBefore(".actionBar .btn").click(function(){
					        		//alert("你点了保存！！表单"+(validateFormInput()?"":"不")+"通过!!");
					        		if(!validateFormInput()){
					        			return false;
					        		}		
					        		$.ajax({
			            				url:"ajaxAddApply.do?state=0"
			            				,data:$("#step-1 form").serialize()
				            			,success:function(data){
				            				CommonCud.alert("保存成功！",function(){
				            					location.href="allUsersApply.do";
				            				});
				            			}
				            			,error:function(){
				            				CommonCud.alert("提交失败，请检查输入内容！");
				            			}
				            		});
					        	});
					        }
					     }else if(stepInfo.toStep==2){
					     	//提交了申请就结束了。
					     	$(".stepContainer").css({"height":"470px","overflowY":"hidden"});
					     	$(".actionBar .btn").hide();
					     	$('<a href="toAddApply.do" class="btn btn-danger customBtn"> 提交新的 </a>').insertBefore(".actionBar .btn");
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
						申请销毁
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
                                            <small>提交申请给领导</small>
                                        </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#step-2">
                                                    <span class="step_no">2</span>
                                                    <span class="step_descr">
                                           	第二步<br />
                                            <small>领导批示</small>
                                        </span>
                                                </a>
                                            </li>
<!--                                            <li>-->
<!--                                                <a href="#step-3">-->
<!--                                                    <span class="step_no">3</span>-->
<!--                                                    <span class="step_descr">-->
<!--                                            第三步<br />-->
<!--                                            <small>安排相关人员</small>-->
<!--                                        </span>-->
<!--                                                </a>-->
<!--                                            </li>-->
                                            <li>
                                                <a href="#step-3">
                                                    <span class="step_no">3</span>
                                                    <span class="step_descr">
                                            第三步<br />
                                            <small>完成申请</small>
                                        </span>
                                                </a>
                                            </li>
                                        </ul>
                                        <div id="step-1">
                                            <form class="form-horizontal form-label-left">
                                            	 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="contactUnit">上报领导: <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                    	<select id="submitUserId" name="submitUserId"  class="form-control col-md-7 col-xs-12">
                                                    	<c:forEach var="user" items="${users}">	<option value="${user.id}">${user.nickName}</option></c:forEach>
                                                    	</select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="contactUnit">单位名称: <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="contactUnit" name="contactUnit" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="contacts">联系人:  <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="contacts" name="contacts" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="telephone">联系电话: <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="telephone" name="telephone" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="address">单位地址: <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="address" name="address" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                                <!-- 
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">物品类型 <span class="required">*</span></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <div  class="btn-group" data-toggle="buttons">
                                                            <label class="btn btn-primary active" >
                                                                <input autocomplete="off" type="radio" name="articleType" value="1" checked="checked"> 纸质 
                                                            </label>
                                                            <label class="btn btn-default" >
                                                                <input autocomplete="off" type="radio" name="articleType" value="2" > 磁介
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                -->
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="articleDesc">销毁物品简述: <span class="required">*</span></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                    	<input id="articleDesc" name="articleDesc"  class="form-control col-md-7 col-xs-12" />
                                                    </div>
                                                </div> 
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">送货方式: <span class="required">*</span></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <div id="gender" class="btn-group" data-toggle="buttons">
                                                           <label class="btn btn-primary active" onclick="toggleInput('plan_time_container')">
                                                                <input autocomplete="off" type="radio" name="sendType" value="1" checked="checked"> 派车
                                                            </label>
                                                             <label class="btn btn-default" onclick="toggleInput('plan_time_container',true)">
                                                                <input autocomplete="off" type="radio" name="sendType" value="0"> 自送 
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group" id="plan_time_container" style="display: none;">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">预计送达日期: <span class="required">*</span></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                    	<input id="reservation" name="oneselfSendTime" readonly="readonly"  class="form-control col-md-7 col-xs-12" />
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">是否监销: <span class="required">*</span></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <div id="gender" class="btn-group" data-toggle="buttons">
                                                           <label class="btn btn-primary active" onclick="toggleInput('destroy_time_container')">
                                                                <input autocomplete="off" type="radio" name="nowDestroy" value="0" checked="checked">&nbsp; 否&nbsp;
                                                            </label>
                                                             <label class="btn btn-default" onclick="toggleInput('destroy_time_container',true)">
                                                                <input autocomplete="off" type="radio" name="nowDestroy" value="1">&nbsp; 是&nbsp;
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                 <div class="form-group" id="destroy_time_container" style="display: none;">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">计划销毁日期: <span class="required">*</span></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                    	<input id="reservation2" name="planDateOfDestroy"  readonly="readonly"  class="form-control col-md-7 col-xs-12" />
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="explain">备注1: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="explain" name="explain" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="explain2">备注2: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="explain2" name="explain2" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div id="step-2">
                                             <form class="form-horizontal form-label-left">

                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >单位: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <label class="form-control col-md-7 col-xs-12" id="contactUnit__lable" >什么什么单位</label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >联系人: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" id="contacts__lable" >什么人</label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >地址: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" id="address__lable" >什么路</label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >联系电话: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" id="telephone__lable" >132XXXXXX</label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">销毁物品简述 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                             <label class="form-control col-md-7 col-xs-12" id="articleDesc__lable" > U盘</label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">送货方式 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                       <label class="form-control col-md-7 col-xs-12" id="sendType__lable" > 自送 </label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注1: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12" id="explain__lable" > 备注1...............</label>  
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注2: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12" id="explain2__lable"  >备注2...............</label>  
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">状态: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                    	<span class="label label-warning">等待领导批示</span>
                                                    </div>
                                                </div><%-- 
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
                                                </div>--%>
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