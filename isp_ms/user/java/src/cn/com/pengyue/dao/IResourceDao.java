package cn.com.pengyue.dao;

import java.util.List;

import cn.com.pengyue.pojo.Resource;

public interface IResourceDao extends IBaseDao<Resource,Integer> {

	void handRelaship(List<Resource> resources, Resource parent);
	
}
