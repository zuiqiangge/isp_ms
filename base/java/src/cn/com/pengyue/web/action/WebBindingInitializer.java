package cn.com.pengyue.web.action;

import java.beans.PropertyEditor;
import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Date;

import javax.print.attribute.standard.Fidelity;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.Version;
import org.codehaus.jackson.annotate.JsonIgnoreType;
import org.codehaus.jackson.map.BeanDescription;
import org.codehaus.jackson.map.BeanProperty;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.map.SerializerFactory;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.TypeSerializer;
import org.codehaus.jackson.map.module.SimpleModule;
import org.codehaus.jackson.map.module.SimpleSerializers;
import org.codehaus.jackson.map.ser.BeanSerializer;
import org.codehaus.jackson.map.ser.CustomSerializerFactory;
import org.codehaus.jackson.map.ser.std.NullSerializer;
import org.codehaus.jackson.map.ser.std.SerializerBase;
import org.codehaus.jackson.map.ser.std.StdArraySerializers;
import org.codehaus.jackson.map.ser.std.StdArraySerializers.ArraySerializerBase;
import org.codehaus.jackson.map.type.ArrayType;
import org.codehaus.jackson.map.type.CollectionLikeType;
import org.codehaus.jackson.map.type.CollectionType;
import org.codehaus.jackson.map.type.MapLikeType;
import org.codehaus.jackson.map.type.MapType;
import org.codehaus.jackson.type.JavaType;
import org.hibernate.Hibernate;
import org.hibernate.collection.PersistentCollection;
import org.hibernate.proxy.HibernateProxy;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJacksonHttpMessageConverter;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.HandlerAdapter;

import com.cedarsoft.serialization.jackson.ListSerializer;

@JsonIgnoreType(true)
public class WebBindingInitializer extends PropertyEditorSupport implements org.springframework.web.bind.support.WebBindingInitializer,InitializingBean,ApplicationContextAware {
	
	private PropertyEditor[] propertyEditors;
	private ApplicationContext applicationContext;
	
	public WebBindingInitializer(PropertyEditor[] propertyEditors) {
		this.propertyEditors = propertyEditors;
	} 


	@SuppressWarnings("unchecked")
	public void initBinder(WebDataBinder binder, WebRequest webrequest) {
		binder.registerCustomEditor(Date.class, this);
	}  
	
	@Override
	public void setAsText(String text) throws IllegalArgumentException {
		IllegalArgumentException lastException = null;
		for (PropertyEditor propertyEditor : this.propertyEditors) {
			try {
				propertyEditor.setAsText(text);
				setValue(propertyEditor.getValue());
				return;
			} catch (IllegalArgumentException e) {
				lastException = e;
			}
		}
		throw lastException;
	}
	
	@Override
	public String getAsText() {
		for (PropertyEditor propertyEditor : this.propertyEditors) {
			try {
				return propertyEditor.getAsText();
			} catch (IllegalArgumentException e) {}
		}
		return "";
	}
	
	private static class  HibernateLazyloadSerializer<T> extends SerializerBase<T> {
		private JsonSerializer loadedDataSerializer;
		private JsonSerializer noloadSerializer;
		public HibernateLazyloadSerializer(Class<T> cls,JsonSerializer<?> loadedDataSerializer,JsonSerializer<?> noloadSerializer) {
			super(cls);
			this.loadedDataSerializer=loadedDataSerializer;
			this.noloadSerializer = noloadSerializer;
		}
		public void serialize(T bean, JsonGenerator jgen,
				SerializerProvider provider) throws IOException,
				JsonGenerationException {
			if(Hibernate.isInitialized(bean)){
				if(loadedDataSerializer == null ){
					if(this._handledType == HibernateProxy.class){
						BeanSerializer.createDummy(bean.getClass()).serialize(bean, jgen, provider);
					}else{
						provider.findValueSerializer(bean.getClass(), null).serialize(bean, jgen, provider);
					}
				} else{
					loadedDataSerializer.serialize(bean, jgen, provider);
				}
			}else{
				noloadSerializer.serialize(bean, jgen, provider);
			}
		}
	}
	
	public void afterPropertiesSet() throws Exception {
		try {
			HandlerAdapter handlerAdapter = this.applicationContext.getBeansOfType(HandlerAdapter.class).values().iterator().next();
			Method method = handlerAdapter.getClass().getMethod("setWebBindingInitializer", org.springframework.web.bind.support.WebBindingInitializer.class);
			method.invoke(handlerAdapter, this);
			try {
				Method getMessageConvertersMethod = handlerAdapter.getClass().getMethod("getMessageConverters");
				HttpMessageConverter[] messageConverters =(HttpMessageConverter[])getMessageConvertersMethod.invoke(handlerAdapter);
				for (HttpMessageConverter httpMessageConverter : messageConverters) {
					if (httpMessageConverter instanceof StringHttpMessageConverter ) {
						StringHttpMessageConverter stringConverter = (StringHttpMessageConverter) httpMessageConverter;
						stringConverter.setSupportedMediaTypes(Arrays.asList(MediaType.parseMediaType("text/plain;charset=UTF-8"),MediaType.parseMediaType("*/*")));
					}else if(httpMessageConverter instanceof MappingJacksonHttpMessageConverter){
						MappingJacksonHttpMessageConverter jsonConverter = (MappingJacksonHttpMessageConverter) httpMessageConverter;
						Field objectMapperField = jsonConverter.getClass().getDeclaredField("objectMapper");objectMapperField.setAccessible(true);
						ObjectMapper objectMapper = (ObjectMapper)objectMapperField.get(jsonConverter);
						objectMapper.setSerializerFactory(new CustomSerializerFactory(){
							@Override
							public JsonSerializer<Object> createSerializer(
									SerializationConfig config, JavaType type,
									BeanProperty property)
									throws JsonMappingException {
								JsonSerializer<Object> result = super.createSerializer(config, type, property);
								if(HibernateProxy.class.isAssignableFrom(type.getRawClass())){
									return new HibernateLazyloadSerializer(HibernateProxy.class,result,NullSerializer.instance);
								}else 
								if(PersistentCollection.class.isAssignableFrom(type.getRawClass())){
									return new HibernateLazyloadSerializer(PersistentCollection.class,result,NullSerializer.instance);
								}
								return result;
							}
						});
					}
				}
			} catch (Exception e) {
				System.out.println("设置返回文本默认utf-8编码失败！！");
			}
		} catch (Exception e) {
			System.out.println("注入日期转化器失败！！");
		}
	}

	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		this.applicationContext = applicationContext;
	}
}
