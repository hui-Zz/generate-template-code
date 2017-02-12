package com.core.generate;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class GenerateService {

	public static void Generate(String ftlPath, String ftlName, String fileName, String filePath, String packageName, String daoPackageName, String modelPackageName,
			String remark) throws IOException, TemplateException {

		String ImplFilePath = filePath + "\\impl\\";
		PathUtil.Path_Judge_Exist(ftlPath);
		PathUtil.Path_Judge_Exist(filePath);
		PathUtil.Path_Judge_Exist(ImplFilePath);

		// 实体类需要其他参数
		Map<String, Object> root = new HashMap<String, Object>();
		root.put("modelPackageName", modelPackageName);
		root.put("daoPackageName", daoPackageName);
		root.put("packageName", packageName);
		root.put("className", fileName);
		root.put("implflag", false);
		root.put("remark", remark);
		Configuration cfg = new Configuration();
		String path = System.getProperty("user.dir") + ftlPath;

		cfg.setDirectoryForTemplateLoading(new File(path));
		Template template = cfg.getTemplate(ftlName);

		PathUtil.printFile(root, template, filePath, fileName + "Service");

		// 生成Impl文件
		root.put("ImplPackageName", packageName + "." + fileName + "Service");
		root.put("packageName", packageName + ".impl");
		root.put("implflag", true);
		PathUtil.printFile(root, template, ImplFilePath, fileName + "ServiceImpl");

	}
}
