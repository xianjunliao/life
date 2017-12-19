package com.life.util;

public interface WebConstant {
	//用户
	String USER_ID = "userId";
	String LOGIN_NAME = "loginName";
	String PASSWORD = "password";
	String LOGIN_ROLEID = "roleId";
	String AUTERITY = "autherity";
	String USER_NAME="userName";
	String USER_TYPE = "userType";
	String USER_ADUID = "userAduid";
	String USER_AD_DETAIL = "userAdDetail";
	String USER_DEV_DETAIL = "userDevDetail";
	String USER_DEVID = "userDevuid";
	String USER_ADMINID = "userAdminuid";
	String USER_ADMIN_DETAIL = "userAdminDetail";
	//是否管理员
	String ISADMIN = "isAdmin";
	
	//是否商家
	String ISMERCHANT = "isMerchant";
	
	String REFURL = "refUrl";
	String CHOICE_AD = "choice_ad";

	
	//========= 评论(KXComment对象)的状态state =================
	/** 评论状态 删除 -2 */
	Integer STATE_KXCOMMENT_DEL = -2;  
	
	
	//========= 用户(Kuser对象)的评论的屏蔽状态black ======================
	/** 用户的评论的屏蔽状态 已屏蔽 1 */
	Integer STATE_KUSER_BLACK_TRUE = 1;
	/** 用户的评论的屏蔽状态 未屏蔽 0 */
	Integer STATE_KUSER_BLACK_FALSE = 0;
	
	
	
	

}