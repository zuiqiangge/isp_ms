package cn.com.pengyue.pojo;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Logging entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "logging")
public class Logging implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer userId;
	private Date opTime;
	private String sysDesc;
	private String detailsInfo;
	private String methodUrl;

	// Constructors

	/** default constructor */
	public Logging() {
	}

	/** full constructor */
	public Logging(Integer userId, Date opTime, String sysDesc,
			String detailsInfo) {
		this.userId = userId;
		this.opTime = opTime;
		this.sysDesc = sysDesc;
		this.detailsInfo = detailsInfo;
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

	@Column(name = "user_id")
	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "op_time", length = 19)
	public Date getOpTime() {
		return this.opTime;
	}

	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}

	@Column(name = "sys_desc", length = 50)
	public String getSysDesc() {
		return this.sysDesc;
	}

	public void setSysDesc(String sysDesc) {
		this.sysDesc = sysDesc;
	}

	@Column(name = "details_info", length = 1000)
	public String getDetailsInfo() {
		return this.detailsInfo;
	}

	public void setDetailsInfo(String detailsInfo) {
		this.detailsInfo = detailsInfo;
	}
	@Column(name="methodUrl")
	public String getMethodUrl() {
		return methodUrl;
	}

	public void setMethodUrl(String methodUrl) {
		this.methodUrl = methodUrl;
	}

}