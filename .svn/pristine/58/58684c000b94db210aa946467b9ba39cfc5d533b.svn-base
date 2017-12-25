package cn.com.pengyue.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import cn.com.pengyue.pojo.ArticlesType;

/**
 * Applyarticle entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "applyarticle")
public class Applyarticle implements java.io.Serializable {

	// Fields

	private Integer id;
	private String articleName;
	private String articleCode;
	private Integer applyId;
	private String picture;
	private String describe;
	private int articleType;

	// Constructors

	/** default constructor */
	public Applyarticle() {
	}

	/** minimal constructor */
	public Applyarticle(Integer id, String articleName, Integer applyId) {
		this.id = id;
		this.articleName = articleName;
		this.applyId = applyId;
	}

	/** full constructor */
	public Applyarticle(Integer id, String articleName, String articleCode,
			Integer applyId, String picture, String describe) {
		this.id = id;
		this.articleName = articleName;
		this.articleCode = articleCode;
		this.applyId = applyId;
		this.picture = picture;
		this.describe = describe;
	}

	// Property accessors
	@Id
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "article_name", nullable = false)
	public String getArticleName() {
		return this.articleName;
	}

	public void setArticleName(String articleName) {
		this.articleName = articleName;
	}

	@Column(name = "article_code")
	public String getArticleCode() {
		return this.articleCode;
	}

	public void setArticleCode(String articleCode) {
		this.articleCode = articleCode;
	}

	@Column(name = "apply_id", nullable = false)
	public Integer getApplyId() {
		return this.applyId;
	}

	public void setApplyId(Integer applyId) {
		this.applyId = applyId;
	}

	@Column(name = "picture")
	public String getPicture() {
		return this.picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	@Column(name = "describe")
	public String getDescribe() {
		return this.describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}
	@Column(name="article_type")
	public int getArticleType() {
		return articleType;
	}

	public void setArticleType(int articleType) {
		this.articleType = articleType;
	}


}