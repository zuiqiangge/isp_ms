package cn.com.pengyue.service;

import java.util.List;

import cn.com.pengyue.pojo.SecretProduct;
import cn.com.pengyue.pojo.User;
import cn.com.pengyue.util.Condition;

public interface IUserService extends IBaseService<User, Integer>{
	
	public List<User> getUserList(Condition conditon);
	
	public int getUserListCount(Condition condition);
}
