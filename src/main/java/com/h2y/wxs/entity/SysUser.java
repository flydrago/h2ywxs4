package com.h2y.wxs.entity;

import java.util.Date;

/**
 * SysUser Model create
 * 
 * @author hwttnet version:1.2 time:2014-10-18 email:info@hwttnet.com
 */

public class SysUser {

	public static final String key = "keySysUser";
	private long id;
	private long unitId;
	private long userOrd;
	private String userName;
	private String userLogin;
	private String userPwd;
	private String mobile;
	private String email;
	private String userCord;
	private Date updateDate;
	private long ifLock;
	private long ifDelete;
	private long reverse1;
	private String reverse2;
	private String reverse3;

	public SysUser() {
		super();
	}

	public SysUser(long id) {
		super();
		this.id = id;
	}

	public SysUser(long id, long unitId, long userOrd, String userName, String userLogin, String userPwd, String mobile, String email, String userCord, Date updateDate, long ifLock, long ifDelete, long reverse1, String reverse2, String reverse3) {
		super();
		this.id = id;
		this.unitId = unitId;
		this.userOrd = userOrd;
		this.userName = userName;
		this.userLogin = userLogin;
		this.userPwd = userPwd;
		this.mobile = mobile;
		this.email = email;
		this.userCord = userCord;
		this.updateDate = updateDate;
		this.ifLock = ifLock;
		this.ifDelete = ifDelete;
		this.reverse1 = reverse1;
		this.reverse2 = reverse2;
		this.reverse3 = reverse3;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getUnitId() {
		return unitId;
	}

	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

	public long getUserOrd() {
		return userOrd;
	}

	public void setUserOrd(long userOrd) {
		this.userOrd = userOrd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserLogin() {
		return userLogin;
	}

	public void setUserLogin(String userLogin) {
		this.userLogin = userLogin;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUserCord() {
		return userCord;
	}

	public void setUserCord(String userCord) {
		this.userCord = userCord;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public long getIfLock() {
		return ifLock;
	}

	public void setIfLock(long ifLock) {
		this.ifLock = ifLock;
	}

	public long getIfDelete() {
		return ifDelete;
	}

	public void setIfDelete(long ifDelete) {
		this.ifDelete = ifDelete;
	}

	public long getReverse1() {
		return reverse1;
	}

	public void setReverse1(long reverse1) {
		this.reverse1 = reverse1;
	}

	public String getReverse2() {
		return reverse2;
	}

	public void setReverse2(String reverse2) {
		this.reverse2 = reverse2;
	}

	public String getReverse3() {
		return reverse3;
	}

	public void setReverse3(String reverse3) {
		this.reverse3 = reverse3;
	}

	public String toString() {
		return "id:" + id + "\t" + "unitId:" + unitId + "\t" + "userOrd:" + userOrd + "\t" + "userName:" + userName + "\t" + "userLogin:" + userLogin + "\t" + "userPwd:" + userPwd + "\t" + "mobile:" + mobile + "\t" + "email:" + email + "\t" + "userCord:" + userCord + "\t" + "updateDate:" + updateDate + "\t" + "ifLock:" + ifLock + "\t" + "ifDelete:" + ifDelete + "\t" + "reverse1:" + reverse1 + "\t" + "reverse2:" + reverse2 + "\t" + "reverse3:" + reverse3;
	}
}