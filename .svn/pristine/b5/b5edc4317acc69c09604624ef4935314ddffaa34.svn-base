package cn.com.pengyue.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import cn.com.pengyue.pojo.Resource;
import cn.com.pengyue.pojo.ResourceRelaship;

@Repository
public class ResourceRelashipDao extends BaseDao<ResourceRelaship, Integer>
		implements cn.com.pengyue.dao.IResourceRelashipDao {

	public void resetRelaship(Integer id, Integer type, Integer[] newResouceIds) {
		getHibernateTemplate().bulkUpdate(
				"delete from " + ResourceRelaship.class.getName()
						+ " where targetId = ? and type = ?  ", id, type);
		for (Integer newResouceId : newResouceIds) {
			getHibernateTemplate().persist(
					new ResourceRelaship(id, newResouceId, type));
		}
	}
   
	public List<Resource> listRelashipResource(
			ResourceRelaship queryResourceCondition) {
		return getHibernateTemplate().find(
				"select t.relashipResource  from "
						+ ResourceRelaship.class.getName()
						+ " t where t.targetId = ? and t.type = ? ",
				queryResourceCondition.getTargetId(),
				queryResourceCondition.getType());
	}

	@Override
	public List<ResourceRelaship> findListByRoleID(int roleid) {
		return  getHibernateTemplate().find(
				"from "
				+ ResourceRelaship.class.getName()
				+ " t where t.targetId = ?",
				roleid);
	}

}
