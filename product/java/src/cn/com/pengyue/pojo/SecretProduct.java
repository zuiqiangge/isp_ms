package cn.com.pengyue.pojo;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "secret_product")
public class SecretProduct {
	private Integer id;
	private String productName;
	private Date inTime;
	private Users manageUser;
	private String rfid;
	private Integer currentPosition;
	private Integer isBack;
	private Integer isWarning;
	private Integer count;
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	
	@Column(name = "product_name")
	public String getProductName() {
		return productName;
	}
	
	public void setProductName(String productName) {
		this.productName = productName;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "in_datetime", nullable = false, length = 10)
	public Date getInTime() {
		return inTime;
	}
	public void setInTime(Date inTime) {
		this.inTime = inTime;
	}
	
	
	@OneToOne(cascade={CascadeType.ALL})  
    @JoinColumn(name="manage_user")  
	public Users getManageUser() {
		return manageUser;
	}
	public void setManageUser(Users manageUser) {
		this.manageUser = manageUser;
	}
	
	@Column(name = "rfid")
	public String getRfid() {
		return rfid;
	}
	public void setRfid(String rfid) {
		this.rfid = rfid;
	}
	
	
	@Column(name = "current_position")
	public Integer getCurrentPosition() {
		return currentPosition;
	}
	public void setCurrentPosition(Integer currentPosition) {
		this.currentPosition = currentPosition;
	}
	
	@Column(name = "is_back")
	public Integer getIsBack() {
		return isBack;
	}
	public void setIsBack(Integer isBack) {
		this.isBack = isBack;
	}
	
	
	@Column(name = "is_warning")
	public Integer getIsWarning() {
		return isWarning;
	}
	public void setIsWarning(Integer isWarning) {
		this.isWarning = isWarning;
	}
	
	@Column(name = "count")
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	
	
	
	
	
	
	
}
