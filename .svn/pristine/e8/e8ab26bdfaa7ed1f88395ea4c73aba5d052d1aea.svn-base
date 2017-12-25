package cn.com.pengyue.dao;

import java.util.List;

import cn.com.pengyue.pojo.DestroyTask;
import cn.com.pengyue.pojo.PageInfo;

public interface IDestroyTaskDao extends IBaseDao<DestroyTask, Integer> {
	
	//近一个月每日销毁量折线图
	public List<Object[]> dayCountDestroy(String date,String time);
	
	//销毁物品类型饼状图
	public List<Object[]> dayDestroyTypeCountDestroy(String date,String time);

	public List<DestroyTask> pageDestroyAndApply(PageInfo pageinfo);
	//日均销毁量
	public List<Object[]> dayDestroyCountAvg(final String date,final String time);




}
