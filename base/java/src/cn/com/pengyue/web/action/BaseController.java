package cn.com.pengyue.web.action;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

import org.springframework.beans.factory.InitializingBean;

import cn.com.pengyue.service.IBaseService;

@SuppressWarnings("unchecked")
public abstract class BaseController<T, PK> 
		implements InitializingBean {

	protected IBaseService<T, PK> baseService;
	protected Class<T> entityClass;
	protected Class<PK> pkClass;
 
	public BaseController() {
		Type[] types = ((ParameterizedType) getClass().getGenericSuperclass())
				.getActualTypeArguments();
		entityClass = (Class<T>) types[0];
		pkClass = (Class<PK>) types[1];
	}



	@SuppressWarnings("unchecked")
	public void afterPropertiesSet() throws Exception {
		for (Field field : getClass().getDeclaredFields()) {
			if (IBaseService.class.isAssignableFrom(field.getType())) {
				IBaseService service = null;
				try {
					field.setAccessible(true);
					service = (IBaseService) field.get(this);
				} catch (IllegalAccessException e) {
				}
				Class serviceClass = (Class) ((ParameterizedType) Class
						.forName(service.toString().replaceFirst("@.*$", ""))
						.getGenericSuperclass()).getActualTypeArguments()[0];
				if (entityClass.equals(serviceClass)) {
					try {
						Field baseDaoField = BaseController.class
								.getDeclaredField("baseService");
						baseDaoField.setAccessible(true);
						baseDaoField.set(this, service);
					} catch (IllegalAccessException e) {
					} catch (NoSuchFieldException e) {
					}
					break;
				}
			}
		}
	}
}
