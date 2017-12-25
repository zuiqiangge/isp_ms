package cn.com.pengyue.util;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;

/***
 * 改类用来维护类中的集合,每个元素添加到其中,规定时间后删除
 * @author Administrator
 *
 */
public class SetUtil {
	private static Set<String> set = new HashSet<String>();
	static Timer timer;
	
	/***
	 * 添加元素
	 * @param str
	 */
	public static void add(final String str){
		set.add(str);
		System.out.println(new Date().toLocaleString()+"注入"+str);
		timer = new Timer();
		timer.schedule(new TimerTask() {
			@Override
			public void run() {
				set.remove(str);
				System.out.println(new Date().toLocaleString()+"清除"+str);
				timer.cancel();
			}
		}, 30000l);
	}
	
	
	/**
	 * 手动清除
	 * @param str
	 */
	public static void remove(String str){
		set.remove(str);
	}
	
	/***
	 * 是否包含
	 * @param args
	 */
	public static boolean contains(String str){
		return set.contains(str);
	}
	public static void main(String[] args) {
		
		add("aaa");
		try {
			Thread.sleep(10000l);
			
			add("bbb");
			Thread.sleep(10000l);
			
			add("ccc");
			Thread.sleep(10000l);
			add("ddd");
			Thread.sleep(10000l);
			add("eee");
			Thread.sleep(10000l);
			add("ff");
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	
	}
}
