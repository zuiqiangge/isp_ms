package cn.com.pengyue.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Lables entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "lables")
public class Lables implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String code;
	private String detailInfo;
	private String selfCode;
	private String pic;
	private Integer destroyTaskArticleId;

	// Constructors

	/** default constructor */
	public Lables() {
	}

	/** full constructor */
	public Lables(String name, String code, String detailInfo, String selfCode,
			String pic, Integer destroyTaskArticleId) {
		this.name = name;
		this.code = code;
		this.detailInfo = detailInfo;
		this.selfCode = selfCode;
		this.pic = pic;
		this.destroyTaskArticleId = destroyTaskArticleId;
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

	@Column(name = "detail_info")
	public String getDetailInfo() {
		return this.detailInfo;
	}

	public void setDetailInfo(String detailInfo) {
		this.detailInfo = detailInfo;
	}

	@Column(name = "self_code")
	public String getSelfCode() {
		return this.selfCode;
	}

	public void setSelfCode(String selfCode) {
		this.selfCode = selfCode;
	}

	@Column(name = "pic")
	public String getPic() {
		return this.pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	@Column(name = "destroy_task_article_id")
	public Integer getDestroyTaskArticleId() {
		return this.destroyTaskArticleId;
	}

	public void setDestroyTaskArticleId(Integer destroyTaskArticleId) {
		this.destroyTaskArticleId = destroyTaskArticleId;
	}

}