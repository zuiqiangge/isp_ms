package cn.com.pengyue.util;

import java.security.MessageDigest;
import java.util.logging.Logger;

public final class Md5Utils {

	
	private static final char[] HEX_CHARS = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
	private static final String DEFAULT_MD5_APPEND_TOKEN = "www.pengyue.com.cn";


	private Md5Utils(){}
	
	public static String md5(String src){
		String result = null;
        try {
            byte[] btInput = src.getBytes();
            // 获得MD5摘要算法的 MessageDigest 对象
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            // 使用指定的字节更新摘要
            mdInst.update(btInput);
            //加上特定 标识
            mdInst.update(DEFAULT_MD5_APPEND_TOKEN.getBytes());
            // 获得密文
            byte[] md = mdInst.digest();
            // 把密文转换成十六进制的字符串形式
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = HEX_CHARS[byte0 >>> 4 & 0xf];
                str[k++] = HEX_CHARS[byte0 & 0xf];
            }
            return new String(str);
        } catch (Exception e) {
        	Logger.getAnonymousLogger().warning("md5处理失败！！");
        }
		return result;
	}
	
	public static final String PWD_123456 = md5("123456");//684562E2B674B37D952BB442CB22B96F
	public static final String PWD_000000 = md5("000000");//322F47416BAC2BD7F8FECAE414A5C939
	public static void main(String[] args) {
		System.out.println(md5("admin123"));
	}
}
