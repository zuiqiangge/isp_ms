package cn.com.pengyue.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.poi.util.StringUtil;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.alibaba.druid.util.StringUtils;

import cn.com.pengyue.dao.IApplyDao;
import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.Audit;
import cn.com.pengyue.pojo.Classes;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.IApplyService;

@Repository
public class ApplyDao extends BaseDao<Apply, Integer> implements IApplyDao {

	public List sendTypeList(int sendType) {
		return getHibernateTemplate().find("from "+Apply.class.getName()+" a left join fetch a.dispaths b where a.sendType="+sendType+
		" and a.state="+IApplyService.APPLY_STATE_PISI+" order by b.id,a.date desc,a.id desc");
	}

	public List allStateList() {
		return getHibernateTemplate().find("from "+Apply.class.getName()+" a   where "+
		" a.isdestroy is null and a.state="+IApplyService.APPLY_STATE_PISI+" order by  a.date desc,a.id desc");
	}
	
	@Override
	public List allState2List() {
		return getHibernateTemplate().find("from "+Apply.class.getName()+" a   where "+
				" a.isdestroy is null and a.state="+IApplyService.APPLY_STATE_PISI+" and a.nowDestroy = 0 order by  a.date desc,a.id desc");
	}

	public int updateStateApply(int id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().bulkUpdate("update "+Apply.class.getName()+" set isdestroy=1 where id=?",id);
	}

	public List<String> usersList(int id) {
		List<String> applyList=new ArrayList<String>();
		applyList=getHibernateTemplate().find("from "+Apply.class.getName()+" where user_id=? order by state asc , id desc",id);
		return applyList;
	} 
	
	public List<Object[]> allIsNullDate(int sendType) {
		List<Object[]> applyList;
		applyList=getHibernateTemplate().find("from "+Apply.class.getName()+" a,"+Classes.class.getName()+" b where a.sendType="+sendType+
				" and a.state="+IApplyService.APPLY_STATE_PISI+" and b.start_time is not null and b.end_time is not null  order by date desc");
		return applyList;
	}

	
	/**
	 * 接收apply集合,并改变所有对象的申请上级
	 */
	public void Entrust(List<Apply> applies,Users user){
		for(Apply apply:applies){
			apply.setSubmitUserId(user.getId());
			Session session = getHibernateTemplate().getSessionFactory().openSession();
			Transaction tx = session.beginTransaction();
			session.merge(apply);
			//session.saveOrUpdate(apply);
			tx.commit();
			session.close();
		}
		
	}
	
	/**
	 * 根据条件查询申请记录
	 */
	@Override
	public List<Apply> getListbyCondition(Apply apply) {
		Session session = getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx = session.beginTransaction();
		Criteria c = session.createCriteria(Apply.class);
		if(null!=apply.getSubmitUserId()&&apply.getSubmitUserId()!=0)
			c.add(Restrictions.eq("submitUserId",apply.getSubmitUserId()));
		if(null!=apply.getContactUnit()&&!(StringUtils.isEmpty(apply.getContactUnit())))
			c.add(Restrictions.eq("contactUnit",apply.getContactUnit()));
		if(null!=apply.getContacts()&&!(StringUtils.isEmpty(apply.getContacts())))
			c.add(Restrictions.eq("contacts",apply.getContacts()));
		if(null!=apply.getTelephone()&&!(StringUtils.isEmpty(apply.getTelephone())))
			c.add(Restrictions.eq("telephone",apply.getTelephone()));
		if(null!=apply.getAddress()&&!(StringUtils.isEmpty(apply.getAddress())))
			c.add(Restrictions.eq("address",apply.getAddress()));
		if(null!=apply.getSendType())
			c.add(Restrictions.eq("sendType",apply.getSendType()));
		if(null!=apply.getNowDestroy())
			c.add(Restrictions.eq("nowDestroy", apply.getNowDestroy()));
		List<Apply> applies = c.list();
		tx.commit();
		session.close();
		return applies;
	}
	
}
