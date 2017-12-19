package com.life.common.time;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateTime {
    /**
     * 获取当前系统的Timestamp
     *
     * @return
     */
    public static Timestamp getCurrentTimestamp() {
        Timestamp ts = new Timestamp(System.currentTimeMillis());
        return ts;
    }
    
    public static Timestamp getNowDate(){
        Date date = new Date();//获得系统时间.
        String nowTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);//将时间格式转换成符合Timestamp要求的格式.
        //System.out.println(nowTime);
        Timestamp goodsC_date =new Timestamp(date.getTime());
        return goodsC_date;
    }

    /**
     * 获取当前系统时间 yyyy-MM-dd HH:mm:ss
     *
     * @return 时间字符串, 如:2014-08-07 12:11:00
     */
    public static String getCurrentDateTime() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            Calendar cal = Calendar.getInstance();
            return dateFormat.format(cal.getTime());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Long getTimeForLong(String time){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            return dateFormat.parse(time).getTime();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 获取当前系统时间
     *
     * @param format 格式
     * @return
     */
    public static String getCurrentDateTime(String format) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(format);
        try {
            Calendar cal = Calendar.getInstance();
            return dateFormat.format(cal.getTime());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 获取日期字符串。
     * <p>
     * <pre>
     *  日期字符串格式： yyyyMMdd
     *  其中：
     *      yyyy   表示4位年。
     *      MM     表示2位月。
     *      dd     表示2位日。
     * </pre>
     *
     * @param date 需要转化的日期。
     * @return String "yyyyMMdd"格式的日期字符串。
     */
    public static String getDate(Date date) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        return formatter.format(date);
    }


    /**
     * 获取过去第几天的日期
     *
     * @param past
     * @return yyyy-mm-dd
     */
    public static String getPastDate(int past) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - past);
        Date today = calendar.getTime();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        return format.format(today);
    }

    /***
     * 获取当前系统的日期
     * @return yyyy-mm-dd
     */
    public static String getCurrentDate() {
        return getDate(new Date());
    }

    /**
     * 判断时间是否在时间段内
     *
     * @param timeNeedJude HH:mm:ss 待判断的时间
     * @param strDateBegin 开始时间 00:00:00
     * @param strDateEnd   结束时间 00:05:00
     * @return true-在时间段内，反之false
     */
    public static boolean isInDate(String timeNeedJude, String strDateBegin, String strDateEnd) {
        DateFormat df = new SimpleDateFormat("HH:mm:ss");// 创建日期转换对象HH:mm:ss为时分秒，年月日为yyyy-MM-dd
        try {
            Date beginTime = df.parse(strDateBegin);// 将字符串转换为date类型
            Date endTime = df.parse(strDateEnd);
            Date nowTimeDate = df.parse(timeNeedJude);
            if (beginTime.getTime() <= nowTimeDate.getTime() && nowTimeDate.getTime() <= endTime.getTime()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /***
     * 计算两个时间点相差了几分钟
     * @param strDateBegin 开始的时间点，格式必须是HH:mm:ss
     * @param strDateEnd 结束的时间点，格式必须是HH:mm:ss
     * @return 相差的时间分钟
     */
    public static int intervalMinutes(String strDateBegin, String strDateEnd) {
        DateFormat df = new SimpleDateFormat("HH:mm:ss");// 创建日期转换对象HH:mm:ss为时分秒，年月日为yyyy-MM-dd
        try {
            Date beginTime = df.parse(strDateBegin);// 将字符串转换为date类型
            Date endTime = df.parse(strDateEnd);
            long interval = endTime.getTime() - beginTime.getTime();
            return (int) (interval / 60000);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /***
     * 将时间戳转换为日期时间
     * @param timestamp 时间戳
     * @param format yyyy-MM-dd HH:mm:ss/yyyy-MM-dd/HH:mm:ss
     * @return yyyy-MM-dd HH:mm:ss/yyyy-MM-dd/HH:mm:ss
     */
    public static String stampToDateTime(long timestamp, String format) {
        String res;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
        Date date = new Date(timestamp);
        res = simpleDateFormat.format(date);
        return res;
    }
    
    /***
     * 将时间戳转换为日期时间
     * @param t1 时间
     * @param t2 时间
     * @return t1到t2相差的月数
     */
    public static int intervalDays(long t1, long t2){
    	Calendar calendar = Calendar.getInstance();
    	Date date1 = new Date(t1);
    	Date date2 = new Date(t2);
    	calendar.setTime(date1);
    	int year1 = calendar.get(Calendar.YEAR);
    	int month1 = calendar.get(Calendar.MONTH);
    	calendar.setTime(date2);
    	int year2 = calendar.get(Calendar.YEAR);
    	int month2 = calendar.get(Calendar.MONTH);
    	if(year1 == year2){
    		int ms = month1-month2;
    		return Math.abs(ms);
    	}else {
    		int ys = Math.abs(year1-year2);//相差了几年
    		if(year1 > year2){
    			return ys*12 - month2 + month1;
    		}else{
    			return ys*12 - month1 + month2;
    		}
    	}
    }
}
