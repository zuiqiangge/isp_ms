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

@Entity
@Table(name = "place_on_file")
public class PlaceOnFile {
	private int id;
	private Integer submitId;
	private String contactUnit;
	private String contact;
	private String telephone;
	private String address;
	private String destoryThingDes;
	private Integer sendType;
	private Integer nowDestory;
	private Integer bigType;
	private Integer smallType;
	private Integer num;
	private double weight;
	private String submitName;
	private Integer isPlaceOn;
	private Date createTime;
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	@Column(name = "submit_id")
	public Integer getSubmitId() {
		return submitId;
	}
	public void setSubmitId(Integer submitId) {
		this.submitId = submitId;
	}
	
	@Column(name = "contactUnit")
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
	
	@Column(name = "destory_thing_des")
	public String getDestoryThingDes() {
		return destoryThingDes;
	}
	public void setDestoryThingDes(String destoryThingDes) {
		this.destoryThingDes = destoryThingDes;
	}
	
	@Column(name = "send_type")
	public Integer getSendType() {
		return sendType;
	}
	public void setSendType(Integer sendType) {
		this.sendType = sendType;
	}
	
	@Column(name = "now_destory")
	public Integer getNowDestory() {
		return nowDestory;
	}
	public void setNowDestory(Integer nowDestory) {
		this.nowDestory = nowDestory;
	}
	
	@Column(name = "big_type")
	public Integer getBigType() {
		return bigType;
	}
	public void setBigType(Integer bigType) {
		this.bigType = bigType;
	}
	
	@Column(name = "small_type")
	public Integer getSmallType() {
		return smallType;
	}
	public void setSmallType(Integer smallType) {
		this.smallType = smallType;
	}
	
	@Column(name = "num")
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	
	@Column(name = "weight")
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	
	@Column(name = "submit_name")
	public String getSubmitName() {
		return submitName;
	}
	public void setSubmitName(String submitName) {
		this.submitName = submitName;
	}
	
	@Column(name = "is_place_on")
	public Integer getIsPlaceOn() {
		return isPlaceOn;
	}
	public void setIsPlaceOn(Integer isPlaceOn) {
		this.isPlaceOn = isPlaceOn;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="create_time")
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	
	
}
