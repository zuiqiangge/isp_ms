package cn.com.pengyue.service;

import java.util.List;

import cn.com.pengyue.pojo.Users;

public interface IUsersService extends IBaseService<Users, Integer> {
	public List<Users> getUsers(int userId);
	public List<Users> getAllLingDao();
}	
