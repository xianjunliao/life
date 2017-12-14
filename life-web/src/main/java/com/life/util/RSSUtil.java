package com.life.util;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Vector;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.ElementHandler;
import org.dom4j.io.SAXReader;

import com.life.model.RSS;

import net.sf.json.JSONArray;

public class RSSUtil {
	/**
	* Get all items form xml file. 
	* @param rss
	* @param root
	*/
	private static void getRSSs(List<RSS> rss, Element root) {
	List<Element> param = root.elements();   
	for(Element e : param){
	if(e.getName().equals("item")){
	String title = e.element("title").getTextTrim();
	String link = e.element("link").getTextTrim();
	String description = e.element("description").getTextTrim();
	String pubdate = e.element("pubDate").getTextTrim();

	RSS r = new RSS(title, link, description, pubdate);

	rss.add(r);
	}else{
	getRSSs(rss, e);
	}
	}
	}

	/**
	* 
	* @param xmlurl
	* @return json
	*/
	public static String xmlToJson(String xmlurl){
	URL xml;
	JSONArray jsona =new JSONArray();
	List<RSS> rss = new Vector<RSS>();

	try {
	xml = new URL(xmlurl);
	HttpURLConnection conn = (HttpURLConnection)xml.openConnection();
	SAXReader reader = new SAXReader();
	Document doc = reader.read(conn.getInputStream());
	Element root = doc.getRootElement();
	getRSSs(rss, root);
	for(RSS r : rss)
	jsona.add(r);
	System.out.println( jsona );
	} catch (Exception e) {
	e.printStackTrace();
	}
	return jsona.toString();
	}
}
