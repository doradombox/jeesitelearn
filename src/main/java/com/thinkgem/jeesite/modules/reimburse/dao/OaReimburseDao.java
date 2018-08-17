/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.reimburse.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.reimburse.entity.OaReimburse;

/**
 * 报销测试DAO接口
 * @author admin
 * @version 2018-08-13
 */
@MyBatisDao
public interface OaReimburseDao extends CrudDao<OaReimburse> {
	
}