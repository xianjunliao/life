package com.life.util;

import org.apache.log4j.Logger;

public class Log {
    private Logger logger;		
    
    public Log(){    	
    }
    
    public Log(Class clz){   
    	LogInit(clz);
    }
	
	public void LogInit(Class clz ){
		if(logger == null){
			logger = Logger.getLogger(clz);
		}	
	}
	
	public void Loge(String log, Exception e){
		try{					 
			LogInit(Log.class);
			if(e == null){
				logger.error(log); 
			}else{
				logger.error(log, e);
			}
		}catch(Exception e1){
			e1.printStackTrace();
		}
	}
	
	public void Logi(String log){ 
		try{	
			//if (logger!=null && !logger.isInfoEnabled()) {  
			//	return;
			//}
			
			LogInit(Log.class);
			logger.warn(log);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void Logd(String log){
		try{
			if (logger!=null && !logger.isDebugEnabled()) {  
				return;
			}
					
			LogInit(Log.class);
			logger.debug(log);	
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
