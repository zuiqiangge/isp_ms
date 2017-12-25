package cn.com.pengyue.dao.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Comp {
	String value();//比较符
	String propertyName() default "";//属性名
	boolean prefix() default false; // 前匹配标志
	boolean full() default false;  // 全匹配标志
	boolean isOr() default false;
	String relashipField() default "";
	boolean isNot() default false;//是否取反
}
