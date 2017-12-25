package cn.com.pengyue.web.action;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.com.pengyue.dao.impl.LogDao;
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
import cn.com.pengyue.util.AccessConstants;

import com.alibaba.druid.util.StringUtils;

@Controller
public class LendInfoController implements AccessConstants{
	@Resource
	private ILendInfoService lendService;
	@Resource
	private IUserService userService;
	@Resource
	private IProductService productService;
	@Resource
	private ILogService logService;
	@javax.annotation.Resource
	private ILoggingService loggingService;
	
	/**
	 * 出库
	 * @param request
	 */
	@RequestMapping("/chuku")
	public void chuku(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		PrintWriter out=null;
		String isSuccess="";
		try{
			LendInfo lend = new LendInfo();
			//获取lendInfo对象要存储的信息
			String id = request.getParameter("id");
			String lendUser = request.getParameter("lendUser");
			String returnTime = request.getParameter("returnTime");
			if(null!=lendUser&&!(StringUtils.isEmpty(lendUser))){
				lend.setLendUser(userService.get(Integer.parseInt(lendUser)));
			}
			if(null!=returnTime&&!(StringUtils.isEmpty(returnTime))){
				try {
					lend.setReturnTime(DateFormat.getDateInstance().parse(returnTime));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			lend.setIsValid(0);
			lend.setLendTime(new Date());
			SecretProduct product = productService.get(Integer.parseInt(id));
			lend.setProduct(product);
			
			
			//修改产品状态为已借出
			product.setIsBack(1);
			
			isSuccess = "出库成功";
			//记录借出日志
			Log log = new Log();
			log.setOperateName("out");
			log.setProduct(product);
			log.setLend(lend);
			log.setCaozuoTime(new Date());
			//存储日志,其关联的产品信息和借出信息也会改变
			logService.save(log);
			out = response.getWriter();
			
			
			//日志操作
			Logging log1=new Logging();
			log1.setOpTime(new Date());
			log1.setMethodUrl("chuku.do");
			log1.setSysDesc("出库！");
			log1.setSysDescId("action");
			Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
			log1.setUserId(loginUsers);
			log1.setDetailsInfo("出库成功!");
			loggingService.save(log1);
		}catch(Exception e){
			isSuccess = "出库失败";
			
			
			//日志操作
			Logging log1=new Logging();
			log1.setOpTime(new Date());
			log1.setMethodUrl("chuku.do");
			log1.setSysDesc("出库！");
			log1.setSysDescId("action");
			Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
			log1.setUserId(loginUsers);
			log1.setDetailsInfo("出库失败!");
			loggingService.save(log1);
			e.printStackTrace();
		}finally{
			if(null!=out){
				out.print(isSuccess);
				out.close();
			}
		}
	}
	
	
	/**
	 * 归还
	 * @param request
	 */
	@RequestMapping("/guihuan")
	public void guihuan(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		PrintWriter out=null;
		String isSuccess="";
		try{
			out = response.getWriter();
			String id = request.getParameter("id");
			//修改当前正在生效借出信息
			List<LendInfo> lendinfos = lendService.findLendByValid(Integer.parseInt(id));
			LendInfo lend = lendinfos.get(0);
			//设置过期
			lend.setIsValid(1);
			lend.setFactReturnTime(new Date());
			//lendService.update(lend);
			
			//关联的产品
			SecretProduct product = productService.get(Integer.parseInt(id));
			//设置产品正常
			product.setIsBack(0);
			//productService.update(product);
			isSuccess = "归还成功";
			
			//记录借出日志
			Log log = new Log();
			log.setOperateName("back");
			log.setProduct(product);
			log.setLend(lend);
			log.setCaozuoTime(new Date());
			logService.save(log);
			
			
			//日志操作
			Logging log1=new Logging();
			log1.setOpTime(new Date());
			log1.setMethodUrl("guihuan.do");
			log1.setSysDesc("归还！");
			log1.setSysDescId("action");
			Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
			log1.setUserId(loginUsers);
			log1.setDetailsInfo("归还成功!");
			loggingService.save(log1);
		}catch(Exception e){
			isSuccess = "归还失败";
			//日志操作
			Logging log1=new Logging();
			log1.setOpTime(new Date());
			log1.setMethodUrl("guihuan.do");
			log1.setSysDesc("归还！");
			log1.setSysDescId("action");
			Users loginUsers = (Users)session.getAttribute(SESSION_NAME_LOGINED_USER);
			log1.setUserId(loginUsers);
			log1.setDetailsInfo("归还失败!");
			loggingService.save(log1);
			e.printStackTrace();
		}finally{
			if(null!=out){
				out.print(isSuccess);
				out.close();
			}
		}
	}
	
	
	public static void main(String[] args) {
		/*ApplicationContext ctx =new FileSystemXmlApplicationContext("WebRoot/WEB-INF/applicationContext.xml");
		LogDao logDao = ctx.getBean(LogDao.class);
		Log log = logDao.get(22);
		LendInfo lend = log.getLend();
		lend.setReturnTime(new Date());
		SecretProduct product = log.getProduct();
		product.setInTime(new Date());
		logDao.save(log);
		System.out.println();*/
		try {
			DateFormat.getDateInstance().parse("2017-06-30");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
