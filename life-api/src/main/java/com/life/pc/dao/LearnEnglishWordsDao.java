package com.life.pc.dao;

import com.life.pc.model.LearnEnglishWordsModel;

public interface LearnEnglishWordsDao {
  

    int deleteByPrimaryKey(String id);


    int insertSelective(LearnEnglishWordsModel record);


    LearnEnglishWordsModel selectByPrimaryKey(String id);


    int updateByPrimaryKeySelective(LearnEnglishWordsModel record);


    LearnEnglishWordsModel selectByWord(String word);
}