package cn.com.pengyue.dao;

import java.util.List;

import cn.com.pengyue.pojo.SecretProduct;
import cn.com.pengyue.util.Condition;

public interface IProductDao extends IBaseDao<SecretProduct, Integer>{
	
	public List<SecretProduct> getList(SecretProduct product,int firstResult,int maxResults) ;
	
	public int getCount(SecretProduct product) ;
	
	
	
}
