package cn.com.pengyue.web.action;

import java.sql.SQLException;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class CountInfoController {
	
	@Resource
	private SessionFactory sessionFactory;
	private HibernateTemplate hibernateTemplate;
	
	@RequestMapping("/ajaxCountData")
	@ResponseBody
	public Object ajaxCountData(HttpSession session, Model model) {
		return geTemplate().execute(new HibernateCallback<Object>(){
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				return 
				session.createSQLQuery(
					"	SELECT COUNT(1) , COUNT(CASE WHEN (now() - apply.date) /1000000  > 7 THEN 0 ELSE 1  end)   FROM apply "

					+"	UNION ALL "

					+"	SELECT COUNT(1) , COUNT(CASE WHEN (now() - destroy_task.destroy_time) /1000000  > 7 THEN 0 ELSE 1  end)   FROM destroy_task "

					+"	UNION ALL  "

					+"	SELECT SUM(weight_log.weight) , SUM(CASE WHEN (now() - weight_log.op_date) /1000000  > 7 THEN 0 ELSE weight_log.weight  end)   FROM weight_log "
						
					+"  UNION ALL "

					+"	SELECT COUNT(1) , COUNT(CASE WHEN (now() - classes.start_time) /1000000  > 7 THEN 0 ELSE 1  end)   FROM classes "
				)
				.list();
			}
		});
	}
	
	
	public HibernateTemplate geTemplate(){
		if(hibernateTemplate==null){
			hibernateTemplate = new HibernateTemplate(sessionFactory);
		}
		return hibernateTemplate;
	}
	
	@RequestMapping("/toDestroyCountLine")
	public String toDestroyCountLine(){
		return "DestroyCountLine";
	}
	
	@RequestMapping("/toDestroyTypeCountPie")
	public String toDestroyTypeCountPie(){
		return "DestroyTypeCountPie";
	}
	
	@RequestMapping("/toCarDispatchBar")
	public String toCarDispatchBar(){
		return "CarDispatchBar";
	}
}
