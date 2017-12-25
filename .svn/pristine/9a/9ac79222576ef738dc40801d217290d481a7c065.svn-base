package cn.com.pengyue.pojo;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 * Audit entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "audit")
public class Audit {
	private Integer id;
	private Integer audit_user_id;
	private String audit_people;
	private String audit_explain;
	private Integer audit_state;
	private String andit_bm;
	private String anditi_position;
	private Integer apply_id;
	private Date audit_date;
	
	private Apply relashipApply;
	
	public Audit(Integer id, String auditPeople, String auditExplain,
			Integer auditState, String anditBm, String anditiPosition,
			Integer applyId, Date auditDate) {
		super();
		this.id = id;
		audit_people = auditPeople;
		audit_explain = auditExplain;
		audit_state = auditState;
		andit_bm = anditBm;
		anditi_position = anditiPosition;
		apply_id = applyId;
		audit_date = auditDate;
	}
	public Audit() {
		super();
	}
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name="id" , nullable=false)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Column(name="audit_people")
	public String getAudit_people() {
		return audit_people;
	}
	public void setAudit_people(String auditPeople) {
		audit_people = auditPeople;
	}
	@Column(name="audit_explain")
	public String getAudit_explain() {
		return audit_explain;
	}
	public void setAudit_explain(String auditExplain) {
		audit_explain = auditExplain;
	}
	@Column(name="audit_state")
	public Integer getAudit_state() {
		return audit_state;
	}
	public void setAudit_state(Integer auditState) {
		audit_state = auditState;
	}
	@Column(name="andit_bm")
	public String getAndit_bm() {
		return andit_bm;
	}
	public void setAndit_bm(String anditBm) {
		andit_bm = anditBm;
	}
	@Column(name="anditi_position")
	public String getAnditi_position() {
		return anditi_position;
	}
	public void setAnditi_position(String anditiPosition) {
		anditi_position = anditiPosition;
	}
	@Column(name="apply_id")
	public Integer getApply_id() {
		return apply_id;
	}
	public void setApply_id(Integer applyId) {
		apply_id = applyId;
	}
	@Column(name="audit_date")
	public Date getAudit_date() {
		return audit_date;
	}
	public void setAudit_date(Date auditDate) {
		audit_date = auditDate;
	}
	@Column(name="audit_user_id")
	public Integer getAudit_user_id() {
		return audit_user_id;
	}
	public void setAudit_user_id(Integer audit_user_id) {
		this.audit_user_id = audit_user_id;
	}
	@Transient
	public Apply getRelashipApply() {
		return relashipApply;
	}
	public void setRelashipApply(Apply relashipApply) {
		this.relashipApply = relashipApply;
	}
	

}