package cn.com.pengyue.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.com.pengyue.pojo.Resource;
import cn.com.pengyue.service.IResourceService;
import cn.com.pengyue.dao.IResourceDao;

@Service
public class ResourceService extends BaseService<Resource, Integer> implements
		IResourceService {
	
	@javax.annotation.Resource
	private IResourceDao resourceDao;
	
	public void handRelaship(List<Resource> resources,Resource parent){
		resourceDao.handRelaship(resources,parent);
	}
}
