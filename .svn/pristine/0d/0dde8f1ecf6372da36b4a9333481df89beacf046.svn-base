<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html>
	<head>
		<title>入库</title>

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
	            var isSubmited = false;
	            $('#wizard').smartWizard({
	            	"labelNext":"下一步"
	            	,labelPrevious:"上一步"
	            	,labelFinish:"完成"
	            	,transitionEffect: 'slide'
	            	,includeFinishButton : false 
	            	,onShowStep:function($stepA,stepInfo){
	            		 $(".actionBar .customBtn").remove();
	            		 if(stepInfo.toStep==1){
			            	$(".stepContainer").css({"height":"440px","overflowY":"hidden"});
					        $(".actionBar").css({"paddingRight":"30%"}).find(" .buttonDisabled").remove();
					     }else if(stepInfo.toStep==2){
					     	$(".stepContainer").css({"height":"250px","overflowY":"hidden"});
					     	$(".actionBar .buttonDisabled").remove();
					     }else if(stepInfo.toStep==3){
					     	$(".stepContainer").css({"height":"450px","overflowY":"hidden"});
					     	$(".actionBar .buttonDisabled").remove();
					     	$(".actionBar").append('<a href="toAddWarehouse.do" class="btn btn-danger customBtn"> 新入库 </a>');
					     }
	            	}
	            	,onLeaveStep: function($stepA,stepInfo/*{fromStep:1,toStep:2}*/){ 
	            		var method = stepInfo.fromStep < stepInfo.toStep ? "goForward" : "goBackward";
	            		if(stepInfo.toStep==2){
	            			if($("#applyId").val()== ""){
	            				CommonCud.alert("请选择申请！");
	            				return false;
	            			}
	            			/**
	            			if(readTime==0){
	            				CommonCud.alert("您的核对时间在5秒内，提醒您请认真核对信息！");
	            			}
	            			**/
	            			
            		 	 	$("#hdn_applyId").val($("#applyId").val());
            		 	 	
	            		}else if(stepInfo.toStep==3){
	            			//,data:$("#step-"+stopObj.fromStep+" form").serialize()
	            			if(!isSubmited ){
		            			$.ajax({
		            				url: "addWarehouse.do"
		            				,data:$("#step-"+stepInfo.fromStep+" form").serialize()
		            				,success:function(warehouse){
		            					 isSubmited = true;
		            					 
		            					 var v = $("#applyId").val();
		            					 var data = v == "" ? {
                                                  			contactUnit:""
                                                  			,contacts:''
                                                  			,address:''
                                                  			,telephone:''
                                                  			,sendType: -1
                                                  			,articleType: -1
                                                  			,explain:''
                                                  			,explain2:''
                                                  		} : applys[v];
                                                  		
                                      	function display(pojo,name,fn){
			            					$("#"+name+"_2_lable").html(fn?fn(pojo[name]):pojo[name]);
			            				}
			            				
			            				display(data,'contactUnit');
			            				display(data,'contacts');
			            				display(data,'address');
			            				display(data,'telephone');
			            				display(data,'sendType',function(type){
			            					return type==1 ? "派车" :  type==0 ? "自送" : "" ;
			            				});
			            				display(data,'articleType',function(type){
			            					return type==1 ? "纸张" : type==2 ? "U盘" : type==3 ? "光盘" : type==4 ? "移动硬盘" : type==5 ? "笔记本" : "" ;
			            				});
			            				display(data,'explain');
			            				display(data,'explain2');
		            					 
		            					 
		            					display(warehouse,'labelNumber');
		            					 
		            					$('#wizard').smartWizard(method);
		            				}
		            				,error:function(){
		            					CommonCud.alert("处理失败！");
		            				}
		            			});
	            			}
	            			return isSubmited;
	            		}
	            		return true;
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
                                            <small>信息核对</small>
                                        </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#step-2">
                                                    <span class="step_no">2</span>
                                                    <span class="step_descr">
                                           	第二步<br />
                                            <small>扫描记录</small>
                                        </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#step-3">
                                                    <span class="step_no">3</span>
                                                    <span class="step_descr">
                                            第三步<br />
                                            <small>完成</small>
                                        </span>
                                                </a>
                                            </li>
                                        </ul>
                                        <div id="step-1">
                                            <form class="form-horizontal form-label-left">
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">申请: <span class="required">*</span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                       	<select id="applyId" class="form-control" onchange="changeContentInfos(this)">  <option value="" >请选择申请</option>     
                                                       	<c:forEach var="apply" items="${allStateList}">
                                                       		<option value="${apply.id}"><c:out value="${apply.contactUnit},${apply.contacts}(${apply.telephone})" escapeXml="true"></c:out></option>
                                                       	</c:forEach></select>
                                                       	<script type="text/javascript">
                                                       	var applys  = {};
                                                       	<c:forEach var="apply" items="${allStateList}">
                                                       		applys['${apply.id}'] = {
                                                       			id:${apply.id}
                                                       			,contactUnit:'<c:out value="${apply.contactUnit}" escapeXml="true"></c:out>'
                                                       			,contacts:'<c:out value="${apply.contacts}" escapeXml="true"></c:out>'
                                                       			,address:'<c:out value="${apply.address}" escapeXml="true"></c:out>'
                                                       			,telephone:'<c:out value="${apply.telephone}" escapeXml="true"></c:out>'
                                                       			,sendType:'<c:out value="${apply.sendType}" escapeXml="true"></c:out>'
                                                       			,articleType:'<c:out value="${apply.articleType}" escapeXml="true"></c:out>'
                                                       			,explain:'<c:out value="${apply.explain}" escapeXml="true"></c:out>'
                                                       			,explain2:'<c:out value="${apply.explain2}" escapeXml="true"></c:out>'
                                                       		};
                                                       	</c:forEach>
                                                       	var readTime = 0;
                                                       	function changeContentInfos(select){
                                                       		var v = select.value;
                                                       		
                                                       		var data = v == "" ? {
                                                       			contactUnit:""
                                                       			,contacts:''
                                                       			,address:''
                                                       			,telephone:''
                                                       			,sendType: -1
                                                       			,articleType: -1
                                                       			,explain:''
                                                       			,explain2:''
                                                       		} : applys[v];
                                                       		
                                                       		function display(pojo,name,fn){
								            					$("#"+name+"__lable").html(fn?fn(pojo[name]):pojo[name]);
								            				}
								            				
								            				display(data,'contactUnit');
								            				display(data,'contacts');
								            				display(data,'address');
								            				display(data,'telephone');
								            				display(data,'sendType',function(type){
								            					return type==1 ? "派车" :  type==0 ? "自送" : "" ;
								            				});
								            				display(data,'articleType',function(type){
								            					return type==1 ? "纸张" : type==2 ? "U盘" : type==3 ? "光盘" : type==4 ? "移动硬盘" : type==5 ? "笔记本" : "" ;
								            				});
								            				display(data,'explain');
								            				display(data,'explain2');
								            				
								            				readTime = 0;
								            				if(v==""){
								            					readTime = 1;
								            				}else{
								            					setTimeout(function(){
								            						readTime = 1;
								            					},5000);
								            				}
                                                       	}
                                                       	</script>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >单位: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <label class="form-control col-md-7 col-xs-12" id="contactUnit__lable" ></label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >联系人: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" id="contacts__lable" ></label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >地址: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" id="address__lable" ></label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >联系电话: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" id="telephone__lable" ></label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">送货方式 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                       <label class="form-control col-md-7 col-xs-12" id="sendType__lable" ></label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">物品类型 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                             <label class="form-control col-md-7 col-xs-12" id="articleType__lable" ></label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注1: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12" id="explain__lable" > </label>  
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注2: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12" id="explain2__lable"  ></label>  
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div id="step-2">
                                             <form class="form-horizontal form-label-left"><input type="hidden" name="applyId" id="hdn_applyId" />
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="labelNumber">条码: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="labelNumber" name="labelNumber" required="required" class="form-control col-md-7 col-xs-12">   
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div id="step-3">
                                            <h2 class="StepTitle" align="center" >已经完成入库！以下是入库信息。</h2>
                                            <form class="form-horizontal form-label-left">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">单位名称: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <label class="form-control col-md-7 col-xs-12" id="contactUnit_2_lable" > 什么什么单位</label>    
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">联系人: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12"   id="contacts_2_lable" >  什么人</label>    
                                                    </div>
                                                </div>
                                                  <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">联系电话: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        		<label class="form-control col-md-7 col-xs-12" id="telephone_2_lable" >  13XXXXXXXX </label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">物品类型 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                             <label class="form-control col-md-7 col-xs-12"  id="articleType_2_lable" >  U盘</label>    
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >备注1: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12" id="explain_2_lable"  > 备注1：备注1： 反季节as放假啊发安杰书店发</label>  
                                                    </div>
                                                </div>
                                                 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">备注2: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      	<label class="form-control col-md-7 col-xs-12"  id="explain2_2_lable"  >  备注2：备注2： 反vzfdadf</label>  
                                                    </div>
                                                </div>
												 <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">条码: 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                          <label class="form-control col-md-7 col-xs-12"  id="labelNumber_2_lable"  >  2 kg</label>  
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