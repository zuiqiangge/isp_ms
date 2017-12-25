package cn.com.pengyue.dao.impl;

import org.springframework.stereotype.Repository;

import cn.com.pengyue.dao.IDepartmentDao;
import cn.com.pengyue.pojo.Department;

@Repository
public class DepartmentDao extends BaseDao<Department, Integer> implements IDepartmentDao {

}
