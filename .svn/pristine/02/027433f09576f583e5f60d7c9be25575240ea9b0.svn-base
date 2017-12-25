package cn.com.pengyue.pojo;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ApplyConditionHistory entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "apply_condition_history")
public class ApplyConditionHistory {
	/*
	 * id主键
	 */
	private Integer id;
	/*
	 * 单位名称
	 */
	private String contactUnit;
	
	/*
	 * 联系人
	 */
	private String contact;
	/*
	 * 上报领导id
	 */
	private Integer submitId;
	
	/*
	 * 上报领导名称
	 */
	private String submitName;
	/*
	 * 联系电话
	 */
	private String telephone;
	/*
	 * 单位地址
	 */
	private String address;
	/*
	 * 送货方式
	 */
	private Integer sendType;
	/*
	 * 是否监销
	 */
	private Integer nowDestory;
	
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "contact_unit")
	public String getContactUnit() {
		return contactUnit;
	}
	public void setContactUnit(String contactUnit) {
		this.contactUnit = contactUnit;
	}
	
	@Column(name = "contact")
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	
	@Column(name = "submit_id")
	public Integer getSubmitId() {
		return submitId;
	}
	public void setSubmitId(Integer submitId) {
		this.submitId = submitId;
	}
	
	@Column(name = "telephone")
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	
	@Column(name = "address")
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	@Column(name = "send_type")
	public Integer getSendType() {
		return sendType;
	}
	public void setSendType(Integer sendType) {
		this.sendType = sendType;
	}
	
	@Column(name = "nowdestory")
	public Integer getNowDestory() {
		return nowDestory;
	}
	public void setNowDestory(Integer nowDestory) {
		this.nowDestory = nowDestory;
	}
	@Column(name = "submit_name")
	public String getSubmitName() {
		return submitName;
	}
	public void setSubmitName(String submitName) {
		this.submitName = submitName;
	}
	
	
	
	
	
}
