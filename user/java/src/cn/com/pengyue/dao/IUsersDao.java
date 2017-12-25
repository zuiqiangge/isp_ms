package cn.com.pengyue.dao;

import java.util.List;

import cn.com.pengyue.pojo.Users;

public interface IUsersDao extends IBaseDao<Users,Integer> {
	
	public List<Users> getUsers(int userId);
	
	public List<Users> getAllLingDao();
	
	/**
	 * 根据用户名查询
	 * @param userName
	 * @return
	 */
	public List<Users> getUserByName(String userName);
}
