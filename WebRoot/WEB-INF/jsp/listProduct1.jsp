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
                  <th width="15%" bgcolor="#f8f8f8"><span class="titlab">数量</span></th>
                  <th width="9%" bgcolor="#f8f8f8"><span class="titlab">是否归还</span></th>
                  <th width="12%" bgcolor="#f8f8f8"><span class="titlab">是否预警</span></th>
                  <th width="12%" bgcolor="#f8f8f8"><span class="titlab">操作</span></th>
            </tr>
        </thead>
        <tbody></tbody> 
    </table>
  
     <script language="JavaScript" type="text/javascript" >
 	
 	
 	$(document).ready(function(){
         table = $('#example').DataTable({
             "serverSide": true,
             "dom": 'tflip',
             'searching':false,
             "lengthMenu":[2,4,6],
             "ordering": false,
             "columns": [
						{
         					"data": "productName"
         				},
						{"data": "inTime",
         					"render": function (data,type, row, meta) {
         						var currentDate = new Date();
         						var day = currentDate.getDate();
         						var month = currentDate.getMonth() + 1;
         						var year = currentDate.getFullYear();
         						var javascriptDate = year + '/' + month + '/' + day // Modify as you need
         						return javascriptDate;
         					}
						},
						{"data": "manageUser.nickName"},
         				{"data": "rfid"},
         				{"data": "currentPosition"},
         				{"data": "count"},
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
         						return "<button type='button' onclick='yiku("+data+")' class='btn btn-default btn-sm'><span class='glyphicon glyphicon-user'>移库</span></button>"; 
         			                		  
         			        }  
         				}, 
         			],
             "ajax" :{
              'url':"list.do",
            	'contentType': "charset=utf-8" 
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
                      "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项", 
                     'infoEmpty': '没有数据'
                 } 
         });
     });
 	
 	
 	
 	
 	
 	
 	//移库操作
 	function yiku(id){
 		var position=prompt("请输入要移动到的位置","");
 		$.ajax({
 				type: "POST",
 				url: "yiku.do",
 				data: "id="+id+"&position="+position,
 				success: function(msg){
 					if("移库成功"==msg)
 						alert(msg );
 					table.page(table.page()).draw(false);
 				}
 		});
 	}
 	
   
     	
  </script>
</body>

</html>