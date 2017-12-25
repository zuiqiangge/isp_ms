package cn.com.pengyue.dao.impl;

import java.io.Serializable;
import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.dao.DataAccessException;

import cn.com.pengyue.dao.DaoException;
import cn.com.pengyue.dao.annotation.Comp;
import cn.com.pengyue.dao.annotation.EliminateCompare;
import cn.com.pengyue.dao.annotation.OrderBy;
import cn.com.pengyue.pojo.PageInfo;
import cn.com.pengyue.util.Delegate;

public abstract class CachedBaseDao<T, PK extends Serializable> extends BaseDao<T,PK>  implements InitializingBean{

	protected Map<PK, T> data;

	@Override
	public void create(T t) throws DataAccessException {
		super.create(t);
		data.put(getId(t), t);
	}

	@Override
	public void delete(List<PK> ids) {
		super.delete(ids);
		for (PK pk : ids) {
			data.remove(pk);
		}
	}

	@Override
	public void delete(T t) {
		super.delete(t);
		data.remove(getId(t));
	}

	@Override
	public T get(PK id) {
		return data.get(id);
	}


	@Override
	public List<T> listAll() {
		return new ArrayList<T>(data.values());
	}

	
	@Override
	public List<T> list(Object condition) {
		PageInfo p = new PageInfo();
		p.setPageSize(data.size());
		p.setNeedSetTotalSize(false);
		return pojoPage(condition, data, p);
	}
	
	@Override
	public List<T> page(Object condition, PageInfo pageInfo) {
		return pojoPage(condition,data, pageInfo);
	}

	@Override
	public List<T> page(PageInfo pageInfo) {
		return pojoPage(null,data,pageInfo);
	}
	
	private List<T> pojoPage(Object condition, Map<PK, T> data,
			PageInfo pageInfo) {
		assertPageInfo(pageInfo);
		initPageInfo(pageInfo);
		
		if(pageInfo.isNeedSetTotalSize()){
			pageInfo.setTotalSize(data.size());
		}
		List<T> result = new ArrayList<T>();
		List<Comparable<T>> conditions = createFromAnnotion(condition);
		for (T t : data.values()) {
			boolean findAdd = true;
			for (Comparable<T> comparable : conditions) {
				if(comparable.compareTo(t) < 0 ){
					findAdd = false;
				}
			}
			if(findAdd){
				result.add(t);
			}
		}
		return result;
	}
	
	public int eq(T t,String name,Object fieldValue){
		Object value = getProperty(t, name);
		if(value!=null && value.equals(fieldValue)){
			return 0;
		}
		return -1;
	}
	
	public int neq(T t,String name,Object fieldValue){
		return eq(t,name,fieldValue)==0 ? -1 : 0 ;
	}
	
	public int ne(T t,String name,Object fieldValue){
		return eq(t,name,fieldValue)==0 ? -1 : 0 ;
	}
	
	public int gt(T t,String name,Object fieldValue){
        //>
		Object value = getProperty(t, name);
		if (value!=null && value instanceof Comparable) {
			Comparable valComp = (Comparable) value;
			if(valComp.compareTo(fieldValue)> 0 ){
				return 0;
			}
		}
		return -1;
    }

	public int lt(T t,String propertyName, Object fieldValue)
    {
//      "<");
    	Object value = getProperty(t, propertyName);
		if (value!=null && value instanceof Comparable) {
			Comparable valComp = (Comparable) value;
			if(valComp.compareTo(fieldValue)< 0 ){
				return 0;
			}
		}
		return -1;
    }

	public int le(T t,String name,Object fieldValue)
    {
        // "<=");
    	Object value = getProperty(t, name);
		if (value!=null && value instanceof Comparable) {
			Comparable valComp = (Comparable) value;
			if(valComp.compareTo(fieldValue) <= 0 ){
				return 0;
			}
		}
		return -1;
    }

