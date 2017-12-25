<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html>
	<head>
		<title>销后计量</title>

		<!-- bootstrap progress js -->
		<script src="js/progressbar/bootstrap-progressbar.min.js"></script>
		<script src="js/nicescroll/jquery.nicescroll.min.js"></script>
		<!-- icheck -->
		<script src="js/icheck/icheck.min.js"></script>
		<script src="js/common-cud.js" type="text/javascript"></script>
		
		 <script type="text/javascript" src="js/wizard/jquery.smartWizard.js"></script>
		<script type="text/javascript">
			$(function(){
	           
			});
		</script>
	</head>
	<body>

		 <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>录入销后计量</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <br>
                                    <form id="demo-form2" action="addWeightLog.do"  class="form-horizontal form-label-left"  >
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="carSelect">车辆：<span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <select id="carSelect" name="opCarId" required="required" class="form-control col-md-7 col-xs-12">
                                               <c:forEach var="car" items="${cars}" ><option value="${car.id}" >${car.carNo}-${car.useUser}</option></c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="weight">重量(kg)：<span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="weight" name="weight" required="required" class="form-control col-md-7 col-xs-12" data-parsley-id="6319"><ul class="parsley-errors-list" id="parsley-id-6319"></ul>
                                            </div>
                                        </div>
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="opContanct">联系方式：
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="opContanct" name="opContanct"  class="form-control col-md-7 col-xs-12" data-parsley-id="6319"><ul class="parsley-errors-list" id="parsley-id-6319"></ul>
                                            </div>
                                        </div>
                                        <div class="ln_solid"></div>
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                                <button type="submit" class="btn btn-success">保存</button>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </div>
                        </div>
		
	</body>
</html>