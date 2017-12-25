package cn.com.pengyue.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.com.pengyue.pojo.Users;

@Repository
public class UsersDao extends BaseDao<Users,Integer> implements cn.com.pengyue.dao.IUsersDao {

	public java.util.List<Users> getUsers(int userId) {
		List<Users> list= getHibernateTemplate().find("from "+Users.class.getName()+" where id!=?  and isLeader=1",userId);
		return list;
	}
	
	public List<Users> getAllLingDao(){
		List<Users> list= getHibernateTemplate().find("from "+Users.class.getName()+" where role in (8,10,1)");
		return list;
	}
	
}
