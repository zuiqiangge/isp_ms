package cn.com.pengyue.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.com.pengyue.dao.IIpDao;
import cn.com.pengyue.pojo.Ip;

@Repository
public class IpDao extends BaseDao<Ip,Integer> implements IIpDao{

	@Override
	public Ip findByIp(String ip) {
		List<Ip> ips = getHibernateTemplate().find("from "+Ip.class.getName()+" where ip='"+ip+"'");
		return ips.size()>0?ips.get(0):null;
	}

}


