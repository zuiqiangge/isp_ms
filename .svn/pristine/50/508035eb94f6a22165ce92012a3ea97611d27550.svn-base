package cn.com.pengyue.pojo;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 * Apply entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "apply")
public class Apply implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer userId;
	private Integer submitUserId;
	private String name;
	private Date date;
	private String title;
	private Integer state;
	private String bmName;
	private String positionName;
	private String contactUnit;
	private String contacts;
	private String explain;
	private String explain2;
	private Integer nowDestroy;
	private Integer monitorDestroy;
	private Integer sendType; 
	private Integer monitorDestroyPerson_id;
	
	private Integer articleType; //物品类型
	
	
	private String articleDesc;
	
	private String telephone;
	private String address;
	private Integer isdestroy;
	private Date oneselfSendTime;

	private Date planDateOfDestroy;
	
	
	private Audit relashipAudit;
	
	private java.util.Set<Classes> dispaths = new HashSet<Classes>();
	private Set<Audit> audits = new HashSet<Audit>();
	
	// Constructors


	/** default constructor */
	public Apply() {
	}

	/** minimal constructor */
	public Apply(Integer id, String name, Date date, Integer state,
			String bmName, String positionName) {
		this.id = id;
		this.name = name;
		this.date = date;
		this.state = state;
		this.bmName = bmName;
		this.positionName = positionName;
	}

	/** full constructor */
	public Apply(Integer id, String name, Date date, String title,
			Integer state, String bmName, String positionName,
			String contactUnit, String contacts, String explain,
			String explain2, Integer nowDestroy, Integer monitorDestroy,
			Integer sendType) {
		super();
		this.id = id;
		this.name = name;
		this.date = date;
		this.title = title;
		this.state = state;
		this.bmName = bmName;
		this.positionName = positionName;
		this.contactUnit = contactUnit;
		this.contacts = contacts;
		this.explain = explain;
		this.explain2 = explain2;
		this.nowDestroy = nowDestroy;
		this.monitorDestroy = monitorDestroy;
		this.sendType = sendType;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}


	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "name", nullable = false)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "date", nullable = false, length = 10)
	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	@Column(name = "title")
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "state")
	public Integer getState() {
		return this.state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	@Column(name = "bm_name")
	public String getBmName() {
		return this.bmName;
	}

	public void setBmName(String bmName) {
		this.bmName = bmName;
	}

	@Column(name = "position_name")
	public String getPositionName() {
		return this.positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	@Column(name="contactUnit")
	public String getContactUnit() {
		return contactUnit;
	}

	public void setContactUnit(String contactUnit) {
		this.contactUnit = contactUnit;
	}
	@Column(name="contacts")
	public String getContacts() {
		return contacts;
	}

	public void setContacts(String contacts) {
		this.contacts = contacts;
	}
	@Column(name="`explain`")
	public String getExplain() {
		return explain;
	}

	public void setExplain(String explain) {
		this.explain = explain;
	}
	@Column(name="explain2")
	public String getExplain2() {
		return explain2;
	}

	public void setExplain2(String explain2) {
		this.explain2 = explain2;
	}
	@Column(name="nowDestroy")
	public Integer getNowDestroy() {
		return nowDestroy;
	}

	public void setNowDestroy(Integer nowDestroy) {
		this.nowDestroy = nowDestroy;
	}
	@Column(name="monitorDestroy")
	public Integer getMonitorDestroy() {
		return monitorDestroy;
	}

	public void setMonitorDestroy(Integer monitorDestroy) {
		this.monitorDestroy = monitorDestroy;
	}
	@Column(name="sendType")
	public Integer getSendType() {
		return sendType;
	}

	public void setSendType(Integer sendType) {
		this.sendType = sendType;
	}


	@Column(name="user_id")
	public Integer getUserId() {
		return userId;
	}
	@Column(name="monitorDestroyPerson_id")
	public Integer getMonitorDestroyPerson_id() {
		return monitorDestroyPerson_id;
	}

	public void setMonitorDestroyPerson_id(Integer monitorDestroyPersonId) {
		monitorDestroyPerson_id = monitorDestroyPersonId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	@Column(name="submit_user_id")
	public Integer getSubmitUserId() {
		return submitUserId;
	}

	public void setSubmitUserId(Integer submitUserId) {
		this.submitUserId = submitUserId;
	}

	@Column(name="article_desc")
	public String getArticleDesc() {
		return articleDesc;
	}

	public void setArticleDesc(String articleDesc) {
		this.articleDesc = articleDesc;
	}
	
	@Column(name="article_type")
	public Integer getArticleType() {
		return articleType;
	}

	public void setArticleType(Integer articleType) {
		this.articleType = articleType;
	}
	@Column(name="telephone")
	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	@Column(name="address")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	@Column(name="isdestroy")
	public Integer getIsdestroy() {
		return isdestroy;
	}

	public void setIsdestroy(Integer isdestroy) {
		this.isdestroy = isdestroy;
	}
	@Transient
	public Audit getRelashipAudit() {
		return relashipAudit;
	}

	public void setRelashipAudit(Audit relashipAudit) {
		this.relashipAudit = relashipAudit;
	}
	
	@OneToMany(fetch=FetchType.LAZY)
	@JoinColumn(insertable=false,updatable=false,
			name="apply_id",referencedColumnName="id")
	public java.util.Set<Classes> getDispaths() {
		return dispaths;
	}

	public void setDispaths(java.util.Set<Classes> dispaths) {
		this.dispaths = dispaths;
	}
	
	@OneToMany(fetch=FetchType.LAZY)
	@JoinColumn(insertable=false,updatable=false,
			name="apply_id",referencedColumnName="id")
	public Set<Audit> getAudits() {
		return audits;
	}

	public void setAudits(Set<Audit> audits) {
		this.audits = audits;
	}
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="oneselfSendTime")
	public Date getOneselfSendTime() {
		return oneselfSendTime;
	}

	public void setOneselfSendTime(Date oneselfSendTime) {
		this.oneselfSendTime = oneselfSendTime;
	}
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="plan_date_of_destroy")
	public Date getPlanDateOfDestroy() {
		return planDateOfDestroy;
	}

	public void setPlanDateOfDestroy(Date planDateOfDestroy) {
		this.planDateOfDestroy = planDateOfDestroy;
	}
	
}