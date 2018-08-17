/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.user.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.user.entity.TestData11;
import com.thinkgem.jeesite.modules.user.dao.TestData11Dao;

/**
 * userService
 * @author admin
 * @version 2018-08-13
 */
@Service
@Transactional(readOnly = true)
public class TestData11Service extends CrudService<TestData11Dao, TestData11> {

	public TestData11 get(String id) {
		return super.get(id);
	}
	
	public List<TestData11> findList(TestData11 testData11) {
		return super.findList(testData11);
	}
	
	public Page<TestData11> findPage(Page<TestData11> page, TestData11 testData11) {
		return super.findPage(page, testData11);
	}
	
	@Transactional(readOnly = false)
	public void save(TestData11 testData11) {
		super.save(testData11);
	}
	
	@Transactional(readOnly = false)
	public void delete(TestData11 testData11) {
		super.delete(testData11);
	}
	
}