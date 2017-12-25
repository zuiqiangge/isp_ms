package cn.com.pengyue.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import cn.com.pengyue.dao.ILendInfoDao;
import cn.com.pengyue.pojo.LendInfo;
import cn.com.pengyue.pojo.SecretProduct;
@Repository
public class LendInfoDao extends BaseDao<LendInfo, Integer> implements ILendInfoDao {

	@Override
	public void del(Integer id) {
		getHibernateTemplate().find("delete * from LendInfo where product.id="+id);
		
	}

	public List<LendInfo> findLendByValid(Integer id){	
		return getHibernateTemplate().find("from LendInfo where isValid=0 and product.id="+id);
		
	}
	
	
	public List<LendInfo> getListByProductId(Integer id){
		return getHibernateTemplate().find("from LendInfo where product.id="+id);
		
	}
	
	public List<LendInfo> getListByLendUserId(Integer id){
		return getHibernateTemplate().find("from LendInfo where lendUser.id="+id);
		
	}

}
