package cn.com.pengyue.pojo;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Transient;

import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;

/**
 * Resource entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "resource")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer","handler"})
public class Resource implements java.io.Serializable,Relashipable<Resource, Integer> {

	// Fields

	private Integer id;
	private String url;
	private String name;
	private Integer type;
	private String remark;
	private Integer parentId;
	private Integer orderIndex;
	private String iconName;

	@JsonIgnore
	private Resource parent;
	private Set<Resource> childs = new HashSet<Resource>();

	// Constructors

	/** default constructor */
	public Resource() {
	}

	/** full constructor */
	public Resource(String url, String name, Integer type, String remark,
			Integer parentId, Integer orderIndex) {
		this.url = url;
		this.name = name;
		this.type = type;
		this.remark = remark;
		this.parentId = parentId;
		this.orderIndex = orderIndex;
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

	@Column(name = "url", length = 500)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "type")
	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	@Column(name = "remark", length = 500)
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "parent_id")
	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	@Column(name = "order_index")
	public Integer getOrderIndex() {
		return this.orderIndex;
	}

	public void setOrderIndex(Integer orderIndex) {
		this.orderIndex = orderIndex;
	}
	
	
	@Column(name = "icon_name")
	public String getIconName() {
		return iconName;
	}

	public void setIconName(String iconName) {
		this.iconName = iconName;
	}

	@Transient
	public Resource getParent() {
		return parent;
	}

	public void setParent(Resource parent) {
		this.parent = parent;
	}

	@Transient
	public Set<Resource> getChilds() {
		return childs;
	}

	public void setChilds(Set<Resource> childs) {
		this.childs = childs;
	}
	
	

}