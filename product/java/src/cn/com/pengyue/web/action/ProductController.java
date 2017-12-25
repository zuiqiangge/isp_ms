package cn.com.pengyue.web.action;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.com.pengyue.pojo.LendInfo;
import cn.com.pengyue.pojo.Log;
import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.SecretProduct;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.ILendInfoService;
import cn.com.pengyue.service.ILogService;
import cn.com.pengyue.service.ILoggingService;
import cn.com.pengyue.service.IProductService;
import cn.com.pengyue.service.IUserService;
import cn.com.pengyue.service.IUsersService;
import cn.com.pengyue.util.AccessConstants;
import cn.com.pengyue.util.Condition;

import com.alibaba.druid.util.StringUtils;

@Controller
public class ProductController implements AccessConstants{
	@Resource
	private IProductService productService; 
	@Resource
	private IUsersService usersService; 
	@Resource
	private ILogService logService; 
	@Resource
	private ILendInfoService lendInfoService; 
	@Resource
	private IUserService userService; 
	@javax.annotation.Resource
	private ILoggingService loggingService;
	/**
	 * 跳转产品列表页面
	 * @return
	 */
	@RequestMapping("toList")
	public String toList(Model model,HttpSession session){
		model.addAttribute("users", usersService.getAllLingDao());
		model.addAttribute("us",userService.listAll());
		
		//日志操作
				Logging log=new Logging();
				log.setOpTime(new Date());
				log.setMethodUrl("toList.do");
				log.setSysDesc("跳转出入库菜单");
				log.setSysDescId("menu");
				Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
				log.setUserId(loginUsers);
				log.setDetailsInfo("跳转出入库菜单!");
				loggingService.save(log);
		return "listProduct";
	}
	
	/**
	 * 跳转产品列表页面
	 * @return
	 */
	@RequestMapping("toList1")
	public String toList1(Model model,HttpSession session){
		model.addAttribute("users", usersService.getAllLingDao());
		//日志操作
		Logging log=new Logging();
		log.setOpTime(new Date());
		log.setMethodUrl("toList1.do");
		log.setSysDesc("跳转移库菜单");
		log.setSysDescId("menu");
		Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
		log.setUserId(loginUsers);
		log.setDetailsInfo("跳转移库和盘库菜单!");
		loggingService.save(log);
		return "listProduct1";
	}
	
