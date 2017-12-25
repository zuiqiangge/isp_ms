package cn.com.pengyue.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.druid.util.StringUtils;

import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.ILoggingService;
import cn.com.pengyue.service.IUserService;
import cn.com.pengyue.service.IUsersService;
import cn.com.pengyue.service.impl.UsersService;
import cn.com.pengyue.util.AccessConstants;

@Controller
public class LoggingController implements AccessConstants{
	@Resource
	public ILoggingService loggingService;
	@Resource
	public IUsersService usersService;
	
	@RequestMapping("/AllLogList")
	public String AllLogList(Model model,HttpSession session){
		//查询记录表里出现过的用户
		List<Users> users = loggingService.getUsersGroupByUser();
		//查询记录里出现过的摘要
		List<Logging> zys = loggingService.getLoggingGroupByZY();
		model.addAttribute("users",users);
		model.addAttribute("zys",zys);
		Users loginUser = (Users) session.getAttribute(SESSION_NAME_LOGINED_USER);
		model.addAttribute("currentUser",loginUser);
		return "AllLogList";
	}
	
	/***
	 * 条件分页查询
	 * @param model
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getAllLogList")
	public void getAllLogList(Logging logging,Model model,HttpServletRequest request,HttpServletResponse response){
		try {
			if(null!=logging.getUserId())
			logging.setUserId(usersService.get(logging.getUserId().getId()));
			String pageStr = request.getParameter("start");
			String numStr = request.getParameter("length");
			int firstResult=0;
			int maxResults=10;
			if(null!=pageStr&&!(StringUtils.isEmpty(pageStr)))
				firstResult = Integer.parseInt(pageStr);
			if(null!=numStr&&!(StringUtils.isEmpty(numStr)))
				maxResults = Integer.parseInt(numStr);
			request.setCharacterEncoding("utf-8");
			PrintWriter out = response.getWriter();
			List<Logging> logs = loggingService.getListByCondition(logging, firstResult, maxResults);
			System.out.println(logs);
			JSONObject result = new JSONObject();
			result.put("data", logs);
			result.put("draw",request.getParameter("draw"));
			int total = loggingService.getCountByCondition(logging);
			result.put("recordsTotal",total);
			result.put("recordsFiltered", total);
			out.print(result);
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping("/ajaxQueryLoggingList")
	public Object ajaxQueryLoggingList(Model model,HttpServletRequest request) throws ParseException{
		int userId=Integer.valueOf(request.getParameter("userId"));
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String start=request.getParameter("startTime");
		String end=request.getParameter("endTime");
		Date startTime=sdf.parse(start);  
		Date endTime=sdf.parse(end);
		

		model.addAttribute("list", loggingService.allByConditionLogList(userId, startTime, endTime));
		return "ajaxQueryLoggingList";
	}
	
}
