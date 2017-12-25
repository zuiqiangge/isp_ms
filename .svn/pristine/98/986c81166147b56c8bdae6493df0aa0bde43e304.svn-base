package cn.com.pengyue.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Position entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "position")
public class Position implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private Integer bmId;
	private Department department;

	// Constructors

	/** default constructor */
	public Position() {
	}

	/** full constructor */
	public Position(Integer id, String name, Integer bmId) {
		this.id = id;
		this.name = name;
		this.bmId = bmId;
	}

	public Position(Integer id, String name, Integer bmId, Department department) {
		super();
		this.id = id;
		this.name = name;
		this.bmId = bmId;
		this.department = department;
	}

	
	
	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
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

	@Column(name = "BM_id", nullable = false)
	public Integer getBmId() {
		return this.bmId;
	}

	public void setBmId(Integer bmId) {
		this.bmId = bmId;
	}

	@ManyToOne(optional=true,fetch=FetchType.EAGER)
	@JoinColumn(insertable=false,nullable=false,updatable=false,name="BM_id",columnDefinition="id")
	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}


}