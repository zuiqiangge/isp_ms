package cn.com.pengyue.dao.impl;

import java.awt.datatransfer.StringSelection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import cn.com.pengyue.dao.IUserDao;
import cn.com.pengyue.pojo.User;
import cn.com.pengyue.util.Condition;
@Repository
public class UserDao extends BaseDao<User, Integer> implements IUserDao {

	@Override
	public List<User> getUserList(Condition condition) {
		List<User> users = new ArrayList<User>();
		Session session = getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx = session.beginTransaction();
		//页码
		int page=0;
		//页长
		int num=10;
		try{
			Criteria c =session.createCriteria(User.class);
			if(null!=condition){
				Map<String,Object> map = condition.getConditions();
				for(String key:map.keySet()){
					if(key.equals("num")){
						num=Integer.parseInt(map.get(key).toString());
						continue;
					}
					if(key.equals("page")){
						page=Integer.parseInt(map.get(key).toString());
						continue;
					}
					c.add(Restrictions.eq(key,map.get(key)));
				}
				c.setFirstResult(page);
				c.setMaxResults(num);
				users = c.list();
				tx.commit();
			}
		}catch(Exception e){
			tx.rollback();
			e.printStackTrace();
		}finally{
			session.close();
		}
		return users;
	}

	
	
	@Override
	public int getUserListCount(Condition condition) {
		List<User> users = new ArrayList<User>();
		Session session = getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx = session.beginTransaction();
		//页码
		int page=0;
		//页长
		int num=10;
		try{
			Criteria c =session.createCriteria(User.class);
			if(null!=condition){
				Map<String,Object> map = condition.getConditions();
				for(String key:map.keySet()){
					if(key.equals("num")){
						continue;
					}
					if(key.equals("page")){
						continue;
					}
					c.add(Restrictions.eq(key,map.get(key)));
				}
				users = c.list();
				tx.commit();
			}
		}catch(Exception e){
			tx.rollback();
			e.printStackTrace();
		}finally{
			session.close();
		}
		return users.size();
	}
	
	
}
