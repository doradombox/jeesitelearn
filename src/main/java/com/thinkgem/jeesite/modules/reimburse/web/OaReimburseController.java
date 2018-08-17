/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.reimburse.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.reimburse.entity.OaReimburse;
import com.thinkgem.jeesite.modules.reimburse.service.OaReimburseService;

/**
 * 报销测试Controller
 * @author admin
 * @version 2018-08-13
 */
@Controller
@RequestMapping(value = "${adminPath}/reimburse/oaReimburse")
public class OaReimburseController extends BaseController {

	@Autowired
	private OaReimburseService oaReimburseService;
	
	@ModelAttribute
	public OaReimburse get(@RequestParam(required=false) String id) {
		OaReimburse entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = oaReimburseService.get(id);
		}
		if (entity == null){
			entity = new OaReimburse();
		}
		return entity;
	}
	
	@RequiresPermissions("reimburse:oaReimburse:view")
	@RequestMapping(value = {"list", ""})
	public String list(OaReimburse oaReimburse, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaReimburse> page = oaReimburseService.findPage(new Page<OaReimburse>(request, response), oaReimburse); 
		model.addAttribute("page", page);
		return "modules/reimburse/oaReimburseList";
	}

	@RequiresPermissions("reimburse:oaReimburse:view")
	@RequestMapping(value = "form")
	public String form(OaReimburse oaReimburse, Model model) {
		model.addAttribute("oaReimburse", oaReimburse);
		return "modules/reimburse/oaReimburseForm";
	}

	@RequiresPermissions("reimburse:oaReimburse:edit")
	@RequestMapping(value = "save")
	public String save(OaReimburse oaReimburse, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, oaReimburse)){
			return form(oaReimburse, model);
		}
		oaReimburseService.save(oaReimburse);
		addMessage(redirectAttributes, "保存报销申请成功");
		return "redirect:"+Global.getAdminPath()+"/reimburse/oaReimburse/?repage";
	}
	
	@RequiresPermissions("reimburse:oaReimburse:edit")
	@RequestMapping(value = "delete")
	public String delete(OaReimburse oaReimburse, RedirectAttributes redirectAttributes) {
		oaReimburseService.delete(oaReimburse);
		addMessage(redirectAttributes, "删除报销申请成功");
		return "redirect:"+Global.getAdminPath()+"/reimburse/oaReimburse/?repage";
	}

}