<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" 
%><!DOCTYPE html>
<html>
	<head>
		<title>未归档列表</title>

	
		<!-- chart js -->
		<script src="js/chartjs/chart.min.js"></script>
		<!-- bootstrap progress js -->
		<script src="js/progressbar/bootstrap-progressbar.min.js"></script>
		<script src="js/nicescroll/jquery.nicescroll.min.js"></script>
		<!-- icheck -->
		<script src="js/icheck/icheck.min.js"></script>
		<script src="js/common-cud.js" type="text/javascript"></script>
		<script language="JavaScript" type="text/javascript" src="js/DataTables-1.10.13/media/js/jquery.dataTables.min.js"></script>
		<link type="text/css" rel="stylesheet" href="js/DataTables-1.10.13/media/css/jquery.dataTables.min.css" />
		 <script type="text/javascript">
		 		//当前被选中的id
		 		var button=[];
		 		//编辑框加载时,设置联动效果
				$(function(){  
					//alert($("#bigType").val());
				});
				
				//选中按钮操作
				function change(check){
					c= $(check);
					if(c.text()=="点击选中"){
						if(button.length==0){
							c.text("已选中");
							c.css('background','red');
							button.push(c.attr("id"));
						}else
							alert("只能选择一行!");
					}
					else{
						c.text("点击选中");
						c.css('background','blue');
						button=[];
					}						
				}
				
				//根据所选项打开对应的模态框
				function getModalContent(edit){
					if(button.length==0)
						alert("请选择一行");
					else
						$(edit).attr("data-target","#"+button[0]);
				}
				
				//根据销毁类型选择细项
				function liandong(id){
					var type = $("#bigType"+id).val();
					var ci = $("#smallAndNum"+id);
					var zhi = $("#weightli"+id);
					//根据选择添加联动
					//选择纸介
					if(type==0){
						ci.hide();
						zhi.show();
					}
					//选择磁介
					if(type==1){
						ci.show();
						zhi.hide();
					}
				}
				
				//提交编辑
				function edit(id){
					var arr = $("#form"+id+"").serializeArray();
					var data = $.param(arr);
					data = data+"&id="+id;
					$.ajax({
   						type: "POST",
   						url: "edit.do",
   						data: data,
   						success: function(msg){
     						alert(msg );
     						$("#"+id+"").modal('hide');
     						location.reload(); 
   						}
					});
				}
				
				//删除方法
				function del(){
					if(button.length==0)
						alert("请选择一行");
					else{
						var is = confirm("确定要删除？");
						if(is){
							$.ajax({
		   						type: "POST",
		   						url: "delete.do",
		   						data:"id="+button[0],
		   						success: function(msg){
		     						alert(msg );
		     						location.reload(); 
		   						}
							});
						}
					}
				}
				
				//编目
				function bianmu(){
					if(button.length==0)
						alert("请选择一行");
					else{
						var is = confirm("确定要编目？");
						if(is){
							$.ajax({
		   						type: "POST",
		   						url: "bianMu.do",
		   						data:"id="+button[0],
		   						success: function(msg){
		     						alert(msg );
		     						location.reload(); 
		   						}
							});
						}
					}
				}
		 </script>
	</head>
	<body>
	<!-- 条件输入框 -->	
  <form class="form-inline" role="form" action="toListFilesWei.do">
		<div class="input-group">
			<span class="input-group-addon">单位名称</span> <input type="text"
				class="form-control" name="contactUnit">
		</div>
		<div class="input-group">
			<span class="input-group-addon">物品类型</span> <select class="form-control" name="bigType">
				<option value="0">纸介</option>
				<option value="1">磁介</option>
			</select>
		</div>
		<div class="input-group">
			<span class="input-group-addon">销毁信息</span> <input type="text"
				class="form-control" name="des">
		</div>
		<input type="submit" value="查询" class="btn btn-primary btn-lg">
	</form>  
	<!--快捷操作按钮--> 
	<div class="btn-group btn-group-lg">
    <button type="button" class="btn btn-default tooltip-test" onclick="javascript:window.location.href='toAddApply.do'" data-toggle="tooltip" title="添加"><span class="glyphicon glyphicon-plus-sign"></span></button>
    <button type="button" class="btn btn-default tooltip-test" data-toggle="modal" title="编辑" data-target="#myModal" onclick="getModalContent(this)"><span class="glyphicon glyphicon-pencil"></span></button>
    <button type="button" class="btn btn-default tooltip-test" data-toggle="tooltip" title="删除" onclick="del()"><span class="glyphicon glyphicon-minus-sign"></span></button>
