package com.life.common.util;

import java.util.List;

import com.life.common.Str;

public class KeywordUtil {

	public String getLike(List<String> keywords, String name){
		
		StringBuffer like = new StringBuffer("( ");
		
		for(int i = 0; i < keywords.size(); i++){
			if(Str.isEmpty(keywords.get(i))){
				continue;
			}
			
			if(i > 0){ 
				like.append(" OR ");
			}

			like.append(name + " like '%" + keywords.get(i) + "%'"); //
		}
		like.append(" )");
		
		return like.toString();
	}
}
