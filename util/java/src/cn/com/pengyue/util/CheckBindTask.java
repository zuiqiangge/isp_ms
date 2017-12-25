package cn.com.pengyue.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckBindTask implements Runnable {
	private String userName;
	private HttpSession session;
	private boolean isValid;
	
	
	public boolean isValid() {
		return isValid;
	}

	public void setValid(boolean isValid) {
		this.isValid = isValid;
	}

	

	public HttpSession getSession() {
		return session;
	}

	public void setSession(HttpSession session) {
		this.session = session;
	}

	

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	
	
	public CheckBindTask(String userName,HttpSession session) {
		super();
		this.userName = userName;
		this.session = session;
	}

	@Override
	public void run() {
		while(true){
			
			
				
			try {
				//如果该session过期,则取消该用户的绑定
				session.getAttributeNames();
				Thread.sleep(1000l);
			} catch (Exception e1) {
				SessionUserUtil.unBind(userName);
				break;
				//e1.printStackTrace();
			}
			if(SessionUserUtil.isBinding(userName,session.getId())){
				
			}else{
				session.invalidate();
				System.out.println(session.getId()+"已经被注销");
				//SessionUserUtil.unBind(userName);
				isValid=true;
				break;
			}
		}
	}

}
