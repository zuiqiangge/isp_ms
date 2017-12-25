package cn.com.pengyue.web.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.alibaba.druid.util.StringUtils;

import cn.com.pengyue.pojo.LendInfo;
import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.User;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.ILendInfoService;
import cn.com.pengyue.service.ILoggingService;
import cn.com.pengyue.service.IUserService;
import cn.com.pengyue.service.impl.LendInfoService;
import cn.com.pengyue.util.AccessConstants;
import cn.com.pengyue.util.Condition;

@Controller
public class UserController implements AccessConstants{
	@Resource
	private IUserService userService;
	@Resource
	private ILendInfoService lendInfoService;
	@javax.annotation.Resource
	private ILoggingService loggingService;
	/**
	 * 用户界面
	 */
	@RequestMapping("/toUserList")
	public String toUserList(HttpServletRequest request,HttpSession session){
		
		//日志操作
		Logging log1=new Logging();
		log1.setOpTime(new Date());
		log1.setMethodUrl("toUserList.do");
		log1.setSysDesc("跳转！");
		log1.setSysDescId("action");
		Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
		log1.setUserId(loginUsers);
		log1.setDetailsInfo("跳转人员管理列表界面!");
		loggingService.save(log1);
		return "listUser";
	}
	
	
	/**
	 * 获取列表
	 */
	@RequestMapping("/getUserList")
	public void getUserList(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		PrintWriter out =null;
		try{
			String pageStr = request.getParameter("start");
			String numStr = request.getParameter("length");
			int page=0;
			int num=10;
			if(null!=pageStr&&!(StringUtils.isEmpty(pageStr)))
				page = Integer.parseInt(pageStr);
			if(null!=numStr&&!(StringUtils.isEmpty(numStr)))
				num = Integer.parseInt(numStr);
			Condition condition = new Condition();
			condition.getConditions().put("page", page);
			condition.getConditions().put("num", num);
			List<User> result = userService.getUserList(condition);
			int total = userService.getUserListCount(condition);
			JSONObject json = new JSONObject();
			json.put("data",result);
			json.put("recordsTotal", total);
			json.put("recordsFiltered", total);
			json.put("draw",Integer.parseInt(request.getParameter("draw")));
			out = response.getWriter();
			out.print(json);
			
			//日志操作
			Logging log1=new Logging();
			log1.setOpTime(new Date());
			log1.setMethodUrl("toUserList.do");
			log1.setSysDesc("获取列表数据！");
			log1.setSysDescId("action");
			Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
			log1.setUserId(loginUsers);
			log1.setDetailsInfo("获取人员管理列表数据!");
			loggingService.save(log1);
			
		}catch(Exception e){
			//日志操作
			Logging log1=new Logging();
			log1.setOpTime(new Date());
			log1.setMethodUrl("toUserList.do");
			log1.setSysDesc("获取列表数据！");
			log1.setSysDescId("action");
			Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
			log1.setUserId(loginUsers);
			log1.setDetailsInfo("获取人员管理列表数据失败!");
			loggingService.save(log1);
			e.printStackTrace();
		}finally{
			if(null!=out)
				out.close();
		}
		
	}
	
	
	/**
	 * 添加用户
	 */
	@RequestMapping("/addUser")
	public String addUser(HttpServletRequest request,HttpServletResponse response){
			String nameStr = request.getParameter("name");
			String sexStr = request.getParameter("sex");
			String ageStr = request.getParameter("age");
			MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
	        Iterator iter=multiRequest.getFileNames();
	        MultipartFile file=null;
	        if(iter.hasNext())
	        	file = multiRequest.getFile(iter.next().toString());
	        
			User user = new User();
			if(null!=file)
			user.setPhoto("upload/"+file.getOriginalFilename());
			if(null!=nameStr&&!(StringUtils.isEmpty(nameStr)))
				user.setName(nameStr);
			if(null!=sexStr&&!(StringUtils.isEmpty(sexStr)))
				user.setSex(Integer.parseInt(sexStr));
			if(null!=ageStr&&!(StringUtils.isEmpty(ageStr)))
				user.setAge(Integer.parseInt(ageStr));
			try {
				springUpload(request);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			userService.save(user);
		return "listUser";
	}
	
	/**
	 * 获取对象
	 */
	@RequestMapping("/get")
	public void get(HttpServletRequest request,HttpServletResponse response){
		String id = request.getParameter("id");
		PrintWriter out =null;
		if(null!=id&&!(StringUtils.isEmpty(id))){
			User user = userService.get(Integer.parseInt(id));
			JSONObject json =new JSONObject();
			json.put("user",user);
			JSONArray f = JSONArray.fromObject(user);
			try {
				out = response.getWriter();
						out.print(f.get(0));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				if(null!=out)
					out.close();
			}
		}
	}

	
	/**
	 * 删除
	 */
	@RequestMapping("/delUser")
	public void del(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out = null;
		String isSuccess = "";
		try{
			out = response.getWriter();
			String id = request.getParameter("id");
			
			if(null!=id&&!(StringUtils.isEmpty(id))){
				List<LendInfo> lends = lendInfoService.getListByLendUserId(Integer.parseInt(id));
				for(LendInfo le :lends){
					le.setLendUser(null);
					lendInfoService.update(le);
				}
				userService.delete(userService.get(Integer.parseInt(id)));
				isSuccess = "删除成功";
			}
			
		}catch(Exception e){
			isSuccess = "删除失败";
			e.printStackTrace();
		}finally{
			if(null!=out){
				out.write(isSuccess);
				out.close();
			}
		}
	}
	
	/**
	 * 编辑
	 * @param request
	 * @param response
	 */
	@RequestMapping("/updateUser")
	public void updateUser(HttpServletRequest request,HttpServletResponse response){
		String id = request.getParameter("id");
		if(null!=id&&!(StringUtils.isEmpty(id))){
			MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
		    Iterator iter=multiRequest.getFileNames();
	        MultipartFile file=null;
	        if(iter.hasNext())
	        	file = multiRequest.getFile(iter.next().toString());
			User user = userService.get(Integer.parseInt(id));
			if(null!=file)
				user.setPhoto("upload/"+file.getOriginalFilename());
			user.setName(request.getParameter("name"));
			user.setSex(Integer.parseInt(request.getParameter("sex")));
			user.setAge(Integer.parseInt(request.getParameter("age")));
			try {
				springUpload(request);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			userService.update(user);
		}
		
	}
	
	
	
	    public void  springUpload(HttpServletRequest request) throws IllegalStateException, IOException
	    {
	         //将当前上下文初始化给  CommonsMutipartResolver （多部分解析器）
	        CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(
	                request.getSession().getServletContext());
	        //检查form中是否有enctype="multipart/form-data"
	        if(multipartResolver.isMultipart(request))
	        {
	            //将request变成多部分request
	            MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
	           //获取multiRequest 中所有的文件名
	            Iterator iter=multiRequest.getFileNames();
	             
	            while(iter.hasNext())
	            {
	                //一次遍历所有文件
	                MultipartFile file=multiRequest.getFile(iter.next().toString());
	                if(file!=null)
	                {
	                    //String path="/upload/springUpload"+file.getOriginalFilename();
	                	String path = request.getSession().getServletContext().getRealPath("/upload");
	                    //上传
	                    file.transferTo(new File(path+"/"+file.getOriginalFilename()));
	                }
	                 
	            }
	           
	        }
	       
	    }
}
