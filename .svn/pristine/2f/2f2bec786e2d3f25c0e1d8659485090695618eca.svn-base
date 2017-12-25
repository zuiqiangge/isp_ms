package cn.com.pengyue.pojo;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

/**
 * Department entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "department")
public class Department implements java.io.Serializable {

	// Fields

	private Integer id;
	private String bmName;

	// Constructors

	/** default constructor */
	public Department() {
	}

	/** minimal constructor */
	public Department(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public Department(Integer id, String bmName) {
		this.id = id;
		this.bmName = bmName;
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

	@Column(name = "bm_name",nullable=false)
	public String getBmName() {
		return this.bmName;
	}

	public void setBmName(String bmName) {
		this.bmName = bmName;
	}

}