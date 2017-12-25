package cn.com.pengyue.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.support.json.JSONUtils;

import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.Resource;
import cn.com.pengyue.pojo.ResourceRelaship;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.ILoggingService;
import cn.com.pengyue.service.IResourceRelashipService;
import cn.com.pengyue.service.IResourceService;
import cn.com.pengyue.service.IRoleService;
import cn.com.pengyue.service.IUsersService;
import cn.com.pengyue.util.AccessConstants;
import cn.com.pengyue.util.JacksonTest;
import cn.com.pengyue.util.Md5Utils;
@Controller
public class AccessController implements AccessConstants , ApplicationContextAware{
	
	@javax.annotation.Resource
	private IUsersService usersService;
	
	@javax.annotation.Resource
	private IResourceService resourceService;
	
	
	@javax.annotation.Resource
	private IRoleService roleService;
	
	@javax.annotation.Resource
	private IResourceRelashipService resourceRelashipService;
	
	@javax.annotation.Resource
	private ILoggingService loggingService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/login")
	public String login(Users user,HttpSession session,Model model){
		Users loginUser = (Users) session.getAttribute(SESSION_NAME_LOGINED_USER);
		Logging log=new Logging();
		if(loginUser!=null){
			return "redirect:/index.do";
		}
		if(userIsEmpty(user)){
			return "login";
		}
		Users condition = new Users();
		condition.setUserName(user.getUserName());
		List<Users> queryResult =  usersService.list(condition);
		if(queryResult==null || queryResult.isEmpty()){
			model.addAttribute("loginErrorMsg", "用户名错误！");
			
			
			log.setOpTime(new Date());
			log.setMethodUrl("login.do");
			log.setSysDesc("登录操作！");
			log.setDetailsInfo("使用了错误的用户名登录！");
			loggingService.save(log);
			return "login";
		}
		loginUser =  queryResult.get(0);
		if(!loginUser.getPassWord().equalsIgnoreCase(Md5Utils.md5(user.getPassWord()))){
			model.addAttribute("loginErrorMsg", "密码错误！");
			
			log.setOpTime(new Date());
			log.setMethodUrl("login.do");
			log.setSysDesc("登录操作！");
			log.setDetailsInfo("使用了错误的密码登录！");
			loggingService.save(log);
			return "login";
		}
		session.setAttribute(SESSION_NAME_LOGINED_USER, loginUser);
		loginUser.setLastLoginTime(new Date());
		usersService.update(loginUser);
		boolean isAdmin = loginUser.getRole()!=null &&  loginUser.getRole().intValue() == 1;
		session.setAttribute(SESSION_NAME_LOING_IS_ADMIN,isAdmin);
		List userResources = null;
		if(isAdmin){
			//全部资源。
			userResources = resourceService.listAll();
		}else{
			ResourceRelaship queryResourceCondition = new ResourceRelaship();
			//用户角色资源
			queryResourceCondition.setType(RESOURCE_TYPE_ROLE);
			queryResourceCondition.setTargetId(loginUser.getRole());
			List userRoleResources = resourceRelashipService.listRelashipResource(queryResourceCondition);
			
			//用户资源
			queryResourceCondition.setType(RESOURCE_TYPE_USER);
			queryResourceCondition.setTargetId(loginUser.getId());
			userResources = resourceRelashipService.listRelashipResource(queryResourceCondition);
			//和一起就是用户的资源
			userResources.addAll(userRoleResources);
			
			//hibernate返回的是object数组这里只要 resource 
			//userResources = ObjArrayListUtils.exportItemOfClass(userResources, Resource.class);
		}
		
		resourceService.handRelaship(userResources, null);
		Collections.sort(userResources,new Comparator<Resource>(){
			public int compare(Resource o1, Resource o2) {
				int a = o1.getOrderIndex() == null ? 0 : o1.getOrderIndex();
				int b = o2.getOrderIndex() == null ? 0 : o2.getOrderIndex();
				return  a - b;
			}
		});
		session.setAttribute("userResources", userResources);
		
		//提供扩展点
		if(initOpts!=null){
			for (LoginInitOpt opt : initOpts) {
				opt.init(session);
			}
		}
		
		log.setOpTime(new Date());
		log.setMethodUrl("login.do");
		log.setSysDesc("登录操作！");
		log.setDetailsInfo("使用用户名："+queryResult.get(0).getUserName()+"登录成功！");
		loggingService.save(log);
		
		
		
		return "redirect:/index.do";
	}
	private boolean userIsEmpty(Users user) {
		return user == null || user.getPassWord() == null || user.getUserName() == null;
	}
	
	@RequestMapping("/index")
	public String toIndex(HttpSession session) {
		Boolean isAdmin = (Boolean) session.getAttribute(SESSION_NAME_LOING_IS_ADMIN);
		if(isAdmin!=null && isAdmin){
			return "admin/index";
		}else{
			return "index";
		}
	}

	
	
	@RequestMapping("/logout")
	public String listAll(HttpSession session){
		//提供扩展点
		if(logoutOpts!=null){
			for (LogoutOpt opt : logoutOpts) {
				opt.logout(session);
			}
		}
		session.invalidate();
		return "redirect:/login.do";
	}
	

	@RequestMapping("/toResetPwd")
	public String toResetPwd() {
		return "resetPwd";
	}
	
