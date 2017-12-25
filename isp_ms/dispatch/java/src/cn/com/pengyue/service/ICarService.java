package cn.com.pengyue.service;

import java.util.List;

import cn.com.pengyue.pojo.Car;

public interface ICarService extends IBaseService<Car, Integer> {
	//近一个月每辆车调度数量统计柱状图
	public List<Object[]> monthCarCount(String date,String time);
	
	public List<Object[]> monthDestroyWeight(String date,String time);
}
