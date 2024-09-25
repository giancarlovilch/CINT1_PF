package com.mycompany.soloboticas.model;

import java.sql.Timestamp;

public class Orders {

	private int oid;
	private String pid;
	private int price;
	private int quantity;
	private String sid; 
	private Timestamp orderdatetime;
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public Timestamp getOrderdatetime() {
		return orderdatetime;
	}
	public void setOrderdatetime(Timestamp orderdatetime) {
		this.orderdatetime = orderdatetime;
	}
	
	

}
