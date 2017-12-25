package cn.com.pengyue.dao.impl;

import java.beans.PropertyDescriptor;
import java.io.Serializable;
import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.ParameterizedType;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.persistence.Transient;

import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.BeanUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;

import cn.com.pengyue.config.Constants;
import cn.com.pengyue.dao.DaoException;
import cn.com.pengyue.dao.IBaseDao;
import cn.com.pengyue.dao.annotation.Comp;
import cn.com.pengyue.dao.annotation.EliminateCompare;
import cn.com.pengyue.dao.annotation.OrderBy;
import cn.com.pengyue.pojo.PageInfo;
@SuppressWarnings({"unchecked","unused"})
abstract class BaseDao<T,PK extends Serializable> implements IBaseDao<T ,PK> ,Constants {  
    protected Class<T> entityClass;  
    protected String className;  
   
	public BaseDao(){  
        entityClass=(Class<T>)((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0]; 
        className=entityClass.getName();  
    }
	
	private HibernateTemplate hibernateTemplate;  
	  
    @Resource  
    public final void setSessionFactory(SessionFactory sessionFactory) {  
        this.hibernateTemplate = new HibernateTemplate(sessionFactory);  
    }
  
    public final HibernateTemplate getHibernateTemplate() {  
    	return this.hibernateTemplate;  
    }
	
    public T get(PK id){ 
        return (T)this.getHibernateTemplate().get(entityClass, id);  
    }  
    public void create(T t) throws DataAccessException{  
        this.getHibernateTemplate().save(t);  
    } 
    public T save(T t) throws DataAccessException{
    	this.getHibernateTemplate().save(t);
		return t;
	}
    public void delete(T t){  
        this.getHibernateTemplate().delete(t);  
    }  
    public void update(T t){  
        this.getHibernateTemplate().update(t);  
    }  
      
    public List<T> listAll(){  
        return (List<T>)this.getHibernateTemplate().find("from "+className+" as c order by c.id desc");  
    }  
    
    public List<T> list(final Object condition){  
        return getHibernateTemplate().findByCriteria(initObj2Criteria(condition,
				DetachedCriteria.forClass(entityClass)));
    }  
    
    public void delete(final List<PK> ids) {
    	if(ids!=null && ids.size()==1){
    		getHibernateTemplate().bulkUpdate("delete from "+className+" as c where c.id = ?",ids.get(0));
    		return;
    	}
    	getHibernateTemplate().execute(new HibernateCallback(){
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				return session
					.createQuery("delete from "+className+" as c where c.id in (:ids)")
					.setParameterList("ids", ids)
					.executeUpdate();
			}
    	});
    }
    public void update(T t,final String[] ignoreProperties) {
		try {
			//取ID
			final PK id = (PK) PropertyUtils.getProperty(t, "id");
			//按ID 查出这个记录
			//T target = get(id);
			//复制属性
			//BeanUtils.copyProperties(t, target , ignoreProperties);
			//更新
			//update(target);
			
			//组装hql
			final StringBuffer hql = new StringBuffer("update ").append(entityClass.getName());
			hql.append(" set ");
			PropertyDescriptor[] properties = BeanUtils.getPropertyDescriptors(entityClass);
			final List<Object> params = new ArrayList<Object>();
			Arrays.sort(ignoreProperties);
			for (PropertyDescriptor propertyDescriptor : properties) {
				//检查全部属性
				if(
					propertyDescriptor.getName().equals("class") ||
					propertyDescriptor.getName().equals("id") ||
						Arrays.binarySearch(ignoreProperties, propertyDescriptor.getName())> -1
					|| propertyDescriptor.getReadMethod().getAnnotation(Transient.class)!=null ){
					continue;
				}
				
				//添加参数
				hql.append(propertyDescriptor.getName()).append("=? ,");
				params.add(propertyDescriptor.getReadMethod().invoke(t));
			}
			if(hql.indexOf("?")<0){
				System.err.println("BaseDao.update(T,String[])执行更新数据时无，更新内容！");
				return;
			}
			hql.deleteCharAt(hql.length()-1);
			hql.append(" where id=? ");
			params.add(id);
			getHibernateTemplate().execute(new HibernateCallback(){
				public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
					//执行。。
					Query q = session.createQuery(hql.toString());
					for (int i =0 ,len = params.size();i<len;i++) {
						q.setParameter(i, params.get(i));
					}
					return q.executeUpdate();
				}	
			});
		} catch (IllegalAccessException e) {
			throw new DaoException("BaseDao.update(T,String[])执行更新数据时取id或者设置属性出错！方法错误的访问！",e);
		} catch (InvocationTargetException e) {
			throw new DaoException("BaseDao.update(T,String[])执行更新数据时取id或者设置属性出错！方法调用失败！",e);
		} catch (NoSuchMethodException e) {
			throw new DaoException("BaseDao.update(T,String[])执行更新数据时取id或者设置属性出错！没有对应方法！",e);
		}
    }
    
    
    public void update(final List<PK> ids,final String propertyName,final Object value) {
    	getHibernateTemplate().execute(new HibernateCallback(){
    		public Object doInHibernate(Session session)
    				throws HibernateException, SQLException {
    			if(ids!=null && ids.size()==1){
    				return session
    				.createQuery("update "+entityClass.getName()+" set "+propertyName+" = :value where id = :ids")
    				.setParameter("value", value)
    				.setParameter("ids", ids.get(0))
    				.executeUpdate();
    			}
    			return session
    				.createQuery("update "+entityClass.getName()+" set "+propertyName+" = :value where id in (:ids)")
    				.setParameter("value", value)
    				.setParameterList("ids", ids)
    				.executeUpdate();
    		}
    	});
    }
    
    public List<T> page(final PageInfo pageInfo) {
    	return page(null, pageInfo);
    }
    
    private Object defaultCondition = new Object(){
    		@OrderBy(value="desc")
    		private String id;
    };
    public List<T> page(final Object condition,final  PageInfo pageInfo) {
    	if(pageInfo==null ){
    		throw new DaoException("BaseDao.page(PageInfo)方法错误的访问！pageInfo不能为空！",new NullPointerException());
    	}
    	if(pageInfo.getPageNo()==0){

//    	if(pageInfo.getCurrentPage()==0){

    		//不可以是0，将设置默认值

    		pageInfo.setPageNo(1);
    	}
    	if(pageInfo.getPageSize()==0){
    		
    		pageInfo.setPageSize(PageInfo.DEFAULT_PAGE_SIZE);
    	}
    	//if(pageInfo.getPageSize()==0){
    		//不可以是0，将设置默认值
    		//pageInfo.setPageSize(DEFAULT_PAGE_SIZE);
    	//}
    	
    	if(condition==null)//默认使用查询全部 ID 降序
    		return page(defaultCondition, pageInfo);

    	return getHibernateTemplate().executeFind(new HibernateCallback(){
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Criteria criteria = initObj2Criteria(condition,DetachedCriteria.forClass(entityClass)).getExecutableCriteria(session);
				
				if(pageInfo.isNeedSetTotalSize()){
					//计算 总数
			    	pageInfo.setTotalSize(
			    			( (Number)(criteria
			    					.setProjection(Projections.count("id")).uniqueResult())
								 ).intValue());
				}
				
		    	//查询信息
				return  criteria.setProjection(null)
						.setFirstResult(pageInfo.getFirstNo())
						.setMaxResults(pageInfo.getPageSize())
						.list();
			}
    	});
    }
    
    
    private DetachedCriteria initObj2Criteria(Object condition,DetachedCriteria criteria) {
    	if(condition==null){
    		return criteria;
    	}
    	try {
	    	Field[] fields = condition.getClass().getDeclaredFields();
	    	List<Field> relashFields = new ArrayList<Field>();
	    	for (Field field : fields) {
	    	 	Map<Criterion, DetachedCriteria> parseResult = parseAnnotion2Craterion(condition ,field, criteria,relashFields);
	    		if(parseResult==null){
	    			continue;
	    		}
	    		for (Entry<Criterion, DetachedCriteria> result : parseResult.entrySet()) {
	    			result.getValue().add(result.getKey());
				}
			}
    	} catch (IllegalArgumentException e) {
			throw new DaoException("BaseDao.initObj2Criteria(Object,Criteria)执行条件处理出错！错误的参数！",e);
		} catch (SecurityException e) {
			throw new DaoException("BaseDao.initObj2Criteria(Object,Criteria)执行条件处理出错！安全策略不允许！",e);
		}
		return criteria;
	}
    
    private Map<Criterion, DetachedCriteria> parseAnnotion2Craterion(Object condition, Field field , DetachedCriteria criteria,List<Field> relashFields){
    	try {
    		if(relashFields.indexOf(field)>-1)return null;//or关联配置已经应用不用解析了。
    		
    		String name = field.getName();
    		if(name.startsWith("this$"))return null;//成员类JDK 自动添加的属性不处理
    		
    		if(!field.isAccessible()){
    			field.setAccessible(true);
    		}
    		
    		Object fieldValue = field.get(condition);
    		OrderBy orderBy = field.getAnnotation(OrderBy.class);
    		if(orderBy != null){
    			if(!orderBy.name().equals("")){
    				name = orderBy.name();
    			}
    			
    			criteria.addOrder(fieldValue == null ? Order.desc(name):Order.asc(name));
//    			criteria.addOrder(orderBy.value().toLowerCase().equals("desc") //
//        				?Order.desc(name)
//        				:Order.asc(name));
    		}
    		
    		if(fieldValue == null)return null;
    		
    		EliminateCompare eCompare = field.getAnnotation(EliminateCompare.class);
    		if (eCompare !=null && eCompare.isEliminateCompare()){
    			//("当前字段不参与比较..."+name);
    			return null;
    		}
    		
    		Comp comp = field.getAnnotation(Comp.class);
    		if(comp == null){
    			//默认 进行=比较
    			return Collections.singletonMap((Criterion)Restrictions.eq(name, fieldValue) ,criteria);
    		}
    		
			Class paramCls = fieldValue.getClass();
			boolean isArrayParam = paramCls.isArray();
			boolean isCollectionParam = Collection.class.isAssignableFrom(paramCls); 
			paramCls = isArrayParam ? Object[].class
					: isCollectionParam ? Collection.class
									: Object.class;
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
			
			int findEndIndex = -1;
			boolean isRelashipQueryParam = false;
			DetachedCriteria oldCriteria = criteria;
			while((findEndIndex = name.indexOf("."))!=-1){
				isRelashipQueryParam = true;
				String relashipName = name.substring(0, findEndIndex);
				criteria = criteria.createCriteria(relashipName);
				name = name.substring(findEndIndex+1);
			}
			
			Criterion criterion = null;
			Object val = null; 
			if(comp.value().equalsIgnoreCase("in")&& (isArrayParam||isCollectionParam)&& (val = getSingleInValue(fieldValue,isArrayParam,isCollectionParam))!=null){//特殊优化 in 一个值
				criterion = Restrictions.eq(name, val);
			}else{
				criterion = (Criterion)Restrictions.class.getMethod(comp.value(),String.class,paramCls)
				.invoke(null, name , fieldValue);
			}
			
			if(comp.isNot()){
				criterion = Restrictions.not(criterion);
			}
			
			if(!comp.isOr()){
    			return Collections.singletonMap(criterion ,criteria);
			}
			if(comp.relashipField()==null){
				System.err.println("or 关系,relashipField为空！跳过or配置。。");
				return Collections.singletonMap(criterion ,criteria);
			}
			Field relashipField = condition.getClass().getDeclaredField(comp.relashipField());
			relashFields.add(field);
			Map<Criterion, DetachedCriteria> relashipCraterion = parseAnnotion2Craterion(condition,condition.getClass().getDeclaredField(comp.relashipField()),oldCriteria,relashFields);
			
			//没找到关联的就直接返回本身
			if(relashipCraterion==null)return Collections.singletonMap(criterion ,criteria);
			
			Entry<Criterion, DetachedCriteria> relashipCraterionAndCriteria = relashipCraterion.entrySet().iterator().next();
			if(relashipCraterionAndCriteria.getValue() == criteria){//同一个实体的条件。
				relashFields.add(relashipField);
				return Collections.singletonMap((Criterion)Restrictions.or(criterion, relashipCraterionAndCriteria.getKey()) ,criteria);
			}
			//不是同一实体就 and 起来
			System.err.println(" or 关系的不是同一张表，暂不支持进行OR!");
			HashMap<Criterion, DetachedCriteria> result = new HashMap<Criterion, DetachedCriteria>();
			result.put(criterion, criteria);
			result.put(relashipCraterionAndCriteria.getKey(), relashipCraterionAndCriteria.getValue());
			return result;
    	} catch (IllegalAccessException e) {
			throw new DaoException("BaseDao.initObj2Criteria(Object,Criteria)执行条件处理出错！错误的访问！",e);
    	} catch (InvocationTargetException e) {
			throw new DaoException("BaseDao.initObj2Criteria(Object,Criteria)执行条件处理出错！调用错误！",e);
		} catch (NoSuchMethodException e) {
			throw new DaoException("BaseDao.initObj2Criteria(Object,Criteria)执行条件处理出错！没有方法！",e);
		} catch (SecurityException e) {
			throw new DaoException("BaseDao.initObj2Criteria(Object,Criteria)执行条件处理出错！安全策略不允许！",e);
		} catch (NoSuchFieldException e) {
			throw new DaoException("BaseDao.initObj2Criteria(Object,Criteria)执行条件处理出错！没有声明成员！",e);
		}
    }

	private Object getSingleInValue(Object arrayOrCollection, boolean isArrayParam, boolean isCollectionParam) {
		if(arrayOrCollection==null)
			return null;
		Collection<Object> collection = null;
		if(isArrayParam && ((Object[]) arrayOrCollection).length==1){
			return Array.get(arrayOrCollection, 0);
		}else if( isCollectionParam && (collection = (Collection<Object>)arrayOrCollection).size()==1 ){
			return ((Collection<Object>)arrayOrCollection).iterator().next();
		}
		return null;
	}
}  
