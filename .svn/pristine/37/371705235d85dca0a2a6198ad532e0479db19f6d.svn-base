package cn.com.pengyue.web.action;

import java.util.Arrays;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.pengyue.pojo.Classes;
import cn.com.pengyue.service.IClassesService;

@Controller
public class ClassesController {
	
	@Resource
	private IClassesService classesService;
	
	@RequestMapping("/listAllClasses") 
	public String listAll(Model model){
		model.addAttribute("pojo", classesService.listAll());
		return "listAllClasses";
	}
	

	@RequestMapping("/addClasses")
	@ResponseBody
	public Object addClasses(HttpServletRequest request){
		Classes pojo=new Classes();
		String name=request.getParameter("name");
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		String type=request.getParameter("type");
		pojo.setEnd_time(endTime);
		pojo.setName(name);
		pojo.setStart_time(startTime);
		pojo.setType(type);
		classesService.save(pojo);
		return pojo;
	}
	
	@RequestMapping("/delClasses")
	@ResponseBody
	public Object delClasses(HttpServletRequest request){
		Integer id=Integer.valueOf(request.getParameter("id"));
		Integer[] ids={id};
		classesService.delete(Arrays.asList(ids));
		return "delClasses";
	}
	
	@RequestMapping("/getClasses")
	@ResponseBody
	public Object getClasses(HttpServletRequest request,Model model){
		Integer id=Integer.valueOf(request.getParameter("id"));
		model.addAttribute("pojo",classesService.get(id));
		return model;
	}
	
	@RequestMapping("/updateClasses")
	@ResponseBody
	public String updateClasses(HttpServletRequest request){
		String name=request.getParameter("name");
		String type=request.getParameter("type");
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		Integer id=Integer.valueOf(request.getParameter("id"));
		Classes pojo=new Classes();
		pojo.setEnd_time(endTime);
		pojo.setName(name);
		pojo.setStart_time(startTime);
		pojo.setType(type);
		pojo.setId(id);
		classesService.update(pojo);
		return "updateClasses";
	}
	
	
	//增加排班
	@RequestMapping("/addCarAndClasses")
	@ResponseBody
	public Object addCarAndClasses(HttpServletRequest request){
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		int car_id=Integer.valueOf(request.getParameter("car_id"));
		System.out.println("输出为："+car_id);
		//申请表id
		int apply_id=Integer.valueOf(request.getParameter("apply_id"));
		Classes pojo=new Classes();
		pojo.setApply_id(apply_id);
		pojo.setEnd_time(endTime);
		pojo.setStart_time(startTime);
		pojo.setCar_id(car_id);
		//pojo.setName(carService.get(car_id).getName());
		classesService.save(pojo);
		return pojo;
	}
}
