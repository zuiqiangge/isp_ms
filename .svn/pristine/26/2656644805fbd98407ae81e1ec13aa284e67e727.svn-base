package cn.com.pengyue.web.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;

import cn.com.pengyue.dao.IApplyConditionHistoryDao;
import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.ApplyConditionHistory;
import cn.com.pengyue.pojo.Audit;
import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.IApplyConditionHistoryService;
import cn.com.pengyue.service.IApplyService;
import cn.com.pengyue.service.IApplyarticleService;
import cn.com.pengyue.service.IAuditService;
import cn.com.pengyue.service.ICarService;
import cn.com.pengyue.service.IDepartmentService;
import cn.com.pengyue.service.ILoggingService;
import cn.com.pengyue.service.IPositionService;
import cn.com.pengyue.service.IUsersService;
import cn.com.pengyue.service.impl.ApplyConditionHistoryService;
import cn.com.pengyue.util.AccessConstants;

@Controller
public class ApplyController {
	@Resource
	public IApplyService applyService;
	@Resource
	public IApplyarticleService applyarticleService;
	@Resource
	public IAuditService auditService;
	@Resource
	public IUsersService usersService;
	@Resource
	public IDepartmentService departmentService;
	@Resource
	public IPositionService positionService;
	
	@Resource
	public ICarService carService;
	
	
	@Resource
	public ILoggingService loggingService;
	@Resource
	public IApplyConditionHistoryService applyConditionHistoryService;
	
