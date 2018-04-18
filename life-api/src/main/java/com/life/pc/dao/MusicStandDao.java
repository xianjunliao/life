package com.life.pc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.pc.model.MusicStandModel;

public interface MusicStandDao {

	int deleteByPrimaryKey(String id);
	
	int deleteByName(@Param("musicname") String musicname, @Param("usercode") String usercode);

	int insertSelective(MusicStandModel record);

	MusicStandModel selectByPrimaryKey(String id);

	int updateByPrimaryKeySelective(MusicStandModel record);

	int updateByPrimaryKey(MusicStandModel record);

	List<MusicStandModel> selectByName(@Param("musicname") String musicname, @Param("usercode") String usercode);

	void toTopAfter(@Param("musicname") String musicname, @Param("usercode") String usercode);

	void toTopBefore(@Param("usercode") String usercode);

	List<MusicStandModel> selectByTop(@Param("usercode") String usercode);
	
	List<MusicStandModel> selectByUser(@Param("usercode") String usercode);
}