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

/**
 * Car entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "car")
public class Car implements java.io.Serializable {

	// Fields

	private Integer id;
	private String carNo;
	private Integer useUserId;
	private Date lastDispatchTime;
	private String useUser;
	private String description;

	// Constructors

	/** default constructor */
	public Car() {
	}
	
	/** full constructor */
	public Car(String carNo, Integer useUserId, Date lastDispatchTime,
			String useUser, String description) {
		this.carNo = carNo;
		this.useUserId = useUserId;
		this.lastDispatchTime = lastDispatchTime;
		this.useUser = useUser;
		this.description = description;
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

	@Column(name = "car_no", length = 64)
	public String getCarNo() {
		return this.carNo;
	}

	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}

	@Column(name = "use_user_id")
	public Integer getUseUserId() {
		return this.useUserId;
	}

	public void setUseUserId(Integer useUserId) {
		this.useUserId = useUserId;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "last_dispatch_time", length = 19)
	public Date getLastDispatchTime() {
		return this.lastDispatchTime;
	}

	public void setLastDispatchTime(Date lastDispatchTime) {
		this.lastDispatchTime = lastDispatchTime;
	}

	@Column(name = "use_user")
	public String getUseUser() {
		return this.useUser;
	}

	public void setUseUser(String useUser) {
		this.useUser = useUser;
	}

	@Column(name = "description")
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}