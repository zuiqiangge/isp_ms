package cn.com.pengyue.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.ILogDao;
import cn.com.pengyue.pojo.Log;
import cn.com.pengyue.service.ILogService;

@Service
public class LogService extends BaseService<Log, Integer> implements ILogService{

	@Resource
	private ILogDao logDao;

	@Override
	public List<Log> getList(int id,String operate,int start,int num) {
		return logDao.getList(id,operate,start,num);
	}

	@Override
	public void del(Integer id) {
		logDao.del(id);
	}

	@Override
	public int getCount(int id, String operate) {
		return logDao.getCount(id, operate);
	}
	
	
	

	

	

}
