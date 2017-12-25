package cn.com.pengyue.service;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.com.pengyue.pojo.Resource;
import cn.com.pengyue.pojo.ResourceRelaship;

public interface IResourceRelashipService extends IBaseService<ResourceRelaship, Integer> {
	
	@Transactional(propagation=Propagation.REQUIRED)
	public void resetRelaship(Integer id, Integer type, Integer[] newResouceIds);

	@Transactional(propagation=Propagation.SUPPORTS)
	public List<Resource> listRelashipResource(ResourceRelaship queryResourceCondition);

	@Transactional(propagation=Propagation.SUPPORTS)
	public List<ResourceRelaship> findListByRoleId(int roleid);
	
	@Transactional(propagation=Propagation.SUPPORTS)
	public List<ResourceRelaship> findListByProperty(ResourceRelaship resourceRelaship);
}
