/**
 * @Project project_admin
 * @File ${className}Dao.java
 * @Package ${packageName}
 * @Date ${.now}
 * @Version V1.0
 * @Copyright (c) 2016, www.company.com All Rights Reserved.
 */

package ${packageName};

import java.util.List;

import org.apache.ibatis.annotations.Param;

/**
 * @ClassName AlbumImagesDao
 * @Description ${remark}Dao
 * @Date ${.now}
 */
public interface ${className}Dao {

	/**
	 * @Title query${className}List
	 * @Description 查询${remark}
	 * @author hui
	 * @param ${className?uncap_first}Query
	 * @return List<${className}Info> 返回类型
	 */
	public List<${className}Info> query${className}List(${className}Query ${className?uncap_first}Query);

	/**
	 * @Title query${className}ById
	 * @Description 根据ID查询${remark}
	 * @author hui
	 * @param id
	 * @return ${className}Info 返回类型
	 */
	public ${className}Info query${className}ById(@Param("id") Long id, @Param("organId") Long organId);

	/**
	 * @Title insert${className}
	 * @Description 添加${remark}
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
	 * @Title delBatch${className}
	 * @Description 批量删除${remark}
	 * @author hui
	 * @param ${className?uncap_first}Ids
	 */
	public void delBatch${className}(@Param("list") List<Long> ${className?uncap_first}Ids);

}
