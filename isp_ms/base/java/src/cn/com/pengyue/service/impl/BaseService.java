package cn.com.pengyue.service.impl;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.util.List;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.dao.DataAccessException;

import cn.com.pengyue.dao.IBaseDao;
import cn.com.pengyue.pojo.PageInfo;
import cn.com.pengyue.service.IBaseService;

public abstract class BaseService<T,PK> implements IBaseService<T,PK>,InitializingBean{
	
	protected IBaseDao<T, PK> baseDao;
	protected Class<T> entityClass;  
	
	
	@SuppressWarnings("unchecked")
	public BaseService() {
		 entityClass =(Class<T>)((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0]; 
	}


	public void create(T t) throws DataAccessException{
		baseDao.create(t);
	}
	
	public T save(T t) {
		return baseDao.save(t);
	}


	public void delete(List<PK> ids) {
		baseDao.delete(ids);
	}


	public void delete(T t) {
		baseDao.delete(t);
	}


	public T get(PK id) {
		return baseDao.get(id);
	}


	public List<T> list(Object condition) {
		return baseDao.list(condition);
	}


	public List<T> listAll() {
		return baseDao.listAll();
	}


	public List<T> page(Object condition, PageInfo pageInfo) {
		return baseDao.page(condition, pageInfo);
	}


	public List<T> page(PageInfo pageInfo) {
		return baseDao.page(pageInfo);
	}


	public void update(T t, String[] ignoreProperties) {
		baseDao.update(t, ignoreProperties);
	}


	public void update(List<PK> ids, String propertyName, Object value) {
		baseDao.update(ids, propertyName, value);
	}


	public void update(T t) {
		baseDao.update(t);
	}
	
	@SuppressWarnings("unchecked")
	public void afterPropertiesSet() throws Exception {
		for (Field field : getClass().getDeclaredFields()) {
			if (IBaseDao.class.isAssignableFrom(field.getType())) {
				IBaseDao dao = null;
				try {
					field.setAccessible(true);
					dao = (IBaseDao) field.get(this);
				} catch (IllegalAccessException e) {}
				Class daoClass = (Class)((ParameterizedType) dao.getClass()
						.getGenericSuperclass()).getActualTypeArguments()[0];
				if (entityClass.equals(daoClass)) {
					try {
						Field baseDaoField = BaseService.class.getDeclaredField("baseDao");
						baseDaoField.setAccessible(true);
						baseDaoField.set(this, dao);
					} catch (IllegalAccessException e) {
					} catch (NoSuchFieldException e) {}
					break;
				}
			}
		}
		
	}
}
