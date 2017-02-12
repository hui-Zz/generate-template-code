/**
 * @Project project_admin
 * @File ${className}Service.java
 * @Package ${packageName}
 * @Date ${.now}
 * @Version V1.0
 * @Copyright (c) 2016, www.company.com All Rights Reserved.
 */

package ${packageName};

<#if !implflag>

import java.util.List;

/**
 * @ClassName {className}Service
 * @Description ${remark}接口服务
 * @Date ${.now}
 */
public interface ${className}Service {

	/**
	 * @Title query${className}List
	 * @Description 查询${remark}
	 * @author hui
	 * @param ${className?uncap_first}Query
	 * @return List<${className}Info> 返回类型
	 */
	public List<${className}Info> query${className}List(${className}Query ${className?uncap_first}Query);

	/**
	 * @Title query${className}Pager
	 * @Description 查询${remark}分页
	 * @author hui
	 * @param pager
	 * @param ${className?uncap_first}Query
	 * @return Pager 返回类型
	 * @throws NoDateResultException
	 */
	public Pager query${className}Pager(Pager pager, ${className}Query ${className?uncap_first}Query);

	/**
	 * @Title query${className}ById
	 * @Description 根据ID查询${remark}
	 * @author hui
	 * @param id
	 * @return ${className}Info 返回类型
	 */
	public ${className}Info query${className}ById(Long id, Long organId) throws NoDateResultException;

	/**
	 * @Title insert${className}
	 * @Description 新增${remark}
	 * @author hui
	 * @param ${className?uncap_first}Info
	 */
	public void insert${className}(${className}Info ${className?uncap_first}Info);

	/**
	 * @Title update${className}
	 * @Description 修改${remark}
	 * @author hui
	 * @param ${className?uncap_first}Info
	 */
	public void update${className}(${className}Info ${className?uncap_first}Info);

	/**
	 * @Title del${className}
	 * @Description 删除${remark} 支持","分隔批量删除
	 * @author hui
	 * @param id
	 */
	public void del${className}(String ids) throws NoDateResultException;

}
<#else>
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

/**
 * @Title ${className}ServiceImpl
 * @Description ${remark}接口服务实现
 * @Date ${.now}
 */
@Service("${className?uncap_first}Service")
public class ${className}ServiceImpl extends SqlSessionWrapper implements ${className}Service {

	@Resource
	private ${className}Dao ${className?uncap_first}Dao;

	@Override
	public List<${className}Info> query${className}List(${className}Query ${className?uncap_first}Query) {
		return ${className?uncap_first}Dao.query${className}List(${className?uncap_first}Query);
	}

	@Override
	public Pager query${className}Pager(Pager pager, ${className}Query ${className?uncap_first}Query) {
		return this.selectPagination("${daoPackageName}.${className}Dao.query${className}List", ${className?uncap_first}Query, pager);
	}

	@Override
	public ${className}Info query${className}ById(Long id, Long organId) throws NoDateResultException {
		${className}Info ${className?uncap_first}Info = ${className?uncap_first}Dao.query${className}ById(id, organId);
		if (${className?uncap_first}Info == null) {
			throw new NoDateResultException("${className}数据查询为空,id:" + id + ",organId:" + organId);
		}
		return ${className?uncap_first}Info;
	}

	@Override
	public void insert${className}(${className}Info ${className?uncap_first}Info) {
		${className?uncap_first}Dao.insert${className}(${className?uncap_first}Info);
	}

	@Override
	public void update${className}(${className}Info ${className?uncap_first}Info) {
		${className?uncap_first}Dao.update${className}(${className?uncap_first}Info);
	}

	@Override
	public void del${className}(String ids) throws NoDateResultException {
		if (StringUtils.isNotBlank(ids)) {
			String[] arrayIds = ids.split(",");
			List<Long> idsList = new ArrayList<Long>();
			for (String id : arrayIds) {
				idsList.add(Long.valueOf(id));
			}
			${className?uncap_first}Dao.delBatch${className}(idsList);
		} else {
			throw new NoDateResultException("参数错误，非法请求");
		}
	}

}
</#if>