/**
 * @Project project_admin
 * @File ${className}Controller.java
 * @Package ${packageName}
 * @Date ${.now}
 * @Version V1.0
 * @Copyright (c) 2016, www.company.com All Rights Reserved.
 */

package ${packageName};

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @ClassName ${className}Controller
 * @Description ${remark}Controller
 * @Date ${.now}
 */
@Controller
@RequestMapping("/${className?uncap_first}")
public class ${className}Controller {

	@Resource(name = "${className?uncap_first}Service")
	private ${className}Service ${className?uncap_first}Service;

	@Resource(name = "seqService")
	private SequenceService sequenceService;

	/**
	 * @Title to${className}Page
	 * @Description 跳转${remark}列表页面
	 * @author hui
	 * @param request
	 * @param response
	 * @return String 返回类型
	 */
	@RequestMapping({ "", "/index" })
	public String to${className}Page(HttpServletRequest request, HttpServletResponse response) {
		return "/view/${className?uncap_first}/${className?uncap_first}Page";
	}

	/**
	 * @Title query${className}Table
	 * @Description 查询${remark}列表
	 * @author hui
	 * @param request
	 * @param response
	 * @param pager
	 * @param ${className?uncap_first}Query
	 * @return Pager 返回类型
	 */
	@RequestMapping("/query${className}Table")
	@ResponseBody
	public Pager query${className}Table(HttpServletRequest request, HttpServletResponse response, Pager pager, ${className}Query ${className?uncap_first}Query) {
		try {
			Long organId = CookieUtils.getorganId(request);
			${className?uncap_first}Query.setOrganId(organId);
			pager = ${className?uncap_first}Service.query${className}Pager(pager, ${className?uncap_first}Query);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pager;
	}

	/**
	 * @Title toEdit${className}Page
	 * @Description 跳转新建或编辑${remark}页面
	 * @author hui
	 * @param request
	 * @param response
	 * @param id
	 * @param model
	 * @return String 返回类型
	 */
	@RequestMapping("/toEdit${className}Page")
	public String toEdit${className}Page(HttpServletRequest request, HttpServletResponse response, String id, Model model) {
		Long organId = CookieUtils.getorganId(request);
		UserBaseInfo user = SessionUtils.getSessionUser(request);
		Map<String, Object> imageUploadParams = UploadHelper.getImageUploadParams(user.getId());
		model.addAllAttributes(imageUploadParams);
		if (StringUtils.isBlank(id)) {
			return "/view/${className?uncap_first}/add${className}";
		} else {
			try {
				${className}Info ${className?uncap_first}Info = this.${className?uncap_first}Service.query${className}ById(Long.valueOf(id), organId);
				${className}Dto ${className?uncap_first}Dto = ${className}Helper.get${className}Dto(${className?uncap_first}Info);
				model.addAttribute("${className?uncap_first}", ${className?uncap_first}Dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "/view/${className?uncap_first}/edit${className}";
		}
	}

	/**
	 * @Title: toView${className}Page
	 * @Description 查看${remark}
	 * @author hui
	 * @param request
	 * @param response
	 * @param id
	 * @param model
	 * @return String 返回类型
	 */
	@RequestMapping("/toView${className}Page")
	public String toView${className}Page(HttpServletRequest request, HttpServletResponse response, String id, Model model) {
		Long organId = CookieUtils.getorganId(request);
		try {
			${className}Info ${className?uncap_first}Info = this.${className?uncap_first}Service.query${className}ById(Long.valueOf(id), organId);
			${className}Dto ${className?uncap_first}Dto = ${className}Helper.get${className}Dto(${className?uncap_first}Info);
			model.addAttribute("${className?uncap_first}", ${className?uncap_first}Dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/view/${className?uncap_first}/view${className}";
	}

	/**
	 * @Title add${className}
	 * @Description 添加${remark}
	 * @author hui
	 * @param request
	 * @param response
	 * @param ${className?uncap_first}Dto
	 * @return Map<String,String> 返回类型
	 */
	@RequestMapping("/add${className}")
	@ResponseBody
	public Map<String, String> add${className}(HttpServletRequest request, HttpServletResponse response, ${className}Dto ${className?uncap_first}Dto) {
		Map<String, String> resultMap = new HashMap<String, String>();
		Long organId = CookieUtils.getorganId(request);
		Long userId = CookieUtils.getUserId(request);
		try {
			${className}Info ${className?uncap_first}Info = ${className}Helper.get${className}(${className?uncap_first}Dto);
			Long id = this.sequenceService.generateSequenceByTables(SequenceService.CLOUD_${className?upper_case});
			${className?uncap_first}Info.setId(id);
			${className?uncap_first}Info.setOrganId(organId);
			${className?uncap_first}Info.setIsDel(false);
			${className?uncap_first}Info.setCreater(userId);
			${className?uncap_first}Info.setUpdater(userId);
			${className?uncap_first}Info.setCreateTime(new Date());
			${className?uncap_first}Info.setUpdateTime(new Date());
			${className?uncap_first}Service.insert${className}(${className?uncap_first}Info);
			resultMap.put("status", Globaldefine.resultCode.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", "创建失败");
			resultMap.put("status", Globaldefine.resultCode.ERROR_EXP);
		}
		return resultMap;
	}

	/**
	 * @Title update${className}
	 * @Description 修改${remark}
	 * @author hui
	 * @param request
	 * @param response
	 * @param ${className?uncap_first}Dto
	 * @return Map<String,String> 返回类型
	 */
	@RequestMapping("/update${className}")
	@ResponseBody
	public Map<String, String> update${className}(HttpServletRequest request, HttpServletResponse response, ${className}Dto ${className?uncap_first}Dto) {	
		Map<String, String> resultMap = new HashMap<String, String>();
		Long userId = CookieUtils.getUserId(request);
		try {
			${className}Info ${className?uncap_first}Info = ${className}Helper.get${className}(${className?uncap_first}Dto);
			${className?uncap_first}Info.setUpdater(userId);
			${className?uncap_first}Info.setUpdateTime(new Date());
			${className?uncap_first}Service.update${className}(${className?uncap_first}Info);
			resultMap.put("status", Globaldefine.resultCode.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", "修改失败");
			resultMap.put("status", Globaldefine.resultCode.ERROR_EXP);
		}
		return resultMap;
	}

	/**
	 * @Title del${className}
	 * @Description 删除${remark} 支持","分隔批量删除
	 * @author hui
	 * @param request
	 * @param response
	 * @param id
	 * @return Map<String,String> 返回类型
	 */
	@RequestMapping("/del${className}")
	@ResponseBody
	public Map<String, String> del${className}(HttpServletRequest request, HttpServletResponse response, String id) {
		Map<String, String> resultMap = new HashMap<String, String>();
		if (StringUtils.isNotBlank(id)) {
			try {
				this.${className?uncap_first}Service.del${className}(id);
				resultMap.put("status", Globaldefine.resultCode.SUCCESS);
			} catch (Exception e) {
				e.printStackTrace();
				resultMap.put("msg", "删除失败");
				resultMap.put("status", Globaldefine.resultCode.ERROR_EXP);
			}
		} else {
			resultMap.put("msg", "参数错误，非法请求");
			resultMap.put("status", Globaldefine.resultCode.ERROR_EXP);
		}
		return resultMap;
	}

}
