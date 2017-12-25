import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;


public class BuildDaoAndService {
	
	@Test
	public void testbuild() throws Exception {
		main(null);
	}
	
	public static void main(String[] args) {
		String root = "userinfo/java/src";
		
		File[] pojos = new File(root+"/cn/com/pengyue/pojo/").listFiles();
		for (File pojo : pojos) {
			if(pojo.isDirectory())continue;
			String pojoName = pojo.getName().replaceFirst(".java", "");
			Map<String, String> vars = new HashMap<String, String>();
			vars.put("pojoName", pojoName);
			vars.put("pojoNameBycamelCase", pojoName.substring(0,1).toLowerCase()+pojoName.substring(1));
			
			String code = readTemp("daoTemp",vars);
			writeSrcFile(root+"/cn/com/pengyue/dao/I"+pojoName+"Dao.java", code);
			
			code = readTemp("daoImplTemp",vars);
			writeSrcFile(root+"/cn/com/pengyue/dao/impl/"+pojoName+"Dao.java", code);
			
			code = readTemp("serviceTemp",vars);
			writeSrcFile(root+"/cn/com/pengyue/service/I"+pojoName+"Service.java", code);
			
			code = readTemp("serviceImplTemp",vars);
			writeSrcFile(root+"/cn/com/pengyue/service/impl/"+pojoName+"Service.java", code);
			
			code = readTemp("controllerTemp",vars);
			writeSrcFile(root+"/cn/com/pengyue/web/action/"+pojoName+"Controller.java", code);
			
		}
	}
	
	private static String readTemp(String tempName,Map<String, String> vars) {
		Reader reader = null;
		StringBuffer sb = new StringBuffer();
		try {
			reader = new InputStreamReader(ClassLoader.getSystemResourceAsStream(tempName),"utf-8");
			int len = 0;
			char[] cs = new char[1024];
			while( (len = reader.read(cs)) !=-1 ){
				sb.append(cs, 0, len );
			}
			int fromIndex = 0;
			int startIndex = -1;
			while ((startIndex = sb.indexOf("${", fromIndex ))!= -1) {
				int endIndex = sb.delete(startIndex, startIndex+2).indexOf("}", startIndex+1);
				String key = sb.substring(startIndex, endIndex);
				String value = vars.get(key);
				sb.delete(endIndex, endIndex+1).delete(startIndex, endIndex)
				.insert(startIndex, value);
				fromIndex = startIndex + value.length()+1;
			}
			return sb.toString();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if(reader!=null){
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}


	public static void writeSrcFile(String path,String code){
		if(code==null){
			System.out.println("代码空的！不执行！");
			return;
		}
		File file = new File(path);
		if(file.exists())return;
		
		try {
			file.getParentFile().mkdirs();
			file.createNewFile();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		Writer writer = null;
		try {
			writer = new OutputStreamWriter(new FileOutputStream(file),"utf-8");
			writer.write(code);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if(writer!=null){
				try {
					writer.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
