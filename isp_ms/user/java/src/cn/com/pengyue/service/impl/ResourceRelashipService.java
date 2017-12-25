package cn.com.pengyue.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.IResourceRelashipDao;
import cn.com.pengyue.pojo.Resource;
import cn.com.pengyue.pojo.ResourceRelaship;
import cn.com.pengyue.service.IResourceRelashipService;

@Service
public class ResourceRelashipService extends BaseService<ResourceRelaship, Integer> implements
		IResourceRelashipService  {
	
	@javax.annotation.Resource
	public IResourceRelashipDao resourceRelashipDao;
	
	public void resetRelaship(Integer id, Integer type ,Integer[] newResouceIds){
		resourceRelashipDao.resetRelaship( id, type,newResouceIds);
	}

	public List<Resource> listRelashipResource(
			ResourceRelaship queryResourceCondition) {
		return resourceRelashipDao.listRelashipResource(queryResourceCondition);
	}

	@Override
	public List<ResourceRelaship> findListByRoleId(int roleid) {
		// TODO Auto-generated method stub
		return resourceRelashipDao.findListByRoleID(roleid);
	}
}
