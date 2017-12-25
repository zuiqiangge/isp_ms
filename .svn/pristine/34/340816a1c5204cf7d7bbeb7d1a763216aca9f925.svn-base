package cn.com.pengyue.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.IApplyConditionHistoryDao;
import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.ApplyConditionHistory;
import cn.com.pengyue.pojo.PageInfo;
import cn.com.pengyue.service.IApplyConditionHistoryService;
@Service
public class ApplyConditionHistoryService extends BaseService<ApplyConditionHistory, Integer> implements IApplyConditionHistoryService {
	@Resource
	private IApplyConditionHistoryDao applyConditionHistoryDao;
	
	@Override
	public void add(ApplyConditionHistory history) {
		applyConditionHistoryDao.add(history);
		
	}

	@Override
	public List<ApplyConditionHistory> listByUserId(Integer userId) {
		
		return applyConditionHistoryDao.listByUserId(userId);
	}

	

	

}
