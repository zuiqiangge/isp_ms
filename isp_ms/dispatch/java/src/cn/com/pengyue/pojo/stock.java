package cn.com.pengyue.pojo;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.format.annotation.DateTimeFormat;
@Entity
@Table(name="stock")
public class stock implements java.io.Serializable {
    private int id;
    private String contactUnit;
    private int type;
    private int num;
    private Date stockDate;
    private int batch;
    private int userId;
    private Users user;
    private int orders;
    
   
    @Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "RFID")
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@Column(name = "contactUnit")
	public String getContactUnit() {
		return contactUnit;
	}
	public void setContactUnit(String contactUnit) {
		this.contactUnit = contactUnit;
	}
	@Column(name = "type")
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	@Column(name = "num")
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	@Column(name = "date")
	public Date getStockDate() {
		return stockDate;
	}
	public void setStockDate(Date stockDate) {
		this.stockDate = stockDate;
	}
	@Column(name = "batch")
	public int getBatch() {
		return batch;
	}
	public void setBatch(int batch) {
		this.batch = batch;
	}
	@Column(name = "orders")
	public int getOrders() {
		return orders;
	}
	public void setOrders(int orders) {
		this.orders = orders;
	}
	@Column(name="user_id")
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	@Transient
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
	
	
	
	
	public stock(int id, String contactUnit, int type, int num, Date stockDate,
			int batch, int userId, Users user, int orders) {
		super();
		this.id = id;
		this.contactUnit = contactUnit;
		this.type = type;
		this.num = num;
		this.stockDate = stockDate;
		this.batch = batch;
		this.userId = userId;
		this.user = user;
		this.orders = orders;
	}
	public stock() {
		super();
		// TODO Auto-generated constructor stub
	}
	
    
}
