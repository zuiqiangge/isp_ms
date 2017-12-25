package cn.com.pengyue.web.action;

import java.sql.Array;
import java.util.Arrays;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.pengyue.pojo.Position;
import cn.com.pengyue.service.IDepartmentService;
import cn.com.pengyue.service.IPositionService;

@Controller
public class PositionController {
	@Resource
	public IPositionService postionService;
	@Resource
	public IDepartmentService department;
	
	@RequestMapping("/listAllPosition")
	public String listAll(Model model){
		model.addAttribute("list", postionService.listAll());
		model.addAttribute("bmList", department.listAll());
		return "listAllPosition";
	}
	
	@RequestMapping("/getPositionById")
	@ResponseBody
	public Object getPositionById(HttpServletRequest request,Model model){
		Position pojo=new Position();
		Integer id=Integer.valueOf(request.getParameter("id"));
		pojo.setId(id);
		model.addAttribute("pojo", postionService.get(id));
		return model;
	}
	
	@RequestMapping("/updatePosition")
	@ResponseBody
	public Object updatePosition(HttpServletRequest request,Position pojo){
		String name=request.getParameter("name");
		Integer id=Integer.valueOf(request.getParameter("id"));
		Integer bmId=Integer.valueOf(request.getParameter("bmId"));
		pojo.setName(name);
		pojo.setBmId(bmId);
		pojo.setId(id);
		postionService.update(pojo);
		return pojo;
	}
	
	
	@RequestMapping("/removePosition")
	public String removePosition(HttpServletRequest request){
		int id=Integer.valueOf(request.getParameter("id"));
		Integer[] ids={id};
		postionService.delete(Arrays.asList(ids));
		return "removePosition";
	}
	
	
	@RequestMapping("/addPosition")
	@ResponseBody
	public Object ajaxAddPosition(HttpServletRequest request){
		Position pojo=new Position();
		String name=request.getParameter("name");
		Integer id=Integer.valueOf(request.getParameter("id"));
		pojo.setName(name);
		pojo.setBmId(id);
		postionService.save(pojo);
		return pojo;
	}
}
