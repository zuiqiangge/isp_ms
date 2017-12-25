package cn.com.pengyue.dao;

import java.util.List;

import cn.com.pengyue.pojo.SecretProduct;
import cn.com.pengyue.pojo.User;
import cn.com.pengyue.util.Condition;

public interface IUserDao extends IBaseDao<User, Integer>{
	
	
	public List<User> getUserList(Condition conditon);
	
	public int getUserListCount(Condition condition);
}
