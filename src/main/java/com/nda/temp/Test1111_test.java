package com.nda.temp;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Test1111_test {

	public static void main(String[] args)
	{
		String date = "2017-05-18";  // Current Monday date.


		System.out.println(getPreviousDate(date, "week"));
		System.out.println(getPreviousDate(date, "month"));
		System.out.println(getPreviousDate(date, "year"));

	}

	private static String getPreviousDate(String date, String operation)
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

}
