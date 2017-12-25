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
 * SysMsg entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "sys_msg")
public class SysMsg implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer sendUserId;
	private Integer toUserId;
	private String msg;
	private String cateDesc;
	private String sendUserNick;
	private Date sendTime = new Date();
	private Integer isRead = 0;

	// Constructors

	/** default constructor */
	public SysMsg() {
	}

	/** full constructor */
	public SysMsg(Integer sendUserId, Integer toUserId, String msg,
			String cateDesc, String sendUserNick, Date sendTime, Integer isRead) {
		this.sendUserId = sendUserId;
		this.toUserId = toUserId;
		this.msg = msg;
		this.cateDesc = cateDesc;
		this.sendUserNick = sendUserNick;
		this.sendTime = sendTime;
		this.isRead = isRead;
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

	@Column(name = "send_user_id")
	public Integer getSendUserId() {
		return this.sendUserId;
	}

	public void setSendUserId(Integer sendUserId) {
		this.sendUserId = sendUserId;
	}

	@Column(name = "to_user_id")
	public Integer getToUserId() {
		return this.toUserId;
	}

	public void setToUserId(Integer toUserId) {
		this.toUserId = toUserId;
	}

	@Column(name = "msg")
	public String getMsg() {
		return this.msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	@Column(name = "cate_desc")
	public String getCateDesc() {
		return this.cateDesc;
	}

	public void setCateDesc(String cateDesc) {
		this.cateDesc = cateDesc;
	}

	@Column(name = "send_user_nick")
	public String getSendUserNick() {
		return this.sendUserNick;
	}

	public void setSendUserNick(String sendUserNick) {
		this.sendUserNick = sendUserNick;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "send_time", length = 19)
	public Date getSendTime() {
		return this.sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	@Column(name = "is_read")
	public Integer getIsRead() {
		return this.isRead;
	}

	public void setIsRead(Integer isRead) {
		this.isRead = isRead;
	}

}