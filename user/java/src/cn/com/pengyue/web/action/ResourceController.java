package cn.com.pengyue.web.action;

import java.util.Arrays;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.pengyue.pojo.Resource;
import cn.com.pengyue.service.IResourceService;

@Controller
public class ResourceController {
	
	@javax.annotation.Resource
	private IResourceService resourceService;
	
	@RequestMapping("/listAllResource")
	public String listAll(Model model){
		model.addAttribute("list", resourceService.listAll());
		return "listAllResource";
	}
	
	@RequestMapping("/getResourceById")
	public String getResourceById(Integer id,Model model){
		model.addAttribute("pojo", resourceService.get(id));
		return "getResourceById";
	}
	
	@RequestMapping("/updateResource")
	public String updateResource(Resource pojo){
		resourceService.update(pojo);
		return "updateResource";
	}
	
	@RequestMapping("/addResource")
	public String addResource(Resource pojo){
		resourceService.save(pojo);
		return "addResource";
	}
	
	@RequestMapping("/removeResource")
	public String removeResource(Integer[] id){
		resourceService.delete(Arrays.asList(id));
		return "removeResource";
	}
	
	
	
	@RequestMapping("/ajaxGetResourceById")
	@ResponseBody
	public Object ajaxGetResourceById(Integer id,Model model){
		return resourceService.get(id);
	}
	
	@RequestMapping("/ajaxUpdateResource")
	@ResponseBody
	public Object ajaxUpdateResource(Resource pojo){
		resourceService.update(pojo);
		return pojo;
	}
	
	@RequestMapping("/ajaxAddResource")
	@ResponseBody
	public Object ajaxAddResource(Resource pojo){
		resourceService.save(pojo);
		return pojo;
	}
	
	@RequestMapping("/ajaxRemoveResource")
	@ResponseBody
	public Object ajaxRemoveResource(Integer[] id){
		resourceService.delete(Arrays.asList(id));
		return Arrays.asList(id);
	}
	
}
