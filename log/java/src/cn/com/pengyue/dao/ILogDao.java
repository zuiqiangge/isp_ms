package cn.com.pengyue.dao;

import java.util.List;

import cn.com.pengyue.pojo.Log;
import cn.com.pengyue.pojo.SecretProduct;
import cn.com.pengyue.util.Condition;

public interface ILogDao extends IBaseDao<Log, Integer>{
	
	public List<Log> getList(int id,String operate,int start,int num);
	
	public int getCount(int id,String operate);
	
	public void del(Integer id);
	
}
