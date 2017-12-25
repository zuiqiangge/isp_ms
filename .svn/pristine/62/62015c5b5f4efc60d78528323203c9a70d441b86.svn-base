package cn.com.pengyue.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Archives entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "archives")
public class Archives implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer archivesTypeId;
	private String archivesTypeName;
	private Integer opUserId;
	private String opUserName;
	private Integer destroyUserId;
	private String destroyUserName;
	private Integer destroyId;
	private Integer applyId;
	private String applyUserName;

	// Constructors

	/** default constructor */
	public Archives() {
	}

	/** full constructor */
	public Archives(Integer archivesTypeId, String archivesTypeName,
			Integer opUserId, String opUserName, Integer destroyUserId,
			String destroyUserName, Integer destroyId, Integer applyId,
			String applyUserName) {
		this.archivesTypeId = archivesTypeId;
		this.archivesTypeName = archivesTypeName;
		this.opUserId = opUserId;
		this.opUserName = opUserName;
		this.destroyUserId = destroyUserId;
		this.destroyUserName = destroyUserName;
		this.destroyId = destroyId;
		this.applyId = applyId;
		this.applyUserName = applyUserName;
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

	@Column(name = "archives_type_id")
	public Integer getArchivesTypeId() {
		return this.archivesTypeId;
	}

	public void setArchivesTypeId(Integer archivesTypeId) {
		this.archivesTypeId = archivesTypeId;
	}

	@Column(name = "archives_type_name")
	public String getArchivesTypeName() {
		return this.archivesTypeName;
	}

	public void setArchivesTypeName(String archivesTypeName) {
		this.archivesTypeName = archivesTypeName;
	}

	@Column(name = "op_user_id")
	public Integer getOpUserId() {
		return this.opUserId;
	}

	public void setOpUserId(Integer opUserId) {
		this.opUserId = opUserId;
	}

	@Column(name = "op_user_name")
	public String getOpUserName() {
		return this.opUserName;
	}

	public void setOpUserName(String opUserName) {
		this.opUserName = opUserName;
	}

	@Column(name = "destroy_user_id")
	public Integer getDestroyUserId() {
		return this.destroyUserId;
	}

	public void setDestroyUserId(Integer destroyUserId) {
		this.destroyUserId = destroyUserId;
	}

	@Column(name = "destroy_user_name")
	public String getDestroyUserName() {
		return this.destroyUserName;
	}

	public void setDestroyUserName(String destroyUserName) {
		this.destroyUserName = destroyUserName;
	}

	@Column(name = "destroy_id")
	public Integer getDestroyId() {
		return this.destroyId;
	}

	public void setDestroyId(Integer destroyId) {
		this.destroyId = destroyId;
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

}