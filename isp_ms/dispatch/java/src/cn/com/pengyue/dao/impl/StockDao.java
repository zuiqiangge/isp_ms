package cn.com.pengyue.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import com.alibaba.druid.util.StringUtils;



import cn.com.pengyue.dao.IStockDao;
import cn.com.pengyue.pojo.ResourceRelaship;
import cn.com.pengyue.pojo.stock;
@Repository
public class StockDao extends BaseDao<stock, Integer> implements IStockDao {

	@Override
	public List<stock> listAllStockByOrder(stock stock) {
		List<stock> stocks = new ArrayList<stock>();
		Session session =null;
		Transaction tx=null;
		try{
			 session = getHibernateTemplate().getSessionFactory().openSession();
			 tx= session.beginTransaction();
			Criteria c = session.createCriteria(stock.class);
			
				c.add(Restrictions.eq("userId",stock.getUserId()));
				
				if(null!=stock.getContactUnit()&&!(StringUtils.isEmpty(stock.getContactUnit()))){
					c.add(Restrictions.eq("contactUnit",stock.getContactUnit()));
				}
				if(stock.getType()!=6){
					c.add(Restrictions.eq("type",stock.getType()));
				}
					
				
				if(null!=stock.getStockDate()){
					c.add(Restrictions.eq("stockDate",stock.getStockDate()));
				}
			    if(0!=stock.getBatch()){
			    	c.add(Restrictions.eq("batch",stock.getBatch()));
			    }
					
				
				
				
			
			
			
			c.addOrder(Order.desc("orders"));
			stocks = c.list();
			
			tx.commit();
		}catch(Exception e){
			if(tx!=null)
				tx.rollback();
			e.printStackTrace();
		}finally{
			if(session!=null)
			session.close();
		}

		return stocks;
		
	}


	

}
