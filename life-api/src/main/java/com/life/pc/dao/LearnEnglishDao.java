package com.life.pc.dao;

import com.life.pc.model.LearnEnglishModel;

public interface LearnEnglishDao {
	
    LearnEnglishModel selectByPrimaryKey(String id);
    
    int updateByPrimaryKeySelective(LearnEnglishModel record);

    int updateByPrimaryKey(LearnEnglishModel record);
    
    int deleteByPrimaryKey(String id);

    int insert(LearnEnglishModel record);

    int insertSelective(LearnEnglishModel record);
}