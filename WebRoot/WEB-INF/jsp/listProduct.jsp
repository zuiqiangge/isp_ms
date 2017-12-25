<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="fmt"
	uri="http://java.sun.com/jsp/jstl/fmt"%><!DOCTYPE html>
<html>
<head>
<title>密品列表</title>



<!-- chart js -->
<script src="js/chartjs/chart.min.js"></script>
<!-- bootstrap progress js -->
<script src="js/progressbar/bootstrap-progressbar.min.js"></script>
<script src="js/nicescroll/jquery.nicescroll.min.js"></script>
<!-- icheck -->
<script src="js/icheck/icheck.min.js"></script>
<script src="js/common-cud.js" type="text/javascript"></script>
<link type="text/css" rel="stylesheet" href="js/DataTables-1.10.13/media/css/jquery.dataTables.min.css" />
<script type="text/javascript" src="js/DataTables-1.10.13/media/js/jquery.dataTables.min.js"></script>
		 <!-- daterangepicker -->
		 <script src="js/input_mask/jquery.inputmask.js"></script>
		<script type="text/javascript" src="js/moment.min2.js"></script>
		<script type="text/javascript" src="js/datepicker/daterangepicker.js"></script>
<script type="text/javascript">
var table;
function queryByCondition(){
	//var data = new FormData($("#conditionForm")[0]);
	//var data = $("#conditionForm").serializeArray();
	//var data = $.param(arr);
	var data = getFormJson($("#conditionForm"));
	table.settings()[0].ajax.data =data;
	table.ajax.reload();
}

function getFormJson(frm) {
    var o = {};
    var a = $(frm).serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            if(this.value!="")
            	o[this.name].push(this.value || '');
        } else {
        	 if(this.value!="")
            	o[this.name] = this.value || '';
        }
    });
    return o;
}
</script>
</head>
<body>
	<div class="btn-group btn-group-lg">
    <button type="button" class="btn btn-default tooltip-test" data-toggle="modal" data-target="#ruku" title="入库"><span class="glyphicon glyphicon-plus-sign"></span></button>
</div>
	<form class="form-inline" role="form" id="conditionForm">
					名称:<input class="form-control" name="productName"/>
					rfid:<input class="form-control" name="rfid">
					当前位置:<input class="form-control" name="currentPosition">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					<button type="button" class="btn btn-default" onclick="queryByCondition()">检索</button>
	</form>
	<table id="example" class="tabindex" width="100%" border="0" cellpadding="0" cellspacing="0">
       		<thead>
            <tr>
               <th width="10%" bgcolor="#f8f8f8" scope="col"><div align="left">名称</div></th>
				  <th width="10%" bgcolor="#f8f8f8"><div align="left">入库时间</div></th>
                  <th width="20%" bgcolor="#f8f8f8"><span class="titlab">管理员</span></th>
                  <th width="15%" bgcolor="#f8f8f8"><span class="titlab">rfid</span></th>
                  <th width="15%" bgcolor="#f8f8f8"><span class="titlab">当前位置</span></th>
                  <th width="9%" bgcolor="#f8f8f8"><span class="titlab">是否归还</span></th>
                  <th width="12%" bgcolor="#f8f8f8"><span class="titlab">是否预警</span></th>
                  <th width="12%" bgcolor="#f8f8f8"><span class="titlab">操作</span></th>
            </tr>
        </thead>
        <tbody></tbody> 
    </table>
    
    
    
    
 <!--入库录入模态窗体-->
 <form id="formruku">
