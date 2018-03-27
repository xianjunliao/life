package com.life.pc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.pc.model.LearnRelationModel;

public interface LearnRelationDao {


    int insert(LearnRelationModel record);
    
    List<LearnRelationModel> selectByuser(String usercode);
    List<LearnRelationModel> selectBylearnid(String learnid);
    Integer  countBylearnid(String learnid);
    void deleteByLidAndWid(@Param("learnid")String learnid,@Param("wordid")String wordid);
    long selectByAll(LearnRelationModel learnRelationModel);
}