package cn.com.pengyue.dao.impl;

import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.alibaba.druid.util.StringUtils;

import cn.com.pengyue.dao.IPOFDao;
import cn.com.pengyue.pojo.PlaceOnFile;
@Repository
public class POFDao extends BaseDao<PlaceOnFile, Integer> implements IPOFDao {

	
	
	/**
	 *根据条件查询未归档列表
	 */
	@Override
	public List<PlaceOnFile> getListByWeiAndCondition(PlaceOnFile file) {
		List<PlaceOnFile> files = new ArrayList<PlaceOnFile>();
		Session session =null;
		Transaction tx=null;
		try{
			 session = getHibernateTemplate().getSessionFactory().openSession();
			 tx= session.beginTransaction();
			Criteria c = session.createCriteria(PlaceOnFile.class);
			if(null!=file.getContactUnit()&&!(StringUtils.isEmpty(file.getContactUnit())))
				c.add(Restrictions.eq("contactUnit",file.getContactUnit()));
			
			if(null!=file.getBigType())
				c.add(Restrictions.eq("bigType",file.getBigType()));
			
			if(null!=file.getDestoryThingDes()&&!(StringUtils.isEmpty(file.getDestoryThingDes())))
				c.add(Restrictions.eq("destory_thing_des",file.getDestoryThingDes()));
			//添加未归档条件
			c.add(Restrictions.eq("isPlaceOn",0));
			c.addOrder(Order.desc("createTime"));
			files = c.list();
			tx.commit();
		}catch(Exception e){
			if(tx!=null)
				tx.rollback();
			e.printStackTrace();
		}finally{
			if(session!=null)
			session.close();
		}
		return files;
	}

	
	/**
	 * 根据条件查询已归档列表
	 */
	@Override
	public List<PlaceOnFile> getListByYiAndCondition(PlaceOnFile file) {
		List<PlaceOnFile> files = new ArrayList<PlaceOnFile>();
		Session session =null;
		Transaction tx=null;
		try{
			 session = getHibernateTemplate().getSessionFactory().openSession();
			 tx= session.beginTransaction();
			Criteria c = session.createCriteria(PlaceOnFile.class);
			if(null!=file.getContactUnit()&&!(StringUtils.isEmpty(file.getContactUnit())))
				c.add(Restrictions.eq("contactUnit",file.getContactUnit()));
			
			if(null!=file.getBigType())
				c.add(Restrictions.eq("bigType",file.getBigType()));
			
			if(null!=file.getDestoryThingDes()&&!(StringUtils.isEmpty(file.getDestoryThingDes())))
				c.add(Restrictions.eq("destory_thing_des",file.getDestoryThingDes()));
			//添加未归档条件
			c.add(Restrictions.eq("isPlaceOn",1));
			c.addOrder(Order.desc("createTime"));
			files = c.list();
			tx.commit();
		}catch(Exception e){
			if(tx!=null)
				tx.rollback();
			e.printStackTrace();
		}finally{
			if(session!=null)
			session.close();
		}
		
		return files;
	}

	

	

	@Override
	public void add(PlaceOnFile file) {
		List<PlaceOnFile> files = new ArrayList<PlaceOnFile>();
		Session session =null;
		Transaction tx=null;
		try{
			 session = getHibernateTemplate().getSessionFactory().openSession();
			 tx= session.beginTransaction();
			session.save(file);
			tx.commit();
		}catch(Exception e){
			if(tx!=null)
				tx.rollback();
			e.printStackTrace();
		}finally{
			if(session!=null)
			session.close();
		}
		
	}


	@Override
	public void edit(PlaceOnFile file) {
		Session session =null;
		Transaction tx=null;
		try{
			 session = getHibernateTemplate().getSessionFactory().openSession();
			 tx= session.beginTransaction();
			session.merge(file);
			tx.commit();
		}catch(Exception e){
			if(tx!=null)
				tx.rollback();
			e.printStackTrace();
		}finally{
			if(session!=null)
			session.close();
		}
		
	}


	@Override
	public void del(PlaceOnFile file) {
		Session session =null;
		Transaction tx=null;
		try{
			 session = getHibernateTemplate().getSessionFactory().openSession();
			 tx= session.beginTransaction();
			session.delete(file);
			tx.commit();
		}catch(Exception e){
			if(tx!=null)
				tx.rollback();
			e.printStackTrace();
		}finally{
			if(session!=null)
			session.close();
		}
	}

}
