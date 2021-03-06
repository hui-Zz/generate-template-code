package com.core.generate;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Map;

import freemarker.template.Template;
import freemarker.template.TemplateException;

public class PathUtil {

	// 判断包路径是否存在
	public static void Path_Judge_Exist(String path) {
//		File file = new File(System.getProperty("user.dir"), path);
		File file = new File(path);
		if (!file.exists()) {
			file.mkdirs();
		}
	}

	// 输出到文件
	public static void printFile(Map<String, Object> root, Template template, String filePath, String fileName) throws IOException, TemplateException {
		System.out.println(filePath + fileName + ".java");
//		String path = System.getProperty("user.dir") + filePath;
		File file = new File(filePath, fileName + ".java");
		if (!file.exists()) {
			file.createNewFile();
		}
		FileWriter fw = new FileWriter(file);
		template.process(root, fw);
		fw.close();
	}

	// 输出到控制台
	public static void printConsole(Map<String, Object> root, Template template) throws TemplateException, IOException {
		StringWriter out = new StringWriter();
		template.process(root, out);
		System.out.println(out.toString());
	}
}
