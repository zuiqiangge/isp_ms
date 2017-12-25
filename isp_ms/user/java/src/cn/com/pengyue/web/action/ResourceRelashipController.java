package cn.com.pengyue.web.action;

import java.util.Arrays;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.pengyue.pojo.ResourceRelaship;
import cn.com.pengyue.service.IResourceRelashipService;

@Controller
public class ResourceRelashipController {
	
	@javax.annotation.Resource
	private IResourceRelashipService resourceRelashipService;
	
	@RequestMapping("/listAllResourceRelaship")
	public String listAll(Model model){
		model.addAttribute("list", resourceRelashipService.listAll());
		return "listAllResourceRelaship";
	}
	
	@RequestMapping("/getResourceRelashipById")
	public String getResourceRelashipById(Integer id,Model model){
		model.addAttribute("pojo", resourceRelashipService.get(id));
		return "getResourceRelashipById";
	}
	
	@RequestMapping("/updateResourceRelaship")
	public String updateResourceRelaship(ResourceRelaship pojo){
		resourceRelashipService.update(pojo);
		return "updateResourceRelaship";
	}
	
	@RequestMapping("/addResourceRelaship")
	public String addResourceRelaship(ResourceRelaship pojo){
		resourceRelashipService.save(pojo);
		return "addResourceRelaship";
	}
	
	@RequestMapping("/removeResourceRelaship")
	public String removeResourceRelaship(Integer[] id){
		resourceRelashipService.delete(Arrays.asList(id));
		return "removeResourceRelaship";
	}
	
	
	
	@RequestMapping("/ajaxGetResourceRelashipById")
	@ResponseBody
	public Object ajaxGetResourceRelashipById(Integer id,Model model){
		return resourceRelashipService.get(id);
	}
	
	@RequestMapping("/ajaxUpdateResourceRelaship")
	@ResponseBody
	public Object ajaxUpdateResourceRelaship(ResourceRelaship pojo){
		resourceRelashipService.update(pojo);
		return pojo;
	}
	
	@RequestMapping("/ajaxAddResourceRelaship")
	@ResponseBody
	public Object ajaxAddResourceRelaship(ResourceRelaship pojo){
		resourceRelashipService.save(pojo);
		return pojo;
	}
	
	@RequestMapping("/ajaxRemoveResourceRelaship")
	@ResponseBody
	public Object ajaxRemoveResourceRelaship(Integer[] id){
		resourceRelashipService.delete(Arrays.asList(id));
		return Arrays.asList(id);
	}
	
}