<div class="modal fade" id="ruku" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					入库窗口
				</h4>
			</div>
			<div class="modal-body">
				<div class="x_content" id="editContent">
			<ul class="list-group">
				<li class="list-group-item">
					<div class="input-group">
						<span class="input-group-addon">产品名称</span> 
						<input type="text" class="form-control" name="productName">
						<span class="input-group-addon">入库时间</span> 
						<input type="text" class="form-control" id="inTime" name="inTime">
					</div>
				</li>
				<li class="list-group-item">
					<div class="input-group">
						<span class="input-group-addon">管理员&nbsp;&nbsp;&nbsp;</span>
						<select class="form-control"  name="manageUser">
							<c:forEach var="us" items="${users}">
								<option value="${us.id}">${us.nickName}</option>
							</c:forEach>
						</select> 
						
						<span class="input-group-addon">&nbsp;&nbsp;&nbsp;&nbsp;rfid</span> 
						<input type="text" class="form-control" name="rfid">
					</div>
				</li>
				
				<li class="list-group-item">
					<div class="input-group">
						
						<span class="input-group-addon">&nbsp;&nbsp;&nbsp;&nbsp;当前位置</span> 
						<input type="text" class="form-control" name="currentPosition">
						<span class="input-group-addon">&nbsp;&nbsp;&nbsp;&nbsp;数量</span> 
						<input type="text" class="form-control" name="count">
					</div>
				</li>
	</ul>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="button" class="btn btn-success" onclick="ruku()">
					提交更改
				</button>
			</div>
		</div>
</div>
</div>
</form>



<!--出库模态框-->
 <form id="formchuku">
<div class="modal fade" id="chuku" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					出库窗口
				</h4>
			</div>
			<div class="modal-body">
				<div class="x_content" id="editContent">
			<ul class="list-group">
				<li class="list-group-item">
					<div class="input-group">
						<span class="input-group-addon">借出人员</span> 
						<select name="lendUser" class="form-control">
							<c:forEach var="u" items="${us}">
								<option value="${u.id}">${u.name}</option>
							</c:forEach>
						</select>
					</div>
				</li>
				<li class="list-group-item">
					<div class="input-group">
						<span class="input-group-addon">归还时间</span> 
						<input type="text" class="form-control" name="returnTime" id="returnTime">
					</div>
				</li>
	</ul>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="button" class="btn btn-success" onclick="chuku()">
					借出
				</button>
			</div>
		</div>
</div>
</div>
<input type="hidden" id="id" name="id"> 
</form>
 
 <!--日志模态框-->
<div class="modal fade" id="log" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:1100px">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<form id="logConditionForm">
					<select class="form-control" id="selectOperation">
						<option value="%">全部</option>
						<option value="in">入库</option>
						<option value="out">出库</option>
						<option value="back">归还</option>
						<option></option>
					</select>
				</form>
			</div>
			<div class="modal-body">
				<div class="x_content" id="editContent">
					<table id="logTable" class="tabindex" width="100%" border="0" cellpadding="0" cellspacing="0">
       		<thead>
           <tr>
               <th width="10%" bgcolor="#f8f8f8" scope="col"><div align="left">操作类型</div></th>
			<th width="10%" bgcolor="#f8f8f8"><div align="left">操作时间</div></th>
                <th width="15%" bgcolor="#f8f8f8"><span class="titlab">操作人</span></th>
            </tr>
        </thead
        <tbody></tbody> 
    </table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
			</div>
		</div>
