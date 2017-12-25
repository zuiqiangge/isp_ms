package cn.com.pengyue.web.action;

import java.util.Arrays;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.IDepartmentService;
import cn.com.pengyue.service.IPositionService;
import cn.com.pengyue.service.IUsersService;
import cn.com.pengyue.util.AccessConstants;

@Controller
public class UsersController {
	
	@javax.annotation.Resource
	private IUsersService usersService;
	
	@javax.annotation.Resource
	private IDepartmentService departmentService;
	
	@javax.annotation.Resource
	private IPositionService positionService;
	
	@RequestMapping("/listAllUsers")
	public String listAll(Model model){
		model.addAttribute("list", usersService.listAll());
		
		model.addAttribute("departmentList", departmentService.listAll());
		model.addAttribute("positionList", positionService.listAll());
		
		return "listAllUsers";
	}
	
	@RequestMapping("/getUsersById")
	public String getUsersById(Integer id,Model model){
		model.addAttribute("pojo", usersService.get(id));
		return "getUsersById";
	}
	
	@RequestMapping("/updateUsers")
	public String updateUsers(Users pojo){
		usersService.update(pojo);
		return "updateUsers";
	}
	
	@RequestMapping("/addUsers")
	public String addUsers(Users pojo){
		usersService.save(pojo);
		return "addUsers";
	}
	
	@RequestMapping("/removeUsers")
	public String removeUsers(Integer[] id){
		usersService.delete(Arrays.asList(id));
		return "removeUsers";
	}
	
	
	
	@RequestMapping("/ajaxGetUsersById")
	@ResponseBody
	public Object ajaxGetUsersById(Integer id,Model model){
		return usersService.get(id);
	}
	
	@RequestMapping("/ajaxUpdateUsers")
	@ResponseBody
	public Object ajaxUpdateUsers(Users pojo){
		usersService.update(pojo,new String[]{
				"id"
				,"passWord"
				,"lastLoginTime"
				,"realPassWord"
		});
		return pojo;
	}
	
	@RequestMapping("/ajaxAddUsers")
	@ResponseBody
	public Object ajaxAddUsers(Users pojo){
		usersService.save(pojo);
		return pojo;
	}
	
	@RequestMapping("/ajaxRemoveUsers")
	@ResponseBody
	public Object ajaxRemoveUsers(Integer[] id){
		usersService.delete(Arrays.asList(id));
		return Arrays.asList(id);
	}
	
	@RequestMapping("/ajaxGetUsersIsNotId")
	@ResponseBody
	public Object ajaxGetUsersIsNotId(HttpSession session,Model model){
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		model.addAttribute("userList", usersService.getUsers(user.getId()));
		return "ajaxGetUsersIsNotId";
	}
}
