package cn.com.pengyue.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.IIpDao;
import cn.com.pengyue.pojo.Ip;
import cn.com.pengyue.service.IIpService;
@Service
public class IpService extends BaseService<Ip, Integer> implements IIpService {
	@Resource
	private IIpDao ipDao;

	public IIpDao getIpDao() {
		return ipDao;
	}

	public void setIpDao(IIpDao ipDao) {
		this.ipDao = ipDao;
	}

	@Override
	public Ip findByIp(String ip) {
		return ipDao.findByIp(ip);
	}
	
}
