package cn.com.pengyue.web.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.pengyue.dao.annotation.Comp;
import cn.com.pengyue.pojo.Car;
import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.PageInfo;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.ICarService;
import cn.com.pengyue.service.ILoggingService;
import cn.com.pengyue.service.IUsersService;
import cn.com.pengyue.util.AccessConstants;

@Controller
public class CarController {
	
	@javax.annotation.Resource
	private ICarService carService;
	@javax.annotation.Resource
	private IUsersService usersService;
	@javax.annotation.Resource
	private ILoggingService loggingService;
	
	@RequestMapping("/listAllCar")
	public String listAll(Model model,HttpSession session){
		model.addAttribute("list", carService.listAll());
		
		Users users= (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(users);
		logging.setMethodUrl("listAllCar.do");
		logging.setDetailsInfo("查询所有的车辆信息！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return "listAllCar";
	}
	
	@RequestMapping("/getCarById")
	public String getCarById(Integer id,Model model,HttpSession session){
		model.addAttribute("pojo", carService.get(id));
		
		Users users= (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(users);
		logging.setMethodUrl("getCarById.do");
		logging.setDetailsInfo("查询ID为："+id+"的车辆信息！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return "getCarById";
	}
	
	@RequestMapping("/updateCar")
	public String updateCar(Car pojo,HttpSession session){
		carService.update(pojo);
		
		Users users= (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(users);
		logging.setMethodUrl("updateCar.do");
		logging.setDetailsInfo("修改ID为："+pojo.getId()+"的车辆信息！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return "updateCar";
	}
	
	@RequestMapping("/addCar")
	public String addCar(Car pojo,HttpSession session){
		carService.save(pojo);
		
		Users users= (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(users);
		logging.setMethodUrl("addCar.do");
		logging.setDetailsInfo("添加车辆信息！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		
		return "addCar";
	}
	
	@RequestMapping("/removeCar")
	public String removeCar(Integer[] id,HttpSession session){
		carService.delete(Arrays.asList(id));
		
		Users users= (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(users);
		logging.setMethodUrl("removeCar.do");
		logging.setDetailsInfo("删除ID为："+id+"车辆信息！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return "removeCar";
	}
	
	
	@RequestMapping("/ajaxSelect2Users")
	@ResponseBody
	public Object ajaxSelect2Users(final @RequestParam(value="term",required=false) String name,Model model){
		PageInfo pageInfo = new PageInfo();
		pageInfo.setNeedSetTotalSize(false);
		pageInfo.setPageSize(10);
		return usersService.page(new Object(){
			@Comp(value="like",full=true)
			private String nickName = name == null ? null : name.trim() ;
		}, pageInfo);
	}
	
	
	
	@RequestMapping("/ajaxGetCarById")
	@ResponseBody
	public Object ajaxGetCarById(Integer id,Model model,HttpSession session){
		Users users= (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(users);
		logging.setMethodUrl("ajaxGetCarById.do");
		logging.setDetailsInfo("ajax查询ID为："+id+"的车辆信息！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		
		return carService.get(id);
	}
	
	@RequestMapping("/ajaxUpdateCar")
	@ResponseBody
	public Object ajaxUpdateCar(Car pojo,HttpSession session){
		carService.update(pojo);
		
		Users users= (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(users);
		logging.setMethodUrl("ajaxUpdateCar.do");
		logging.setDetailsInfo("ajax修改ID为："+pojo.getId()+"的车辆信息！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		
		return pojo;
	}
	
	@RequestMapping("/ajaxAddCar")
	@ResponseBody
	public Object ajaxAddCar(Car pojo,HttpSession session){
		carService.save(pojo);
		
		Users users= (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(users);
		logging.setMethodUrl("ajaxAddCar.do");
		logging.setDetailsInfo("ajax添加车辆信息！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		
		return pojo;
	}
	
	@RequestMapping("/ajaxRemoveCar")
	@ResponseBody
	public Object ajaxRemoveCar(Integer[] id,HttpSession session){
		carService.delete(Arrays.asList(id));
		Users users= (Users) session.getAttribute(AccessConstants.SESSION_NAME_LOGINED_USER);
		Logging logging=new Logging();
		logging.setUserId(users);
		logging.setMethodUrl("removeCar.do");
		logging.setDetailsInfo("ajax删除ID为："+id+"车辆信息！");
		logging.setOpTime(new Date());
		loggingService.save(logging);
		return Arrays.asList(id);
	}
	
	
	
	@RequestMapping("/echartsBar")
	@ResponseBody
	public Object echartsBar(HttpServletRequest request){
		String date=request.getParameter("date");
		String time=request.getParameter("time");
		System.out.println("日期是"+date);
		List<Object[]> list= carService.monthCarCount(date,time);
		
		List<Car> carList=carService.listAll();
		
		for(int i=0;i<carList.size();i++){
			boolean is=false;
			for(int j=0;j<list.size();j++){
				if(carList.get(i).getCarNo().equals(list.get(j)[0])){
					is=true;
					break;
				}
			}
			if(!is){
				list.add(new Object[]{carList.get(i).getCarNo(),0});
			}
			
		}
		for(int i=0;i<list.size();i++){
			System.out.println(list.get(i)[0]);
		}
		
		return list;
	}
	
	
	
	@RequestMapping("/echartsLine")
	@ResponseBody
	public Object echartsLine(HttpServletRequest request) throws ParseException{
		String date="2015-10-01";
		String time="2015-10-15";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date bigDate=sdf.parse(date);
		Date endTime=sdf.parse(time);
		Long day = Long
				.valueOf((endTime.getTime() - bigDate.getTime()) / 86400000L + 1L);
		List<Object[]> list=carService.monthDestroyWeight(date, time);
		Calendar cal = Calendar.getInstance();
		for (int i = 0; i < day.longValue(); i++) {
			boolean you = false;
			for (int j = 0; j < list.size(); j++) {
				Date dateTimeIf = sdf
						.parse((String) ((Object[]) list.get(j))[0]);
				if (dateTimeIf.equals(bigDate)) {
					you = true;
					break;
				}
			}
			if (you) {
				cal.setTime(bigDate);
				cal.add(5, 1);
				bigDate = cal.getTime();
			} else {
				list
						.add(new Object[] { sdf.format(bigDate),
								Integer.valueOf(0) });
				cal.setTime(bigDate);
				cal.add(5, 1);
				bigDate = cal.getTime();
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
	
}
