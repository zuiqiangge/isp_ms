package cn.com.pengyue.service;

import java.util.Date;
import java.util.List;

import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.Users;

public interface ILoggingService extends IBaseService<Logging, Integer>  {
	public List<Logging> allLogList();
	
	
	public List<Logging> allByConditionLogList(Integer id,Date startTime,Date endTime);
	
	
	public List<Logging> getListByCondition(Logging logging,int firstResult,int maxResults);


	
	public int getCountByCondition(Logging logging);
	
	
	public List<Users> getUsersGroupByUser();
	
	public List<Logging> getLoggingGroupByZY();
	
	
	public List<Logging> getListByUserId(List<Integer> ids);
}
