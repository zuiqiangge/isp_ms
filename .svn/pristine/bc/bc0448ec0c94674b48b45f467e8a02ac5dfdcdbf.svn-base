package cn.com.pengyue.web.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.com.pengyue.service.ILoggingService;

@Controller
public class LoggingController {
	@Resource
	public ILoggingService loggingService;
	
	@RequestMapping("/AllLogList")
	public String AllLogList(Model model){
		model.addAttribute("list", loggingService.allLogList());
		return "AllLogList";
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
