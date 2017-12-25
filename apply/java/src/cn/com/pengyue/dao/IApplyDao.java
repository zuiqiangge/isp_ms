package cn.com.pengyue.dao;

import java.util.List;

import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.Users;

public interface IApplyDao extends IBaseDao<Apply, Integer> {
	
	public List sendTypeList(int sendType);  
	
	public List allStateList();  
	
	public int updateStateApply(int id);
	
	public List usersList(int id);
	
	public List<Object[]> allIsNullDate(int sendType);

	public List allState2List();
	
	public void Entrust(List<Apply> applies,Users user);
	
	public List<Apply> getListbyCondition(Apply apply);
}
