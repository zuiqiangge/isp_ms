package cn.com.pengyue.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.IApplyDao;
import cn.com.pengyue.dao.IAuditDao;
import cn.com.pengyue.dao.IDepartmentDao;
import cn.com.pengyue.dao.IPositionDao;
import cn.com.pengyue.dao.IUsersDao;
import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.Audit;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.IApplyService;
import cn.com.pengyue.service.IAuditService;

@Service
public class ApplyService extends BaseService<Apply, Integer> implements IApplyService{
	@Resource
	public IApplyDao applyDao;
	
	@Resource
	private IAuditDao auditDao;
	
	
	@Resource
	private IUsersDao usersDao;
	@Resource
	private IDepartmentDao departmentDao;
	@Resource
	private IPositionDao positionDao;
	
	public void submitApplyAndAudit(Apply apply) {
		boolean isSaveApply = apply.getState().equals(APPLY_STATE_SAVEED);//如果是保存 不提审核则不进行
		if(isSaveApply){
			//先添加 申请
			if(apply.getId()==null){
				applyDao.save(apply);
			}else{
				applyDao.update(apply);
			}
			return;
		}
		if(apply.getSubmitUserId()==null){//如果没选择 提交领导 则状态为全部领导可见
			apply.setState(APPLY_STATE_SUBMIT_ALL);//设置状态为已提交 
		}else{
			apply.setState(APPLY_STATE_SUBMIT_ONE);//设置状态为已提交 
		}
		
		//先添加 申请
		if(apply.getId()==null){
			applyDao.save(apply);
		}else{
			applyDao.update(apply);
		}
		Audit audit = new Audit();
		audit.setApply_id(apply.getId());
		audit.setAudit_state(IAuditService.AUDIT_STATE_UNREAD);
		
		if(apply.getState().equals(APPLY_STATE_SUBMIT_ONE)){//提交给某个领导 
			Users lingdao = usersDao.get(apply.getSubmitUserId());//设置制定领导id
			audit.setAudit_people(lingdao.getNickName());
			audit.setAudit_user_id(lingdao.getId());
			if(lingdao.getDepartment()==null){
				lingdao.setDepartment(departmentDao.get(lingdao.getBmId()));
			}
			audit.setAndit_bm(lingdao.getDepartment().getBmName());
			
			if(lingdao.getPosition()==null){
				lingdao.setPosition(positionDao.get(lingdao.getPositionId()));
			}
			audit.setAnditi_position(lingdao.getPosition().getName());
		}
		auditDao.save(audit);
		
		apply.setRelashipAudit(audit);
	}

	public List sendTypeList(int sendType) {
		// TODO Auto-generated method stub
		return applyDao.sendTypeList(sendType);
	}

	public List allStateList() {
		// TODO Auto-generated method stub
		return applyDao.allStateList();
	}

	public int updateStateApply(int id) {
		// TODO Auto-generated method stub
		return applyDao.updateStateApply(id);
	}

	public List usersList(int id) {
		// TODO Auto-generated method stub
		return applyDao.usersList(id);
	}

	@Override
	public List allState2List() {
		// TODO Auto-generated method stub
		return applyDao.allState2List();
	}

	@Override
	public void Entrust(List<Apply> applies, Users user) {
		applyDao.Entrust(applies, user);
		
	}

	@Override
	public List<Apply> getListbyCondition(Apply apply) {
		
		return applyDao.getListbyCondition(apply);
	}
	
	
	
	
}
