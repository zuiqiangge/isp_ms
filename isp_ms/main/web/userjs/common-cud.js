var CommonCud = (function($,w){
	var defaultConf = {
			"addBtnSelect":".addBtn"
			,"updateBtnSelect":".updateBtn"
			,"deleteBtnSelect":".deleteBtn"
			,"modalSelect":".bs-common-edit-modal-lg"
			
			,"onlyAddShowSelect":".only-add-show"
			
			,"titleSelect":".modal-title input"
			,"modalSubmitBtnSelect":" .modal-footer button:eq(0)"
			,"modalMsgSelect":" .modal-footer [name=msg]"
			
			,"commonAlertSelect":".bs-alert-modal-sm"
			,"commonConfirmSelect":".bs-confirm-modal-sm"
			
			,"msg-no-jquery":"jquery 没加载 不能进行页面初始化！"
		};
	var dd = function(configName){
		return defaultConf[configName] || configName;
	};
	var $d = function(configName){
		return $(dd(configName));
	};
	var $modal = null;
	var $md = function(configName){
		return $(dd(configName),$modal);
	};
	var commonAlert=function(alertMsg,callback){
		$d("commonAlertSelect").find(".modal-body").html(alertMsg).end().modal();
		if(!commonAlert.callback){
			$d("commonAlertSelect").on("hidden.bs.modal",function(){
				commonAlert.callback();
			});
		}
		commonAlert.callback = callback || (function(){});
		 return CommonCud;
	};
	var commonConfirm=function(alertMsg,callback){
		$d("commonConfirmSelect").find(".modal-body").html(alertMsg).end().modal();
		if(!commonConfirm.callback){
			$d("commonConfirmSelect").on("hidden.bs.modal",function(){
				if(commonConfirm.result)commonConfirm.callback();
			});
			$d("commonConfirmSelect").find(".modal-footer .btn:eq(0)").click(function(){
				commonConfirm.result = true;
			});
			$d("commonConfirmSelect").find(".modal-footer .btn:eq(1)").click(function(){
				commonConfirm.result = false;
			});
		}
		commonConfirm.callback = callback || (function(){});
		 return CommonCud;
	};
	
	var obj2Form = function(obj,form){
	 	 var $form = $(form);
	 	 for(p in obj){
	 	 	$input =  $form.find("[name="+p+"]");
	 	 	if($input.length==0)continue;
	 	 	if($input.is("select")){
	 	 		$input.find("[selected]").removeAttr("selected");
	 	 		$input.find("[value="+obj[p]+"]").attr("selected")
	 	 	}
	 	 	$input.val(obj[p]);
	 	 }             	
	 };
	 var showModel = function(id){
	   var titleTemp = (showModel.titleTemp =  showModel.titleTemp ||  $md("titleSelect").val());
	 		if(id){
	 			$.ajax({
					url: dd("getUrl")+"?id="+id
					,method:"POST"
					,success:function(data){
							$md("onlyAddShowSelect").hide();
							$md(" .modal-title").html("修改"+titleTemp);	
				 			$md(" .modal-body form").attr("action",dd("updateUrl"));
							$md(" .modal-body form input[name=id]").val(id);
				 			$md("modalMsgSelect").val("修改"+titleTemp+"信息成功！");
				 			obj2Form(data,$md(".modal-body form"));
				 			$modal.modal();
					},error:function(){
							commonAlert("修改失败！");
					}
				});
	 		}else{
	 			$md("onlyAddShowSelect").show();
	 			$md(" .modal-title").html("新增"+titleTemp);		
	 			$md(" .modal-body form").attr("action",dd("addUrl"));
				$md(" .modal-body form input[name=id]").val("");
	 			$md("modalMsgSelect").val("新增"+titleTemp+"信息成功！");
	 			$modal.modal();
	 		}
	 };
	 var handAddBtn = function(){
	 		$d("addBtnSelect").click(function(){
	 			showModel();
	 		});
	 };
	  var handUpdateBtns = function(){
	  	  $d("updateBtnSelect").click(function(){
	 			showModel($(this).parent().find("[name=id]").val());
	 	  });
	  };
	 var handModalSubmitBtn =function(){
	 		$md("modalSubmitBtnSelect").click(function(){
	 				var $form =  $(this).parents(".modal-content").find("form");
					$.ajax({
							url: $form.attr("action") 
							,method:"POST"
							,data:$form.serialize()
							,success:function(data){
									$form.parents(".modal").modal("hide");
									commonAlert($md("modalMsgSelect").val()+"",function(){
										w.location.reload();
									});
							},error:function(){
									commonAlert("操作失败！");
							}
					});
	 		});	
	 };
	 var handDeleteBtns = function(){
	  	  $d("deleteBtnSelect").click(function(){
	  	  	var id = $(this).parent().find("[name=id]").val();
	 			commonConfirm("你确定要删除吗?", function(result) {
                   	$.ajax({
							url: dd("removeUrl")+"?id="+id
							,method:"POST"
							,success:function(data){
									commonAlert("删除成功！",function(){
										w.location.reload();
									});
							},error:function(){
									commonAlert("删除失败!");
							}
					});
                }); 
	 	  });
	 };
	 var initTable = function(url,data){
	 	  var _fn = arguments.callee;
	 	  if(!jQuery.fn.dataTable){
	 	  	 jQuery.getScript('js/datatables/js/jquery.dataTables.js',function(){
	 	  	 	 _fn(url,data);
	 	  	 });
	 	  	 return;
	 	  }
	 	  if(!jQuery.fn.dataTable.TableTools){
	 	 	 jQuery('head').append('<link href="css/datatables/tools/css/dataTables.tableTools.css" rel="stylesheet">')
	 	  	jQuery.getScript('js/datatables/tools/js/dataTables.tableTools.js',function(){
	 	  	 	 _fn(url,data);
	 	  	 });
	 	  	 return;
	 	  }
	 	   var oTable = $('#example').dataTable({
                  "oLanguage": {
                      "sSearch": "Search all columns:"
                  },
                  "aoColumnDefs": [
                      {
                          'bSortable': false,
                          'aTargets': "ALL"
                      } //disables sorting for column one
          			],
                  'iDisplayLength': 12,
                  "sPaginationType": "full_numbers",
                  "dom": 'T<"clear">lfrtip',
                  "tableTools": {
                      "sSwfPath": "js/datatables/tools/swf/copy_csv_xls_pdf.swf"
                  }
              });
              $("tfoot input").keyup(function () {
                  /* Filter on the column based on the index of this element's parent <th> */
                  oTable.fnFilter(this.value, $("tfoot th").index($(this).parent()));
              });
              $("tfoot input").each(function (i) {
                  asInitVals[i] = this.value;
              });
              $("tfoot input").focus(function () {
                  if (this.className == "search_init") {
                      this.className = "";
                      this.value = "";
                  }
              });
              $("tfoot input").blur(function (i) {
                  if (this.value == "") {
                      this.className = "search_init";
                      this.value = asInitVals[$("tfoot input").index(this)];
                  }
              });
	 	
	 	 return CommonCud;
	 };
	 
	return {
		init:function(newConf){
			if(newConf){
				defaultConf = $.extend({},defaultConf,newConf)
			}
			if(!$){
				throw new Error(defaultConf["msg-no-jquery"]);
				return false;
			}
			
			$modal = $d("modalSelect");	
			
		   handAddBtn();
		   handUpdateBtns();
		   handModalSubmitBtn();
		   handDeleteBtns();
		   
		   return CommonCud;
		}
		,commonAlert:commonAlert
		,commonConfirm:commonConfirm
		,initTable:initTable
		,alert:commonAlert
		,confirm:commonConfirm
	};
})(jQuery,window)