</div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<div class="btn-group btn-group-lg">
    <button type="button" class="btn btn-default tooltip-test" data-toggle="tooltip" onclick="bianmu()" title="编目"><span class="glyphicon glyphicon-plus-sign"></span></button>
</div>

<!-- 编辑窗口 -->
<c:forEach var="file" items="${Wfiles}">
<form id="form${file.id}">
<div class="modal fade" id="${file.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					编辑窗口
				</h4>
			</div>
			<div class="modal-body">
				<div class="x_content" id="editContent">
			<ul class="list-group">
				<li class="list-group-item">
				<div class="message_date">
					<h3 class="date text-info">
						<fmt:formatDate value="${file.createTime}" pattern="d'日'" />
					</h3>
					<p class="month">
						<fmt:formatDate value="${file.createTime}" pattern="yyyy'年'M'月'" />
					</p>
				</div>
				</li>
				<li class="list-group-item">
					<div class="input-group">
						<span class="input-group-addon">单位名称</span> 
						<input type="text" class="form-control" id="contactUnit${file.id}" name="contactUnit${file.id}" value="${file.contactUnit}">
						<span class="input-group-addon">联系人</span> 
						<input type="text" class="form-control" id="contact${file.id}" name="contact${file.id}" value="${file.contact}">
					</div>
				</li>
				<li class="list-group-item">
					<div class="input-group">
						<span class="input-group-addon">上报领导</span>
						<select class="form-control" id="submit${file.id}" name="submit${file.id}">
							<c:forEach var="us" items="${users}">
								<option value="${us.id}"
								<c:if test="${us.id==file.submitId}">
									selected="selected"
								</c:if>
								>${us.nickName}</option>
							</c:forEach>
						</select> 
						<span class="input-group-addon">电话</span> 
						<input type="text" class="form-control" id="telephone${file.id}" name="telephone${file.id}" value="${file.telephone}">
					</div>
				</li>
				<li class="list-group-item">
					<div class="input-group">
						<span class="input-group-addon">地址</span> 
						<input type="text" class="form-control" id="address${file.id}" name="address${file.id}" value="${file.address}">
					</div>
				</li>
				
				
				<li class="list-group-item">
					<div class="input-group">
						<span class="input-group-addon">销毁物品简述</span> 
						<input type="text" class="form-control" id="desc${file.id}" name="desc${file.id}" value="${file.destoryThingDes}">
					</div>
				</li>
				<li class="list-group-item" id="types${file.id}">
					<div class="input-group">
						<span class="input-group-addon">销毁物品类型</span>
						<select class="form-control" name="bigType${file.id}" id="bigType${file.id}" onchange="liandong(${file.id})">
							<option value="0" 
								<c:if test="${file.bigType==0}">
									selected="selected"
								</c:if>
							>
								纸介
							</option>
							<option value="1"
								<c:if test="${file.bigType==1}">
									selected="selected"
								</c:if>
							>
								磁介
							</option>
						</select> 
					</div>
				</li>
				
					<li class="list-group-item" id="smallAndNum${file.id}" 
					<c:if test="${file.bigType==0}">	
						style="display:none;"
					</c:if>
					>
						<div class="input-group">
							<span class="input-group-addon">物件类型</span> 
							<select class="form-control" name="smallType${file.id}" id="smallType${file.id}">
								<option value="1"
									<c:if test="${file.smallType==1}">
										selected="selected"
									</c:if>
								>U盘</option>
                                <option value="2"
                                	<c:if test="${file.smallType==2}">
										selected="selected"
									</c:if>
                                >移动硬盘</option>
                                <option value="3"
                                	<c:if test="${file.smallType==3}">
										selected="selected"
									</c:if>
                                >光盘</option>
                                <option value="4"
                                	<c:if test="${file.smallType==4}">
										selected="selected"
									</c:if>
                                >其它磁介质</option>
							</select>
							<span class="input-group-addon">数量</span> 
							<input type="text" class="form-control" id="num${file.id}" name="num${file.id}" value="${file.num}">
						</div>
						
					</li>
					
					
					<li class="list-group-item" id="weightli${file.id}"
					<c:if test="${file.bigType==1}">
						style="display:none;"
					</c:if>
					>
						<div class="input-group">
							<span class="input-group-addon">重量</span> 
							<input type="text" class="form-control" id="weight${file.id}" name="weight${file.id}" value="${file.weight}">
						</div>
					</li>
					

				
				<li class="list-group-item">
				<div id="gender" class="btn-group" data-toggle="buttons">
						<label class=" 
						<c:if test="${file.sendType==0}">
							btn btn-primary active	
						</c:if>
						<c:if test="${file.sendType==1}">
							btn btn-default	
						</c:if>
						"> <input autocomplete="off" type="radio" name="sendType${file.id}" value="0" checked="checked"> 自送
						</label>
						<label class="
						<c:if test="${file.sendType==1}">
							btn btn-primary active	
						</c:if>
						<c:if test="${file.sendType==0}">
							btn btn-default	
						</c:if>
						"> <input autocomplete="off" type="radio" name="sendType${file.id}" value="1"> 派车
						</label> 
				</div>
						
							
				
					<div id="gender" class="btn-group" data-toggle="buttons">
						<label class="
						<c:if test="${file.sendType==0}">
							btn btn-primary active	
						</c:if>
						<c:if test="${file.sendType==1}">
							btn btn-default	
						</c:if>
						"> <input
							autocomplete="off" type="radio" name="nowDestroy${file.id}" value="0" checked="checked"
							>&nbsp; 否&nbsp;
						</label> <label class="
						<c:if test="${file.sendType==1}">
							btn btn-primary active	
						</c:if>
						<c:if test="${file.sendType==0}">
							btn btn-default	
						</c:if>
						"> <input
							autocomplete="off" type="radio" name="nowDestroy${file.id}" value="1"
							>&nbsp;
							是&nbsp;
						</label>
					</div>
			</li>

	</ul>
	
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="button" class="btn btn-success" onclick="edit(${file.id})">
					提交更改
				</button>
			</div>
		</div>
