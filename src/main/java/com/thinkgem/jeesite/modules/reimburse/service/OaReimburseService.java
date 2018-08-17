/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.reimburse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.reimburse.entity.OaReimburse;
import com.thinkgem.jeesite.modules.reimburse.dao.OaReimburseDao;
import com.thinkgem.jeesite.modules.reimburse.entity.OaReimburseDetail;
import com.thinkgem.jeesite.modules.reimburse.dao.OaReimburseDetailDao;

/**
 * 报销测试Service
 * @author admin
 * @version 2018-08-13
 */
@Service
@Transactional(readOnly = true)
public class OaReimburseService extends CrudService<OaReimburseDao, OaReimburse> {

	@Autowired
	private OaReimburseDetailDao oaReimburseDetailDao;
	
	public OaReimburse get(String id) {
		OaReimburse oaReimburse = super.get(id);
		oaReimburse.setOaReimburseDetailList(oaReimburseDetailDao.findList(new OaReimburseDetail(oaReimburse)));
		return oaReimburse;
	}
	
	public List<OaReimburse> findList(OaReimburse oaReimburse) {
		return super.findList(oaReimburse);
	}
	
	public Page<OaReimburse> findPage(Page<OaReimburse> page, OaReimburse oaReimburse) {
		return super.findPage(page, oaReimburse);
	}
	
	@Transactional(readOnly = false)
	public void save(OaReimburse oaReimburse) {
		super.save(oaReimburse);
		for (OaReimburseDetail oaReimburseDetail : oaReimburse.getOaReimburseDetailList()){
			if (oaReimburseDetail.getId() == null){
				continue;
			}
			if (OaReimburseDetail.DEL_FLAG_NORMAL.equals(oaReimburseDetail.getDelFlag())){
				if (StringUtils.isBlank(oaReimburseDetail.getId())){
					oaReimburseDetail.setOaReimburse(oaReimburse);
					oaReimburseDetail.preInsert();
					oaReimburseDetailDao.insert(oaReimburseDetail);
				}else{
					oaReimburseDetail.preUpdate();
					oaReimburseDetailDao.update(oaReimburseDetail);
				}
			}else{
				oaReimburseDetailDao.delete(oaReimburseDetail);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(OaReimburse oaReimburse) {
		super.delete(oaReimburse);
		oaReimburseDetailDao.delete(new OaReimburseDetail(oaReimburse));
	}
	
}