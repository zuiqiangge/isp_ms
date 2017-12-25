package cn.com.pengyue.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.ILoggingDao;
import cn.com.pengyue.pojo.Logging;
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
}
