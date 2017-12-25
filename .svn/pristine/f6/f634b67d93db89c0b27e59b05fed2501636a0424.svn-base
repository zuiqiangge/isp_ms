package cn.com.pengyue.dao.impl;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import cn.com.pengyue.dao.ILoggingDao;
import cn.com.pengyue.pojo.Logging;
@Repository
public class LoggingDao extends BaseDao<Logging, Integer> implements ILoggingDao {

	public List<Logging> allByConditionLogList(Integer id, Date startTime, Date endTime) {
		List<Logging> list=null;
		if(id==null&&startTime!=null){
			list=getHibernateTemplate().find("from "+Logging.class.getName()+" where opTime>=?"+
					" and opTime<=? order by opTime desc",startTime,endTime);
			return list;
		}else if(id!=null&&startTime==null){
			list=getHibernateTemplate().find("from "+Logging.class.getName()+" where userId="+id+
					" order by opTime desc");
			return list;
		}
		list=getHibernateTemplate().find("from "+Logging.class.getName()+" where userId="+id+" and opTime>=?"+
				" and opTime<=?  order by opTime desc",startTime,endTime);
		return list;
	}


	public List<Logging> allLogList() {
		List<Logging> list=getHibernateTemplate().find("from "+Logging.class.getName()+" order by opTime desc");
		return null;
	}

}
