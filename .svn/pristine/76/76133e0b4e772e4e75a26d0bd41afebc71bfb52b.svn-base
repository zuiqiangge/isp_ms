package cn.com.pengyue.test.dao;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * <b>Summary: </b> TODO Junit 基础类,加载环境 <b>Remarks: </b> TODO DAO测试基础类
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public abstract class BaseTest extends AbstractTransactionalJUnit4SpringContextTests {
	/**
	 * <b>Summary: </b> 复写方法 setDataSource
	 * 
	 * @param dataSource
	 * @see org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests#setDataSource(javax.sql.DataSource)
	 */
	@Override
	@Resource(name = "dataSource")
	public void setDataSource(DataSource dataSource) {
		super.setDataSource(dataSource);
	}
	
	/**
	 * 测试方法代码  例子
	 */
	
//	@Autowired  
//    private UserDao userDao;  
//    @Test  
//    public void testUserDao() {  
//        User user = new User();  
//        user.setPassword("123456");  
//        user.setName("大妈");  
//        user.setSex(1);  
//        //System.out.println(userDao.findOnValidate(user).getMark());  
//        List<User> list = userDao.getAll();  
//        System.out.println(list);  
//        //System.out.println(userDao.findOneByName("张三s"));  
//        //System.out.println(userDao.addUser(user));  
//    }  
}
