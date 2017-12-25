package cn.com.pengyue.web.action;

import java.util.Arrays;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.pojo.Warehouse;
import cn.com.pengyue.service.IApplyService;
import cn.com.pengyue.service.ILoggingService;
import cn.com.pengyue.service.IWarehouseService;
import cn.com.pengyue.util.AccessConstants;

@Controller
public class WarehouseController {
	@Resource
	public IWarehouseService warehouseService;
	@Resource
	public ILoggingService loggingService;
	
	@Resource
	public IApplyService applyService;
	
	
	@RequestMapping("/toAddWarehouse")
	public String toAddWarehouse(Model model){
		//查询所有结束的申请
		model.addAttribute("allStateList", applyService.allState2List());
		return "toWarehouse";
	}
	
	@RequestMapping("/addWarehouse")
	@ResponseBody
	public Object addWarehouse(Warehouse pojo,HttpSession session){
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		//入库时间
		pojo.setEnterDate(new Date());
		//入库登记人id
		pojo.setRegister_id(user.getId());
		//入库登记人姓名
		pojo.setRegisterPerson(user.getUserName());
		//入库状态
		pojo.setDestroyState(0);
		pojo.setType(0);
		
		warehouseService.save(pojo);
		
		if(pojo.getApplyId()!=null){
			//更改申请表的状态为已销毁
			applyService.updateStateApply(pojo.getApplyId());
		}
		
		//增加日志信息
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("addWarehouse.do");
		logging.setDetailsInfo("对需要销毁的物品进行入库！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return pojo;
	}
	
	@RequestMapping("/getByIdWarehouse")
	@ResponseBody
	public Object getByIdWarehouse(HttpServletRequest request,Model model,HttpSession session){
		int id=Integer.valueOf(request.getParameter("id"));
		Warehouse pojo=new Warehouse();
		pojo=warehouseService.get(id);
		//增加日志信息
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("getByIdWarehouse.do");
		logging.setDetailsInfo("查询ID为"+id+"的入库信息！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return pojo;
	}
	
	@RequestMapping("/allWarehouseList")
	public String allWarehouseList(Model model,HttpSession session){
		model.addAttribute("list", warehouseService.listAll());
		//增加日志信息
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("allWarehouseList.do");
		logging.setDetailsInfo("查询所有的入库信息！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return "allWarehouseList";
	}
	
	@RequestMapping("/ajaxUpdateWarehouse")
	@ResponseBody
	public Object ajaxUpdateWarehouse(HttpServletRequest request,HttpSession session,Warehouse pojo){
		//销毁id
		//int destroyId=Integer.valueOf(request.getParameter("destroyId"));
		//pojo.setDestroy_id(destroyId);
		//申请id
		//int applyId=Integer.valueOf(request.getParameter("applyId"));
		//增加销毁时间
		//pojo.setDestroyDate(new Date());
		
		Warehouse warehouse =  warehouseService.get(pojo.getId());
		//更改销毁状态为已销毁
		warehouse.setDestroyState(1);
		warehouseService.update(warehouse);
		
		//增加日志信息
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("allWarehouseList.do");
		logging.setDetailsInfo("对暂入库并且状态为暂存的信息状态改为已销毁！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return pojo;
	}
}
