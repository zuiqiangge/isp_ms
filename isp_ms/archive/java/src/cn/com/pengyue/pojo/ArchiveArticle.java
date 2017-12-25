package cn.com.pengyue.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ArchiveArticle entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "archive_article")
public class ArchiveArticle implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private Integer lableId;
	private String lableCode;
	private String selfCode;
	private String pic;
	private String detailsInfo;
	private Integer archiveId;

	// Constructors

	/** default constructor */
	public ArchiveArticle() {
	}

	/** full constructor */
	public ArchiveArticle(String name, Integer lableId, String lableCode,
			String selfCode, String pic, String detailsInfo, Integer archiveId) {
		this.name = name;
		this.lableId = lableId;
		this.lableCode = lableCode;
		this.selfCode = selfCode;
		this.pic = pic;
		this.detailsInfo = detailsInfo;
		this.archiveId = archiveId;
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

	@Column(name = "lable_id")
	public Integer getLableId() {
		return this.lableId;
	}

	public void setLableId(Integer lableId) {
		this.lableId = lableId;
	}

	@Column(name = "lable_code")
	public String getLableCode() {
		return this.lableCode;
	}

	public void setLableCode(String lableCode) {
		this.lableCode = lableCode;
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

	@Column(name = "details_info")
	public String getDetailsInfo() {
		return this.detailsInfo;
	}

	public void setDetailsInfo(String detailsInfo) {
		this.detailsInfo = detailsInfo;
	}

	@Column(name = "archive_id")
	public Integer getArchiveId() {
		return this.archiveId;
	}

	public void setArchiveId(Integer archiveId) {
		this.archiveId = archiveId;
	}

}