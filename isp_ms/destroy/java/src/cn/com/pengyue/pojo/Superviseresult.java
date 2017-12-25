package cn.com.pengyue.pojo;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Superviseresult entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "superviseresult")
public class Superviseresult implements java.io.Serializable {

	// Fields

	private Integer id;
	private String destroyPeople;
	private String supervisePeople;
	private Date date;
	private Integer applyId;
	private String state;
	private String explain;

	// Constructors

	/** default constructor */
	public Superviseresult() {
	}

	/** minimal constructor */
	public Superviseresult(Integer id, String destroyPeople, Date date,
			Integer applyId, String state) {
		this.id = id;
		this.destroyPeople = destroyPeople;
		this.date = date;
		this.applyId = applyId;
		this.state = state;
	}

	/** full constructor */
	public Superviseresult(Integer id, String destroyPeople,
			String supervisePeople, Date date, Integer applyId, String state,
			String explain) {
		this.id = id;
		this.destroyPeople = destroyPeople;
		this.supervisePeople = supervisePeople;
		this.date = date;
		this.applyId = applyId;
		this.state = state;
		this.explain = explain;
	}

	// Property accessors
	@Id
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "destroyPeople", nullable = false)
	public String getDestroyPeople() {
		return this.destroyPeople;
	}

	public void setDestroyPeople(String destroyPeople) {
		this.destroyPeople = destroyPeople;
	}

	@Column(name = "supervisePeople")
	public String getSupervisePeople() {
		return this.supervisePeople;
	}

	public void setSupervisePeople(String supervisePeople) {
		this.supervisePeople = supervisePeople;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "date", nullable = false, length = 10)
	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	@Column(name = "apply_Id", nullable = false)
	public Integer getApplyId() {
		return this.applyId;
	}

	public void setApplyId(Integer applyId) {
		this.applyId = applyId;
	}

	@Column(name = "state", nullable = false)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "explain")
	public String getExplain() {
		return this.explain;
	}

	public void setExplain(String explain) {
		this.explain = explain;
	}

}