package cn.com.pengyue.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.IDepartmentDao;
import cn.com.pengyue.pojo.Department;
import cn.com.pengyue.service.IDepartmentService;

@Service
public class DepartmentService extends BaseService<Department, Integer> implements IDepartmentService {

	@Resource
	public IDepartmentDao departmentDao;
}
