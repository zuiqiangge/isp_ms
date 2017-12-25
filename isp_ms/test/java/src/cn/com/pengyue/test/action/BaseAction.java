package cn.com.pengyue.test.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.springframework.mock.web.MockServletContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.XmlWebApplicationContext;
import org.springframework.web.servlet.HandlerAdapter;
import org.springframework.web.servlet.HandlerExecutionChain;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter;
import org.springframework.web.servlet.mvc.annotation.DefaultAnnotationHandlerMapping;


public abstract class BaseAction {
	 private static HandlerMapping handlerMapping;  
	 private static HandlerAdapter handlerAdapter; 
	 
	 	/** 
	     * 读取配置文件 
	     */  
	    @BeforeClass  
	    public static void setUp() {  
	        if (handlerMapping == null) {  
	            String[] configs = {   
	                    "classpath:applicationContext.xml"
	            		,"classpath:spring-servlet.xml"};  
	            XmlWebApplicationContext context = new XmlWebApplicationContext();  
	            context.setConfigLocations(configs);  
	            MockServletContext msc = new MockServletContext();  
	            context.setServletContext(msc);  
	            context.refresh();  
	            msc.setAttribute(  
	                    WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE,  
	                    context);
	            handlerMapping = (HandlerMapping) context  
	                    .getBean(DefaultAnnotationHandlerMapping.class);  
	  
	            handlerAdapter = (HandlerAdapter) context  
	                    .getBean(context  
	                            .getBeanNamesForType(AnnotationMethodHandlerAdapter.class)[0]);  
	  
	            // handlerAdapter = (HandlerAdapter) context.getBean(context  
	            // .getNamespace());  
	        }  
	    }  
	  
	    /** 
	     * 执行request请求的action 
	     *  
	     * @param request 
	     * @param response 
	     * @return 
	     * @throws Exception 
	     */  
	    public ModelAndView excuteAction(HttpServletRequest request,  
	            HttpServletResponse response) throws Exception {  
	        // 这里需要声明request的实际类型，否则会报错  
//	        request.setAttribute(HandlerMapping.INTROSPECT_TYPE_LEVEL_MAPPING, true);  
	        HandlerExecutionChain chain = handlerMapping.getHandler(request);  
	        ModelAndView model = null;  
	        try {  
	        	Assert.assertNotNull("找不到 对应类和方法！！请确定要测试的Controller存在",chain);
	        		model = handlerAdapter  
	                    .handle(request, response, chain.getHandler());  
	        } catch (Exception e) {  
	            e.printStackTrace();  
	        }  
	        return model;  
	    }  
	    
	    /**
	     * action 测试代码！  例子
	     */
//	    @Autowired UserService service;  
//	    @Test  
//	    public void testUserShow() throws Exception{  
//	        MockHttpServletRequest request = new MockHttpServletRequest();  
//	        MockHttpServletResponse response = new MockHttpServletResponse();  
//	        request.setServletPath("/userManager/user.show");  
//	        request.addParameter("name", "张三");  
//	        request.addParameter("password", "123456");  
//	        request.setMethod("post");  
//	        request.setAttribute("msg", "测试action成功");  
//	        final ModelAndView mav = this.excuteAction(request, response);  
//	        Assert.assertEquals("userManager/userlist", mav.getViewName());  
//	        String msg=(String)request.getAttribute("msg");  
//	        System.out.println(msg);  
//	    }  
	    
}
