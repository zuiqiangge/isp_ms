package cn.com.pengyue.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.ILoggingDao;
import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.ILoggingService;

@Service
public class LoggingService extends BaseService<Logging, Integer> implements ILoggingService {
	@Resource
	public ILoggingDao loggingDao;
	
	public List<Logging> allLogList(){
		return loggingDao.allLogList();
	}
	
	
	public List<Logging> allByConditionLogList(Integer id,Date startTime,Date endTime){
		return loggingDao.allByConditionLogList(id, startTime, endTime);
	}
	
	@Override
	public List<Logging> getListByCondition(Logging logging,int firstResult,int maxResults){
		return loggingDao.getListByCondition(logging, firstResult, maxResults);
	}


	@Override
	public int getCountByCondition(Logging logging) {
		return loggingDao.getCountByCondition(logging);
	}
	
	/***
	 * 统计记录表里出现过的用户
	 * @return
	 */
	public List<Users> getUsersGroupByUser(){
		return loggingDao.getUsersGroupByUser();
	}
	
	
	/***
	 * 统计记录表里出现过的摘要
	 * @return
	 */
	public List<Logging> getLoggingGroupByZY(){
		return loggingDao.getLoggingGroupByZY();
	}
	
	
	/***
	 * 根据userId获取日志记录
	 */
	public List<Logging> getListByUserId(List<Integer> ids){
		return loggingDao.getListByUserId(ids);
	}
}
