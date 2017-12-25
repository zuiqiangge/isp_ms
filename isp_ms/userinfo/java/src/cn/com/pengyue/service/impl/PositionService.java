package cn.com.pengyue.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.IPositionDao;
import cn.com.pengyue.pojo.Position;
import cn.com.pengyue.service.IPositionService;

@Service 
public class PositionService extends BaseService<Position, Integer> implements IPositionService {
	@Resource
	public IPositionDao positionDao;
}
