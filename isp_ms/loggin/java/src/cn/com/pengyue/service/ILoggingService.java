package cn.com.pengyue.service;

import java.util.Date;
import java.util.List;

import cn.com.pengyue.pojo.Logging;

public interface ILoggingService extends IBaseService<Logging, Integer>  {
	public List<Logging> allLogList();
	
	
	public List<Logging> allByConditionLogList(Integer id,Date startTime,Date endTime);
}
