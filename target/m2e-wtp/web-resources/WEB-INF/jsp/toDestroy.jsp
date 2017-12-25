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
			function showAddArticleModal(){
				$(".bs-add-modal-lg").modal();
			}
			
			function warehouse(){
				$(".wizard_content:visible from").append("<input type='hidden' value='1' name='isWarehouse' />");
				$('#wizard').smartWizard("goForward");
			}
		
			function validateForm(){
				if($("#step-2 input[name=type]").length == 0){
					CommonCud.alert("请至少添加一个物品！");
					return false;
				}
				return true;
			}
		
			$(function(){
				$("#typeSelect").change(function(){
					var $this =  $(this).parents(".form-group");
					var $thisSiblings = $this.siblings();
					$thisSiblings.hide().filter(".type"+$(this).val()).show();
				});
				
				function article2Html(article,isEdit){
					 var html = 
					 '<div class="form-group article-info">'+
                         ' <label class="control-label col-md-3 col-sm-3 col-xs-12"  >'+
                         ' </label>'+
                         ' <div class="col-md-6 col-sm-6 col-xs-12">'+
                            	'<label class="form-control col-md-7 col-xs-12"  style="padding-top:0px;"  >';
                     var formVal2html = isEdit ? ' <a><i class="fa fa-close"></i></a>  ' : '';
                     var endhtml = '	</label>   </div> </div>';
                     
                     if(article.typeParent == 0){
                     	formVal2html += '<span class="label label-info">纸质</span><input type="hidden" name="type" value="0" /><input type="hidden" name="typeParent" value="0" /> ';
                     	formVal2html += '<span class="label label-info">重量：'+article.num+'kg</span><input type="hidden" name="num" value="'+article.num+'" /> ';
                     }else{
                     	formVal2html += '<span class="label label-info">磁介</span><input type="hidden" name="typeParent" value="1" /> ';
                     	formVal2html += '<span class="label label-info">磁介类型：'+$("#ciType").find("[value="+article.type+"]").text()+'</span><input type="hidden" name="type" value="'+article.type+'" /> ';
                     	formVal2html += '<span class="label label-info">数量：'+article.num+'</span><input type="hidden" name="num" value="'+article.num+'" /> ';
                     }
                     return html+formVal2html+endhtml;
				}
				
				$(".bs-add-modal-lg .btn-success").click(function(){
					 var $contentDiv = $(".wizard_content:visible").parent();
					 var article = {};
                     var typeVal = $("#typeSelect").val();
                     if(typeVal==""){
                     	CommonCud.alert("请选择类型！");
                     	return;
                     }
                     if(typeVal==1){
                     	article.typeParent = 0;
                     	article.type = 0;
                     	var weightVal = $("#weight").val();
                     	if(weightVal==""){
	                     	CommonCud.alert("请输入重量！");$("#weight")[0].select();
	                     	return;
	                     }
	                     if(!/^[\d]+$/i.test(weightVal)){
	                     	CommonCud.alert("请输入数字！");$("#weight")[0].select();
	                     	return;
	                     }
	                     article.num = weightVal;
                     }else{
                     	article.typeParent = 1;
                     	 var ciTypeVal = $("#ciType").val();
                     	if(ciTypeVal==""){
	                     	CommonCud.alert("请选择磁介类型！");
	                     	return;
	                     }
	                     article.type = ciTypeVal;
                     	 var numTxtVal = $("#numTxt").val();
                     	if(numTxtVal==""){
	                     	CommonCud.alert("请输入数量！");$("#numTxt")[0].select();
	                     	return;
	                     }
	                     if(!/^[\d]+$/i.test(numTxtVal)){
	                     	CommonCud.alert("请输入数字！");$("#numTxt")[0].select();
	                     	return;
	                     }
	                      article.num = numTxtVal;
                     }
                     
                     $( article2Html( article , true  ) ).insertBefore($contentDiv.find(".form-group .btn-primary").parents(".form-group"));
                     
                     $(".bs-add-modal-lg").modal("hide");
					 $contentDiv.css({"height":($contentDiv.height()+45)+"px"});
				});
			
			
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
					       // $('<a href="toAddWarehouse.do" class="btn btn-danger customBtn">直接入库</a>').insertBefore( $(".actionBar .btn"));
					     }else if(stepInfo.toStep==2){
					     	$(".stepContainer").css({"height":"200px","overflowY":"hidden"});
					     	$(".actionBar .buttonDisabled").remove();
					     	$('<a href="javascript:warehouse();" class="btn btn-danger customBtn">直接入库</a>').insertBefore( $(".actionBar .btn"));
					     }else if(stepInfo.toStep==3){
					     	$(".stepContainer").css({"height":(300+$(".article-info").length*45)+"px","overflowY":"hidden"});
					     	$(".actionBar .buttonDisabled").remove();
					     	$(".actionBar").append('<a href="toAddDestroy.do" class="btn btn-danger customBtn"> 新的作业 </a>');
					     }
	            	}
	            	,onLeaveStep: function($stepA,stepInfo/*{fromStep:1,toStep:2}*/){ 
	            		var method = stepInfo.fromStep < stepInfo.toStep ? "goForward" : "goBackward";
	            		if("goBackward"==method){return false;}//不让后退步骤;
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
            		 	 	
            		 	 	showAddArticleModal();
            		 	 	
	            		}else if(stepInfo.toStep==3){
	            			//,data:$("#step-"+stopObj.fromStep+" form").serialize()
	            			if(!isSubmited && validateForm() ){
		            			$.ajax({
		            				url: "ajaxAddDestroy.do"
		            				,data:$("#step-"+stepInfo.fromStep+" form").serialize()
		            				,success:function(destroyTask){
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
			            				display(data,'sendDesc');
			            				display(data,'sendType',function(type){
			            					return type==1 ? "派车" :  type==0 ? "自送" : "未知" ;
			            				});
			            				display(data,'articleDesc');
			            				display(data,'articleType',function(type){
			            					return type==1 ? "纸质" : type==2 ? "磁介" : "未知" ;
			            				});
			            				display(data,'explain');
			            				display(data,'explain2');
		            					 
		            					//display(destroyTask,'frontWeight');
		            					//display(destroyTask,'backWeight');
		            					 
		            					$.each(destroyTask.articles,function(i,article){
		            						$("#step-3 form").append(article2Html(article));
		            					});
		            					 
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
            	}).click(function(event){
            		if($(event.target).is(".form-group a .fa-close")){
            			var $this = $(event.target).parents(".form-group");
            			var $contentDiv = $(".wizard_content:visible").parent();
            			$this.remove();
            			$contentDiv.css({"height":($contentDiv.height()-45)+"px"});
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
                                            <small>登记</small>
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
                                                       			,articleDesc:'<c:out value="${apply.articleDesc}" escapeXml="true"></c:out>'
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
								            					return type==1 ? "派车" :  type==0 ? "自送" : "未知" ;
								            				});
								            				display(data,'articleDesc');
								            				display(data,'articleType',function(type){
								            					return type==1 ? "纸质" : type==2 ? "磁介" : "未知" ;
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
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">销毁物品简述 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                             <label class="form-control col-md-7 col-xs-12" id="articleDesc__lable" ></label>    
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
                                        <div id="step-2"   class="" >
                                             <form class="form-horizontal form-label-left"><input type="hidden" name="applyId" id="hdn_applyId" />
                                                <!-- <div class="form-group articleType2">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" >类型:
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                    	  <select  name="type" required="required" class="form-control col-md-7 col-xs-12">
                                                    	  	<option value="1">纸质</option>
                                                    	    <option value="2">磁介</option>
                                                    	  </select>
                                                    </div>
                                                </div>
                                                <div class="form-group articleType2">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"  >数量
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                         <input type="text"   name="num" required="required" class="form-control col-md-7 col-xs-12">  
                                                    </div>
                                                </div>
                                                 <div class="form-group articleType1">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="frontWeight">过磅称重(kg): 
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="frontWeight" name="frontWeight" required="required" class="form-control col-md-7 col-xs-12">   
                                                    </div>
                                                </div>
                                                 -->
                                                 <div class="form-group articleType2">
                                                    <div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">
                                                        <input type="button" class="btn btn-primary" onclick="showAddArticleModal()"  value="添加物品" />
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div id="step-3">
                                            <h2 class="StepTitle" align="center" >已经完成销毁！以下是销毁信息。</h2>
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
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">销毁物品简述 :</label>  
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                             <label class="form-control col-md-7 col-xs-12"  id="articleDesc_2_lable" >  U盘</label>    
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
                                            </form>
                                        </div>

                                    </div>
                                    <!-- End SmartWizard Content -->
				</div>
			</div>
		</div> 
		
		<!-- 单个数据操作对话框 -->
		<div class="modal fade bs-add-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
             <div class="modal-dialog modal-lg">
                 <div class="modal-content">

                     <div class="modal-header">
                         <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                         </button>
                         <h4 class="modal-title" >添加销毁物品信息
                         </h4>
                     </div>
                     <div class="modal-body">
                     	<form class="form-horizontal form-label-left">
                             <div class="form-group">
                                 <label>类型</label>
                                 <select id="typeSelect" class="form-control" >
                                 	<option value="1">纸质</option>
                                 	<option value="2">磁介</option>
                                 </select>
                             </div>
                             <div class="form-group type2" style="display: none;">
                                 <label>磁介类型</label>
                                 <select id="ciType" class="form-control" >
                                 	<option value="">请选择</option>
                                 	<option value="1">U盘</option>
                                 	<option value="2">移动硬盘</option>
                                 	<option value="3">硬盘</option>
                                 </select>
                             </div>
                             <div class="form-group type1" >
                                 <label>重量(kg)</label>
                                <input type="text" id="weight" class="form-control" placeholder="输入重量(kg)">
                             </div>
                             <div class="form-group type2" style="display: none;">
                                 <label>数量</label>
                                <input type="text" id="numTxt" name="num" class="form-control" placeholder="输入数量">
                             </div>
                         </form>
                     </div>
                     <div class="modal-footer">
                     	 <button type="button" class="btn btn-success">保存</button>
                         <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                     </div>
                 </div> 
             </div>
         </div>
	</body>
</html>