	@RequestMapping("/allListApply")
	public String allListApply(HttpSession session,Model model){
		model.addAttribute("applyList", applyService.listAll());
		
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		//增加日志信息
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("allListApply.do");
		logging.setDetailsInfo("查询所有的申请！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return "allListApply";
	}
	
	@RequestMapping("/toAddApply")
	public String toAddApply(HttpSession session,Model model){
		final Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		model.addAttribute("users",usersService.getUsers(user.getId()));
		return "toApply";
	}
	
	@RequestMapping("/ajaxGetApplyById")
	@ResponseBody
	public String ajaxGetApplyId(HttpServletRequest request,Model model){
		int id=Integer.valueOf(request.getParameter("id"));
		
		applyService.get(id);
		
		model.addAttribute("usersList",usersService.listAll());
		return "ajaxGetApplyById";
	}
	
	@RequestMapping("/ajaxAddApply")
	@ResponseBody
	public Object ajaxAddApply(HttpSession session,Apply pojo){
		//设置申请表默认内容
		pojo.setDate(new Date());
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		pojo.setName(user.getNickName());//设置提交申请人名称
		if(user.getDepartment()==null){//设置申请人部门name
			user.setDepartment(departmentService.get(user.getBmId()));
		}
		pojo.setBmName(user.getDepartment().getBmName());
		
		if(user.getPosition()==null){//设置申请人职位name
			user.setPosition(positionService.get(user.getPositionId()));
		}
		pojo.setPositionName(user.getPosition().getName());
		pojo.setUserId(user.getId());//设置提交申请人id
		
		if(pojo.getState() ==null){//没有 设置为保存的请求都算 提交审核的请求
			pojo.setState(IApplyService.APPLY_STATE_SUBMIT_ALL);
		}
		//“是否监销” 由 “是否现销” 决定
		pojo.setMonitorDestroy(pojo.getNowDestroy());
		
		//接下来的 同时添加的申请和审核表在services里的事务进行。
		applyService.submitApplyAndAudit(pojo);
		
		//增加日志信息
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("ajaxAddApply.do");
		logging.setDetailsInfo("新增一个申请！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		
		
		return pojo;
	}
	
	@RequestMapping("/ajaxRemoveApply")
	@ResponseBody
	public Object ajaxRemoveApply(HttpServletRequest request,HttpSession session){
		int id=Integer.valueOf(request.getParameter("id"));
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Integer[] ids={id};
		Apply apply = applyService.get(id);
		if(apply.getState()==0){
			applyService.delete(apply);
			//增加日志信息
			Logging logging=new Logging();
			logging.setUserId(user.getId());
			logging.setMethodUrl("ajaxRemoveApply.do");
			logging.setDetailsInfo("删除一个保存未提交的申请！");
			logging.setOpTime(new Date());
			loggingService.save(logging);
		}else{
			//增加日志信息
			Logging logging=new Logging();
			logging.setUserId(user.getId());
			logging.setMethodUrl("ajaxRemoveApply.do");
			logging.setDetailsInfo("想非法删除一个已提交的申请！");
			logging.setOpTime(new Date());
			loggingService.save(logging);
			throw new RuntimeException("非法操作！！");
		}
		
		return Arrays.asList(ids);
	}
	
	@RequestMapping("/ajaxUpdateApplyAndAudit")
	@ResponseBody
	public Object ajaxUpdateApplyAndAudit(HttpSession session,Audit audit){
		//监毁人
		//int monitorDestroyPerson=Integer.valueOf(request.getParameter("monitorDestroyPerson"));
		//批示
//		String audit_explain=request.getParameter("audit_explain");
		
//		Audit audit=new Audit();
//		audit.setAudit_explain(audit_explain);	//批示
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		audit.setAudit_user_id(user.getId());//审核人
	
		
		auditService.pishi(audit);
//		auditService.update(audit);
//		
//		Apply pojo=new Apply();
//		pojo.setMonitorDestroyPerson_id(monitorDestroyPerson);
//		//批示已完成，更改申请表的状态为已结束
//		pojo.setState(3);
//		applyService.update(pojo);

		//增加日志信息
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("ajaxUpdateApplyAndAudit.do");
		logging.setDetailsInfo("申请批示操作！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		
		return audit;
	}
	
	//保存后的修改
	@RequestMapping("/ajaxUpdateApply")
	@ResponseBody
	public Object ajaxUpdateApply(HttpSession session,Apply pojo){
//		//联系人单位
//		String contactUnit=request.getParameter("contactUnit");
//		//联系人
//		String contacts=request.getParameter("contacts");
//		//备注
//		String explain=request.getParameter("explain");
//		//备注2
//		String explain2=request.getParameter("explain2");
//		//联系电话
//		String telephone=request.getParameter("telephone");
//		//联系地址
//		String address=request.getParameter("address");
//		//物品类型
//		int article_type=Integer.valueOf(request.getParameter("articleType"));
//		//送货方式
//		int sendType=Integer.valueOf(request.getParameter("sendType"));
//		//是否监销
//		int monitorDestroy=Integer.valueOf(request.getParameter("monitorDestroy"));
//		
//		Apply pojo=new Apply();
//		
//		pojo.setContacts(contacts);
//		pojo.setContactUnit(contactUnit);
//		pojo.setDate(new Date());
//		pojo.setExplain(explain);
//		pojo.setExplain2(explain2);
//		pojo.setMonitorDestroy(monitorDestroy);
//		pojo.setSendType(sendType);
//		pojo.setArticleType(article_type);
//		pojo.setTelephone(telephone);
//		pojo.setAddress(address);
		
		//设置申请表默认内容
		pojo.setDate(new Date());
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		pojo.setName(user.getNickName());//设置提交申请人名称
		if(user.getDepartment()==null){//设置申请人部门name
			user.setDepartment(departmentService.get(user.getBmId()));
		}
		pojo.setBmName(user.getDepartment().getBmName());
		
		if(user.getPosition()==null){//设置申请人职位name
			user.setPosition(positionService.get(user.getPositionId()));
		}
		pojo.setPositionName(user.getPosition().getName());
		pojo.setUserId(user.getId());//设置提交申请人id
		
		if(pojo.getState() ==null){//没有 设置为保存的请求都算 提交审核的请求
			pojo.setState(IApplyService.APPLY_STATE_SUBMIT_ALL);
		}
		//“是否监销” 由 “是否现销” 决定
		pojo.setMonitorDestroy(pojo.getNowDestroy());
		
		//接下来是否是提交或者是继续保存 在service操作   提交的话同时添加的申请和审核表在services里的事务进行。
		applyService.submitApplyAndAudit(pojo);
		
		//增加日志信息
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("ajaxUpdateApply.do");
		logging.setDetailsInfo("修改保存未提交的申请！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		
		return pojo;
	}
	
	//查询所有派车的申请
	@RequestMapping("/isMonitorDestroyList")
	public String isMonitorDestroyList(HttpServletRequest request,Model model,HttpSession session){
		int sendType=Integer.valueOf(request.getParameter("sendType"));
		//判断申请是否需要派车
		if(sendType==1){
			model.addAttribute("carList", carService.listAll());
			model.addAttribute("applyList", applyService.sendTypeList(sendType));
		}
		//增加日志信息
			Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
			Logging logging=new Logging();
			logging.setUserId(user.getId());
			logging.setMethodUrl("isMonitorDestroyList.do");
			logging.setDetailsInfo("查询所有申请里需要派车的信息！");
			logging.setOpTime(new Date());
			loggingService.save(logging);
		return "listUnDispatchApply";
	}
	
	//根据id查询申请表和审批表
	@RequestMapping("/ajaxGetApplyAndAudit")
	@ResponseBody
	public Object ajaxGetApplyAndAudit(HttpServletRequest request,Model model,HttpSession session){
		int applyId=Integer.valueOf(request.getParameter("applyId"));
		int auditId=Integer.valueOf(request.getParameter("auditId"));
		Apply apply=applyService.get(applyId);
		Audit audit=auditService.get(auditId);
		model.addAttribute("apply", apply);
		model.addAttribute("audit", audit);
		
		//增加日志信息
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("ajaxGetApplyAndAudit.do");
		logging.setDetailsInfo("根据id查询申请表和审批表信息！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		
		return "ajaxGetApplyAndAudit";
	}
	
	//根据id查询申请表和审批表
	@RequestMapping("/toUpdateApply.do")
	public Object getApplyAndAudit(HttpSession session,@RequestParam(value="id") Integer id,Model model){
		Apply apply=applyService.get(id);
		if(apply.getState() != IApplyService.APPLY_STATE_SAVEED){
			List<Audit> audits = auditService.getByApplyIdFindAudit(id);
			if(audits!=null&&audits.size()>0){
				model.addAttribute("audits", audits);
			}
		}
		model.addAttribute("apply", apply);
		final Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		model.addAttribute("users",usersService.getUsers(user.getId()));
		return "toUpdateApply";
	}
	
	//查询所有结束的申请
	@RequestMapping("/ajaxAllEndApply")
	@ResponseBody
	public String ajaxAllEndApply(HttpSession session,Model model){
		model.addAttribute("allStateList", applyService.allStateList());
		
		//增加日志信息
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("ajaxAllEndApply.do");
		logging.setDetailsInfo("查询所有结束的申请！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		
		return "ajaxAllEndApply";
	}
	
	//查询用户的所有申请
	@RequestMapping("/allUsersApply")
	public String allUsersApply(HttpSession session,Model model){
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		model.addAttribute("applyList", applyService.usersList(user.getId()));
		model.addAttribute("users",usersService.getAllLingDao());
		model.addAttribute("currentUser",user);
		//增加日志信息
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("allUsersApply.do");
		logging.setDetailsInfo("查询用户的所有申请！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return "listApply";
	}
	
	/**
	 * 导出所有历史申请记录
	 * @param session
	 * @param model
	 * @param response
	 */
	@RequestMapping("/exportApply")
	public void exportApply(HttpSession session,Model model,HttpServletResponse response,HttpServletRequest request){
		PrintWriter out=null;
		String isSucess="";
		String ids = request.getParameter("ids");
		String[] idArray = ids.split(",");
		List<Apply> applies = new ArrayList<Apply>();
		for(int i=0;i<idArray.length;i++){
			applies.add(applyService.get(Integer.parseInt(idArray[i])));
		}
		//List<Apply> applies = applyService.usersList(user.getId());
		
        HSSFWorkbook wb = new HSSFWorkbook();  
        HSSFSheet sheet = wb.createSheet("申请历史表一");  
        HSSFRow row = sheet.createRow((int) 0);  
        HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        HSSFCell cell = row.createCell((short) 0); 
        cell.setCellValue("电话");  
        cell.setCellStyle(style);  
        cell = row.createCell((short) 1);  
        cell.setCellValue("地址");  
        cell.setCellStyle(style);  
        cell = row.createCell((short) 2);  
        cell.setCellValue("销毁物品简述");  
        cell.setCellStyle(style);  
        cell = row.createCell((short) 3);  
        
        for (int i = 0; i < applies.size(); i++)  
        {  
            row = sheet.createRow((int) i + 1);  
            Apply apply = (Apply) applies.get(i);  
            // 第四步，创建单元格，并设置值  
            row.createCell((short) 0).setCellValue(apply.getTelephone());  
            row.createCell((short) 1).setCellValue(apply.getAddress());  
            row.createCell((short) 2).setCellValue(apply.getArticleDesc());  
           /* cell = row.createCell((short) 3);  
            cell.setCellValue(new SimpleDateFormat("yyyy-mm-dd").format(stu.getBirth()));  */
        }  
        
        try  
        {  
            FileOutputStream fout = new FileOutputStream("C:/applies"+new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss").format(new Date())+".xls");  
            wb.write(fout);  
            fout.close();  
            out = response.getWriter();
            isSucess="1";
            
        }  
        catch (Exception e)  
        {  
            e.printStackTrace();  
        }finally{
        	out.write(isSucess);
        	out.close();
        }  
	}
	
	/**
	 * 根据条件查询申请历史列表
	 * @param session
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/getListByCondition")
	public String getListByCondition(HttpSession session,Model model,HttpServletRequest request){
		Apply apply = conllectApplyInfo(request);
		//插入查询记录
		saveApplyCondition(apply);
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		apply.setUserId(user.getId());
		model.addAttribute("applyList", applyService.getListbyCondition(apply));
		model.addAttribute("users",usersService.getAllLingDao());
		model.addAttribute("currentUser",user);
		//增加日志信息
		Logging logging=new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("getListByCondition.do");
		logging.setDetailsInfo("条件查询用户的所有申请！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return "listApply";
	}
	
	/**
	 * 查询条件记录列表
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("/ListApplyCondition")
	public String ListApplyCondition(HttpSession session,Model model){
		Users user = (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		List<ApplyConditionHistory> conditions = applyConditionHistoryService.listByUserId(user.getId());
		model.addAttribute("conditions",conditions);
		return "listApplyCondition";
	}
	
	
	/**
	 * 
	 * @param session
	 * @param model
	 * @param response
	 * @param request
	 */
	@RequestMapping("/EntrustForElse")
	public void EntrustForElse(HttpSession session,Model model,HttpServletResponse response,HttpServletRequest request){
		PrintWriter out = null;
		String isSuccess="";
		try{
			List<Apply> applies = new ArrayList<Apply>();
			String applyIds = request.getParameter("applyids");
			String[] idsArray = applyIds.split(",");
			for(int i=0;i<idsArray.length;i++){
				applies.add(applyService.get(Integer.parseInt(idsArray[i])));
			}
			String userId = request.getParameter("userId");
			Users user = usersService.get(Integer.parseInt(userId));
			applyService.Entrust(applies, user);
			isSuccess="1";
			out = response.getWriter();
		}catch(Exception e){
			try {
				out = response.getWriter();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			isSuccess="0";
			e.printStackTrace();
		}finally{
			out.write(isSuccess);
			out.close();
		}
		
	}
	/**
	 * 整合所有属性成一个apply对象
	 * @param request
	 * @return
	 */
	public Apply conllectApplyInfo(HttpServletRequest request){
		Apply apply = new Apply();
		try{
			//上报领导
			String submitUserId = request.getParameter("submitUserId");
			if(null!=submitUserId&&!(StringUtils.isEmpty(submitUserId))){
				apply.setSubmitUserId(Integer.parseInt(submitUserId));
			}
			//单位名称
			String contactUnit = request.getParameter("contactUnit");
			if(null!=contactUnit&&!(StringUtils.isEmpty(contactUnit))){
				apply.setContactUnit(contactUnit.trim());
			}
			//联系人
			String contacts = request.getParameter("contacts");
			if(null!=contacts&&!(StringUtils.isEmpty(contacts))){
					apply.setContacts(contacts.trim());
			}
			//联系电话
			String telephone = request.getParameter("telephone");
			if(null!=telephone&&!(StringUtils.isEmpty(telephone))){
						apply.setTelephone(telephone.trim());
			}
			//单位地址
			String address = request.getParameter("address");
			if(null!=address&&!(StringUtils.isEmpty(address))){
					apply.setAddress(address.trim());
			}
			//送货方式
			String sendtype = request.getParameter("sendType");
			if(null!=sendtype&&!(StringUtils.isEmpty(sendtype))){
					apply.setSendType(Integer.parseInt(sendtype));
			}
			//是否监销
			String nowDestroy = request.getParameter("nowDestroy");
			if(null!=nowDestroy&&!(StringUtils.isEmpty(nowDestroy))){
					apply.setNowDestroy(Integer.parseInt(nowDestroy));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return apply;
	}
	
	
	/**
	 * 保存条件查询记录
	 * @param apply
	 */
	public void saveApplyCondition(Apply apply){
		ApplyConditionHistory history = new ApplyConditionHistory();
		history.setContactUnit(apply.getContactUnit());
		history.setContact(apply.getContacts());
		history.setSubmitId(apply.getSubmitUserId());
		history.setTelephone(apply.getTelephone());
		history.setAddress(apply.getAddress());
		history.setSendType(apply.getSendType());
		history.setNowDestory(apply.getNowDestroy());
		history.setSubmitName(usersService.get(apply.getSubmitUserId()).getNickName());
		applyConditionHistoryService.add(history);
	}
	
	
	
	
}
