<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><!DOCTYPE html>
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
				
				function validateFormInput2(){//验证表单
					console.log("validateFormInput2..");
					return true;
				}
				
	            // Smart Wizard 	
	            $('#wizard').smartWizard({
	            	"labelNext":"下一步"
	            	,labelPrevious:"上一步"
	            	,labelFinish:"完成"
	            	,transitionEffect: 'slide'
	            	
	            	,selected: <c:out value="${loginUser.id eq apply.submitUserId ? 1 : 0}"  default="0" /> // Selected Step, 0 = first step
	            	
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
	            		if(!isSubmited && stopObj.toStep == <c:out value="${loginUser.id eq apply.submitUserId ? 3 : 2}"  default="1" /> 
	            			&& validateFormInput<c:out value="${loginUser.id eq apply.submitUserId ? '2' : ''}"  default="" />() ){
	            			console.log($("#step-"+stopObj.fromStep+" form").serialize());
	            			$.ajax({
	            				url:"<c:out value="${loginUser.id eq apply.submitUserId ? 'ajaxUpdateApplyAndAudit.do' :'ajaxAddApply.do?state=1' }"  default="ajaxAddApply.do?state=1" />"
	            				,data:$("#step-"+stopObj.fromStep+" form").serialize()
		            			,success:function(data){
		            				isSubmited = true;
		            				<c:if test="${loginUser.id eq apply.submitUserId}">
		            				var  audit  = data;
		            				data = audit.relashipApply;</c:if>
		            				
		            				function display(pojo,name,fn){
		            					$("#"+name+"_<c:out value="${loginUser.id eq apply.submitUserId ? '2' : ''}"  default="" />_lable").html(fn?fn(pojo[name]):(pojo[name]?pojo[name]:"无"));
		            				}
		            				
		            				display(data,'contactUnit');
		            				display(data,'contacts');
		            				display(data,'address');
		            				display(data,'telephone');
		            				display(data,'sendType',function(type){
		            					return type==1 ? "派车" : "自送";
		            				});
		            				
		            				display(data,'articleDesc');
		            				display(data,'articleType',function(type){
		            					return type==1 ? "纸质" :  /*type==2 ?*/ "磁介" ;
		            				});
		            				display(data,'nowDestroy',function(type){
		            					return type==0 ? "否" : type==1 ? "是" : "未知" ;
		            				});
		            				display(data,'explain');
		            				display(data,'explain2');
		            				
		            				<c:if test="${loginUser.id eq apply.submitUserId}">
		            				display(audit,'audit_explain');
		            				</c:if>
		            				
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
					     }else if(stepInfo.toStep==2){<c:choose>
					     	<c:when test="${loginUser.id eq apply.submitUserId}">
					     	$(".stepContainer").css({"height":"580px","overflowY":"hidden"});
					     	$(".actionBar .btn-primary").hide();
					     	</c:when><c:otherwise>
					     	//提交了申请就结束了。
					     	$(".stepContainer").css({"height":"470px","overflowY":"hidden"});
					     	$(".actionBar .btn").hide();
					     	$('<a href="toAddApply.do" class="btn btn-danger customBtn"> 提交新的 </a>').insertBefore(".actionBar .btn:first");
					     </c:otherwise></c:choose>
					     }else if(stepInfo.toStep==3){
					     	$(".stepContainer").css({"height":"620px","overflowY":"hidden"});
					     	$('<a href="allLingdaoList.do" class="btn btn-danger customBtn"> 返回 </a>').insertBefore(".actionBar .btn:first");
					     	$(".actionBar .btn.buttonDisabled").remove();
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
                                            <form class="form-horizontal form-label-left"><input type="hidden" name="id" value="${apply.id}" />
                                            	 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="contactUnit">上报领导: <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                    	<select id="submitUserId" name="submitUserId"  class="form-control col-md-7 col-xs-12">
                                                    	<c:forEach var="user" items="${users}">	<option value="<c:out value="${user.id}" escapeXml="true" ></c:out>" ${apply.submitUserId eq user.id ? 'selected="selected"' : '' } >${user.nickName}</option></c:forEach>
                                                    	</select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="contactUnit">单位名称: <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="contactUnit" name="contactUnit" value="<c:out value="${apply.contactUnit}" escapeXml="true" ></c:out>" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="contacts">联系人:  <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="contacts" name="contacts"  value="<c:out value="${apply.contacts}" escapeXml="true" ></c:out>" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="telephone">联系电话:  <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="telephone" name="telephone" value="<c:out value="${apply.telephone}" escapeXml="true" ></c:out>" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="address">单位地址: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="address" name="address" value="<c:out value="${apply.address}" escapeXml="true" ></c:out>" required="required" class="form-control col-md-7 col-xs-12">
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
                                                    	<input id="articleDesc" name="articleDesc"  class="form-control col-md-7 col-xs-12" value="<c:out value="${apply.articleDesc}" escapeXml="true" ></c:out>" />
                                                    </div>
                                                </div> 
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">送货方式 <span class="required">*</span></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <div id="gender" class="btn-group" data-toggle="buttons">
                                                           <label class="btn ${apply.sendType eq 1 ? 'btn-primary active' :'btn-default'}" onclick="toggleInput('plan_time_container')" >
                                                                <input autocomplete="off" type="radio" name="sendType" value="1"  ${apply.sendType eq 1 ? ' checked="checked"' :''} > 派车
                                                            </label>
                                                             <label class="btn ${apply.sendType eq 0 ? 'btn-primary active' :'btn-default'}" >
                                                                <input autocomplete="off" type="radio" name="sendType" value="0" ${apply.sendType eq 0 ? ' checked="checked"' :''}> 自送 
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                 <div class="form-group" id="plan_time_container" style="${apply.sendType eq 1 ? 'display: none;' :''}" onclick="toggleInput('plan_time_container',true)">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">预计送达日期 <span class="required">*</span></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                    	<input id="reservation" name="oneselfSendTime" readonly="readonly"  value="<fmt:formatDate value="${apply.oneselfSendTime}" pattern="yyyy-MM-dd" ></fmt:formatDate>" class="form-control col-md-7 col-xs-12" />
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">是否监销 <span class="required">*</span></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <div id="gender" class="btn-group" data-toggle="buttons">
                                                           <label class="btn ${apply.nowDestroy eq 0 ? 'btn-primary active' :'btn-default'}"  onclick="toggleInput('destroy_time_container')">
                                                                <input autocomplete="off" type="radio" name="nowDestroy" value="0" ${apply.nowDestroy eq 0 ? ' checked="checked"' :''}>&nbsp; 否 &nbsp;
                                                            </label>
                                                             <label class="btn ${apply.nowDestroy eq 1 ? 'btn-primary active' :'btn-default'}" >
                                                                <input autocomplete="off" type="radio" name="nowDestroy" value="1" ${apply.nowDestroy eq 1 ? ' checked="checked"' :''}>&nbsp; 是 &nbsp;
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group" id="destroy_time_container" style="${apply.nowDestroy eq 0 ? 'display: none;' :''}"  onclick="toggleInput('destroy_time_container',true)">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">计划销毁日期 <span class="required">*</span></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                    	<input id="reservation2" name="planDateOfDestroy"  readonly="readonly"   value="<fmt:formatDate value="${apply.planDateOfDestroy}" pattern="yyyy-MM-dd" ></fmt:formatDate>" class="form-control col-md-7 col-xs-12" />
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="explain">备注1: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="explain" name="explain" value="${apply.explain}" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="explain2">备注2: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="explain2" name="explain2"  value="${apply.explain2}"  required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div id="step-2">
                                             <form class="form-horizontal form-label-left"><c:if test="${loginUser.id eq apply.submitUserId}">
                                             	 <input type="hidden" name="id" value="${audits[0].id}" />
                                             	 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >提交人: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <label class="form-control col-md-7 col-xs-12" id="contactUnit__lable" ><c:out value="${apply.name}" escapeXml="true" /></label>    
                                                    </div>
                                                </div></c:if>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >单位: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <label class="form-control col-md-7 col-xs-12" id="contactUnit__lable" ><c:out value="${apply.contactUnit}" escapeXml="true" /></label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >联系人: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" id="contacts__lable" ><c:out value="${apply.contacts}" escapeXml="true" /></label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >地址: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" id="address__lable" ><c:out value="${apply.address}" escapeXml="true" /></label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >联系电话: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" id="telephone__lable" ><c:out value="${apply.telephone}" escapeXml="true" /></label>    
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
                                                       <label class="form-control col-md-7 col-xs-12" id="sendType__lable" > <c:choose> <c:when test="${apply.sendType eq 1}">派车</c:when><c:when test="${apply.sendType eq 0}">自送</c:when></c:choose></label>    
                                                    </div>
                                                </div>
                                                <!-- 
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">物品类型 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                             <label class="form-control col-md-7 col-xs-12" id="articleType__lable" >  <c:choose> 
                                                             																		<c:when test="${apply.articleType eq 1}">纸质</c:when>
                                                             																		<c:when test="${apply.articleType eq 2}">磁介</c:when>
                                                             																		</c:choose></label>    
                                                    </div>
                                                </div> -->
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">是否监销 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                             <label class="form-control col-md-7 col-xs-12" id="nowDestroy__lable" >${ apply.nowDestroy eq 0 ? '否' :'是' }</label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注1: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12" id="explain__lable" > <c:out value="${apply.explain}" escapeXml="true" /></label>  
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注2: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12" id="explain2__lable"  ><c:out value="${apply.explain2}" escapeXml="true" /></label>  
                                                    </div>
                                                </div><c:choose><c:when test="${loginUser.id eq apply.submitUserId}">
												 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">批示: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <textarea required="required" name="audit_explain" class="form-control col-md-7 col-xs-12"><c:out value="${audits[0].audit_explain}" escapeXml="true" /></textarea>
                                                    </div>
                                                </div></c:when><c:otherwise>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">状态: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                    	<span class="label label-warning">等待领导批示</span>
                                                    </div>
                                                </div></c:otherwise></c:choose>
                                            </form>
                                        </div>
                                        <div id="step-3">
                                            <h2 class="StepTitle" align="center" >已经完成请求！以下是申请信息。</h2>
                                             <form class="form-horizontal form-label-left"><c:if test="${loginUser.id eq apply.submitUserId}">
                                             	 <input type="hidden" name="id" value="${audits[0].id}" />
                                             	 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >提交人: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <label class="form-control col-md-7 col-xs-12" id="contactUnit_2_lable" ><c:out value="${apply.name}" escapeXml="true" /></label>    
                                                    </div>
                                                </div></c:if>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >单位: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <label class="form-control col-md-7 col-xs-12" id="contactUnit_2_lable" ><c:out value="${apply.contactUnit}" escapeXml="true" /></label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >联系人: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" id="contacts_2_lable" ><c:out value="${apply.contacts}" escapeXml="true" /></label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >地址: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" id="address_2_lable" ><c:out value="${apply.address}" escapeXml="true" /></label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >联系电话: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" id="telephone_2_lable" ><c:out value="${apply.telephone}" escapeXml="true" /></label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">送货方式 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                       <label class="form-control col-md-7 col-xs-12" id="sendType_2_lable" > <c:choose> <c:when test="${apply.sendType eq 1}">派车</c:when><c:when test="${apply.sendType eq 0}">自送</c:when></c:choose></label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">物品类型 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                             <label class="form-control col-md-7 col-xs-12" id="articleType_2_lable" >  <c:choose> 
                                                             																		<c:when test="${apply.articleType eq 1}">纸张</c:when>
                                                             																		<c:when test="${apply.articleType eq 2}">U 盘</c:when>
                                                             																		<c:when test="${apply.articleType eq 3}">光盘</c:when>
                                                             																		<c:when test="${apply.articleType eq 4}">移动硬盘</c:when>
                                                             																		<c:when test="${apply.articleType eq 5}">笔记本</c:when>
                                                             																		</c:choose></label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">是否监销 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                             <label class="form-control col-md-7 col-xs-12" id="nowDestroy_2_lable" >${ apply.nowDestroy eq 0 ? '否' :'是' }</label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注1: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12" id="explain_2_lable" > <c:out value="${apply.explain}" escapeXml="true" /></label>  
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注2: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12" id="explain2_2_lable"  ><c:out value="${apply.explain2}" escapeXml="true" /></label>  
                                                    </div>
                                                </div>
												 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">批示: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <textarea disabled="disabled" required="required" name="audit_explain"  id="audit_explain_2_lable" class="form-control col-md-7 col-xs-12"></textarea>
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