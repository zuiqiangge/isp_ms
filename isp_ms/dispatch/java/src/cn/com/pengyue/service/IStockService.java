package cn.com.pengyue.service;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


import cn.com.pengyue.pojo.stock;

public interface IStockService extends IBaseService<stock, Integer> {
	public List<stock> listAllStockByOrder(stock stock);
	
}
