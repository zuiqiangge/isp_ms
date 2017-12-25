package cn.com.pengyue.web.action;

import java.util.Arrays;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.pengyue.pojo.Role;
import cn.com.pengyue.service.IRoleService;

@Controller
public class RoleController {
	
	@javax.annotation.Resource
	private IRoleService roleService;
	
	@RequestMapping("/listAllRole")
	public String listAll(Model model){
		model.addAttribute("list", roleService.listAll());
		return "listAllRole";
	}
	
	@RequestMapping("/getRoleById")
	public String getRoleById(Integer id,Model model){
		model.addAttribute("pojo", roleService.get(id));
		return "getRoleById";
	}
	
	@RequestMapping("/updateRole")
	public String updateRole(Role pojo){
		roleService.update(pojo);
		return "updateRole";
	}
	
	@RequestMapping("/addRole")
	public String addRole(Role pojo){
		roleService.save(pojo);
		return "addRole";
	}
	
	@RequestMapping("/removeRole")
	public String removeRole(Integer[] id){
		roleService.delete(Arrays.asList(id));
		return "removeRole";
	}
	
	
	
	@RequestMapping("/ajaxGetRoleById")
	@ResponseBody
	public Object ajaxGetRoleById(Integer id,Model model){
		return roleService.get(id);
	}
	
	@RequestMapping("/ajaxUpdateRole")
	@ResponseBody
	public Object ajaxUpdateRole(Role pojo){
		roleService.update(pojo);
		return pojo;
	}
	
	@RequestMapping("/ajaxAddRole")
	@ResponseBody
	public Object ajaxAddRole(Role pojo){
		roleService.save(pojo);
		return pojo;
	}
	
	@RequestMapping("/ajaxRemoveRole")
	@ResponseBody
	public Object ajaxRemoveRole(Integer[] id){
		roleService.delete(Arrays.asList(id));
		return Arrays.asList(id);
	}
	
}
