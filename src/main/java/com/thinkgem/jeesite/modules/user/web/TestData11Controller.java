/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.user.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.modules.user.entity.TestData11;
import com.thinkgem.jeesite.modules.user.service.TestData11Service;

/**
 * userController
 * 
 * @author admin
 * @version 2018-08-13
 */
@Controller
@RequestMapping(value = "${adminPath}/user/testData11")
public class TestData11Controller extends BaseController {

	@Autowired
	private TestData11Service testData11Service;

	@ModelAttribute
	public TestData11 get(@RequestParam(required = false) String id) {
		TestData11 entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = testData11Service.get(id);
		}
		if (entity == null) {
			entity = new TestData11();
		}
		return entity;
	}

	@RequiresPermissions("user:testData11:view")
	@RequestMapping(value = { "list", "" })
	public String list(TestData11 testData11, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TestData11> page = testData11Service.findPage(new Page<TestData11>(request, response), testData11);
		model.addAttribute("page", page);
		return "modules/user/testData11List";
	}

	@RequiresPermissions("user:testData11:view")
	@RequestMapping(value = "form")
	public String form(TestData11 testData11, Model model) {
		model.addAttribute("testData11", testData11);
		return "modules/user/testData11Form";
	}

	/*
	 * @RequiresPermissions("user:testData11:edit")
	 * 
	 * @RequestMapping(value = "download") public String
	 * downloadTemplate(HttpServletResponse response, RedirectAttributes
	 * redirectAttributes) { try { String fileName = "课程表数据导入模板.xlsx";
	 * List<JslCourse> list = Lists.newArrayList(); list.add(new JslCourse()); new
	 * ExportExcel("课程表数据", JslCourse.class, 2).setDataList(list).write(response,
	 * fileName).dispose(); return null; } catch (Exception e) {
	 * addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage()); } return
	 * "redirect:" + adminPath + "/jsl/jslCourse?repage"; }
	 */

	@RequiresPermissions("user:testData11:view")
	@RequestMapping(value = "import/template")
	public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "信息数据导入模板.xlsx";
			List<TestData11> list = Lists.newArrayList();
			list.add(new TestData11());
			new ExportExcel("信息数据", TestData11.class, 2).setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/user/testData11/list?repage";
	}

	/**
	 * excel导入
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "import", method=RequestMethod.POST)
	public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
	    try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<TestData11> list = ei.getDataList(TestData11.class);
			for (TestData11 testData11 : list){
				try{
					testData11Service.save(testData11);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条员工记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条员工记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入员工失败！失败信息："+e.getMessage());
		}
	    return "redirect:" + adminPath + "/user/testData11/list?repage";
	}
	
	@RequestMapping(value = "export", method=RequestMethod.POST)
	public String exportFile(TestData11 testData11, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
	    try {
	        String fileName = "信息数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
	        // 调用获取数据的方法 ... 省略 6         
	        Page<TestData11> page = testData11Service.findPage(new Page<TestData11>(request, response, -1), testData11);
	        new ExportExcel("信息数据", TestData11.class).setDataList(page.getList()).write(response, fileName).dispose();
	        return null;
	    } catch (Exception e) {
	        addMessage(redirectAttributes, "信息数据导出失败！失败信息："+e.getMessage());
	    }
	    return "redirect:" + adminPath + "/user/testData11/list?repage";
	}

	@RequiresPermissions("user:testData11:edit")
	@RequestMapping(value = "save")
	public String save(TestData11 testData11, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, testData11)) {
			return form(testData11, model);
		}
		testData11Service.save(testData11);
		addMessage(redirectAttributes, "保存user成功");
		return "redirect:" + Global.getAdminPath() + "/user/testData11/?repage";
	}

	@RequiresPermissions("user:testData11:edit")
	@RequestMapping(value = "delete")
	public String delete(TestData11 testData11, RedirectAttributes redirectAttributes) {
		testData11Service.delete(testData11);
		addMessage(redirectAttributes, "删除user成功");
		return "redirect:" + Global.getAdminPath() + "/user/testData11/?repage";
	}

}