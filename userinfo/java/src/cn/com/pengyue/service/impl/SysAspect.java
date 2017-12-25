package cn.com.pengyue.service.impl;

import java.util.Date;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.Audit;
import cn.com.pengyue.pojo.SysMsg;
import cn.com.pengyue.service.IApplyService;
import cn.com.pengyue.service.IAuditService;
import cn.com.pengyue.service.ISysMsgService;


@Aspect
@Component
public class SysAspect {
	
	@javax.annotation.Resource
	private ISysMsgService sysMsgService;
	
	@AfterReturning("execution(* cn.com.pengyue.service..*.save*(..))" +
			" && execution(* cn.com.pengyue.service..*.submitApplyAndAudit(..))" + //提交申请
			" && execution(* cn.com.pengyue.service..*.pishi(..))" + //批示
			" && execution(* cn.com.pengyue.service..*.update*(..))")
	public void afterSave(JoinPoint joinPoint){
		if(joinPoint.getArgs()==null|| joinPoint.getArgs().length==0){
			return;
		}
		Object saveObj = joinPoint.getArgs()[0];
		
		if(saveObj == null){
			return;
		}
		SysMsg t = new SysMsg();
		t.setIsRead(0);
		t.setSendTime(new Date());
		
		if (saveObj instanceof Apply) {
			Apply apply = (Apply) saveObj;
			//状态是提交 有提交对象就往系统信息表添加消息
			if(apply.getState() == IApplyService.APPLY_STATE_SUBMIT_ONE  
				&& apply.getSubmitUserId() !=null	){
				t.setSendUserId(apply.getUserId());
				t.setSendUserNick(apply.getName());
				t.setToUserId(apply.getSubmitUserId());
				t.setMsg("提交了一个销毁申请，请您批示！");
				sysMsgService.save(t);
				return;
			}
		}else if (saveObj instanceof Audit) {
			Audit audit = (Audit) saveObj;
			//审核 
			if(audit.getAudit_state() == IAuditService.AUDIT_STATE_READ
				&& audit.getRelashipApply() != null	){//状态是已经审核就进行系统消息通知
				t.setMsg("提交的销毁申请，\""+audit.getAudit_people()+"\"领导已批示！");
				t.setSendUserId(audit.getAudit_user_id());
				t.setSendUserNick(audit.getAudit_people());
				t.setToUserId(audit.getRelashipApply().getUserId());
				sysMsgService.save(t);
				return;
			}
		}
	}
}