	/**
	 * 获取列表数据
	 */
	@RequestMapping("list")
	public void list(HttpServletRequest request,HttpServletResponse response,HttpSession session,
			int start,int length,SecretProduct product){
		try {
			if(null!=product.getProductName()){
				String productName = new String(product.getProductName().getBytes("iso-8859-1"),"utf-8");
				product.setProductName(productName);
			}
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		PrintWriter out= null;
		try{
			List<SecretProduct> result = new ArrayList<SecretProduct>();
			result = productService.getList(product,start,length);
			int total=productService.getCount(product);
			out = response.getWriter();
			//判断是否预警
			for(SecretProduct pro:result){
				List<LendInfo> infos = lendInfoService.findLendByValid(product.getId());
				//当前产品有正在生效的借出信息
				if(infos.size()>0){
					//且当前时间已超过预定归还时间
					if(infos.get(0).getReturnTime().getTime()<new Date().getTime())
						product.setIsWarning(1);
				}
				
			}
			JSONObject json = new JSONObject();
			int draw =Integer.parseInt(request.getParameter("draw"));
			
			json.put("draw",draw);
			json.put("recordsTotal", total);
			json.put("recordsFiltered", total);
			json.put("data",result);
			out.print(json);
			
			
			//日志操作
			Logging log=new Logging();
			log.setOpTime(new Date());
			log.setMethodUrl("list.do");
			log.setSysDesc("获取列表数据！");
			log.setSysDescId("action");
			Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
			log.setUserId(loginUsers);
			log.setDetailsInfo("异步获取密品列表数据!");
			loggingService.save(log);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(null!=out)
			out.close();
		}
	}
	
	
	/**
	 * 入库
	 * @param request
	 */
	@RequestMapping("/ruku")
	public void ruKu(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		PrintWriter out=null;
		String isSuccess="";
		try{
			//做出异步返回消息
			out = response.getWriter();
			SecretProduct product = new SecretProduct();
			//收集表单信息
			String productNameStr=request.getParameter("productName");
			String inTimeStr = request.getParameter("inTime");
			String manageUserStr = request.getParameter("manageUser");
			String rfid=request.getParameter("rfid");
			String currentPositionStr = request.getParameter("currentPosition");
			String count = request.getParameter("count");
			if(null!=productNameStr&&!(StringUtils.isEmpty(productNameStr)))
				product.setProductName(productNameStr);
			if(null!=inTimeStr&&!(StringUtils.isEmpty(inTimeStr))){
				Date inTime = new Date();
				try {
					inTime = DateFormat.getDateInstance().parse(inTimeStr);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				product.setInTime(inTime);
			}
			if(null!=manageUserStr&&!(StringUtils.isEmpty(manageUserStr)))
				product.setManageUser(usersService.get(Integer.parseInt(manageUserStr)));
			if(null!=rfid&&!(StringUtils.isEmpty(rfid)))
				product.setRfid(rfid);
			if(null!=currentPositionStr&&!(StringUtils.isEmpty(currentPositionStr)))
				product.setCurrentPosition(Integer.parseInt(currentPositionStr));
			if(null!=count&&!(StringUtils.isEmpty(count)))
				product.setCount(Integer.parseInt(count));
			//初始化为正常
			product.setIsBack(0);
			product.setIsWarning(0);
			//进行产品插入
			//productService.save(product);
			//录入日志
			Log log = new Log();
			log.setOperateName("in");
			log.setProduct(product);
			log.setCaozuoTime(new Date());
			logService.save(log);
			isSuccess="入库成功";
			
			//日志操作
			Logging log1=new Logging();
			log1.setOpTime(new Date());
			log1.setMethodUrl("ruku.do");
			log1.setSysDesc("入库！");
			log1.setSysDescId("action");
			Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
			log1.setUserId(loginUsers);
			log1.setDetailsInfo("入库成功!");
			loggingService.save(log1);
		}catch(Exception e){
			isSuccess="入库失败";
			//日志操作
			Logging log1=new Logging();
			log1.setOpTime(new Date());
			log1.setMethodUrl("ruku.do");
			log1.setSysDesc("入库！");
			log1.setSysDescId("action");
			Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
			log1.setUserId(loginUsers);
			log1.setDetailsInfo("入库失败!");
			loggingService.save(log1);
			e.printStackTrace();
		}finally{
			if(null!=out){
				out.write(isSuccess);
				out.close();
			}
		}
	}
	
	
	/**
	 * 移库
	 * @param request
	 * @param response
	 */
	@RequestMapping("/yiku")
	public void yiKu(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		PrintWriter out=null;
		String isSuccess="";
		try{
			out = response.getWriter();
			String id = request.getParameter("id");
			String position = request.getParameter("position");
			if(null!=id&&!(StringUtils.isEmpty(id))){
				
				SecretProduct product = productService.get(Integer.parseInt(id));
				if(null!=position&&!(StringUtils.isEmpty(position)))
					product.setCurrentPosition(Integer.parseInt(position));
				productService.update(product);
				
			}
			isSuccess="移库成功";
			//做出异步返回消息
			//日志操作
			Logging log1=new Logging();
			log1.setOpTime(new Date());
			log1.setMethodUrl("ruku.do");
			log1.setSysDesc("移库！");
			log1.setSysDescId("action");
			Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
			log1.setUserId(loginUsers);
			log1.setDetailsInfo("移库成功!");
			loggingService.save(log1);
		}catch(Exception e){
			isSuccess="移库失败";
			//日志操作
			Logging log1=new Logging();
			log1.setOpTime(new Date());
			log1.setMethodUrl("ruku.do");
			log1.setSysDesc("移库！");
			log1.setSysDescId("action");
			Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
			log1.setUserId(loginUsers);
			log1.setDetailsInfo("移库失败!");
			loggingService.save(log1);
			e.printStackTrace();
		}finally{
			if(null!=out){
				out.write(isSuccess);
				out.close();
			}
		}
	}
}