</div>
</div>   
    <script language="JavaScript" type="text/javascript" >
 
 	
 	var logtable;
 	//初始化主页面列表
 	$(document).ready(function(){
		$('#returnTime').daterangepicker({
			locale:myLocales.zh
			,singleDatePicker: true
			,format: 'YYYY-MM-DD'
		}, function (start, end, label) {
        });
		
		$('#inTime').daterangepicker({
			locale:myLocales.zh
			,singleDatePicker: true
			,format: 'YYYY-MM-DD'
		}, function (start, end, label) {
        });
         $(".daterangepicker.dropdown-menu").css({"zIndex": 99999});
	
 		//格式化日期方法
 		Date.prototype.Format = function (fmt) { //author: meizz 
 		    var o = {
 		        "M+": this.getMonth() + 1, //月份 
 		        "d+": this.getDate(), //日 
 		        "h+": this.getHours(), //小时 
 		        "m+": this.getMinutes(), //分 
 		        "s+": this.getSeconds(), //秒 
 		        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
 		        "S": this.getMilliseconds() //毫秒 
 		    };
 		    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
 		    for (var k in o)
 		    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
 		    return fmt;
 		}
 		
 		//格式化产品列表
         table = $('#example').DataTable({
             "serverSide": true,
             "dom": 'tflip',
             'searching':false,
             "lengthMenu":[2,4,6],
             "ordering": false,
             "columns": [
						{
         					"data": "productName",
         					"render": function (data,type, row, meta) {
         						return "<a href='#' data-toggle='modal' onclick='getData("+row.id+")'><font color='blue'>"+data+"</font></a>"
         					}
         				},
						{"data": "inTime",
         					"render": function (data,type, row, meta) {
         						return new Date(data.time).Format("yyyy-MM-dd hh:mm:ss");
         					}	
						},
						{"data": "manageUser.nickName"},
         				{"data": "rfid"},
         				{"data": "currentPosition"},
         				{
         					"data": "isBack",
         					"render": function (data,type, row, meta) {
         						if(data==1)
         							return "<font color='red'>借出中</font>";
         						else
         							return "正常"; 
         					}
         				},
         				{
         					"data": "isWarning",
         					"render": function (data,type, row, meta) { 
         						if(data==1)
         							return "<font color='red'>预警</font>";
         						else
         							return "正常"; 
         			                		  
         			        }  
         				}, 
         				{
         					"data": "id",
         					"render": function (data,type, row, meta) { 
         						if(row.isBack==0)
         							return "<button type='button' onclick='tochuku("+data+")' class='btn btn-default btn-sm'><span class='glyphicon glyphicon-user'>出库</span></button>"; 
         						else 
         							return "<button type='button' onclick='guihuan("+data+")' class='btn btn-default btn-sm'><span class='glyphicon glyphicon-user'>归还</span></button>"; 
         			        }  
         				}, 
         			],
             "ajax" :{
              'url':"list.do"
              },
            	 'language': {  
                     'emptyTable': '没有数据',  
                     'loadingRecords': '加载中...',  
                     'processing': '查询中...',  
                     'lengthMenu': '每页 _MENU_行',  
                     'zeroRecords': '没有数据',  
                     'paginate': {  
                         'first':      '第一页',  
                         'last':       '最后一页',  
                         'next':       '下一页',  
                         'previous':   '上一页'  
                     }, 
                     "info": "显示页 _PAGE__of__PAGES_页   共 _TOTAL_ 项",
                     //"sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项", 
                     'infoEmpty': '没有数据'
                 } 
         });
         
         
         
         //初始化日志列表
        
     });
 	
 	
 	//入库操作
 	function ruku(){
 		var arr = $("#formruku").serializeArray();
 		var data = $.param(arr);
 		$.ajax({
 				type: "POST",
 				url: "ruku.do",
 				data: data,
 				success: function(msg){
 					alert(msg );
 					$("#ruku").modal('hide');
 					table.ajax.reload();
 				}
 		});
 	}	
 	
 	//跳往出库页面
 	function tochuku(id){
 		$("#id").val(id);
 		$('#chuku').modal('show')
 		
 	}
 	
 	//出库操作
 	function chuku(){
 		var arr = $("#formchuku").serializeArray();
 		var data = $.param(arr);
 		$.ajax({
 				type: "POST",
 				url: "chuku.do",
 				data: data,
 				success: function(msg){
 					alert(msg );
 					$("#chuku").modal('hide');
 					table.page(table.page()).draw(false);
 				}
 		});
 	}
 	
 	//归还操作
 	function guihuan(id){
 		$.ajax({
				type: "GET",
				url: "guihuan.do?id="+id,
				success: function(msg){
					alert(msg );
					table.page(table.page()).draw(false);
				}
		});
 	}
 	//获取日志数据
 	function getData(id){
 		$('#log').modal('show');
 		if(logtable!=null){
 			logtable.ajax.url("logList.do?id="+id).load();
 		}
 		else{ 
 			 logtable = $('#logTable').DataTable({
 	             "serverSide": true,
 	             "paging": true,
 	             "dom": 'tflip',
 	             "info": false,
 	            "searchable":true,
 	             //'searching':false,
 	             "lengthMenu":[2,4,6],
 	             "ordering": false,
 	             'retrieve': true,
 	             "columns": [
 	 						{
 	          					"data": "operateName",
 	          					"render": function (data,type, row, meta) {
 	          						var button;
 	          						if(data=="in"){
 	          							button = "<button type='button' class='btn btn-primary' data-toggle='collapse' data-target='#"+row.id+"'>入库</button>";
 	          							
 	          						}else if(data=="out"){
 	          							button = "<button type='button' class='btn btn-primary' data-toggle='collapse' data-target='#"+row.id+"'>借出</button>";         							
 	          						}
 	          						else{
 	          							button = "<button type='button' class='btn btn-primary' data-toggle='collapse' data-target='#"+row.id+"'>归还</button>";
 	          						}
 	          						button+=abc(row);
 	          						return button;
 	          					}
 	          				},
 	         				{"data": "caozuoTime",
 	          					"render": function (data,type, row, meta) {
 	          						if(data!=undefined&&data!=null)
 	          							return new Date(data.time).Format("yyyy-MM-dd hh:mm:ss");
 	          						else
 	 									return "";
 	          					}
 	          				},
 	 						{"data": "product.manageUser.nickName"},
 	         			],
 	         			"ajax" :{
 	         	              'url':"logList.do?id="+id
 	         	        },
 	              	 'language': {  
 	                     'emptyTable': '没有数据',  
 	                     'loadingRecords': '加载中...',  
 	                     'processing': '查询中...',  
 	                     'lengthMenu': '每页 _MENU_行',  
 	                     'zeroRecords': '没有数据',  
 	                     'paginate': {  
 	                         'first':      '第一页',  
 	                         'last':       '最后一页',  
 	                         'next':       '下一页',  
 	                         'previous':   '上一页'  
 	                     },  
 	                    	"info": "显示页 _PAGE_ of _PAGES_页_",
 	                      //"sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项", 
 	                     'infoEmpty': '没有数据'
 	                 } 
 	            
 	         });
 		
 		}
 		$('#selectOperation').change( function() {
 			
 			logtable.search($('#selectOperation').val()).draw();
 			//logtable.draw();
 	    } );
 	}
   
  	
    
  	
  	
  	//
  	function abc(row){
  		var table="<table id='"+row.id+"' class='collapse table' width='100%'>";
  		if(row.operateName=="in"){
  			table+="<tr><td>入库时间</td><td>产品名称</td><td>操作人</td></tr>"
  			table+="<tr><td>"+new Date(row.product.inTime.time).Format("yyyy-MM-dd hh:mm:ss")+"</td>";
  			table+="<td>"+row.product.productName+"</td>";
  			table+="<td>"+row.product.manageUser.nickName+"</td></tr>";
  		}else if(row.operateName=="out"){
  			table+="<tr><td>借出时间:</td><td>产品名称:</td><td>借出人:</td><td>归还时间:</td><td>是否归还:</td><td>实际归还时间:</td></tr>";
  			table+="<tr><td>"+new Date(row.lend.lendTime.time).Format("yyyy-MM-dd hh:mm:ss")+"</td>";
  			table+="<td>"+row.product.productName+"</td>";
  			if(row.lend.lendUser!=null)
  				table+="<td>"+row.lend.lendUser.name+"</td>";
  			else
  				table+="<td></td>";	
  			table+="<td>"+new Date(row.lend.returnTime.time).Format("yyyy-MM-dd hh:mm:ss")+"</td>";
  			table+="<td>"+(row.lend.isValid==1?"已归还(正常)":"没有(借出中)")+"</td>";
  			if(row.lend.isValid==1)
  				table+="<td>"+new Date(row.lend.factReturnTime.time).Format("yyyy-MM-dd hh:mm:ss")+"</td>";
  		}else{
  			table+="<tr><td>归还时间:</td><td>产品名称:</td><td>归还人:</td></tr>"
  			table+="<td>"+new Date(row.lend.lendTime.time).Format("yyyy-MM-dd hh:mm:ss")+"</li>";
  			table+="<td>"+row.product.productName+"</td>";
  			table+="<td>"+row.lend.lendUser.name+"</td>";
  		} 
  		table+="</tr></table>"
  		return table;
  	}
  	
  	
  
  </script>
</body>

</html>