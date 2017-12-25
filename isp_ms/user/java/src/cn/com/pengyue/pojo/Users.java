package cn.com.pengyue.pojo;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import cn.com.pengyue.util.Md5Utils;

/**
 * Users entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "users")
public class Users implements java.io.Serializable {

	// Fields

	private Integer id;
	private String nickName;
	private String userName;
	private String passWord;
	private Integer role;
	private java.util.Date lastLoginTime;
	private String status;	//0禁用 1启用
	private Integer bmId;//部门id
	private Integer positionId;
	
	private Integer isLeader;//是否是领导
	
	private Department department;
	private Position position;
	

	private String realPassWord;

	// Constructors

	/** default constructor */
	public Users() {
	}

	/** full constructor */
	public Users(String userName, String passWord, Integer role) {
		this.userName = userName;
		this.passWord = passWord;
		this.role = role;
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

	@Column(name = "user_name", length = 200)
	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Column(name = "pass_word", length = 32)
	public String getPassWord() {
		return this.passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	@Column(name = "role")
	public Integer getRole() {
		return this.role;
	}

	public void setRole(Integer role) {
		this.role = role;
	}

	@Column(name = "last_login_time")
	public java.util.Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(java.util.Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	@Column(name="status")
	public String getStatus() {
		return status;
	}

	
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Transient
	public String getRealPassWord() {
		return realPassWord;
	}

	public void setRealPassWord(String realPassWord) {
		this.realPassWord = realPassWord;
		this.passWord = Md5Utils.md5(realPassWord);
	}
	
	@Column(name = "nick_name")
	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	
	@Column(name = "BM_id")
	public Integer getBmId() {
		return bmId;
	}

	public void setBmId(Integer bmId) {
		this.bmId = bmId;
	}
	@Column(name = "is_leader")
	public Integer getIsLeader() {
		return isLeader;
	}

	public void setIsLeader(Integer isLeader) {
		this.isLeader = isLeader;
	}

	@Transient
	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}
	
	@Column(name = "position_id")
	public Integer getPositionId() {
		return positionId;
	}

	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}
	
	@Transient
	public Position getPosition() {
		return position;
	}

	public void setPosition(Position position) {
		this.position = position;
	}
	
	

}