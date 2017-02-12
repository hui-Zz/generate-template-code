package com.core.generate;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import freemarker.template.TemplateException;

/**
 * @Description: 自动生成各分层代码
 * @author hui
 * @date 2016-09-01 15:27:46
 */
public class Generate {

	public static void main(String[] args)
			throws IOException, TemplateException, ParserConfigurationException, SAXException {
		String ftlPath = "";
		String fileName = "";
		String remark = "";

		String modelFtlName = "";
		String modelFilePath = "";
		String modelPackageName = "";

		String daoFtlName = "";
		String daoFilePath = "";
		String daoPackageName = "";

		String serviceFtlName = "";
		String serviceFilePath = "";
		String servicePackageName = "";

		String controllerFtlName = "";
		String controllerFilePath = "";
		String controllerPackageName = "";

		List<Object> modellist = new ArrayList<Object>();

		File xmlFile = new File(System.getProperty("user.dir"), "\\src\\com\\core\\generate\\GenerateConf.xml");
		DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = builderFactory.newDocumentBuilder();
		Document doc = builder.parse(xmlFile);
		// 获取根元素
		Element rootElement = doc.getDocumentElement();
		// 获取ftl目录
		Node ftlnode = rootElement.getElementsByTagName("ftl").item(0);
		ftlPath = ((Element) ftlnode).getAttribute("path");
		// 获取ftl文件名称
		NodeList params = ftlnode.getChildNodes();
		for (int i = 0; i < params.getLength(); i++) {
			Node node = params.item(i);
			if (node.getNodeType() != Node.ELEMENT_NODE) {
				continue;
			}
			Element e = (Element) node;
			if (e.getAttribute("name").trim().equals("model")) {
				modelFtlName = node.getFirstChild().getNodeValue();
			}
			if (e.getAttribute("name").trim().equals("dao")) {
				daoFtlName = node.getFirstChild().getNodeValue();
			}
			if (e.getAttribute("name").trim().equals("service")) {
				serviceFtlName = node.getFirstChild().getNodeValue();
			}
			if (e.getAttribute("name").trim().equals("controller")) {
				controllerFtlName = node.getFirstChild().getNodeValue();
			}
		}
		// 获取各个ftl需要的信息
		Node controllerNode = rootElement.getElementsByTagName("controller").item(0);
		controllerFilePath = ((Element) controllerNode).getAttribute("path");
		controllerPackageName = controllerNode.getChildNodes().item(1).getFirstChild().getNodeValue();

		Node serviceNode = rootElement.getElementsByTagName("service").item(0);
		serviceFilePath = ((Element) serviceNode).getAttribute("path");
		servicePackageName = serviceNode.getChildNodes().item(1).getFirstChild().getNodeValue();

		Node daoNode = rootElement.getElementsByTagName("dao").item(0);
		daoFilePath = ((Element) daoNode).getAttribute("path");
		daoPackageName = daoNode.getChildNodes().item(1).getFirstChild().getNodeValue();

		Node modelNode = rootElement.getElementsByTagName("model").item(0);
		modelFilePath = ((Element) modelNode).getAttribute("path");
		params = modelNode.getChildNodes();
		for (int i = 0; i < params.getLength(); i++) {
			Node node = params.item(i);
			if (node.getNodeType() != Node.ELEMENT_NODE) {
				continue;
			}
			Element e = (Element) node;
			if (e.getNodeName().trim().equals("packageName")) {
				modelPackageName = node.getFirstChild().getNodeValue();
			}
			if (e.getNodeName().trim().equals("class")) {
				fileName = node.getFirstChild().getNodeValue();
			}
			if (e.getNodeName().trim().equals("remark")) {
				remark = node.getFirstChild().getNodeValue();
			}
			if (e.getNodeName().trim().equals("field")) {
				NodeList attrnode = node.getChildNodes();
				Attr attr = new Attr();
				for (int j = 0; j < attrnode.getLength(); j++) {
					Node anode = attrnode.item(j);
					if (anode.getNodeType() != Node.ELEMENT_NODE) {
						continue;
					}
					Element ae = (Element) anode;
					if (ae.getTagName().trim().equals("fieldName")) {
						attr.setField(anode.getFirstChild().getNodeValue());
					}
					if (ae.getTagName().trim().equals("fieldType")) {
						attr.setType(anode.getFirstChild().getNodeValue());
					}
					if (ae.getTagName().trim().equals("fieldComment")) {
						attr.setComment(anode.getFirstChild().getNodeValue());
					}
				}
				modellist.add(attr);
			}
		}

		generateModel(ftlPath, modelFtlName, fileName, modelFilePath, modelPackageName, modellist, remark);
		generateDao(ftlPath, daoFtlName, fileName, daoFilePath, daoPackageName, modelPackageName, remark);
		generateService(ftlPath, serviceFtlName, fileName, serviceFilePath, servicePackageName, daoPackageName,
				modelPackageName, remark);
		generateController(ftlPath, controllerFtlName, fileName, controllerFilePath, controllerPackageName,
				servicePackageName, modelPackageName, remark);
		System.out.println("生成成功，刷新一下");
	}

	private static void generateController(String ftlPath, String controllerFtlName, String fileName,
			String controllerFilePath, String controllerPackageName, String servicePackageName, String modelPackageName,
			String remark) throws IOException, TemplateException {
		GenerateController.Generate(ftlPath, controllerFtlName, fileName, controllerFilePath, controllerPackageName,
				servicePackageName, modelPackageName, remark);
	}

	private static void generateService(String ftlPath, String serviceftlName, String fileName, String serviceFilePath,
			String servicePackageName, String daoPackageName, String modelPackageName, String remark)
			throws IOException, TemplateException {
		GenerateService.Generate(ftlPath, serviceftlName, fileName, serviceFilePath, servicePackageName, daoPackageName,
				modelPackageName, remark);
	}

	private static void generateDao(String ftlPath, String daoftlName, String fileName, String daoFilePath,
			String daoPackageName, String modelPackageName, String remark) throws IOException, TemplateException {
		GenerateDao.Generate(ftlPath, daoftlName, fileName, daoFilePath, daoPackageName, modelPackageName, remark);
	}

	private static void generateModel(String ftlPath, String modelftlName, String fileName, String modelFilePath,
			String modelPackageName, List<Object> modellist, String remark) throws IOException, TemplateException {
		GenerateModel.Generate(ftlPath, modelftlName, fileName, modelFilePath, modelPackageName, modellist, remark);
	}
}
