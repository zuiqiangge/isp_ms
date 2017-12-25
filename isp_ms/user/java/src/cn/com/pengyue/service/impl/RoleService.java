package cn.com.pengyue.service.impl;

import org.springframework.stereotype.Service;

import cn.com.pengyue.pojo.Role;
import cn.com.pengyue.service.IRoleService;
import cn.com.pengyue.dao.IRoleDao;

@Service
public class RoleService extends BaseService<Role, Integer> implements
		IRoleService {
	
	@javax.annotation.Resource
	private IRoleDao roleDao;
}
