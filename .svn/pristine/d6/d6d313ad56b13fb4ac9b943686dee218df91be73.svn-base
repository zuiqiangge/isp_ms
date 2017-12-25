package cn.com.pengyue.service.impl;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.IApplyDao;
import cn.com.pengyue.dao.IAuditDao;
import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.Audit;
import cn.com.pengyue.service.IApplyService;
import cn.com.pengyue.service.IAuditService;
@Service
public class AuditService extends BaseService<Audit, Integer> implements IAuditService {
	@Resource
	public IAuditDao auditDao;
	
	@Resource
	public IApplyDao applyDao;
	
	public List  lingdaoList(int id) {
		return auditDao.lingdaoList(id);
		
	}
	
	
	public List getByApplyIdFindAudit(int id){
		
		return auditDao.getByApplyIdFindAudit(id);
	}


	@Override
	public void pishi(Audit audit) {
		Audit oldData = auditDao.get(audit.getId());
		if(audit.getAudit_user_id() ==null || !oldData.getAudit_user_id().equals(audit.getAudit_user_id())){
			throw new IllegalArgumentException("提交信息中，id+审核人id 与数据库信息不一致！！请不要越权操作批示！");
		}
		
		oldData.setAudit_explain(audit.getAudit_explain());//批示
		oldData.setAudit_date(new Date());//时间
		oldData.setAudit_state(IAuditService.AUDIT_STATE_READ);	//将状态设为已阅
		
		auditDao.update(oldData);
		
		//批示已完成，更改申请表的状态为已结束
		applyDao.update(Arrays.asList(oldData.getApply_id()), 
				"state", IApplyService.APPLY_STATE_PISI);
		
		//查出来 给页面显示
		Apply apply =  applyDao.get(oldData.getApply_id());
		audit.setRelashipApply(apply);
	}
	
}
