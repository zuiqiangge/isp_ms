package cn.com.pengyue.service;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.com.pengyue.pojo.PageInfo;

public interface IBaseService<T, PK> {
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	void create(T t);

	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	T save(T t);

	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	void update(T t);

	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	void update(T t, String[] ignoreProperties);

	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	void update(List<PK> ids, String propertyName, Object value);
	
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	void delete(T t);

	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	void delete(List<PK> ids);

	@Transactional(propagation = Propagation.SUPPORTS)
	T get(PK id);

	@Transactional(propagation = Propagation.SUPPORTS)
	List<T> page(PageInfo pageInfo);

	@Transactional(propagation = Propagation.SUPPORTS)
	List<T> page(Object condition, PageInfo pageInfo);

	@Transactional(propagation = Propagation.SUPPORTS)
	List<T> listAll();

	@Transactional(propagation = Propagation.SUPPORTS)
	List<T> list(Object condition);
}
