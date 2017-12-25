package cn.com.pengyue.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.com.pengyue.pojo.Ip;
import cn.com.pengyue.service.IIpService;

@Controller
public class IpController {
	@Resource
	private IIpService ipService;

	
	
	
	public IIpService getIpService() {
		return ipService;
	}




	public void setIpService(IIpService ipService) {
		this.ipService = ipService;
	}



	/***
	 * 跳转到ip列表
	 * @param model
	 * @return
	 */
	@RequestMapping("/toIpList")
	public String toIpList(Model model){
		List<Ip> list = ipService.listAll();
		model.addAttribute("ipList", list);
		return "ipList";
	}
	
	/***
	 * 添加到ip数据库
	 * @param ip
	 * @param response
	 */
	@RequestMapping("/addIp")
	public void add(@RequestParam("ip")String ip,HttpServletResponse response){
		System.out.println(ip);
		Ip ipEntity = new Ip();
		ipEntity.setIp(ip);
		Ip reback = ipService.save(ipEntity);
		if(null!=reback){
			try {
				PrintWriter out = response.getWriter();
				out.print("1");
				out.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}
	
	/***
	 * 从数据库删除指定id的记录
	 * @param ip
	 * @param response
	 */
	@RequestMapping("/delIp")
	public void delIp(@RequestParam("id")String id,HttpServletResponse response){
			Ip ipEntity = new Ip();
			ipEntity.setIp(id);
			List<Integer> ids = new ArrayList<Integer>();
			ids.add(new Integer(id));
			ipService.delete(ids);
	}
}
