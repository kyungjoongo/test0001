package com.nda.util;


import com.nda.model.Stats;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.Map;

public class CSVUtils {

    /**
     * 연결리스트  to 콤마구분자 String으로 변환
     *
     * @param statsList
     * @return
     */
    public static String makeCSVString(List<Stats> statsList, String startDate, String endDate) {

        StringBuffer stringBuffer = new StringBuffer();

        String headerDate = startDate + "~" + endDate + "\n";

        String header = "질의문장,응답문장, 쿼리카운트, 작업자\n";

        stringBuffer.append(headerDate);
        stringBuffer.append(header);

        int row=1;
        for (Stats statsOne : statsList) {

            //기존라우팅
            //변경라우팅
            //query_type
            //query_continuation
            //query_work_status
            //일괄블럭.
            //query_blocked
            //qm라우팅
            //worker
            //qcCount
            //날짜
            int id = (int) statsOne.getId();
            String queryText = (String) statsOne.getQuery_text();
            String queryResponse = (String) statsOne.getQuery_response();

            //변경쿼리
            String query_replace = (String) statsOne.getQuery_replace();
            //대화도메인
            String dialogDomain = (String) statsOne.getDialogDomain();

            String queryRoute = statsOne.getQuery_route();
            queryRoute = CommonUtils.getRouteName(queryRoute);


            /*String outputRoute = statsOne.getQuery_route();
            outputRoute = CommonUtils.getRouteName(outputRoute);*/


            String queryType = statsOne.getQuery_type();
            String queryContinuation = statsOne.getQuery_continuation();
            String queryWorkStatus = statsOne.getQuery_work_status();
            int queryBlocked = statsOne.getQuery_blocked();
            String strQueryBlocked= "";
            if(queryBlocked==1 ){
                strQueryBlocked= "true";
            }else{
                strQueryBlocked= "false";
            }

            /*String qmQueryRoute = statsOne.getQuery_route_by_date();
            qmQueryRoute = CommonUtils.getRouteName(qmQueryRoute);*/
            String worker = statsOne.getWorker();
            int qcCount = (int) statsOne.getQc_sum();
            String pubDate = statsOne.getPub_date();

            String cvsString = id
                    + "," + queryText
                    + "," + queryResponse
                    + "," + query_replace
                    + "," + dialogDomain
                    + "," + queryRoute
                   /* + "," + outputRoute*/
                    + "," + queryType
                    + "," + queryContinuation
                    + "," + queryWorkStatus
                    + "," + strQueryBlocked
                    /*+ "," + qmQueryRoute*/
                    + "," + worker
                    + "," + qcCount
                    + "," + pubDate
                    + "\n";
            stringBuffer.append(cvsString);

            row++;

            System.out.println("cvsExport Row==>"+ row);

        }

        return stringBuffer.toString();
    }


}
