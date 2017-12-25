package cn.com.pengyue.util;

import java.util.ArrayList;
import java.util.List;

public final class ObjArrayListUtils {
	private ObjArrayListUtils(){}	
	
	@SuppressWarnings("unchecked")
	public static <T> List<T> exportItemOfClass(List data,Class<T> cls){
		int index = -1;
		List<T> result = new ArrayList<T>();
		for (Object obj : data) {
			if(obj==null){continue;}
			Object[] objects = null;
			if(obj instanceof Object[]){
				objects = (Object[])obj;
			}else if(cls.isInstance(obj)){
				result.add((T)cls);
			}else{
				break;
			}
			if(index != -1 ){
				result.add((T)objects[index]);
			}
			for (int i = 0; i < objects.length; i++) {
				if(objects[i]!=null && cls.isInstance(objects[i])){
					index = i;
					result.add((T)objects[index]);
					break;
				}
			}
		}
		return result;
	}
}
