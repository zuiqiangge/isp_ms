package cn.com.pengyue.pojo;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "log")
public class Log {
	private int id;
	private String operateName;
	private SecretProduct product;
	private LendInfo lend;
	private Date caozuoTime;
	
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	@Column(name = "caozuo_name")
	public String getOperateName() {
		return operateName;
	}
	public void setOperateName(String operateName) {
		this.operateName = operateName;
	}
	
	@OneToOne(cascade={CascadeType.ALL})
    @JoinColumn(name="product_id")  
	public SecretProduct getProduct() {
		return product;
	}
	public void setProduct(SecretProduct product) {
		this.product = product;
	}
	
	@OneToOne(cascade={CascadeType.ALL})
    @JoinColumn(name="lend_id")  
	public LendInfo getLend() {
		return lend;
	}
	public void setLend(LendInfo lend) {
		this.lend = lend;
	}
	
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "caozuo_datetime", nullable = false, length = 10)
	public Date getCaozuoTime() {
		return caozuoTime;
	}
	public void setCaozuoTime(Date caozuoTime) {
		this.caozuoTime = caozuoTime;
	}
	
	

	
	
	
}
