package cn.com.pengyue.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.com.pengyue.dao.ICarDao;
import cn.com.pengyue.pojo.Car;

@Repository
public class CarDao extends BaseDao<Car, Integer> implements ICarDao {

	public List<Object[]> monthCarCount(final String date,final String time) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {

			public Object doInHibernate(Session session){
				String sql = ("select  b.car_no, count(a.id) from car b LEFT JOIN classes a "+
						"  on a.car_id=b.id and   DATE_FORMAT(a.start_time,'%Y/%m/%d')>=date_format('"+date+"','%Y/%m/%d') and DATE_FORMAT(a.start_time,'%Y/%m/%d')<=" +
						"date_format('"+time+"','%Y/%m/%d')"+
				"  GROUP BY  b.car_no");
				 Query query = session.createSQLQuery(sql); 
				
				return query.list();
			}

		});
	}
	
	public List<Object[]> monthDestroyWeight(final String date, final String time) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {

			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				String sql=" select DATE_FORMAT(a.op_date,'%Y-%m-%d'),sum(a.weight) from weight_log a "+
								" where a.op_date>="+date+" and a.op_date<="+time+""+
								"	group by DATE_FORMAT(a.op_date,'%Y-%m-%d')";
				Query query=session.createSQLQuery(sql);
				return query.list();
			}
		});
	}

}
