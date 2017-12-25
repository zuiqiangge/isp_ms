package cn.com.pengyue.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.IUserDao;
import cn.com.pengyue.dao.impl.ProductDao;
import cn.com.pengyue.pojo.SecretProduct;
import cn.com.pengyue.pojo.User;
import cn.com.pengyue.service.IProductService;
import cn.com.pengyue.service.IUserService;
import cn.com.pengyue.util.Condition;

@Service
public class UserService extends BaseService<User, Integer> implements IUserService{

	@Resource
	public IUserDao userDao;
	@Override
	public List<User> getUserList(Condition conditon) {
		return userDao.getUserList(conditon);
	}
	@Override
	public int getUserListCount(Condition condition) {
		return userDao.getUserListCount(condition);
	}
	

	

	

}
