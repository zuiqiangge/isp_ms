package cn.com.pengyue.web.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.druid.util.StringUtils;

import cn.com.pengyue.pojo.Log;
import cn.com.pengyue.service.ILogService;

@Controller
public class LogController {
	@Resource
	private ILogService logService;
	
	
	/**
	 * 日志列表查询
	 * @param request
	 */
	@RequestMapping("logList")
	public void logList(HttpServletRequest request,HttpServletResponse response){
		String id = request.getParameter("id");
		for(Object key :request.getParameterMap().keySet()){
			System.out.println(key+"="+request.getParameter(key.toString()));
		}
		String pageStr = request.getParameter("start");
		String numStr = request.getParameter("length");
		int start=0;
		int num=10;
		if(null!=pageStr&&!(StringUtils.isEmpty(pageStr)))
			start = Integer.parseInt(pageStr);
		if(null!=numStr&&!(StringUtils.isEmpty(numStr)))
			num = Integer.parseInt(numStr);
		List<Log> logs= new ArrayList<Log>();
		String operate = request.getParameter("search[value]");
		logs = logService.getList(Integer.parseInt(id),operate.equals("")?"%":operate,start,num);
		JSONObject json = new JSONObject();
		int draw =Integer.parseInt(request.getParameter("draw"));
		int total = logService.getCount(Integer.parseInt(id),operate.equals("")?"%":operate);
		json.put("draw",draw);
		json.put("recordsTotal", total);
		json.put("recordsFiltered", total);
		
		json.put("data",logs);
		try {
			response.getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
