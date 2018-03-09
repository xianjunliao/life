package com.life.pc.dao;

import java.util.List;

import com.life.pc.model.LearnEnglishModel;

public interface LearnEnglishDao {
	
	List<LearnEnglishModel> selectListByUser(String usercode);
	
    LearnEnglishModel selectByPrimaryKey(String id);
    
	int updateByPrimaryKeySelective(LearnEnglishModel record);

    int deleteByPrimaryKey(String id);

    int insertSelective(LearnEnglishModel record);
    
    LearnEnglishModel selectByTimeClass(String selectByTimeClass);
}