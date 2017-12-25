package cn.com.pengyue.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.com.pengyue.dao.IDestroyTaskArticleDao;
import cn.com.pengyue.pojo.DestroyTaskArticle;
import cn.com.pengyue.service.IDestroyTaskArticleService;
@Service
public class DestroyTaskArticleService extends
		BaseService<DestroyTaskArticle, Integer> implements IDestroyTaskArticleService{
	
	@Resource
	private IDestroyTaskArticleDao destroyTaskArticleDao;
	
}
