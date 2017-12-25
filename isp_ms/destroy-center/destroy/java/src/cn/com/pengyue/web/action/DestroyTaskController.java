package cn.com.pengyue.web.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.DestroyTask;
import cn.com.pengyue.pojo.DestroyTaskArticle;
import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.PageInfo;
import cn.com.pengyue.pojo.PlaceOnFile;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.IApplyService;
import cn.com.pengyue.service.IDestroyTaskArticleService;
import cn.com.pengyue.service.IDestroyTaskService;
import cn.com.pengyue.service.ILoggingService;
import cn.com.pengyue.service.IPOFService;
import cn.com.pengyue.service.IUsersService;
import cn.com.pengyue.util.AccessConstants;

@Controller
public class DestroyTaskController {
	@Resource
	public IDestroyTaskService destroyTaskService;
	@Resource
	public IDestroyTaskArticleService destroyTaskArticleService;
	@Resource
	public IApplyService applyService;
	@Resource
	public IUsersService usersService;
	@Resource
	public ILoggingService loggingService;
	@Resource
	public IPOFService pOFService;

	@RequestMapping("/c")
	public Object AllDestroyList(HttpSession session, Model model) {
		model.addAttribute("destroyList", destroyTaskService.listAll());
		Users user = (Users) session.getAttribute("loginUser");
		Logging logging = new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("AllDestroyList.do");
		logging.setDetailsInfo("查询所有销毁信息！");
		logging.setOpTime(new Date());
		this.loggingService.save(logging);

		return "AllDestroyList";
	}

	@RequestMapping("/ajaxGetDestroyById")
	@ResponseBody
	public Object ajaxGetDestroyById(HttpSession session, @RequestParam("id")
	Integer id, Model model) {
		Users user = (Users) session.getAttribute("loginUser");
		Logging logging = new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("ajaxGetDestroyById.do");
		logging.setDetailsInfo("查询id为：" + id + " 的销毁信息！");
		logging.setOpTime(new Date());
		this.loggingService.save(logging);
		return destroyTaskService.get(id);
	}
	
	
	
	@RequestMapping("/ajaxListDestroys")
	@ResponseBody
	public Object ajaxListDestroys(HttpSession session,PageInfo pageinfo) {
		if(pageinfo==null){
			pageinfo = new PageInfo();
			pageinfo.setPageNo(1);
			pageinfo.setPageSize(4);
		}
		pageinfo.setNeedSetTotalSize(false);
		return destroyTaskService.pageDestroyAndApply(pageinfo);
	}

	@RequestMapping("/toAddDestroy")
	public String toAddDestroy(Model model) {
		// 查询所有结束的申请
		model.addAttribute("allStateList", applyService.allStateList());
		return "toDestroy";
	}

	@RequestMapping("/ajaxAddDestroy")
	@ResponseBody
	public Object ajaxAddDestroy(HttpSession session,
			@RequestParam("typeParent")
			Integer[] typeParent, @RequestParam("type")
			Integer[] type, @RequestParam("num")
			Integer[] num, DestroyTask pojo,HttpServletRequest request) {
		PlaceOnFile file = newPOF(request);
		pOFService.add(file);
		if (typeParent.length != type.length || type.length != num.length) {
			throw new IllegalArgumentException("不对称的附件参数!!");
		}

		Users user = (Users) session
				.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);

		pojo.setDestroyTime(new Date());
		// 添加销毁人
		pojo.setDestroyUserId(user.getId());
		pojo.setDestroyUserName(user.getNickName());
		// 申请人姓名
		Apply apply = applyService.get(pojo.getApplyId());
		pojo.setApplyUserName(apply.getName());

		// 销毁状态改为已销毁
		pojo.setStateType(2);
		if (pojo.getIsWarehouse() == null) {
			pojo.setIsWarehouse(0);
		}

		destroyTaskService.save(pojo);
		// 更改申请表的状态为已销毁
		applyService.updateStateApply(pojo.getApplyId());

		// 保存附件信息
		for (int i = 0; i < num.length; i++) {
			DestroyTaskArticle dta = new DestroyTaskArticle();
			dta.setDestroyTaskId(pojo.getId());
			dta.setType(type[i]);
			dta.setTypeParent(typeParent[i]);
			dta.setNum(num[i]);
			destroyTaskArticleService.save(dta);
			pojo.getArticles().add(dta);
		}

		Logging logging = new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("ajaxAddDestroy.do");
		logging.setDetailsInfo("更改销毁状态为已销毁！");
		logging.setOpTime(new Date());
		this.loggingService.save(logging);

