package cn.com.pengyue.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import cn.com.pengyue.dao.IApplyConditionHistoryDao;
import cn.com.pengyue.dao.IApplyarticleDao;
import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.ApplyConditionHistory;
import cn.com.pengyue.pojo.Applyarticle;
import cn.com.pengyue.pojo.PageInfo;
@Repository
public class ApplyConditionHistoryDao extends BaseDao<ApplyConditionHistory, Integer> implements IApplyConditionHistoryDao {

	@Override
	public void add(ApplyConditionHistory history) {
		Session session = getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx = session.beginTransaction();
		session.merge(history);
		//session.saveOrUpdate(apply);
		tx.commit();
		session.close();
	}

	@Override
	public List<ApplyConditionHistory> listByUserId(Integer userId) {
		return getHibernateTemplate().find("from "+ApplyConditionHistory.class.getName());
	}

	

}
