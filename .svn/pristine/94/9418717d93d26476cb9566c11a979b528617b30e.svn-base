package cn.com.pengyue.web.action;

import java.util.Arrays;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.tools.internal.ws.processor.model.Request;

import cn.com.pengyue.pojo.Department;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.IDepartmentService;

@Controller
public class DepartmentController {
	
	@Resource
	private IDepartmentService departmentService;
	
	@RequestMapping("/listAllDepartment")
	public String listAll(Model model){
		model.addAttribute("list", departmentService.listAll());
		return "listAllDepartment";
	}
	
	@RequestMapping("/getDepartmentById")
	@ResponseBody
	public Object getDepartmentById(HttpServletRequest request,Model model){
		Integer id=Integer.valueOf(request.getParameter("bm_id"));
		model.addAttribute("pojo", departmentService.get(id));
		return model;
	}
	
	@RequestMapping("/updateDepartment")
	@ResponseBody
	public Object updateDepartment(HttpServletRequest request,Department pojo){
		String name=request.getParameter("name");
		pojo.setBmName(name);
		departmentService.update(pojo);
		return pojo;
	} 
	
	
	@RequestMapping("/removeDepartment")
	public String removeDepartment(HttpServletRequest request){
		int id=Integer.valueOf(request.getParameter("bm_id"));
		Integer[] ids={id};
		departmentService.delete(Arrays.asList(ids));
		return "removeDepartment";
	}
	
	
	@RequestMapping("/addDepartment")
	@ResponseBody
	public Object ajaxAddDepartment(HttpServletRequest request){
		Department pojo=new Department();
		String name=request.getParameter("bm_name");
		pojo.setBmName(name);
		departmentService.save(pojo);
		return "listAllDepartment";
	}

	
}
