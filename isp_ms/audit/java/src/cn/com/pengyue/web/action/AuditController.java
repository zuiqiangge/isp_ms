package cn.com.pengyue.web.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.HttpRequestHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.com.pengyue.pojo.Audit;
import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.IAuditService;
import cn.com.pengyue.service.ILoggingService;
import cn.com.pengyue.service.IUsersService;
import cn.com.pengyue.util.AccessConstants;

@Controller
public class AuditController {
	
	@Resource
	public IAuditService auditService;
	@Resource
	public ILoggingService loggingService;
	@Resource
	public IUsersService userService;
	
	@RequestMapping("/allLingdaoList")
	public String allLingdaoList(Model model,HttpSession session){
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		model.addAttribute("lingdao", auditService.lingdaoList(user.getId()));
		model.addAttribute("users",userService.getAllLingDao());
		model.addAttribute("currentUser",user);
		
		//增加日志信息
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("allLingdaoList.do");
		logging.setDetailsInfo("查询需要审批的所有申请！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return "allLingdaoList";
	}
	
	@RequestMapping("/getByIdAudit")
	public Object getByIdAudit(HttpServletRequest request,Model model,HttpSession session){
		int id=Integer.valueOf(request.getParameter("id"));
		Audit audit=new Audit();
		audit=auditService.get(id);
		
		//增加日志信息		
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("getByIdAudit.do");
		logging.setDetailsInfo("查询id为："+id+" 的审批信息！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return audit;
	}
}
