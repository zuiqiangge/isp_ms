package cn.com.pengyue.pojo;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="warehouse",catalog="destroy_center")
public class Warehouse implements Serializable{
	private Integer id;
	private Integer type;
	private String labelNumber;
	private Integer articleType;
	private Date enterDate;
	private Integer applyId;
	private Integer destroy_id;
	private Date destroyDate;
	private String registerPerson;
	private Integer register_id;
	private Integer destroyState;
	
	
	public Warehouse(Integer id, Integer type, String labelNumber,
			Integer articleType, Date enterDate, Integer applyId,
			Integer destroyId, Date destroyDate, String registerPerson,
			Integer registerId) {
		super();
		this.id = id;
		this.type = type;
		this.labelNumber = labelNumber;
		this.articleType = articleType;
		this.enterDate = enterDate;
		this.applyId = applyId;
		destroy_id = destroyId;
		this.destroyDate = destroyDate;
		this.registerPerson = registerPerson;
		register_id = registerId;
	}
	public Warehouse() {
		super();
	}
	@Id
	@Column(name="id")
	@GeneratedValue(strategy = IDENTITY)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Column(name="type")
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	@Column(name="labelNumber")
	public String getLabelNumber() {
		return labelNumber;
	}
	public void setLabelNumber(String labelNumber) {
		this.labelNumber = labelNumber;
	}
	@Column(name="articleType")
	public Integer getArticleType() {
		return articleType;
	}
	public void setArticleType(Integer articleType) {
		this.articleType = articleType;
	}
	@Column(name="enterDate")
	public Date getEnterDate() {
		return enterDate;
	}
	public void setEnterDate(Date enterDate) {
		this.enterDate = enterDate;
	}
	@Column(name="apply_id")
	public Integer getApplyId() {
		return applyId;
	}
	public void setApplyId(Integer applyId) {
		this.applyId = applyId;
	}
	@Column(name="destroy_id")
	public Integer getDestroy_id() {
		return destroy_id;
	}
	public void setDestroy_id(Integer destroyId) {
		destroy_id = destroyId;
	}
	@Column(name="destroyDate")
	public Date getDestroyDate() {
		return destroyDate;
	}
	public void setDestroyDate(Date destroyDate) {
		this.destroyDate = destroyDate;
	}
	@Column(name="registerPerson")
	public String getRegisterPerson() {
		return registerPerson;
	}
	public void setRegisterPerson(String registerPerson) {
		this.registerPerson = registerPerson;
	}
	@Column(name="register_id")
	public Integer getRegister_id() {
		return register_id;
	}
	public void setRegister_id(Integer registerId) {
		register_id = registerId;
	}
	@Column(name="destroyState")
	public Integer getDestroyState() {
		return destroyState;
	}
	public void setDestroyState(Integer destroyState) {
		this.destroyState = destroyState;
	}
	
}
