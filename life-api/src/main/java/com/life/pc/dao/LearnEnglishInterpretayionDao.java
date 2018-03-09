package com.life.pc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.pc.model.LearnEnglishInterpretayionModel;

public interface LearnEnglishInterpretayionDao {


    int deleteByPrimaryKey(String id);


    int insertSelective(LearnEnglishInterpretayionModel record);


    LearnEnglishInterpretayionModel selectByPrimaryKey(String id);


    int updateByPrimaryKeySelective(LearnEnglishInterpretayionModel record);
    
    
    List<LearnEnglishInterpretayionModel> selectBywordId(String wordId);
    
    LearnEnglishInterpretayionModel selectBywordIdAndWordType(@Param("wordid")String wordid,@Param("wordType")String wordType);

}