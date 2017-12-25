package cn.com.pengyue.web.action;

import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;


import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.pengyue.pojo.Users;
import cn.com.pengyue.pojo.stock;
import cn.com.pengyue.service.IStockService;
import cn.com.pengyue.service.IUsersService;
import cn.com.pengyue.util.AccessConstants;

import com.alibaba.druid.util.StringUtils;



@Controller
public class StockController {
	@javax.annotation.Resource
	private IStockService stockService;
	@javax.annotation.Resource
	private IUsersService userService;
	
	@RequestMapping("/listAllStock")
	public String listAll(Model model){
		model.addAttribute("list", stockService.listAll());
		model.addAttribute("user", userService.listAll());
		return "listAllStock";
	}
	
	@RequestMapping("/listAllStockByOrder")
	public String listAllStockByOrder(Model model,HttpServletRequest request) throws ParseException{
		stock stcok1=new stock();
		if(null!=request.getParameter("type")){
			String contactUnit = request.getParameter("contactUnit");
			String user=request.getParameter("userid");
			if(null!=user&&!(StringUtils.isEmpty(user))){
				int userId=Integer.parseInt(user);
				stcok1.setUserId(userId);
			}
			String types=request.getParameter("type");
			if(null!=types&&!(StringUtils.isEmpty(types))){
				int type=Integer.parseInt(types);
				stcok1.setType(type);
			}
			
			String dates=request.getParameter("stockDates");
			if(dates!=null&&!(StringUtils.isEmpty(dates))){
			
				SimpleDateFormat formatter=new SimpleDateFormat("yyyy/MM/dd");  
				Date stockDate=formatter.parse(dates);
				
				stcok1.setStockDate(stockDate);
			}
			
			String batchs=request.getParameter("batch");
			if(batchs!=null&&!(StringUtils.isEmpty(batchs))){
				int batch=Integer.parseInt(batchs);
				stcok1.setBatch(batch);
			}
			
			if(contactUnit!=null&&!(StringUtils.isEmpty(contactUnit))){
				stcok1.setContactUnit(contactUnit);
			}
		}
		
	
		model.addAttribute("list", stockService.listAllStockByOrder(stcok1));
		model.addAttribute("user", userService.listAll());
		return "listAllStock";
	}
	//入库
	@RequestMapping("/addStock")
	public String addStock(stock pojo){
		stockService.save(pojo);
		return "listAllStock";
	}
	
	@RequestMapping("/ajaxAddStock")
	@ResponseBody
	public Object ajaxAddRole(stock pojo){
		stockService.save(pojo);
		return pojo;
	}
	@RequestMapping("/getStockById")
	public String getRoleById(Integer id,Model model){
		model.addAttribute("pojo", stockService.get(id));
		return "getStockById";
	}
	
	@RequestMapping("/updateStock")
	public String updateRole(stock pojo){
		stockService.update(pojo);
		return "updateStock";
	}
	
	
	@RequestMapping("/removeStock")
	public String removeRole(Integer[] id){
		stockService.delete(Arrays.asList(id));
		return "removeStock";
	}
	
	
	@RequestMapping("/ajaxGetStockById")
	@ResponseBody
	public Object ajaxGetRoleById(Integer id,Model model){
		return stockService.get(id);
	}
	
	@RequestMapping("/ajaxUpdateStock")
	@ResponseBody
	public Object ajaxUpdateRole(stock pojo){
		stockService.update(pojo);
		return pojo;
	}
	

	@RequestMapping("/ajaxRemoveStock")
	@ResponseBody
	public Object ajaxRemoveRole(Integer[] id){
		stockService.delete(Arrays.asList(id));
		return Arrays.asList(id);
	}
	//剪贴板
    public static void main(String[] args) {
    	StringSelection stringSelection = new StringSelection("ljlkjl");
		  // 系统剪贴板
		  Clipboard  clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
		  clipboard.setContents(stringSelection, null);
		  

		  
	} 
}