</div>
</div>
</form>
</c:forEach>
	<!-- 数据内容 -->
          <div class="x_content">
			<c:forEach var="file" items="${Wfiles}">
			<ul class="list-group">
				<li class="list-group-item">
				<div class="message_date">
					<h3 class="date text-info">
						<fmt:formatDate value="${file.createTime}" pattern="d'日'" />
					</h3>
					<p class="month">
						<fmt:formatDate value="${file.createTime}" pattern="yyyy'年'M'月'" />
					</p>
					<button type="button" class="btn btn-primary" id="${file.id}" onclick="change(this)">点击选中</button>
				</div>
				</li>
				<li class="list-group-item">
					单位名称:<span id="contactUnit">${file.contactUnit}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					联系人:<span id="contact">${file.contact}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					上报领导:<span id="submitName">${file.submitName}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					电话：<span id="telephone">${file.telephone}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					地址：<span id="address">${file.address}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</li>
				<li class="list-group-item">销毁物品简述：
					<span id="desc">${file.destoryThingDes}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					销毁物品类型：
					<span id="bigType">
					<c:if test="${file.bigType==0}">
						纸介
					</c:if>
					<c:if test="${file.bigType==1}">
						磁介
					</c:if>
					</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<!--当物品为磁介时才有小类型-->
					<c:if test="${file.bigType==1}">
						物件类型：<span id="smallType">
						<c:if test="${file.smallType==1}">
							U盘
						</c:if>
						<c:if test="${file.smallType==2}">
							移动硬盘
						</c:if>
						<c:if test="${file.smallType==3}">
							光盘
						</c:if>
						<c:if test="${file.smallType==4}">
							其它磁介质
						</c:if>
						</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						数量：<span id="num">${file.num}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</c:if>
					<!--当物品为纸介时-->
					<c:if test="${file.bigType==0}">
						重量：<span>${file.weight}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</c:if>
					<c:choose>
						<c:when test="${file.sendType eq 1}">
							<span class="label label-warning">需派车</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
						<li class="list-group-item">
							<span class="label label-success">对方自送</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${file.sendType eq 1}">
							<span class="label label-warning">监销</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							<span class="label label-success">不监销</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
				</li>

	</ul>
	</c:forEach>
				</div>
    

		

	</body>
	
	<script type="text/javascript">
		//编辑框加载时,设置联动效果
				
  	
	</script>
</html>