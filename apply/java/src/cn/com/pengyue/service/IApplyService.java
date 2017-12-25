package cn.com.pengyue.service;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.Users;

public interface IApplyService extends IBaseService<Apply, Integer> {
	
	@Transactional(propagation=Propagation.REQUIRED)//这个方法中必须开启事务
	void submitApplyAndAudit(Apply pojo);
	
	
	public List sendTypeList(int sendType);  
	
	public List allStateList();
	public List allState2List();
	@Transactional(propagation=Propagation.REQUIRED)
	public int updateStateApply(int id);
	public List usersList(int id);
	public void Entrust(List<Apply> applies,Users user);
	public List<Apply> getListbyCondition(Apply apply);
	public static final int APPLY_STATE_SAVEED = 0;
	public static final int APPLY_STATE_SUBMIT_ALL = 2;
	public static final int APPLY_STATE_SUBMIT_ONE = 1;
	public static final int APPLY_STATE_PISI = 3;
	
}
