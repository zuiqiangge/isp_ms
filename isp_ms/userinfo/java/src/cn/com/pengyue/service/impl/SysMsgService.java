package cn.com.pengyue.service.impl;

import org.springframework.stereotype.Service;

import cn.com.pengyue.pojo.SysMsg;
import cn.com.pengyue.service.ISysMsgService;
import cn.com.pengyue.dao.ISysMsgDao;

@Service
public class SysMsgService extends BaseService<SysMsg, Integer> implements
		ISysMsgService {
	
	@javax.annotation.Resource
	private ISysMsgDao sysMsgDao;
}
