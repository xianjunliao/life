package com.life.common.model;

public class RSS {
	/**
	* 
	*/
	private String title;
	private String link;
	private String descriptionLong;
	private String description;
	private String pubdate;

	public String getDescriptionLong() {
		return descriptionLong;
	}

	public void setDescriptionLong(String descriptionLong) {
		this.descriptionLong = descriptionLong;
	}

	public RSS() {
	// TODO Auto-generated constructor stub
	}
	    
	public RSS(String title, String link, String description, String pubdate) {
	this.title = title;
	this.link = link;
	this.description = description;
	this.pubdate = pubdate;
	}


	public String getTitle() {
	return title;
	}


	public void setTitle(String title) {
	this.title = title;
	}


	public String getLink() {
	return link;
	}


	public void setLink(String link) {
	this.link = link;
	}


	public String getDescription() {
	return description;
	}


	public void setDescription(String description) {
	this.description = description;
	}


	public String getPubdate() {
	return pubdate;
	}


	public void setPubdate(String pubdate) {
	this.pubdate = pubdate;
	}


	@Override
	public String toString() {
		return "RSS [title=" + title + ", link=" + link + ", descriptionLong=" + descriptionLong + ", description=" + description + ", pubdate=" + pubdate + "]";
	}
}
