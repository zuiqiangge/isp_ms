package cn.com.pengyue;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

public class LockUser {
	private Map<String,User> users = new HashMap<String,User>();
	
	
	
	public void getFailed(String userName){
		if(null==users.get(userName)){
			User user = new User();
			user.setName(userName);
			user.setCountFiald(1);
			users.put(userName,user);
		}else{
			User user = users.get(userName);
			user.setCountFiald(user.getCountFiald()+1);
			if(user.getCountFiald()==3){
				user.setLock(true);
				user.setLockTime(600000);
				new Thread(new MyTask(user,this)).start();
				
				
			}
		}
			
	}
	

	public User isLock(String userName){
		if(null!=users.get(userName)){
			User user = users.get(userName);
			if(user.isLock()){
				return user;
			}
		}
		return null;
	}



	





	public Map<String, User> getUsers() {
		return users;
	}












	public void setUsers(Map<String, User> users) {
		this.users = users;
	}


}
class MyTask implements Runnable{
	private User user;
	private LockUser lockUser;
	
	public MyTask(User user,LockUser lockUser) {
		super();
		this.user = user;
		this.lockUser=lockUser;
	}


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}


	
	public LockUser getLockUser() {
		return lockUser;
	}


	public void setLockUser(LockUser lockUser) {
		this.lockUser = lockUser;
	}


	@Override
	public void run() {
		while(true){
			try {
				Thread.sleep(1000);
				user.setLockTime(user.getLockTime()-1000);
				if(user.getLockTime()==0){
					user.setLock(false);
					user.setCountFiald(0);
					lockUser.getUsers().remove(user.getName());
					break;
				}
					
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
	
}
	
	
	
