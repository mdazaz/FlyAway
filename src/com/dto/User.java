package com.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="users")
	public class User {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ID")
	    private int id;
	@Column(name="FIRST_NAME",length = 100)
	    private String fname;
	@Column(name="LAST_NAME",length = 100)
	    private String lname;
	@Column(name="USER_NAME",length = 60, unique=true)
	    private String userName;
	@Column(name="PASSWORD")
	    private String password;
	@Column(name="EMAIL")
	    private String email;
	@Column(name="PHONE",length = 12)
	    private String phone;
	@Column(name="CITY",length = 100)
	    private String city;
	@Column(name="COUNTRY",length = 100)
	    private String country;
	@Column(name="GENDER",length = 6)
	    private char gender;
	    
	    public User() {};
	 
	    public User(String fname, String lname, String userName, String password, String email, String phone,
				String city, String country, char gender) {
			this.fname = fname;
			this.lname = lname;
			this.userName = userName;
			this.password = password;
			this.email = email;
			this.phone = phone;
			this.city = city;
			this.country = country;
			this.gender = gender;
		}

		public char getGender() {
			return gender;
		}

		public void setGender(char gender) {
			this.gender = gender;
		}

		public String getFname() {
			return fname;
		}

		public void setFname(String fname) {
			this.fname = fname;
		}

		public String getLname() {
			return lname;
		}

		public void setLname(String lname) {
			this.lname = lname;
		}

		public String getCountry() {
			return country;
		}

		public void setCountry(String country) {
			this.country = country;
		}

		public int getId() {
	        return id;
	    }
	 
	    public void setId(int id) {
	        this.id = id;
	    }
	 
	    public String getUserName() {
	        return userName;
	    }
	 
	    public void setUserName(String userName) {
	        this.userName = userName;
	    }
	 
	    public String getPassword() {
	        return password;
	    }
	 
	    public void setPassword(String password) {
	        this.password = password;
	    }
	 
	    public String getEmail() {
	        return email;
	    }
	 
	    public void setEmail(String email) {
	        this.email = email;
	    }
	 
	    public String getPhone() {
	        return phone;
	    }
	 
	    public void setPhone(String phone) {
	        this.phone = phone;
	    }
	 
	    public String getCity() {
	        return city;
	    }
	 
	    public void setCity(String city) {
	        this.city = city;
	    }
	 
	}