	public int ge(T t,String name,Object fieldValue)
    {
        // ">=");
        Object value = getProperty(t, name);
		if (value!=null && value instanceof Comparable) {
			Comparable valComp = (Comparable) value;
			if(valComp.compareTo(fieldValue) >= 0 ){
				return 0;
			}
		}
		return -1;
    }
    
	public int in(T t,String name,Object fieldValue)
    {
    	Object value = getProperty(t, name);
		int result = -1 ;
		if(value==null || fieldValue==null ){
			return result;
		}
		Class paramCls = fieldValue.getClass();
		paramCls = paramCls.isArray() ? Object[].class
				: Collection.class.isAssignableFrom(paramCls) ? Collection.class
						: Object.class;
		if(paramCls.isArray()){
			for (int i = 0,length = Array.getLength(value); i < length; i++) {
				if(value.equals(Array.get(fieldValue, i))){
					return 0;
				}
			}
		}else if(Collection.class.isAssignableFrom(paramCls)){
			for (Object obj : ((Collection)fieldValue)) {
				if(value.equals(obj)){
					return 0;
				}
			}
		}
		return result;
    }
	
	
    private Object getProperty(T t,String name){
    	try {
			return PropertyUtils.getProperty(t, name);
		} catch (IllegalAccessException e) {
			logger.debug("取属性失败！..."+name,e);
		} catch (InvocationTargetException e) {
			logger.debug("取属性失败！..."+name,e);
		} catch (NoSuchMethodException e) {
			logger.debug("取属性失败！..."+name,e);
		}
		return null;
    }
    
    public int like(T t,String name,Object fieldValue){
		Object value = getProperty(t, name);
		if (value instanceof String) {
			String val = (String) value;
			String compVal = fieldValue.toString();
			compVal = compVal.replaceAll("_", ".").replaceAll("%", ".*");
			if(val!=null && val.matches(compVal)){
				return 0;
			}
		}else{
			throw new DaoException("like 比较只支持字符串比较..",new IllegalArgumentException());
		}
		return -1;
	}
	
    public int isNull(T t,String name,Object fieldValue){
        return getProperty(t, name)==null ? 0 : -1;
    }
	
    public int isNotNull(T t,String name,Object fieldValue){
        return getProperty(t, name)!=null ? 0 : -1;
    }
	
    public int isEmpty(T t,String name,Object fieldValue){
		Object value = getProperty(t, name);
        if( value !=null && value.toString().isEmpty() ) {
        	return 0;
        }
        return -1;
    }

    public int isNotEmpty(T t,String name,Object fieldValue){
		Object value = getProperty(t, name);
        if( value !=null && !value.toString().isEmpty() ) {
        	return 0;
        }
        return -1;
    }


	private List<Comparable<T>> createFromAnnotion(Object condition) {
		List<Comparable<T>> result = new ArrayList<Comparable<T>>();
		try {
	    	Field[] fields =  condition.getClass().getDeclaredFields();
	    	for (Field field : fields) {
	    		field.setAccessible(true);
	    		
	    		String name = field.getName();
	    		
	    		Object fieldValue = field.get(condition);
	    		OrderBy orderBy = field.getAnnotation(OrderBy.class);
	    		if(orderBy != null){
	    			logger.info("内存进行搜索，不支持排序请自行实现！！..."+name);
	    		}
	    		
	    		if(name.startsWith("this$"))continue;//成员类JDK 自动添加的属性不处理
	    		
	    		if(fieldValue != null){
	    			EliminateCompare eCompare = field.getAnnotation(EliminateCompare.class);
	    			if (field.isAnnotationPresent(EliminateCompare.class) && eCompare.isEliminateCompare()){
	    				logger.info("当前字段不参与比较..."+name);
	    			}else{
	    				Comp comp = field.getAnnotation(Comp.class);
	    				if(comp == null){
	    					//默认 进行=比较
	    					result.add(Delegate.$(this, "eq" , Comparable.class,name, fieldValue));
	    				}else{
	    					if(!"".equals(comp.propertyName())){
	    						name = comp.propertyName();
	    					}
	    					if(comp.value().equalsIgnoreCase("like")){
	    						if(comp.full()){
	    							fieldValue = "%"+fieldValue+"%";
	    						}else if(comp.prefix()){
	    							fieldValue = "%"+fieldValue;
	    						}
	    					}
	    					result.add(Delegate.$(this, comp.value(), Comparable.class, name, fieldValue));
	    				}
	    			}
	    		} 
			}
    	} catch (IllegalArgumentException e) {
			throw new DaoException("BaseDao.initObj2Criteria(Object,Criteria)执行条件处理出错！错误的参数！",e);
		} catch (SecurityException e) {
			throw new DaoException("BaseDao.initObj2Criteria(Object,Criteria)执行条件处理出错！安全策略不允许！",e);
		} catch (IllegalAccessException e) {
			throw new DaoException("BaseDao.initObj2Criteria(Object,Criteria)执行条件处理出错！错误的访问！",e);
		} 
		return result;
	}

