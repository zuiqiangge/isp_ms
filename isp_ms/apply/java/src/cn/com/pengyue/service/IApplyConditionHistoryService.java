package cn.com.pengyue.service;

import java.util.List;

import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.ApplyConditionHistory;

public interface IApplyConditionHistoryService extends IBaseService<ApplyConditionHistory, Integer>{
	
	/**
	 * 存储单个对象
	 * @param history
	 */
	public void add(ApplyConditionHistory history);
	
	/**
	 * 查询列表
	 */
	public List<ApplyConditionHistory> listByUserId(Integer userId);
}
