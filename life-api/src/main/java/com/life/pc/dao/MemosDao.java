package com.life.pc.dao;

import com.life.pc.model.MemosModel;

public interface MemosDao {
	
	public MemosModel selectById(String id);
	
	public void deleteById(String id);
	
	public void save(MemosModel memosModel);
	
	public void update(MemosModel memosModel);
	
}