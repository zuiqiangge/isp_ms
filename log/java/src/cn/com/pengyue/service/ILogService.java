package cn.com.pengyue.service;

import java.util.List;

import cn.com.pengyue.pojo.Log;
import cn.com.pengyue.pojo.SecretProduct;

public interface ILogService extends IBaseService<Log, Integer>{
	
	public List<Log> getList(int id,String operate,int start,int num);
	
	public void del(Integer id);
	
	public int getCount(int id,String operate);
}
