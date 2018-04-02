package com.life.pc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.pc.model.LearnEnglishModel;

public interface LearnEnglishDao {
	
	List<LearnEnglishModel> selectListByUser(@Param("usercode")String usercode,@Param("number")int number);
	
    LearnEnglishModel selectByPrimaryKey(String id);
    
	int updateByPrimaryKeySelective(LearnEnglishModel record);

    int deleteByPrimaryKey(String id);

    int insertSelective(LearnEnglishModel record);
    
    LearnEnglishModel selectByTimeClass(@Param("timeClass")String timeClass,@Param("usercode")String usercode);
    
    List<LearnEnglishModel> getCountByUser(@Param("usercode")String usercode);
    
    List<LearnEnglishModel> getDaysByUser(@Param("usercode")String usercode,@Param("number")int number);
}