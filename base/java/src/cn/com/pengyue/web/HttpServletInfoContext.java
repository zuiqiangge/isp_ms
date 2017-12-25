package cn.com.pengyue.web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class HttpServletInfoContext implements Filter {

	private static ThreadLocal<String> ip = new ThreadLocal<String>();
	private static String appDir;

	public void init(FilterConfig config) throws ServletException {
		appDir = config.getServletContext().getRealPath("");
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		if (request instanceof HttpServletRequest) {
			HttpServletRequest req = (HttpServletRequest) request;
			ip.set(getReqIp(req));
		}
		chain.doFilter(request, response);
	}

	private String getReqIp(HttpServletRequest request) {
		//如果是使用负载均衡软件 则要用下面的代码得到真实ip
//		String ip = request.getHeader("X-Forwarded-For");
//		if (ip != null && !ip.trim().isEmpty()
//				&& !"unKnown".equalsIgnoreCase(ip)) {
//			// 多次反向代理后会有多个ip值，第一个ip才是真实ip
//			int index = ip.indexOf(",");
//			if (index != -1) {
//				return ip.substring(0, index);
//			} else {
//				return ip;
//			}
//		}
//		ip = request.getHeader("X-Real-IP");
//		if (ip != null && !ip.trim().isEmpty()
//				&& !"unKnown".equalsIgnoreCase(ip)) {
//			return ip;
//		}
		return request.getRemoteAddr();
	}

	public static String getIp() {
		return ip.get();
	}

	public static String getAppDir() {
		return appDir;
	}

	public void destroy() {
	}
}
