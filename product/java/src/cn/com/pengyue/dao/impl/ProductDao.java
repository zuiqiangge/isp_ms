package cn.com.pengyue.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.com.pengyue.dao.IProductDao;
import cn.com.pengyue.pojo.SecretProduct;
import cn.com.pengyue.util.Condition;
@Repository
public class ProductDao extends BaseDao<SecretProduct, Integer> implements IProductDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<SecretProduct> getList(SecretProduct product,int firstResult,int maxResults) {
		return getHibernateTemplate().findByExample(product, firstResult, maxResults);
	}

	@Override
	public int getCount(SecretProduct product) {
		return getHibernateTemplate().findByExample(product).size();
	}

	
	
	

}
