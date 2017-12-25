package cn.com.pengyue.test.dao;

import java.io.IOException;
import java.util.ArrayList;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.Version;
import org.codehaus.jackson.map.BeanDescription;
import org.codehaus.jackson.map.BeanProperty;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.map.module.SimpleModule;
import org.codehaus.jackson.map.module.SimpleSerializers;
import org.codehaus.jackson.type.JavaType;
import org.hibernate.Hibernate;
import org.hibernate.collection.PersistentCollection;
import org.hibernate.proxy.HibernateProxy;
import org.hibernate.proxy.LazyInitializer;
import org.junit.Assert;
import org.junit.Test;

import com.cedarsoft.serialization.jackson.NullSerializer;
public class JacksonTest {
	private HibernateProxy test = new HibernateProxy(){
		@Override
		public LazyInitializer getHibernateLazyInitializer() {
			return null;
		}
		@Override
		public Object writeReplace() {
			return null;
		}
	};
	
	public HibernateProxy getTest() {
		return test;
	}

	public void setTest(HibernateProxy test) {
		this.test = test;
	}

	@Test
	public void testJackson() throws JsonGenerationException, JsonMappingException, IOException{
		ObjectMapper objectMapper = new ObjectMapper();
		SimpleModule hibernateModule = new SimpleModule("myHibernateModule",new Version(1,1,1,"dev"));
		hibernateModule.setSerializers(new SimpleSerializers(){
			public JsonSerializer<?> findSerializer(SerializationConfig config,
					JavaType type, BeanDescription beanDesc,
					BeanProperty property) {
				if(HibernateProxy.class.isAssignableFrom(type.getRawClass())
					|| PersistentCollection.class.isAssignableFrom(type.getRawClass())
				){
					return org.codehaus.jackson.map.ser.std.NullSerializer.instance;
				}
				return super.findSerializer(config, type, beanDesc, property);
			}
		});
		objectMapper.registerModule(hibernateModule);
		java.util.List<Object> value = new ArrayList<Object>();
		
		value.add(new JacksonTest());
		System.out.println(objectMapper.writeValueAsString(value));
		Assert.assertEquals("[{\"test\":null}]", objectMapper.writeValueAsString(value));
	}
}
