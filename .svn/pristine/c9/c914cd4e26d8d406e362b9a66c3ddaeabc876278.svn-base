package cn.com.pengyue.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnore;

/**
 * ResourceRelaship entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "resource_relaship")
public class ResourceRelaship implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer targetId;
	private Integer resourceId;
	private Integer type;
	private Resource relashipResource;
	

	// Constructors

	/** default constructor */
	public ResourceRelaship() {
	}

	/** full constructor */
	public ResourceRelaship(Integer targetId, Integer resourceId, Integer type) {
		this.targetId = targetId;
		this.resourceId = resourceId;
		this.type = type;
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

	@Column(name = "target_id")
	public Integer getTargetId() {
		return this.targetId;
	}

	public void setTargetId(Integer targetId) {
		this.targetId = targetId;
	}

	@Column(name = "resource_id")
	public Integer getResourceId() {
		return this.resourceId;
	}

	public void setResourceId(Integer resourceId) {
		this.resourceId = resourceId;
	}

	@Column(name = "type")
	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(
			insertable=false
			,updatable=false
			,name="resource_id"
	)
	public Resource getRelashipResource() {
		return relashipResource;
	}

	public void setRelashipResource(Resource relashipResource) {
		this.relashipResource = relashipResource;
	}

}