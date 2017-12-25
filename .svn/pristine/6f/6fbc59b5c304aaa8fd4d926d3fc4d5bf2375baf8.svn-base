package cn.com.pengyue.pojo;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "lend_info")
public class LendInfo {
	private int id;
	private User lendUser;
	private Date lendTime;
	private Date returnTime;
	private int isValid;
	private SecretProduct product;
	private Date factReturnTime;
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	@OneToOne(cascade={CascadeType.ALL})  
    @JoinColumn(name="lend_user")  
	public User getLendUser() {
		return lendUser;
	}
	public void setLendUser(User lendUser) {
		this.lendUser = lendUser;
	}
	
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "lend_datetime", nullable = false, length = 10)
	public Date getLendTime() {
		return lendTime;
	}
	public void setLendTime(Date lendTime) {
		this.lendTime = lendTime;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "return_datetime", nullable = false, length = 10)
	public Date getReturnTime() {
		return returnTime;
	}
	public void setReturnTime(Date returnTime) {
		this.returnTime = returnTime;
	}
	
	
	@Column(name = "is_valid")
	public int getIsValid() {
		return isValid;
	}
	public void setIsValid(int isValid) {
		this.isValid = isValid;
	}
	
	@OneToOne(cascade={CascadeType.ALL})  
    @JoinColumn(name="product_id")  
	public SecretProduct getProduct() {
		return product;
	}
	public void setProduct(SecretProduct product) {
		this.product = product;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "fact_return_datetime", nullable = true, length = 10)
	public Date getFactReturnTime() {
		return factReturnTime;
	}
	public void setFactReturnTime(Date factReturnTime) {
		this.factReturnTime = factReturnTime;
	}
	
	
	
	
	
}
