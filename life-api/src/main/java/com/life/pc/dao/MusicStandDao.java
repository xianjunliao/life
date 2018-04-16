package com.life.pc.dao;

import com.life.pc.model.MusicStandModel;

public interface MusicStandDao {

    int deleteByPrimaryKey(String id);

    int insertSelective(MusicStandModel record);

    MusicStandModel selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(MusicStandModel record);

    int updateByPrimaryKey(MusicStandModel record);
}