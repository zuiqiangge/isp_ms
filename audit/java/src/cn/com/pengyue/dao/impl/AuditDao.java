package cn.com.pengyue.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.com.pengyue.dao.IAuditDao;
import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.Audit;
import cn.com.pengyue.service.IAuditService;

@Repository
public class AuditDao extends BaseDao<Audit, Integer> implements IAuditDao {

	public List lingdaoList(int id) {
		return getHibernateTemplate().find("from "+Apply.class.getName()+ 
				" a left join fetch  a.audits b " +
				" where a.submitUserId="+id +" and b.audit_state = "+IAuditService.AUDIT_STATE_UNREAD+" order by  a.date desc ,b.id,a.id desc");
	}

	public List getByApplyIdFindAudit(int id) {
		return getHibernateTemplate().find("from "+Audit.class.getName()+" where apply_id="+id);
	}

}
