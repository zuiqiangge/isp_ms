package cn.com.pengyue;

import java.io.IOException;
import java.util.Enumeration;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import cn.com.pengyue.pojo.Ip;
import cn.com.pengyue.service.IIpService;
@Repository
public class MyInterceptor implements HandlerInterceptor{
	@Resource
	private IIpService ipService;
	private boolean flag=true;
	
	 public IIpService getIpService() {
		return ipService;
	}

	public void setIpService(IIpService ipService) {
		this.ipService = ipService;
	}

	@Override
	    public boolean preHandle(HttpServletRequest request,
	            HttpServletResponse response, Object handler) throws Exception {
		 Enumeration params = request.getParameterNames();
	        String sql = "";
	        while (params.hasMoreElements()) {
	            //得到参数名
	            String name = params.nextElement().toString();
	            String[] value = request.getParameterValues(name);
	            for (int i = 0; i < value.length; i++) {
	                sql = sql + value[i];
	            }
	        }
	      
	      
	      if (sqlValidate(sql)) {
	    	  flag=false;
	    	  //request.getRequestDispatcher("login.jsp").forward(request, response);
	      }else{
	    	  flag=true;
	    	 
	      } 
	      
	        return true;
	    }
	    
	//效验
	    protected static boolean sqlValidate(String str) {
	        str = str.toLowerCase();//统一转为小写
	        String badStr = "'|and|exec|execute|insert|select|delete|update|count|drop|*|%|chr|mid|master|truncate|" +
	                "char|declare|sitename|net user|xp_cmdshell|;|or|-|+|,|like'|and|exec|execute|insert|create|drop|" +
	                "table|from|grant|use|group_concat|column_name|" +
	                "information_schema.columns|table_schema|union|where|select|delete|update|order|by|count|*|" +
	                "chr|mid|master|truncate|char|declare|or|;|-|--|+|,|like|//|/|%|#";//过滤掉的sql关键字，可以手动添加
	        String[] badStrs = badStr.split("\\|");
	        for (int i = 0; i < badStrs.length; i++) {
	            if (str.indexOf(badStrs[i]) >= 0) {
	                return true;
	            }
	        }
	        return false;
	    }
	 
	 
	    @Override
	    public void postHandle(HttpServletRequest request,
	            HttpServletResponse response, Object handler,
	            ModelAndView modelAndView) throws Exception {
	 		if(!flag){
	 			 modelAndView.addObject("loginErrorMsg", "您发送请求中的参数中含有非法字符");
		    	 modelAndView.setViewName("login");
	 		}
			
	    	
	    }
	    
	    @Override
	    public void afterCompletion(HttpServletRequest request,
	            HttpServletResponse response, Object handler, Exception ex)
	            throws Exception {
	    	System.out.println("afterCompletion");
	    	
	    }

}
