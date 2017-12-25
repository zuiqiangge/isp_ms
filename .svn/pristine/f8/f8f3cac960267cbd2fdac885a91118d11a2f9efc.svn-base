package cn.com.pengyue.pojo;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Classes entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "classes")
public class Classes implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String type;
	private String start_time;
	private String end_time;
	private Integer car_id;
	private Integer apply_id;
	// Constructors

	/** default constructor */
	public Classes() {
	}


	/** full constructor */
	public Classes(Integer id, String name, String time, String type,
			String startTime, String endTime) {
		super();
		this.id = id;
		this.name = name;
		this.type = type;
		start_time = startTime;
		end_time = endTime;
	}


	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "type")
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name="start_time")
	public String getStart_time() {
		return start_time;
	}


	public void setStart_time(String startTime) {
		start_time = startTime;
	}

	@Column(name="end_time")
	public String getEnd_time() {
		return end_time;
	}


	public void setEnd_time(String endTime) {
		end_time = endTime;
	}

	@Column(name="car_id")
	public Integer getCar_id() {
		return car_id;
	}


	public void setCar_id(Integer carId) {
		car_id = carId;
	}

	@Column(name="apply_id")
	public Integer getApply_id() {
		return apply_id;
	}


	public void setApply_id(Integer applyId) {
		apply_id = applyId;
	}
	
}