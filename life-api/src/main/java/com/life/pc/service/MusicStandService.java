package com.life.pc.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.life.pc.model.MusicStandModel;

public interface MusicStandService {

	int deleteByPrimaryKey(String id);

	int insertSelective(MultipartFile file,MusicStandModel record);

	MusicStandModel selectByPrimaryKey(String id);

	int updateByPrimaryKeySelective(MusicStandModel record);

	int updateByPrimaryKey(MusicStandModel record);
	
    List<MusicStandModel>  selectByName(String musicname);
}