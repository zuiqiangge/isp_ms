package cn.com.pengyue.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.druid.util.StringUtils;

import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.PlaceOnFile;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.ILoggingService;
import cn.com.pengyue.service.IPOFService;
import cn.com.pengyue.service.IUsersService;
import cn.com.pengyue.util.AccessConstants;

@Controller
public class POFController {
	@Resource
	private IPOFService pOFService;
	@Resource
	private ILoggingService loggingService;
	@Resource
	private IUsersService usersService;

	/**
	 * 跳转未归档列表页面
	 * 
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("/toListFilesWei")
	public String toListFilesWei(HttpSession session, Model model,
			HttpServletRequest request) {
		// 带条件的的实体
		PlaceOnFile file = null;
		// 首次加载列表没有条件
		if (null == request.getParameter("bigType")){
			file = new PlaceOnFile();
		}else{
			file = new PlaceOnFile();
			String contactUnit = request.getParameter("contactUnit");
			if(null!=contactUnit&&!(StringUtils.isEmpty(contactUnit)))
				file.setContactUnit(contactUnit);
			String des = request.getParameter("des");
			if(null!=des&&!(StringUtils.isEmpty(des)))
				file.setDestoryThingDes(des);
			String type = request.getParameter("bigType");
			if(null!=type&&!(StringUtils.isEmpty(type)))
				file.setBigType(Integer.parseInt(type));
		}

		Users user = (Users) session
				.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		model.addAttribute("Wfiles", pOFService.getListByWeiAndCondition(file));
		model.addAttribute("users", usersService.getAllLingDao());
		model.addAttribute("currentUser",user);
		
		
		// 增加日志信息
		Logging logging = new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("listByWei.do");
		logging.setDetailsInfo("查询所有的未归档！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return "listFilesWei";
	}

	/**
	 * 跳转已归档列表页面
	 * 
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("/toListFilesYi")
	public String toListFilesYi(HttpSession session, Model model,HttpServletRequest request) {
		// 带条件的的实体
		PlaceOnFile file = null;
		// 首次加载列表没有条件
				if (null == request.getParameter("bigType")){
					file = new PlaceOnFile();
				}else{
					file = new PlaceOnFile();
					String contactUnit = request.getParameter("contactUnit");
					if(null!=contactUnit&&!(StringUtils.isEmpty(contactUnit)))
						file.setContactUnit(contactUnit);
					String des = request.getParameter("des");
					if(null!=des&&!(StringUtils.isEmpty(des)))
						file.setDestoryThingDes(des);
					String type = request.getParameter("bigType");
					if(null!=type&&!(StringUtils.isEmpty(type)))
						file.setBigType(Integer.parseInt(type));
				}

		model.addAttribute("Yfiles", pOFService.getListByYiAndCondition(file));
		Users user = (Users) session
				.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		model.addAttribute("users", usersService.getAllLingDao());
		model.addAttribute("currentUser",user);
		// 增加日志信息
		Logging logging = new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("listByWei.do");
		logging.setDetailsInfo("查询所有的已归档！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return "listFilesYi";
	}

	/**
	 * 添加归档信息
	 * 
	 * @param request
	 */
	@RequestMapping("/add")
	public void add(HttpServletRequest request) {
		PlaceOnFile file = new PlaceOnFile();
		pOFService.add(file);
	}
	
	
	
	/**
	 *修改
	 */
	@RequestMapping("/edit")
	public void edit(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		PrintWriter out=null;
		String isSucess="";
		try{
			String id = request.getParameter("id");
			PlaceOnFile file =pOFService.get(Integer.parseInt(id));
			file.setContactUnit(request.getParameter("contactUnit"+id));
			file.setContact(request.getParameter("contact"+id));
			file.setAddress(request.getParameter("address"+id));
			file.setBigType(Integer.parseInt(request.getParameter("bigType"+id)));
			file.setDestoryThingDes(request.getParameter("desc"+id));
			file.setNowDestory(Integer.parseInt(request.getParameter("nowDestroy"+id)));
			file.setNum(Integer.parseInt(request.getParameter("num"+id)));
			file.setSendType(Integer.parseInt(request.getParameter("sendType"+id)));
			file.setSmallType(Integer.parseInt(request.getParameter("smallType"+id)));
			file.setSubmitId(Integer.parseInt(request.getParameter("submit"+id)));
			file.setSubmitName(usersService.get(Integer.parseInt(request.getParameter("submit"+id))).getNickName());
			file.setTelephone(request.getParameter("telephone"+id));
			file.setWeight(Double.parseDouble(request.getParameter("weight"+id)));
			pOFService.edit(file);
			isSucess="修改成功";
			out = response.getWriter();
		}catch(Exception e){
			try {
				out = response.getWriter();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			isSucess="修改失败!";
			e.printStackTrace();
		}finally{
			out.write(isSucess);
			out.close();
		}
		
		
		
	} 
	
	/*
	 * 删除
	 */
	@RequestMapping("/delete")
	public void delete(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		PrintWriter out=null;
		String isSucess="";
		try{
			String id = request.getParameter("id");
			PlaceOnFile file =pOFService.get(Integer.parseInt(id));
			
			pOFService.del(file);
			isSucess="删除成功";
			out = response.getWriter();
		}catch(Exception e){
			try {
				out = response.getWriter();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			isSucess="删除失败!";
			e.printStackTrace();
		}finally{
			out.write(isSucess);
			out.close();
		}
	}
	
	
	/**
	 * 撤出当前卷
	 */
	@RequestMapping("/cheJuan")
	public void cheJuan(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		PrintWriter out=null;
		String isSucess="";
		try{
			String id = request.getParameter("id");
			PlaceOnFile file =pOFService.get(Integer.parseInt(id));
			file.setIsPlaceOn(0);
			pOFService.edit(file);
			isSucess="撤出成功";
			out = response.getWriter();
		}catch(Exception e){
			try {
				out = response.getWriter();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			isSucess="撤出失败!";
			e.printStackTrace();
		}finally{
			out.write(isSucess);
			out.close();
		}
	}
	
	/**
	 * 拆卷
	 */
	@RequestMapping("/chaiJuan")
	public void chaiJuan(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		PrintWriter out=null;
		String isSucess="";
		try{
			String id = request.getParameter("id");
			String[] ids=id.split(",");
			for(int i=0;i<ids.length;i++){
				PlaceOnFile file =pOFService.get(Integer.parseInt(ids[i]));
				file.setIsPlaceOn(0);
				pOFService.edit(file);
			}
			
			isSucess="拆卷成功";
			out = response.getWriter();
		}catch(Exception e){
			try {
				out = response.getWriter();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			isSucess="拆卷失败!";
			e.printStackTrace();
		}finally{
			out.write(isSucess);
			out.close();
		}
	}

	
	
	
	/**
	 * 编目
	 */
	@RequestMapping("/bianMu")
	public void bianMu(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		PrintWriter out=null;
		String isSucess="";
		try{
			String id = request.getParameter("id");
			PlaceOnFile file =pOFService.get(Integer.parseInt(id));
			file.setIsPlaceOn(1);
			pOFService.edit(file);
			isSucess="编目成功";
			out = response.getWriter();
		}catch(Exception e){
			try {
				out = response.getWriter();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			isSucess="编目失败!";
			e.printStackTrace();
		}finally{
			out.write(isSucess);
			out.close();
		}
	}
}
