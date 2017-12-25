package cn.com.pengyue.util;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.Arrays;
import java.util.Hashtable;
import java.util.Map;

public final class Delegate implements InvocationHandler{
	
	private Object[] args;
	private Object realObj;
	private String delegateMethodName;
	private String realMethodName;
	private Class<?> delegateInterface;
	private Class<?> realClass;
	private Map<Method,Method> methodMap;
	private Method[] realMethods;
	private boolean appendArgs;
	private Class[] argsTypes;
	private Method[] realAllMethods; 
	private Delegate(Object[] args, Object realObj, String delegateMethodName,
			String realMethodName, Class<?> delegateInterface,
			Class<?> realClass) {
		super();
		this.args = args;
		this.realObj = realObj;
		this.delegateMethodName = delegateMethodName;
		this.realMethodName = realMethodName;
		this.delegateInterface = delegateInterface;
		this.realClass = realClass;
		this.methodMap = new Hashtable<Method, Method>();
	}
	
	public static <T> T $(Object hasMethodObj,String methodName,String delegateMethodName,Class<T> cls,Object... args){
		Delegate h = new Delegate(args,hasMethodObj,delegateMethodName,methodName,cls,hasMethodObj.getClass());
		if(delegateMethodName==null){
			Method[] ms = h.delegateInterface.getDeclaredMethods();
			if(ms.length==1){
				h.delegateMethodName = ms[0].getName();
			}
		}
		if(args!=null && args.length> 0){
			h.appendArgs = true;
			if(methodName==null){
				h.argsTypes = new Class[args.length];
				for (int i = 0; i < args.length; i++) {
					h.argsTypes[i] = args[i].getClass();
				}
			}
		}
		return (T)Proxy.newProxyInstance(h.realClass.getClassLoader(), new Class[]{cls}, h);
	}
	
	public static <T> T $(Object hasMethodObj,String methodName,Class<T> cls,Object... args){
		return $(hasMethodObj, methodName, null ,cls,args);
	}
	
	public static <T> T $(Object hasMethodObj,Class<T> cls,Object... args){
		return $(hasMethodObj, null,null ,cls, args);
	}


	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {
		//不是接口定义的方法 代理处理类执行。
		if(!method.getDeclaringClass().equals(this.delegateInterface)){
			return method.invoke(this, args);
		}
		args = magreArgs(args);
		Class<?>[] parameterTypes = magreParamterTypes(method.getParameterTypes());
		Method realMethod = method;
		if(delegateMethodName!=null && !method.getName().equals(delegateMethodName)){//不是要进行委托
			return returnDefaultVal(method);
		}
		//没说明 委托到接口的什么方法 则从调用者参试寻找符合接口参数和返回值定义的方法
		//存的搜索结果里找下，找到用存好的。
		realMethod = methodMap.get(method);
		if(realMethod==null){
			realMethod = searchMethodByParams(parameterTypes);
			if(realMethod==null){
				return returnDefaultVal(method);
			}
			method.setAccessible(true);
			//缓存下来
			methodMap.put(method, realMethod);
		}
		args = checkArgs(args, realMethod.getParameterTypes(),method);
		return realMethod.invoke(realObj, args);
	}
	
	//检测 参数数量， 不够用默认值补齐,多了截断参数
	private Object[] checkArgs(Object[] args, Class<?>[] parameterTypes,Method method) {
		if(parameterTypes.length!=args.length){
			Object[] newArgs = new Object[parameterTypes.length];
			System.arraycopy(args, 0, newArgs, 0, args.length);
			for (int i = args.length; i < newArgs.length; i++) {
				if(i==args.length && parameterTypes[i].equals(Method.class)){
					newArgs[i] = method;
				}else{
					newArgs[i] = returnDefaultVal(parameterTypes[i]);
				}
			}
			args=newArgs;
		}
		return args;
	}


	private Object returnDefaultVal(Class<?> returnType) {
		//默认返回 
		if(returnType.isPrimitive() && !returnType.equals(Void.TYPE)){
			if(returnType.equals(boolean.class)){
				return false;
			}
			return 0;
		}
		return null;
	}
	
	private Object returnDefaultVal(Method method) {
		return returnDefaultVal(method.getReturnType());
	}

	private Method searchMethodByParams(Class<?>[] parameterTypes) {
		boolean useNameSearch = false;
		if(this.realMethodName!=null){
			//优先搜索 自己类定义的 再搜索继承的
			try {
				return realClass.getDeclaredMethod(this.realMethodName, parameterTypes);
			} catch (SecurityException e) {} catch (NoSuchMethodException e) {}
			try {
				return realClass.getMethod(this.realMethodName, parameterTypes);
			} catch (SecurityException e) {} catch (NoSuchMethodException e) {}
			useNameSearch = true;
		}
		if(this.realMethods==null){
			this.realMethods = realClass.getDeclaredMethods();
		}
		for (Method realMethod : realMethods) {
			if(useNameSearch){
				if(realMethod.getName().equals(realMethodName)){
					return realMethod;
				}
			}else if(isFirstSubArray(parameterTypes, realMethod.getParameterTypes())
					|| isFirstSubArray(parameterTypes, realMethod.getParameterTypes())
//				&& Modifier.isPublic(realMethod.getModifiers())
			){
				return realMethod;
			}
		}
		//名称搜索 扩大范围
		if(useNameSearch){
			if(this.realAllMethods== null){
				this.realAllMethods = realClass.getSuperclass().getMethods();
			}
			for (Method realMethod : realAllMethods) {
				if(realMethod!=null && realMethod.getName().equals(realMethodName)){
					return realMethod;
				}
			}
		}
		return null;
	}

	//特殊比较方法， 以第二参数 @param{ realParameterTypes } 只要第一参数是其中的前一段 完全匹配就认为一样的
	private static boolean isFirstSubArray(Class[] methodParameterTypes, Class[] realParameterTypes) {
        if (methodParameterTypes==realParameterTypes)
            return true;

        int length = methodParameterTypes.length;
        if(realParameterTypes.length<length)return false;
        
        for (int i=0; i<length; i++) {
        	Class p1 = methodParameterTypes[i];
        	Class p2 = realParameterTypes[i];
            if (!(p1==null ? p2==null : p1.equals(p2)))
                return false;
        }

        return true;
    }

	private Object[] magreArgs(Object[] args) {
		if(this.appendArgs){
			if(args==null || args.length==0){
				args = this.args;
			}else{
				Object[] newArgs = new Object[args.length+this.args.length];
				System.arraycopy(args, 0, newArgs, 0, args.length);
				System.arraycopy(this.args, 0, newArgs, args.length, this.args.length);
				args = newArgs;
			}
		}
		return args;
	}
	
	private Class<?>[] magreParamterTypes(Class<?>[] parameterTypes) {
		if(this.argsTypes!=null && this.argsTypes.length>0){
			if(parameterTypes==null || parameterTypes.length==0){
				parameterTypes = this.argsTypes;
			}else{
				Class<?>[] newTypes = new Class[parameterTypes.length+this.argsTypes.length];
				System.arraycopy(parameterTypes, 0, newTypes, 0, parameterTypes.length);
				System.arraycopy(this.argsTypes, 0, newTypes, parameterTypes.length, this.argsTypes.length);
				parameterTypes = newTypes;
			}
		}
		return parameterTypes;
	}
	
	
	@Override
	public String toString() {
		return "[委托]"+(delegateMethodName==null?"自动匹配":delegateMethodName)+" 实现："+ this.realObj.toString();
	}
}
