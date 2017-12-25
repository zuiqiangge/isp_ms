package cn.com.pengyue.dao.impl;

import org.springframework.stereotype.Repository;

import cn.com.pengyue.dao.IPositionDao;
import cn.com.pengyue.pojo.Position;

@Repository
public class PositionDao extends BaseDao<Position, Integer> implements IPositionDao {

}
