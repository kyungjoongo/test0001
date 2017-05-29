package com.nda.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by kyungjoon.go on 2017-05-11.
 */
public class CommonUtils {


    public static void main(String[] args){

        System.out.println("어제-->"+ getPreviousDate(getTodayDateYyyymmdd(), "yesterday"));
    }




    public static String getTodayDate() {

        DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");
        Date date = new Date();
        System.out.println(dateFormat.format(date));

        return dateFormat.format(date);
    }


    public static String getTodayDateYyyymmdd() {

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        System.out.println(dateFormat.format(date));

        return dateFormat.format(date);
    }



    /**
     *
     * @param date
     * @param operation (week, month, year)
     * @return
     */
    public static String getPreviousDate(String date, String operation)
    {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Calendar calendar = Calendar.getInstance(); //create new calendar instance
        calendar.clear(); //clear the current information on the calendar instance
        calendar.setLenient(false);

        try {
            calendar.setTime(sdf.parse(date)); //parse current Monday date and set as calendar date/time
        } catch (ParseException e) {
            e.printStackTrace();
        }

        if("yesterday".equalsIgnoreCase(operation)) {
            calendar.add(Calendar.DATE, -1);  // for previous Monday
        }



        if("week".equalsIgnoreCase(operation)) {
            calendar.add(Calendar.DATE, -7);  // for previous Monday
        }

        if("month".equalsIgnoreCase(operation)) {
            calendar.add(Calendar.DATE, -30);  // for previous Monday
        }


        if("year".equalsIgnoreCase(operation)) {
            calendar.add(Calendar.DATE, -365);  // for previous Monday
        }


        return sdf.format(calendar.getTime()); //format the calendar date/time
    }

    /**
     * 0,1,2,3 --> P1,P2,AE,95로 라우터 네임을 바꿔준다.
     * @param query_route_by_date
     * @return
     */
    public static String getRouteName(String query_route_by_date) {

        if (query_route_by_date.equals("0") ){
            query_route_by_date= "P1";
        }else if (query_route_by_date.equals("1") ){
            query_route_by_date= "P2";
        }else if (query_route_by_date.equals("2") ){
            query_route_by_date= "AE";
        }else if (query_route_by_date.equals("3") ){
            query_route_by_date= "P5";
        }

        return  query_route_by_date;
    }

}
