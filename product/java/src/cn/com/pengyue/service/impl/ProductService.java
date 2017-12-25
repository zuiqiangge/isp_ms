package cn.com.pengyue.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.impl.ProductDao;
import cn.com.pengyue.pojo.SecretProduct;
import cn.com.pengyue.service.IProductService;
import cn.com.pengyue.util.Condition;

@Service
public class ProductService extends BaseService<SecretProduct, Integer> implements IProductService{

	@Resource
	public ProductDao productDao;

	@Override
	public List<SecretProduct> getList(SecretProduct product,int firstResult,int maxResults) {
		return productDao.getList(product,firstResult,maxResults);
	}

	@Override
	public int getCount(SecretProduct product)  {
		return productDao.getCount(product);
	}
	

	

	

}
