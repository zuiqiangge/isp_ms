package cn.com.pengyue.test.action;

import static org.junit.Assert.fail;

import java.util.List;

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.web.servlet.ModelAndView;

import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.util.AccessConstants;

public class ApplyControllerTest extends BaseAction {
	
	
//	@Test
//	public void testAjaxAddApply2() throws Exception {
//	   MockHttpServletRequest request = new MockHttpServletRequest();  
//        MockHttpServletResponse response = new MockHttpServletResponse();  
//        request.setServletPath("/ajaxAddApply2.do");  
//        //设置session 属性模拟登录
//        Users users = new Users();
//        users.setId(1);
//        users.setNickName("昵称");
//		request.getSession().setAttribute(AccessConstants.SESSION_NAME_LOGINED_USER, users);
//		//设置session 属性模拟登录结束。。。
//		
//		
//        request.setParameter("id", "1");
//        request.setParameter("submitUserId", "2");
//        
//        request.setMethod("post");  
//        
//         this.excuteAction(request, response);  
//	}
	

//	@Test
//	public void testAllListApply() throws Exception {
//	   MockHttpServletRequest request = new MockHttpServletRequest();  
//        MockHttpServletResponse response = new MockHttpServletResponse();  
//        request.setServletPath("/allListApply.do");  
//        request.setMethod("post");  
//        
//        final ModelAndView mav = this.excuteAction(request, response);  
//        Assert.assertEquals("allListApply", mav.getViewName());  
//        List msg=(List)mav.getModel().get("applyList");
//        Assert.assertNotNull("返回结果是空的！",msg);
//        Assert.assertTrue("返回结果是空的！",!msg.isEmpty());
//	}
//
//	@Test
//	public void testAjaxGetApplyId() throws Exception {
//		MockHttpServletRequest request = new MockHttpServletRequest();  
//        MockHttpServletResponse response = new MockHttpServletResponse();  
//        request.setServletPath("/ajaxGetApplyById.do"); 
//        request.setParameter("id", "1");
//        request.setMethod("post");  
//        final ModelAndView mav = this.excuteAction(request, response);  
//        
//         Assert.assertNull("ajax请求，结果应该为null", mav);
//         Assert.assertEquals("ajax请求，结果类型应该为json", "json/application",response.getContentType());
//	}
//
//	@Test
//	public void testAjaxAddApply() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testAjaxRemoveApply() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testAjaxUpdateApply() {
//		fail("Not yet implemented");
//	}

}
