package com.life.pc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.pc.model.LearnEnglishWordsModel;

public interface LearnEnglishWordsDao {
  

    int deleteByPrimaryKey(String id);


    int insertSelective(LearnEnglishWordsModel record);


    LearnEnglishWordsModel selectByPrimaryKey(String id);


    int updateByPrimaryKeySelective(LearnEnglishWordsModel record);


    LearnEnglishWordsModel selectByWord(String word);
    
    List<LearnEnglishWordsModel>  selectByIds(@Param("ids")List<String> ids);
    
    List<LearnEnglishWordsModel>  selectByIdsAll(@Param("ids")List<String> ids,@Param("type")String type);
}