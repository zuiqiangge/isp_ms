package cn.com.pengyue.service;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.com.pengyue.pojo.Audit;

public interface IAuditService extends IBaseService<Audit, Integer> {

	Integer AUDIT_STATE_UNREAD = 0;
	Integer AUDIT_STATE_READ = 1;
	public List lingdaoList(int id);
	public List getByApplyIdFindAudit(int id);
	@Transactional(propagation=Propagation.REQUIRED)
	public void pishi(Audit audit);
}
