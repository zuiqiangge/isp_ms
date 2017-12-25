package cn.com.pengyue.service;

import java.util.List;

import cn.com.pengyue.pojo.DestroyTask;
import cn.com.pengyue.pojo.PageInfo;

public interface IDestroyTaskService extends IBaseService<DestroyTask, Integer> {
	public abstract List<Object[]> dayCountDestroy(String beginDate,
			String endDate);

	public abstract List<Object[]> dayDestroyTypeCountDestroy(String beginDate,
			String endDate);
	
	public abstract List<DestroyTask> pageDestroyAndApply(PageInfo pageinfo);
	

	//日均销毁量
	public List<Object[]> dayDestroyCountAvg(final String date,final String time);
}
