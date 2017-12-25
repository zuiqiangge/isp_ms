package cn.com.pengyue.web.action;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.pengyue.dao.annotation.Comp;
import cn.com.pengyue.pojo.PageInfo;
import cn.com.pengyue.pojo.SysMsg;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.ISysMsgService;
import cn.com.pengyue.util.AccessConstants;

@Controller
public class SysMsgController {
	
	@javax.annotation.Resource
	private ISysMsgService sysMsgService;
	
	@RequestMapping("/readMsg") 
	public String readMsg(@RequestParam("id") Integer id,Model model){
		SysMsg data = sysMsgService.get(id);
		data.setIsRead(1);
		sysMsgService.update(data);
		model.addAttribute("pojo", data);
		return "readMsg";
	}
	
	@RequestMapping("/ajaxGetUnreadMsg") 
	@ResponseBody
	public Object ajaxGetUnreadMsg(HttpSession session,PageInfo pageInfo){
		final Users loginUser = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", sysMsgService.page(new Object(){
			@Comp("eq")@SuppressWarnings("unused")
			private Integer isRead = 0;
			
			@Comp("eq")@SuppressWarnings("unused")
			private Integer toUserId = loginUser.getId();
		},pageInfo) );
		result.put("pageInfo",pageInfo);
		return result;
	}
	
	@RequestMapping("/ajaxChange2readMsg") 
	@ResponseBody
	public Object ajaxChange2readMsg(@RequestParam("id")Integer[] id){
		sysMsgService.update(Arrays.asList(id), "isRead", 1);
		return "success";
	}
	
}
