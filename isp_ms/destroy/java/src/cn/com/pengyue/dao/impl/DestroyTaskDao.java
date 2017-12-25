package cn.com.pengyue.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.com.pengyue.dao.IDestroyTaskDao;
import cn.com.pengyue.pojo.DestroyTask;
import cn.com.pengyue.pojo.PageInfo;

@Repository
public class DestroyTaskDao extends BaseDao<DestroyTask, Integer> implements
		IDestroyTaskDao {
	public List<Object[]> dayCountDestroy(final String date, final String time) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) {
				String sql = "select  date_format(destroy_time,'%Y-%c-%d ') as date,count(*) as number from destroy_task a where destroy_time>='"
						+ date
						+ "' and destroy_time<='"
						+ time
						+ "' and a.state_type=2 GROUP BY date_format(destroy_time,'%Y-%c-%d ')";
				Query query = session.createSQLQuery(sql);
				return query.list();
			}
		});
	}

	public List<Object[]> dayDestroyTypeCountDestroy(final String date,
			final String time) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) {
				String sql = "select b.type as type,sum(b.num) as number from destroy_task a,destroy_task_article b  where a.id=b.destroy_task_id and destroy_time>='"
						+ date
						+ "' and destroy_time<='"
						+ time
						+ "' and a.state_type=2  GROUP BY b.type";
				Query query = session.createSQLQuery(sql);
				return query.list();
			}
		});
	}


	//日均销毁量
	public List<Object[]> dayDestroyCountAvg(final String date,final String time){
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) {
				String sql = "select avg(b.num) as number from destroy_task a,destroy_task_article b  where a.id=b.destroy_task_id and destroy_time>='"
						+ date
						+ "' and destroy_time<='"
						+ time
						+ "' and a.state_type=2";
				Query query = session.createSQLQuery(sql);
				return query.list();
			}
		});
	}
	
	@Override
	public List<DestroyTask> pageDestroyAndApply(final PageInfo pageinfo) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) {

				if(pageinfo.isNeedSetTotalSize()){
					int total = ((Number)(session.createQuery("select count(c) from "+DestroyTask.class.getName()+" c")
						.uniqueResult())).intValue();
					pageinfo.setTotalSize(total);
				}
				return session.createQuery("from "+DestroyTask.class.getName()+" c left join fetch c.apply order by c.id desc")
					.setMaxResults(pageinfo.getPageSize())
					.setFirstResult(pageinfo.getFirstNo())
					.list();
			}
		});
		
	}

}
