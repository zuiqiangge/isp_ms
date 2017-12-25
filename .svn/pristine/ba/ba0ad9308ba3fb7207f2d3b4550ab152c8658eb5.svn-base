package cn.com.pengyue.service.impl;





import java.util.List;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.IStockDao;

import cn.com.pengyue.pojo.stock;
import cn.com.pengyue.service.IStockService;
@Service
public class StockService extends BaseService<stock, Integer>  implements IStockService {
	@javax.annotation.Resource
	private IStockDao stockDao;

	@Override
	public List<stock> listAllStockByOrder(stock stock) {
		// TODO Auto-generated method stub
		return stockDao.listAllStockByOrder(stock);
	}

}
