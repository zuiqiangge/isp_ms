package cn.com.pengyue.dao.impl;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import cn.com.pengyue.dao.ILoggingDao;
import cn.com.pengyue.pojo.Logging;
import cn.com.pengyue.pojo.Users;
@Repository
public class LoggingDao extends BaseDao<Logging, Integer> implements ILoggingDao {

	public List<Logging> allByConditionLogList(Integer id, Date startTime, Date endTime) {
		List<Logging> list=null;
		if(id==null&&startTime!=null){
			list=getHibernateTemplate().find("from "+Logging.class.getName()+" where opTime>=?"+
					" and opTime<=? order by opTime desc",startTime,endTime);
			return list;
		}else if(id!=null&&startTime==null){
			list=getHibernateTemplate().find("from "+Logging.class.getName()+" where userId="+id+
					" order by opTime desc");
			return list;
		}
		list=getHibernateTemplate().find("from "+Logging.class.getName()+" where userId="+id+" and opTime>=?"+
				" and opTime<=?  order by opTime desc",startTime,endTime);
		return list;
	}


	public List<Logging> allLogList() {
		List<Logging> list=getHibernateTemplate().find("from "+Logging.class.getName()+" order by opTime desc");
		return list;
	}
	
	
	
	public List<Logging> getListByCondition(Logging logging,int firstResult,int maxResults){
		Session session = getHibernateTemplate().getSessionFactory().openSession();
		String hql="from "+Logging.class.getName(); 
		if(null!=logging.getUserId())
			hql+=" where userId.id="+logging.getUserId().getId();
		if(null!=logging.getSysDescId()&&(!logging.getSysDescId().isEmpty()))
			hql+=" and sysDescId='"+logging.getSysDescId()+"'";
		Query query = session.createQuery(hql);
		query.setFirstResult(firstResult);
		query.setMaxResults(maxResults);
		return query.list();
		//return getHibernateTemplate().findByExample(logging, firstResult, maxResults);
	}


	@Override
	public int getCountByCondition(Logging logging) {
		Session session = getHibernateTemplate().getSessionFactory().openSession();
		String hql="from "+Logging.class.getName(); 
		if(null!=logging.getUserId())
			hql+=" where userId.id="+logging.getUserId().getId();
		if(null!=logging.getSysDescId()&&(!logging.getSysDescId().isEmpty()))
			hql+=" and sysDescId='"+logging.getSysDescId()+"'";
		Query query = session.createQuery(hql);
		return query.list().size();
	}

	
	
	/***
	 * 统计记录表里出现过的用户
	 * @return
	 */
	public List<Users> getUsersGroupByUser(){
		return getHibernateTemplate().find("from "+Users.class.getName()+" where id in (select userId from "+Logging.class.getName()+" group by userId)");
	}
	
	
	/***
	 * 统计记录表里出现过的摘要
	 * @return
	 */
	public List<Logging> getLoggingGroupByZY(){
		return getHibernateTemplate().find("from "+Logging.class.getName()+" group by sysDescId");
	}
	
	
	public List<Logging> getListByUserId(List<Integer> ids){
		String hql="(";
		for(int i=0;i<ids.size();i++){
			if(i==ids.size()-1)
				hql+=ids.get(i)+")";
			else
				hql+=ids.get(i)+",";
		}
		return getHibernateTemplate().find("from "+Logging.class.getName()+" where userId.id in "+hql);
	}
}
