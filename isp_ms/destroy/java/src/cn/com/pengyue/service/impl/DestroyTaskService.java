package cn.com.pengyue.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.IDestroyTaskDao;
import cn.com.pengyue.pojo.DestroyTask;
import cn.com.pengyue.pojo.PageInfo;
import cn.com.pengyue.service.IDestroyTaskService;

@Service
public class DestroyTaskService extends BaseService<DestroyTask, Integer>
		implements IDestroyTaskService {
	@Resource
	public IDestroyTaskDao destroyTaskDao;

	public List<Object[]> dayCountDestroy(String date, String time) {
		return this.destroyTaskDao.dayCountDestroy(date, time);
	}

	public List<Object[]> dayDestroyTypeCountDestroy(String date, String time) {
		return this.destroyTaskDao.dayDestroyTypeCountDestroy(date, time);
	}

	@Override
	public List<DestroyTask> pageDestroyAndApply(PageInfo pageinfo) {
		return this.destroyTaskDao.pageDestroyAndApply(pageinfo);
	}
	@Override
	public List<Object[]> dayDestroyCountAvg(String date, String time) {
		// TODO Auto-generated method stub
		return this.destroyTaskDao.dayDestroyCountAvg(date, time);
	}
}
