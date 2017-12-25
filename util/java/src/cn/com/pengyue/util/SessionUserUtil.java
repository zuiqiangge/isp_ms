package cn.com.pengyue.util;

import java.util.HashMap;
import java.util.Map;
/***
 * 该类用来绑定用户和会话session
 * @author Administrator
 *
 */
public class SessionUserUtil {
	//绑定的容器
	public static Map<String,String> map = new HashMap<String,String>();
	
	//绑定方法
	public static void bind(String sesssionId,String userName){
		map.put(userName, sesssionId);
		System.out.println("绑定"+userName+":"+sesssionId);
	}

	
	//查看是否绑定用户
	public static boolean isBind(String userName){
		return map.containsKey(userName);
	}
	
	
	//解绑方法
	public static void unBind(String userName){
		map.remove(userName);
	}
	
	
	//查看当前已登陆用户是否绑定的是当前会话
	public static boolean isBinding(String userName,String sessionId){
		return sessionId.equals(map.get(userName))?true:false;
	}

	
}
