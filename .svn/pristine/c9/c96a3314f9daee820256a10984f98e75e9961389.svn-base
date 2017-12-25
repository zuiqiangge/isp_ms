package cn.com.pengyue.dao;

import java.util.List;

import cn.com.pengyue.pojo.Resource;
import cn.com.pengyue.pojo.ResourceRelaship;

public interface IResourceRelashipDao extends IBaseDao<ResourceRelaship,Integer> {
	
	void resetRelaship(Integer id,Integer type , Integer[] newResouceIds);

	List<Resource> listRelashipResource(ResourceRelaship queryResourceCondition);
	
	List<ResourceRelaship> findListByRoleID(int roleid);
	
}