	@Override
	public T save(T t) throws DataAccessException {
		super.save(t);
		data.put(getId(t),t);
		return t;
	}

	@Override
	public void update(List<PK> ids, String propertyName, Object value) {
		super.update(ids, propertyName, value);
		for (PK pk : ids) {
			T t = data.get(pk);
			try {
				BeanUtils.setProperty(t, propertyName, value);
			} catch (IllegalAccessException e) {
				logger.debug("设置属性值失败！！",e);
			} catch (InvocationTargetException e) {
				logger.debug("设置属性值失败！！",e);
			}
		}
	}

	@Override
	public void update(T t, String[] ignoreProperties) {
		super.update(t, ignoreProperties);
		T dataEle = data.get(getId(t));
		if(dataEle!= t){
			org.springframework.beans.BeanUtils.copyProperties(t, data.get(getId(t)), ignoreProperties);
		}
	}

	@Override
	public void update(T t) {
		super.update(t);
		try {
			T dataEle = data.get(getId(t));
			if(dataEle!= t){
				BeanUtils.copyProperties(data.get(getId(t)), t);
			}
		} catch (IllegalAccessException e) {
			logger.debug("设置属性值失败！！",e);
		} catch (InvocationTargetException e) {
			logger.debug("设置属性值失败！！",e);
		}
	}
	
	public void afterPropertiesSet() throws Exception {
		initDao();
	}
	protected void initDao() throws Exception {
		// 缓存全部信息
		List<T> list = super.listAll();
		this.data = new TreeMap<PK, T>();
		for (T t : list) {
			data.put(getId(t), t);
		}
	}
	
	private boolean try2GetId = true;
	protected PK getId(T pojo){
		if(try2GetId){
			try{
				return (PK)getProperty(pojo, "id");
			}catch (Exception e) {
				try2GetId = false;
			}
		}
		throw new DaoException("默认得到id属性失败！请重写getId方法",new UnsupportedOperationException());
	}
	
	
	protected void assertPageInfo(final PageInfo pageInfo) {
		if(pageInfo==null ){
    		throw new DaoException("BaseDao.page(PageInfo)方法错误的访问！pageInfo不能为空！",new NullPointerException());
    	}
	}
	
	protected void initPageInfo(final PageInfo pageInfo) {
		//    	if(pageInfo.getCurrentPage()==0){
		    		//不可以是0，将设置默认值
		    		//pageInfo.setCurrentPage(1);
		//    	}
//		if(pageInfo.getiDisplayLength()>0){
//	    	int currentPage = (pageInfo.getiDisplayStart()/pageInfo.getiDisplayLength())+1;
//	    	pageInfo.setCurrentPage(currentPage);
//	    	//if(pageInfo.getPageSize()==0){
//	    		//不可以是0，将设置默认值
//	    		//pageInfo.setPageSize(DEFAULT_PAGE_SIZE);
//	    	//}
//	    	pageInfo.setPageSize(pageInfo.getiDisplayLength());
//		}
	}
	
	private Log logger = LogFactory.getLog(CachedBaseDao.class);
}
