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
 * WeightLog entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "weight_log")
public class WeightLog implements java.io.Serializable {

	// Fields

	private Integer id;
	private String opUser;
	private Date opDate;
	private Integer weight;
	private Integer opCarId;
	private String opContanct;
	private Integer opDriverId;
	private Integer state;

	// Constructors

	/** default constructor */
	public WeightLog() {
	}

	/** full constructor */
	public WeightLog(String opUser, Date opDate, Integer weight,
			Integer opCarId, String opContanct, Integer opDriverId) {
		this.opUser = opUser;
		this.opDate = opDate;
		this.weight = weight;
		this.opCarId = opCarId;
		this.opContanct = opContanct;
		this.opDriverId = opDriverId;
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

	@Column(name = "op_user")
	public String getOpUser() {
		return this.opUser;
	}

	public void setOpUser(String opUser) {
		this.opUser = opUser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "op_date", length = 19)
	public Date getOpDate() {
		return this.opDate;
	}

	public void setOpDate(Date opDate) {
		this.opDate = opDate;
	}

	@Column(name = "weight")
	public Integer getWeight() {
		return this.weight;
	}

	public void setWeight(Integer weight) {
		this.weight = weight;
	}

	@Column(name = "op_car_id")
	public Integer getOpCarId() {
		return this.opCarId;
	}

	public void setOpCarId(Integer opCarId) {
		this.opCarId = opCarId;
	}

	@Column(name = "op_contanct")
	public String getOpContanct() {
		return this.opContanct;
	}

	public void setOpContanct(String opContanct) {
		this.opContanct = opContanct;
	}

	@Column(name = "op_driver_id")
	public Integer getOpDriverId() {
		return this.opDriverId;
	}

	public void setOpDriverId(Integer opDriverId) {
		this.opDriverId = opDriverId;
	}
	
	@Column(name = "state")
	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

}