package cn.com.pengyue.dao;

import java.util.Date;
import java.util.List;

import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.Users;

public interface ILoggingDao extends IBaseDao<Logging, Integer> {
	
	public List<Logging> allLogList();
	
	
	public List<Logging> allByConditionLogList(Integer id,Date startTime,Date endTime);
	
	public List<Logging> getListByCondition(Logging logging,int firstResult,int maxResults);
	
	public int getCountByCondition(Logging logging);
	
	public List<Users> getUsersGroupByUser();
	
	
	public List<Logging> getLoggingGroupByZY();
	
	public List<Logging> getListByUserId(List<Integer> ids);
}
