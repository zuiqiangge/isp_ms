package cn.com.pengyue.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.ICarDao;
import cn.com.pengyue.pojo.Car;
import cn.com.pengyue.service.ICarService;
@Service
public class CarService extends BaseService<Car, Integer> implements ICarService {
	@Resource
	public ICarDao carDao;

	public List<Object[]> monthCarCount(String date, String time) {
		// TODO Auto-generated method stub
		return carDao.monthCarCount(date, time);
	}
	
	public List<Object[]> monthDestroyWeight(String date,String time){
		return carDao.monthDestroyWeight(date, time);
	}
}
