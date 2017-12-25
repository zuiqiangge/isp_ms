package cn.com.pengyue.dao.impl;

import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.alibaba.druid.util.StringUtils;

import cn.com.pengyue.dao.ILogDao;
import cn.com.pengyue.dao.IProductDao;
import cn.com.pengyue.pojo.Log;
import cn.com.pengyue.pojo.SecretProduct;
import cn.com.pengyue.util.Condition;
@Repository
public class LogDao extends BaseDao<Log, Integer> implements ILogDao {

	@Override
	public List<Log> getList(int id,String operate,int start,int num) {
		Session session = getHibernateTemplate().getSessionFactory().openSession();
		Query query = session.createQuery("from Log where product.id="+id+" and operateName like '"+operate+"' ");
		query.setFirstResult(start);
		query.setMaxResults(num);
		List<Log> logs = query.list();
		return logs;
	}

	@Override
	public int getCount(int id,String operate){
		return getHibernateTemplate().find("from Log where product.id="+id+" and operateName like '"+operate+"'").size();
	}
	
	
	@Override
	public void del(Integer id) {
		Session session=null;
		Transaction transactoin=null;
		try{
			session = getHibernateTemplate().getSessionFactory().openSession();
			transactoin = session.beginTransaction();
			transactoin.begin();
			Query query= session.createSQLQuery("delete * from log where id="+id);
			query.executeUpdate();
			transactoin.commit();
		}catch(Exception e){
			if(null!=transactoin)
				transactoin.rollback();
			e.printStackTrace();
		}finally{
			if(null!=session)
				session.close();
		}
		
	}

	

	

	
	
	

}
