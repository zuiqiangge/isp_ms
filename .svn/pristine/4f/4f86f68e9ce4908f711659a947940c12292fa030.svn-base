package cn.com.pengyue.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ArticleWeightLog entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "article_weight_log")
public class ArticleWeightLog implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer destroyTaskArticleId;
	private Integer lableId;
	private String code;
	private Float beforeWeight;
	private Float afterWeight;
	private Integer weightType;
	private Integer destroyId;

	// Constructors

	/** default constructor */
	public ArticleWeightLog() {
	}

	/** full constructor */
	public ArticleWeightLog(Integer destroyTaskArticleId, Integer lableId,
			String code, Float beforeWeight, Float afterWeight,
			Integer weightType, Integer destroyId) {
		this.destroyTaskArticleId = destroyTaskArticleId;
		this.lableId = lableId;
		this.code = code;
		this.beforeWeight = beforeWeight;
		this.afterWeight = afterWeight;
		this.weightType = weightType;
		this.destroyId = destroyId;
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

	@Column(name = "destroy_task_article_id")
	public Integer getDestroyTaskArticleId() {
		return this.destroyTaskArticleId;
	}

	public void setDestroyTaskArticleId(Integer destroyTaskArticleId) {
		this.destroyTaskArticleId = destroyTaskArticleId;
	}

	@Column(name = "lable_id")
	public Integer getLableId() {
		return this.lableId;
	}

	public void setLableId(Integer lableId) {
		this.lableId = lableId;
	}

	@Column(name = "code")
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "before_weight", precision = 12, scale = 0)
	public Float getBeforeWeight() {
		return this.beforeWeight;
	}

	public void setBeforeWeight(Float beforeWeight) {
		this.beforeWeight = beforeWeight;
	}

	@Column(name = "after_weight", precision = 12, scale = 0)
	public Float getAfterWeight() {
		return this.afterWeight;
	}

	public void setAfterWeight(Float afterWeight) {
		this.afterWeight = afterWeight;
	}

	@Column(name = "weight_type")
	public Integer getWeightType() {
		return this.weightType;
	}

	public void setWeightType(Integer weightType) {
		this.weightType = weightType;
	}

	@Column(name = "destroy_id")
	public Integer getDestroyId() {
		return this.destroyId;
	}

	public void setDestroyId(Integer destroyId) {
		this.destroyId = destroyId;
	}

}