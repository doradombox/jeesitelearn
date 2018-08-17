/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.reimburse.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 报销测试Entity
 * @author admin
 * @version 2018-08-13
 */
public class OaReimburseDetail extends DataEntity<OaReimburseDetail> {
	
	private static final long serialVersionUID = 1L;
	private OaReimburse oaReimburse;		// 关联id 父类
	private String targetProject;		// 出差项目
	private String custom;		// 客户
	private String tarPlace;		// 出差地点
	private String projectManager;		// 项目经理
	private Double amount;		// 金额
	private String ticket;		// 票计
	private String cause;		// 事由
	
	public OaReimburseDetail() {
		super();
	}

	public OaReimburseDetail(String id){
		super(id);
	}

	public OaReimburseDetail(OaReimburse oaReimburse){
		this.oaReimburse = oaReimburse;
	}

	@Length(min=1, max=64, message="关联id长度必须介于 1 和 64 之间")
	public OaReimburse getOaReimburse() {
		return oaReimburse;
	}

	public void setOaReimburse(OaReimburse oaReimburse) {
		this.oaReimburse = oaReimburse;
	}
	
	@Length(min=0, max=128, message="出差项目长度必须介于 0 和 128 之间")
	public String getTargetProject() {
		return targetProject;
	}

	public void setTargetProject(String targetProject) {
		this.targetProject = targetProject;
	}
	
	@Length(min=0, max=128, message="客户长度必须介于 0 和 128 之间")
	public String getCustom() {
		return custom;
	}

	public void setCustom(String custom) {
		this.custom = custom;
	}
	
	@Length(min=0, max=32, message="出差地点长度必须介于 0 和 32 之间")
	public String getTarPlace() {
		return tarPlace;
	}

	public void setTarPlace(String tarPlace) {
		this.tarPlace = tarPlace;
	}
	
	@Length(min=0, max=32, message="项目经理长度必须介于 0 和 32 之间")
	public String getProjectManager() {
		return projectManager;
	}

	public void setProjectManager(String projectManager) {
		this.projectManager = projectManager;
	}
	
	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}
	
	@Length(min=0, max=11, message="票计长度必须介于 0 和 11 之间")
	public String getTicket() {
		return ticket;
	}

	public void setTicket(String ticket) {
		this.ticket = ticket;
	}
	
	@Length(min=0, max=1024, message="事由长度必须介于 0 和 1024 之间")
	public String getCause() {
		return cause;
	}

	public void setCause(String cause) {
		this.cause = cause;
	}
	
}