		return pojo;
	}

	@RequestMapping("/ajaxUpdateDestroyList")
	@ResponseBody
	public Object ajaxUpdateDestroyList(DestroyTask pojo, HttpSession session) {
		DestroyTask destroyTask = (DestroyTask) this.destroyTaskService
				.get(pojo.getId());
		if (destroyTask.getStateType().intValue() == 0) {
			this.destroyTaskService.update(pojo);
		}
		Users user = (Users) session.getAttribute("loginUser");
		Logging logging = new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("ajaxUpdateDestroyList.do");
		logging.setDetailsInfo("修改销毁信息！");
		logging.setOpTime(new Date());
		this.loggingService.save(logging);
		return pojo;
	}

	@RequestMapping("/ajaxRemoveDestroy")
	@ResponseBody
	public Object ajaxRemoveDestroy(HttpSession session, @RequestParam("id")
	Integer[] id) {
		if (id != null && id.length > 0) {
			for (Integer i : id) {
				DestroyTask destroyTask = destroyTaskService.get(i);
				if ((destroyTask.getStateType().intValue() == 1)
						|| (destroyTask.getStateType().intValue() == 3)) {
					this.destroyTaskService.delete(destroyTask);
				}
			}
		}
		Users user = (Users) session.getAttribute("loginUser");
		Logging logging = new Logging();
		logging.setUserId(user.getId());
		logging.setMethodUrl("ajaxRemoveDestroy.do");
		logging.setDetailsInfo("删除id为:" + id + "的销毁信息！");
		logging.setOpTime(new Date());
		this.loggingService.save(logging);
		return Arrays.asList(id);
	}

	// 根据申请id查询是否需要称重或者扫条码

	@RequestMapping("/isWeigh")
	public Object isWeigh(HttpServletRequest request, Model model) {
		int id = Integer.valueOf(request.getParameter("id"));
		Apply pojo = applyService.get(id);
		return pojo;
	}

	@RequestMapping( { "/echartsPie" })
	@ResponseBody
	public Object echartsPie(HttpServletRequest request) {
		String date = request.getParameter("date");
		
		String time = request.getParameter("time");
		return this.destroyTaskService.dayDestroyTypeCountDestroy(date,
				time);
	}

	@RequestMapping( { "/echartsWire" })
	@ResponseBody
	public Object echartsWire(HttpServletRequest request) throws ParseException {
		String date = request.getParameter("date");
		String time = request.getParameter("time");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date bigTime = sdf.parse(date);
		Date endTime = sdf.parse(time);
		Long day = Long
				.valueOf((endTime.getTime() - bigTime.getTime()) / 86400000L + 1L);
		List list = this.destroyTaskService.dayCountDestroy(date, time);
		Calendar cal = Calendar.getInstance();
		for (int i = 0; i < day.longValue(); i++) {
			boolean you = false;
			for (int j = 0; j < list.size(); j++) {
				Date dateTimeIf = sdf
						.parse((String) ((Object[]) list.get(j))[0]);
				if (dateTimeIf.equals(bigTime)) {
					you = true;
					break;
				}
			}
			if (you) {
				cal.setTime(bigTime);
				cal.add(5, 1);
				bigTime = cal.getTime();
			} else {
				list
						.add(new Object[] { sdf.format(bigTime),
								Integer.valueOf(0) });
				cal.setTime(bigTime);
				cal.add(5, 1);
				bigTime = cal.getTime();
			}
		}

		Collections.sort(list, new Comparator<Object[]>() {
			public int compare(Object[] o1, Object[] o2) {
				String a = (String) o1[0];
				String b = (String) o2[0];
				return a.compareTo(b);
			}
		});
		return list;
	}

	
	
	public PlaceOnFile newPOF(HttpServletRequest request){
		Integer applyId =Integer.parseInt(request.getParameter("applyId"));
		Integer bigType = Integer.parseInt(request.getParameter("typeParent"));
		Integer smallType = Integer.parseInt(request.getParameter("type"));
		String num = request.getParameter("num");
		
		Apply apply = applyService.get(applyId);
		PlaceOnFile file = new PlaceOnFile();
		file.setAddress(apply.getAddress());
		file.setBigType(bigType);
		file.setContact(apply.getContacts());
		file.setContactUnit(apply.getContactUnit());
		file.setDestoryThingDes(apply.getArticleDesc());
		file.setIsPlaceOn(0);
		file.setNowDestory(apply.getNowDestroy());
		if(bigType.equals("0"))
			file.setWeight(Double.parseDouble(num));
		if(bigType.equals("1"))
			file.setNum(Integer.parseInt(num));
		file.setSendType(apply.getSendType());
		file.setSmallType(smallType);
		file.setSubmitId(apply.getSubmitUserId());
		file.setSubmitName(usersService.get(apply.getSubmitUserId()).getNickName());
		file.setTelephone(apply.getTelephone());
		file.setCreateTime(new Date());
		return file;
		
	}
	/**
	 * 销毁表加个是否入库字段 然后入库表有申请的id 销毁表的id 编码 入库时间 销毁时间 状态 类型 入库登记人
	 */
}
