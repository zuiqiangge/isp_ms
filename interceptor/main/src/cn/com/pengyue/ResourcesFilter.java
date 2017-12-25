package cn.com.pengyue;

import java.io.IOException;

import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;

import cn.com.pengyue.pojo.ResourceRelaship;
import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.service.IResourceRelashipService;
import cn.com.pengyue.service.IResourceService;
import cn.com.pengyue.service.impl.ResourceRelashipService;
import cn.com.pengyue.service.impl.ResourceService;
import cn.com.pengyue.util.AccessConstants;

@Controller
public class ResourcesFilter implements Filter, AccessConstants {
	// @javax.annotation.Resource(name="resourceService")
	private IResourceService resourceService;
	// @javax.annotation.Resource(name="resourceRelashipService")
	private IResourceRelashipService resourceRelashipService;

	public IResourceService getResourceService() {
		return resourceService;
	}

	public void setResourceService(IResourceService resourceService) {
		this.resourceService = resourceService;
	}

	public IResourceRelashipService getResourceRelashipService() {
		return resourceRelashipService;
	}

	public void setResourceRelashipService(
			IResourceRelashipService resourceRelashipService) {
		this.resourceRelashipService = resourceRelashipService;
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;

		HttpServletResponse res = (HttpServletResponse) response;
		String currentURL = req.getRequestURI();
		String targetURL = currentURL.substring(currentURL.indexOf("/", 1),
				currentURL.length());
		HttpSession session = req.getSession(true);
		// 获取登陆用户
		Users loginUser = (Users) session
				.getAttribute(SESSION_NAME_LOGINED_USER);

		// 查看拦截*.do请求是否是资源表里的数据
		cn.com.pengyue.pojo.Resource resource = new cn.com.pengyue.pojo.Resource();
		resource.setUrl(targetURL.substring(1));
		List<cn.com.pengyue.pojo.Resource> list = resourceService
				.getListByCondition(resource);

		// 是需要拦截的资源
		if (list.size() > 0) {
			//管理员角色
			if(loginUser.getRole()==1){
		        	chain.doFilter(request, response);
		    }else{
				// 检查该用户是否有此权限
				ResourceRelaship relaship = new ResourceRelaship();
				relaship.setTargetId(loginUser.getRole());// 条件:当前用户的角色id
				relaship.setResourceId(list.get(0).getId());// 条件:当前请求的url
				List<ResourceRelaship> relaships = resourceRelashipService
						.findListByProperty(relaship);
				// 当前用户的该权限在表中有记录,代表没有越权
				if (relaships.size() > 0) {
					chain.doFilter(request, response);
					// 已经越权
				} else {
					res.sendRedirect("error.html");
					res.setCharacterEncoding("utf-8");
					chain.doFilter(request, response);
				}
		    }
			// 不需要拦截的请求
		} else {
			chain.doFilter(request, response);
		}

	}

	@Override
	public void destroy() {

	}

}
