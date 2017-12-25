package cn.com.pengyue.pojo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.management.loading.PrivateClassLoader;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * DestroyTask entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "destroy_task")
public class DestroyTask implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer distributeUserId;
	private Integer superviseUserId;
	private Integer applyId;
	private String applyUserName;
	private String destroyUserName;
	private Integer destroyUserId;
	private Date destroyTime;
	private Integer stateType;
	private Integer prevId;
	private Double frontWeight;
	private Double backWeight;
	private Integer isWarehouse;
	
	
	private Set<DestroyTaskArticle> articles = new HashSet<DestroyTaskArticle>();
	private Apply apply;
	
	// Constructors

	/** default constructor */
	public DestroyTask() {
	}

	/** full constructor */
	public DestroyTask(Integer distributeUserId, Integer superviseUserId,
			Integer applyId, String applyUserName, String destroyUserName,
			Integer destroyUserId, Date destroyTime, Integer stateType,
			Integer prevId) {
		this.distributeUserId = distributeUserId;
		this.superviseUserId = superviseUserId;
		this.applyId = applyId;
		this.applyUserName = applyUserName;
		this.destroyUserName = destroyUserName;
		this.destroyUserId = destroyUserId;
		this.destroyTime = destroyTime;
		this.stateType = stateType;
		this.prevId = prevId;
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

	@Column(name = "distribute_user_id")
	public Integer getDistributeUserId() {
		return this.distributeUserId;
	}

	public void setDistributeUserId(Integer distributeUserId) {
		this.distributeUserId = distributeUserId;
	}

	@Column(name = "supervise_user_id")
	public Integer getSuperviseUserId() {
		return this.superviseUserId;
	}

	public void setSuperviseUserId(Integer superviseUserId) {
		this.superviseUserId = superviseUserId;
	}

	@Column(name = "apply_id")
	public Integer getApplyId() {
		return this.applyId;
	}

	public void setApplyId(Integer applyId) {
		this.applyId = applyId;
	}

	@Column(name = "apply_user_name")
	public String getApplyUserName() {
		return this.applyUserName;
	}

	public void setApplyUserName(String applyUserName) {
		this.applyUserName = applyUserName;
	}

	@Column(name = "destroy_user_name")
	public String getDestroyUserName() {
		return this.destroyUserName;
	}

	public void setDestroyUserName(String destroyUserName) {
		this.destroyUserName = destroyUserName;
	}

	@Column(name = "destroy_user_id")
	public Integer getDestroyUserId() {
		return this.destroyUserId;
	}

	public void setDestroyUserId(Integer destroyUserId) {
		this.destroyUserId = destroyUserId;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "destroy_time", length = 19)
	public Date getDestroyTime() {
		return this.destroyTime;
	}

	public void setDestroyTime(Date destroyTime) {
		this.destroyTime = destroyTime;
	}

	@Column(name = "state_type")
	public Integer getStateType() {
		return this.stateType;
	}

	public void setStateType(Integer stateType) {
		this.stateType = stateType;
	}

	@Column(name = "prev_id")
	public Integer getPrevId() {
		return this.prevId;
	}

	public void setPrevId(Integer prevId) {
		this.prevId = prevId;
	}
	@Column(name="frontWeight")
	public Double getFrontWeight() {
		return frontWeight;
	}

	public void setFrontWeight(Double frontWeight) {
		this.frontWeight = frontWeight;
	}
	@Column(name="backWeight")
	public Double getBackWeight() {
		return backWeight;
	}

	public void setBackWeight(Double backWeight) {
		this.backWeight = backWeight;
	}
	@Column(name="isWarehouse")
	public Integer getIsWarehouse() {
		return isWarehouse;
	}

	public void setIsWarehouse(Integer isWarehouse) {
		this.isWarehouse = isWarehouse;
	}
	
	@OneToMany(fetch=FetchType.LAZY)
	@JoinColumn(insertable=false,updatable=false,
			name="destroy_task_id",referencedColumnName="id")
	public Set<DestroyTaskArticle> getArticles() {
		return articles;
	}

	public void setArticles(Set<DestroyTaskArticle> articles) {
		this.articles = articles;
	}
	
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(insertable=false,updatable=false,
			name="apply_id",referencedColumnName="id")
	public Apply getApply() {
		return apply;
	}

	public void setApply(Apply apply) {
		this.apply = apply;
	}

	
}