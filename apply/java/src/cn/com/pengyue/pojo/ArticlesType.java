 package cn.com.pengyue.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="archives_type",catalog="destroy_center")
public class ArticlesType {
	private Integer id;
	private String name;
	private Integer parent_id;

	public ArticlesType() {
		super();
	}
	public ArticlesType(Integer id, String name, Integer parentId) {
		super();
		this.id = id;
		this.name = name;
		parent_id = parentId;
	}
	@Id
	@Column(name="id")
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Column(name="name")
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Column(name="parent_id")
	public Integer getParent_id() {
		return parent_id;
	}
	public void setParent_id(Integer parentId) {
		parent_id = parentId;
	}
	
	
}
