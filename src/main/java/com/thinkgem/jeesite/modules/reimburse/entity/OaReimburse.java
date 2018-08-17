/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.reimburse.entity;

import com.thinkgem.jeesite.modules.sys.entity.User;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 报销测试Entity
 * @author admin
 * @version 2018-08-13
 */
public class OaReimburse extends DataEntity<OaReimburse> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 出差人
	private String month;		// 月份
	private String reimburseDate;		// 报销日期
	private String reimburseType;		// 报销类型
	private String businessDays;		// 出差天数
	private Double travelAllowance;		// 差补总和
	private Double jtfyzh;		// 交通费用总和
	private Double zsfyzh;		// 餐费总和
	private Double cfzh;		// 餐费总和
	private Double zdfzh;		// 招待费总和
	private Double zlfzh;		// 租赁费总和
	private Double flfzh;		// 福利费总和
	private Double tbfzh;		// 投标费总和
	private Double bgypzh;		// 办公用品总和
	private Double qtzh;		// 其他总和
	private String bxzh;		// 报销总和
	private List<OaReimburseDetail> oaReimburseDetailList = Lists.newArrayList();		// 子表列表
	
	public OaReimburse() {
		super();
	}

	public OaReimburse(String id){
		super(id);
	}

	@NotNull(message="出差人不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=1, max=64, message="月份长度必须介于 1 和 64 之间")
	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}
	
	@Length(min=1, max=64, message="报销日期长度必须介于 1 和 64 之间")
	public String getReimburseDate() {
		return reimburseDate;
	}

	public void setReimburseDate(String reimburseDate) {
		this.reimburseDate = reimburseDate;
	}
	
	@Length(min=1, max=11, message="报销类型长度必须介于 1 和 11 之间")
	public String getReimburseType() {
		return reimburseType;
	}

	public void setReimburseType(String reimburseType) {
		this.reimburseType = reimburseType;
	}
	
	@Length(min=1, max=11, message="出差天数长度必须介于 1 和 11 之间")
	public String getBusinessDays() {
		return businessDays;
	}

	public void setBusinessDays(String businessDays) {
		this.businessDays = businessDays;
	}
	
	@NotNull(message="差补总和不能为空")
	public Double getTravelAllowance() {
		return travelAllowance;
	}

	public void setTravelAllowance(Double travelAllowance) {
		this.travelAllowance = travelAllowance;
	}
	
	public Double getJtfyzh() {
		return jtfyzh;
	}

	public void setJtfyzh(Double jtfyzh) {
		this.jtfyzh = jtfyzh;
	}
	
	public Double getZsfyzh() {
		return zsfyzh;
	}

	public void setZsfyzh(Double zsfyzh) {
		this.zsfyzh = zsfyzh;
	}
	
	public Double getCfzh() {
		return cfzh;
	}

	public void setCfzh(Double cfzh) {
		this.cfzh = cfzh;
	}
	
	public Double getZdfzh() {
		return zdfzh;
	}

	public void setZdfzh(Double zdfzh) {
		this.zdfzh = zdfzh;
	}
	
	public Double getZlfzh() {
		return zlfzh;
	}

	public void setZlfzh(Double zlfzh) {
		this.zlfzh = zlfzh;
	}
	
	public Double getFlfzh() {
		return flfzh;
	}

	public void setFlfzh(Double flfzh) {
		this.flfzh = flfzh;
	}
	
	public Double getTbfzh() {
		return tbfzh;
	}

	public void setTbfzh(Double tbfzh) {
		this.tbfzh = tbfzh;
	}
	
	public Double getBgypzh() {
		return bgypzh;
	}

	public void setBgypzh(Double bgypzh) {
		this.bgypzh = bgypzh;
	}
	
	public Double getQtzh() {
		return qtzh;
	}

	public void setQtzh(Double qtzh) {
		this.qtzh = qtzh;
	}
	
	public String getBxzh() {
		return bxzh;
	}

	public void setBxzh(String bxzh) {
		this.bxzh = bxzh;
	}
	
	public List<OaReimburseDetail> getOaReimburseDetailList() {
		return oaReimburseDetailList;
	}

	public void setOaReimburseDetailList(List<OaReimburseDetail> oaReimburseDetailList) {
		this.oaReimburseDetailList = oaReimburseDetailList;
	}
}