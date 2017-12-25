package cn.com.pengyue.web;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginFilter implements Filter {
	
	private static final String DEFAULT_SESSION_ATTR_NAME = "loginUser";
	private static final String DEFAULT_LOGIN_URL = "login.html";
	private static final String DEFAULT_LOGIN_PATTERN = "login\\.((html)|(jsp))";
	private Pattern toLoginNeedUrlPattern ;
	private String loginUrl ;
	private String sessionAttrName;
	private String loginQueryString;
	private ServletContext servletContext;
	private boolean logPath;
	
	public void init(FilterConfig config) throws ServletException {
		this.servletContext = config.getServletContext();
		String p = config.getInitParameter("toLoginNeedUrlPattern");
		if(p==null){
			p = DEFAULT_LOGIN_PATTERN;
		}
		toLoginNeedUrlPattern = Pattern.compile(p);
		
		p = config.getInitParameter("loginUrl");
		if(p==null){
			p = DEFAULT_LOGIN_URL;
		}
		loginUrl = p;
		
		p = config.getInitParameter("sessionAttrName");
		if(p==null){
			p = DEFAULT_SESSION_ATTR_NAME;
		}
		sessionAttrName = p;
		
		loginQueryString = config.getInitParameter("loginQueryString");
		
		this.logPath = config.getInitParameter("logPath")!=null;
	}

	public void doFilter(ServletRequest sreq, ServletResponse sresp,
			FilterChain fc) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) sreq;
		String basePath = req.getContextPath();
		if(basePath==null || basePath.trim().length()==0){
			basePath = "/";
		}else{
			basePath += "/";
		}
		req.setAttribute("basePath", basePath);
		basePath = req.getServletPath();
		if(basePath.trim().length()==0){
			basePath = "/";
		}
		String path = basePath.substring(1);
		if(logPath){
			servletContext.log(path);
		}
		if(toLoginNeedUrlPattern.matcher(path).find()
				&& (loginQueryString == null ||
						( req.getQueryString() != null && loginQueryString.equals(req.getQueryString())) 
					)) {
			fc.doFilter(sreq, sresp); 
			return;
		}
		Object loginInfo  = req.getSession().getAttribute(sessionAttrName);
		if(loginInfo==null){
			((HttpServletResponse)sresp).sendRedirect(loginUrl);
			return;
		}
		fc.doFilter(sreq, sresp);
	}
	
	public void destroy() {

	}
}
