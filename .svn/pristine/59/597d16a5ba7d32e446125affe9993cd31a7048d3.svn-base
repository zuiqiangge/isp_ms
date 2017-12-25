package cn.com.pengyue.dao;

import java.util.List;

import cn.com.pengyue.pojo.PageInfo;

public interface IBaseDao<T,PK> {  
    void create(T t);  
    T save(T t);
    void update(T t); 
    void update(T t,String[] ignoreProperties); 
    void update(List<PK> ids,String propertyName,Object value); 
    void delete(T t);
    void delete(List<PK> ids);
    T get(PK id);  
    List<T> page(PageInfo pageInfo);  
    List<T> page(Object condition,PageInfo pageInfo);  
    List<T> listAll();
    List<T> list(Object condition);  
}