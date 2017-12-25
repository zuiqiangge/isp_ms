package cn.com.pengyue.service;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.com.pengyue.pojo.Resource;

public interface IResourceService extends IBaseService<Resource, Integer> {
	@Transactional(propagation=Propagation.NOT_SUPPORTED)
	public void handRelaship(List<Resource> resources, Resource parent);

}
