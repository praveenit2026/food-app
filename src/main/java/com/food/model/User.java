package com.food.model;

public class User {
	private int id;
	private String name;
	private String eamil;
	private String password;
	
	public User() {
		
	}

	public User(String name, String eamil, String password) {
		super();
		this.name = name;
		this.eamil = eamil;
		this.password = password;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEamil() {
		return eamil;
	}

	public void setEamil(String eamil) {
		this.eamil = eamil;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", eamil=" + eamil + ", password=" + password + "]";
	}
	
	
}
