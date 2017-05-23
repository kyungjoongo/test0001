package com.nda.util;



import com.nda.model.Stats;

import java.util.List;
import java.util.Map;

public class CSVUtils {

    /**
     * 연결리스트  to 콤마구분자 String으로 변환
     *
     * @param statsList
     * @return
     */
    public static String makeCSVString(List<Stats> statsList) {

        StringBuffer sb = new StringBuffer();

        String header = "질의문장,응답문장\n";

        sb.append(header);

        for (Stats statsOne : statsList) {

            String query_text = (String) statsOne.getQuery_text();
            String query_response = (String) statsOne.getQuery_response();

            int qc_sum = (int) statsOne.getQc_sum();

            String worker = (String) statsOne.getWorker();

            String tempStr = query_text + "," + query_response + "," + worker + "," +qc_sum +   "\n";
            sb.append(tempStr);

        }

        return sb.toString();
    }


}
