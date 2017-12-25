package cn.com.pengyue.service;

import java.util.List;

import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.PlaceOnFile;

public interface IPOFService extends IBaseService<PlaceOnFile, Integer>{
	
	public List<PlaceOnFile> getListByWeiAndCondition(PlaceOnFile file);
	public List<PlaceOnFile> getListByYiAndCondition(PlaceOnFile file);
	public void del(PlaceOnFile file);
	public void add(PlaceOnFile file);
	public void edit(PlaceOnFile file);
}
