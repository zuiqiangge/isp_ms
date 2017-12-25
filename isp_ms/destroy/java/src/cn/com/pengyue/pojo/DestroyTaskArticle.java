package cn.com.pengyue.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * DestroyTaskArticle entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "destroy_task_article")
public class DestroyTaskArticle implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String code;
	private String pic;
	private String detailsInfo;
	private Integer destroyTaskId;
	
	private Integer type;
	private Integer typeParent;
	private Integer num;

	// Constructors

	/** default constructor */
	public DestroyTaskArticle() {
	}

	/** full constructor */
	public DestroyTaskArticle(String name, String code, String pic,
			String detailsInfo, Integer destroyTaskId) {
		this.name = name;
		this.code = code;
		this.pic = pic;
		this.detailsInfo = detailsInfo;
		this.destroyTaskId = destroyTaskId;
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

	@Column(name = "code")
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "pic")
	public String getPic() {
		return this.pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	@Column(name = "details_info")
	public String getDetailsInfo() {
		return this.detailsInfo;
	}

	public void setDetailsInfo(String detailsInfo) {
		this.detailsInfo = detailsInfo;
	}

	@Column(name = "destroy_task_id")
	public Integer getDestroyTaskId() {
		return this.destroyTaskId;
	}

	public void setDestroyTaskId(Integer destroyTaskId) {
		this.destroyTaskId = destroyTaskId;
	}
	
	@Column(name = "type")
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	@Column(name = "type_parent")
	public Integer getTypeParent() {
		return typeParent;
	}

	public void setTypeParent(Integer typeParent) {
		this.typeParent = typeParent;
	}

	@Column(name = "num")
	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	
	
}