	@RequestMapping("/resetPwd")
	@ResponseBody
	public Object resetPwd(HttpSession session,Users user){
		String oldPwd = user.getUserName();
		String newPwd = user.getPassWord();
		Logging log=new Logging();
		Users loginUser = (Users) session.getAttribute(SESSION_NAME_LOGINED_USER);
		if(loginUser==null){
			
			log.setOpTime(new Date());
			log.setMethodUrl("login.do");
			log.setSysDesc("修改密码！");
			log.setDetailsInfo("您尚未登录或会话过期，请重新登录后操作!");
			loggingService.save(log);
			return "您尚未登录或会话过期，请重新登录后操作!";
		}
		if(oldPwd!=null && !loginUser.getPassWord().equals(Md5Utils.md5(oldPwd))){
			log.setOpTime(new Date());
			log.setMethodUrl("resetPwd.do");
			log.setSysDesc("修改密码！");
			log.setDetailsInfo("输入的密码错误，修改失败！");
			loggingService.save(log);
			return "当前密码输入错误!";
		}
		loginUser.setPassWord(Md5Utils.md5(newPwd));
		usersService.update(loginUser);
		
		log.setOpTime(new Date());
		log.setMethodUrl("resetPwd.do");
		log.setSysDesc("修改密码！");
		log.setDetailsInfo("修改密码成功！");
		loggingService.save(log);
		
		return "修改成功!";
	}

	
	@RequestMapping("/toGrantUser")
	public String toGrantUser(Model model,HttpSession session) {
		List<Resource> resources = resourceService.listAll();
		resourceService.handRelaship(resources, null);
		//移除子菜单
		for (int i = resources.size()-1; i > -1; i--) {
			if(resources.get(i).getParent()!=null){
				resources.remove(i);
			}
		}
		model.addAttribute("roles",roleService.listAll());
		model.addAttribute("resources",resources);
		
		Logging log=new Logging();
		log.setOpTime(new Date());
		log.setMethodUrl("toGrantUser.do");
		log.setSysDesc("菜单显示！");
		log.setDetailsInfo("显示所有菜单！");
		loggingService.save(log);
		
		return "grantUser";
	}
	
	/**
	 * 根据角色Id获取权限信息
	 * @param model 模型视图
	 * @param session 会话对象
	 * @param id 角色Id
	 * @return
	 */
	@RequestMapping("/toGrantUserById")
	public void toGrantUserById(HttpServletResponse response,Model model,HttpSession session,Integer id) {
		List<ResourceRelaship> ListresourceRelaship = resourceRelashipService.findListByRoleId(id);
		List<Resource> resources = new ArrayList<Resource>();
		for(ResourceRelaship relaship : ListresourceRelaship){
			int resourceId = relaship.getResourceId();
			Resource resource = resourceService.get(resourceId);
			resources.add(resource);
		}
		resourceService.handRelaship(resources, null);
		//移除子菜单
		for (int i = resources.size()-1; i > -1; i--) {
			if(resources.get(i).getParent()!=null){
				resources.remove(i);
			}
		}
		
		
		Logging log=new Logging();
		log.setOpTime(new Date());
		log.setMethodUrl("toGrantUserById.do");
		log.setSysDesc("菜单显示！");
		log.setDetailsInfo("显示所有菜单！");
		loggingService.save(log);
		PrintWriter out=null;
		
			try {
				out = response.getWriter();
				
				 
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			try {
				//mapper.writeValue(out, resources);
//				ObjectMapper mapper = new ObjectMapper();
				
			 ObjectMapper mapper = new ObjectMapper();
			//String json = mapper.writeValueAsString(resources);
			//mapper.writeValue(System.out, resources); 
			mapper.writeValue(out, resources);
			
				//json = "{\"resources\":" +json+"}";
				
				//out.write(json);
				
				
			} catch (JsonGenerationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JsonMappingException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				out.close();
			}

		
	}
	
	
	
	public static void main(String[] args) {
		List<Date> list=new ArrayList<Date>();
		list.add(new Date());
		list.add(new Date());
		ObjectMapper mapper = new ObjectMapper();
		  try {
			mapper.writeValue(System.out, list);
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} //返回字符串
	}
	
	@RequestMapping("/grantUser")
	@ResponseBody
	public String grantUser(
			@RequestParam(value="userId",required=false) Integer userId
			,@RequestParam(value="roleId",required=false) Integer roleId
			,@RequestParam("resouceId") Integer[] resouceIds
	) {
		if(userId==null && roleId == null){
			return "必须选择角色或者用户!";
		}
		int id = roleId != null ? roleId : userId;
		int type = roleId != null ? RESOURCE_TYPE_ROLE : RESOURCE_TYPE_USER;
		resourceRelashipService.resetRelaship(id, type, resouceIds);
		
		Logging log=new Logging();
		log.setOpTime(new Date());
		log.setMethodUrl("grantUser.do");
		log.setSysDesc("授权操作！");
		log.setDetailsInfo("给该用户添加权限!");
		loggingService.save(log);
		
		return "赋权成功！";
	}
	
	
	private ApplicationContext beanFactroy;
	private Collection<LogoutOpt> logoutOpts;
	private Collection<LoginInitOpt> initOpts;
	public void setApplicationContext(ApplicationContext applicationContext)
		throws BeansException {
		this.beanFactroy = applicationContext;
		
		//提供扩展点
		Map<String,LoginInitOpt> initOpts = beanFactroy.getBeansOfType(LoginInitOpt.class);
		if(initOpts!=null && initOpts.isEmpty()){
			this.initOpts = null;
		}else{
			this.initOpts = initOpts.values();
		}
		
		//提供扩展点
		Map<String,LogoutOpt> logoutOpts = beanFactroy.getBeansOfType(LogoutOpt.class);
		if(logoutOpts!=null && logoutOpts.isEmpty()){
			this.logoutOpts = null;
		}else{
			this.logoutOpts = logoutOpts.values();
		}
	}

}
