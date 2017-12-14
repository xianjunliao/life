package com.life.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by xiao on 2017/5/11.
 */
public class Util {


    public static Timestamp getNowDate(){
        Date date = new Date();//获得系统时间.
        String nowTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);//将时间格式转换成符合Timestamp要求的格式.
        System.out.println(nowTime);
        Timestamp goodsC_date =new Timestamp(date.getTime());
        return goodsC_date;
    }

    public static int getRandom(int max ,int min) {
        Random random = new Random();

        int s = random.nextInt(max)%(max-min+1) + min;
        return s;
    }

    public static Date getBeforeDate(Date date,int beforeORAlter){
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(calendar.DATE,beforeORAlter);//把日期往后增加一天.整数往后推,负数往前移动
        date=calendar.getTime(); //这
        return date;
    }

    /**
     *
     * @param date
     * @param dateFormat
     * @return
     */
    public static String dateToString(Date date, String dateFormat) {
        SimpleDateFormat formatDate = new SimpleDateFormat(dateFormat);
        return formatDate.format(date);
    }
    
    
    public static String getUUID(){ 
        String s = UUID.randomUUID().toString(); 
        return s.substring(0,8)+s.substring(9,13)+s.substring(14,18)+s.substring(19,23)+s.substring(24); 
    }
    public static String getUUId16() {
        int machineId = 1;//最大支持1-9个集群机器部署
        int hashCodeV = UUID.randomUUID().toString().hashCode();
        if(hashCodeV < 0) {//有可能是负数
            hashCodeV = - hashCodeV;
        }
        // 0 代表前面补充0
        // 4 代表长度为4
        // d 代表参数为正数型
        return machineId + String.format("%015d", hashCodeV);
    }
    public static void main(String[] args) {
        System.out.println(getUUId16());
    }
    
    
}
