package cn.com.pengyue.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ArchivesType entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "archives_type")
public class ArchivesType implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String parentId;

	// Constructors

	/** default constructor */
	public ArchivesType() {
	}

	/** full constructor */
	public ArchivesType(String name, String parentId) {
		this.name = name;
		this.parentId = parentId;
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

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "parent_id")
	public String getParentId() {
		return this.parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

}