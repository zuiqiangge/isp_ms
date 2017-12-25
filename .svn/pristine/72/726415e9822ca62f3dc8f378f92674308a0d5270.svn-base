package cn.com.pengyue.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.IUsersDao;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.IUsersService;

@Service
public class UsersService extends BaseService<Users, Integer> implements
		IUsersService {
	
	@javax.annotation.Resource
	private IUsersDao usersDao;

	public List<Users> getUsers(int userId) {
		// TODO Auto-generated method stub
		return usersDao.getUsers(userId);
	}

	@Override
	public List<Users> getAllLingDao() {
		// TODO Auto-generated method stub
		return usersDao.getAllLingDao();
	}
}
