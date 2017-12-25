package cn.com.pengyue.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.pengyue.dao.ILendInfoDao;
import cn.com.pengyue.dao.ILogDao;
import cn.com.pengyue.dao.IProductDao;
import cn.com.pengyue.dao.impl.LendInfoDao;
import cn.com.pengyue.dao.impl.ProductDao;
import cn.com.pengyue.pojo.LendInfo;
import cn.com.pengyue.pojo.Log;
import cn.com.pengyue.pojo.SecretProduct;
import cn.com.pengyue.service.ILendInfoService;
import cn.com.pengyue.service.IProductService;

@Service
public class LendInfoService extends BaseService<LendInfo, Integer> implements ILendInfoService{

	@Resource
	public ILendInfoDao lendInfoDao;
	@Resource
	public IProductDao productDao;
	@Resource
	public ILogDao logDao;

	@Override
	public void del(Integer id) {
		lendInfoDao.del(id);
		
	}

	@Override
	public List<LendInfo> findLendByValid(Integer id) {
		return lendInfoDao.findLendByValid(id);
		
	}
	@Transactional
	@Override
	public List<LendInfo> getListByProductId(Integer id) {
		// TODO Auto-generated method stub
		return lendInfoDao.getListByProductId(id);
	}

	@Override
	public List<LendInfo> getListByLendUserId(Integer id) {
		return lendInfoDao.getListByLendUserId(id);
	}
	
	
	

	
	
}
