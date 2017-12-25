package cn.com.pengyue.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.IApplyDao;
import cn.com.pengyue.dao.IPOFDao;
import cn.com.pengyue.dao.impl.POFDao;
import cn.com.pengyue.pojo.PlaceOnFile;
import cn.com.pengyue.service.IPOFService;
import cn.com.pengyue.service.impl.BaseService;
@Service
public class POFService extends BaseService<PlaceOnFile, Integer> implements IPOFService{

	@Resource
	public IPOFDao pOFDao;
	

	

	@Override
	public List<PlaceOnFile> getListByWeiAndCondition(PlaceOnFile file) {
		return pOFDao.getListByWeiAndCondition(file);
	}

	@Override
	public List<PlaceOnFile> getListByYiAndCondition(PlaceOnFile file) {
		return pOFDao.getListByYiAndCondition(file);
	}

	@Override
	public void add(PlaceOnFile file) {
		pOFDao.add(file);
	}

	@Override
	public void edit(PlaceOnFile file) {
		pOFDao.edit(file);
		
	}

	@Override
	public void del(PlaceOnFile file) {
		pOFDao.del(file);
		
	}

}
