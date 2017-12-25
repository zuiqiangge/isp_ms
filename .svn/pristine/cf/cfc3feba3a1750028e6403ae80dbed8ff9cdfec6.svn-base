package cn.com.pengyue.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.com.pengyue.pojo.Resource;

@Repository
public class ResourceDao extends BaseDao<Resource,Integer> implements cn.com.pengyue.dao.IResourceDao {

	public void handRelaship(List<Resource> resources, Resource parent) {
		 RelashipCacheBaseDao.reshipCates(resources, parent);
	}
	
	
	/**
	 * 根据条件查询资源集合
	 */
	@Override
	public List<Resource> getListByCondition(Resource resource) {
		
		return getHibernateTemplate().findByExample(resource);
	}
}
