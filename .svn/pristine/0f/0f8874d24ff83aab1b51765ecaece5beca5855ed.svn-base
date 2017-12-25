package cn.com.pengyue.web.action;

import java.util.Arrays;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.pengyue.pojo.PageInfo;
import cn.com.pengyue.pojo.WeightLog;
import cn.com.pengyue.service.ICarService;
import cn.com.pengyue.service.IWeightLogService;

@Controller
public class WeightLogController {
	
	@javax.annotation.Resource
	private IWeightLogService weightLogService;
	
	@javax.annotation.Resource
	private ICarService carService;
	
	@RequestMapping("/listAllWeightLog")
	public String listAll(Model model){
		model.addAttribute("list", weightLogService.listAll());
		return "listAllWeightLog";
	}
	
	@RequestMapping("/pageWeightLog")
	public String page(Model model,PageInfo pageInfo){
		if(pageInfo.getPageNo()>1)return "forward:ajaxPageWeightLog.do";
		pageInfo.setNeedSetTotalSize(false);
		pageInfo.setPageSize(50);
		model.addAttribute("list", weightLogService.page(pageInfo));
		model.addAttribute("page",(pageInfo));
		return "pageWeightLog";
	}
	
	@RequestMapping("/ajaxPageWeightLog")
	@ResponseBody
	public Object ajaxPage(Model model,PageInfo pageInfo){
		pageInfo.setNeedSetTotalSize(false);
		pageInfo.setPageSize(50);
		model.addAttribute("list", weightLogService.page(pageInfo));
		model.addAttribute("page",(pageInfo));
		return model;
	}
	
	@RequestMapping("/getWeightLogById")
	public String getWeightLogById(Integer id,Model model){
		model.addAttribute("pojo", weightLogService.get(id));
		return "getWeightLogById";
	}
	
	@RequestMapping("/updateWeightLog")
	public String updateWeightLog(WeightLog pojo){
		weightLogService.update(pojo);
		return "updateWeightLog";
	}
	
	@RequestMapping("/addWeightLog")
	public String addWeightLog(WeightLog pojo){
		pojo.setOpDate(new Date());
		pojo.setOpUser(carService.get(pojo.getOpCarId()).getCarNo());
		pojo.setState(0);
		weightLogService.save(pojo);
		return "redirect:pageWeightLog.do";
	}
	
	@RequestMapping("/removeWeightLog")
	public String removeWeightLog(Integer[] id){
		weightLogService.delete(Arrays.asList(id));
		return "removeWeightLog";
	}
	
	
	@RequestMapping("/toLogWeight")
	public String toLogWeight(Model model){
		model.addAttribute("cars",  carService.listAll());
		return "toWeightLog";
	}
	
	
	@RequestMapping("/ajaxGetWeightLogById")
	@ResponseBody
	public Object ajaxGetWeightLogById(Integer id,Model model){
		return weightLogService.get(id);
	}
	
	@RequestMapping("/ajaxUpdateWeightLog")
	@ResponseBody
	public Object ajaxUpdateWeightLog(WeightLog pojo){
		weightLogService.update(pojo);
		return pojo;
	}
	
	@RequestMapping("/ajaxAddWeightLog")
	@ResponseBody
	public Object ajaxAddWeightLog(WeightLog pojo){
		weightLogService.save(pojo);
		return pojo;
	}
	
	@RequestMapping("/ajaxRemoveWeightLog")
	@ResponseBody
	public Object ajaxRemoveWeightLog(Integer[] id){
		weightLogService.delete(Arrays.asList(id));
		return Arrays.asList(id);
	}
	
	
	@RequestMapping("/ajaxValidateWeightLog")
	@ResponseBody
	public Object ajaxValidateWeight(WeightLog pojo){
		 WeightLog data = weightLogService.get(pojo.getId());
		 if(!data.getWeight().equals(pojo.getWeight())){
			 return "与本身重量不一致！反馈失败！";
		 }
		 
		 data.setState(1);
		 weightLogService.save(data);
		 return "反馈成功！";
	}
	
}
