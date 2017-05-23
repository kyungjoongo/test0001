package com.nda.scheduler;

import com.nda.dao.StatsDAO;
import com.nda.model.Stats;
import com.nda.util.CommonUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import static com.nda.util.CommonUtils.getPreviousDate;
import static com.nda.util.CommonUtils.getTodayDateYyyymmdd;

@Component
public class ScheduledTasks {

    private static final Logger log = LoggerFactory.getLogger(ScheduledTasks.class);
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");

    @Autowired
    private StatsDAO statsDAO;


    /**
     * 매일 23시에 실행 (pm 10시)
     * 하루에 한번 pm 10:00에 스케쥴러가 실행하여 오늘의 쿼리카운트 증가량을 insert한다...
     */
    @Scheduled(cron = "0 0 22 * * *")
    public void insertTodaysQueryCount() {
        log.info("The time is now {}", dateFormat.format(new Date()));

        //전체 쿼리데이타 list를 fetch
        List<Map<String, Object>> arrList = statsDAO.getTotalDataList();


        for ( Map<String, Object> arrOne : arrList){

            int id = (int) arrOne.get("id");
            Stats stats=new Stats();
            stats.setId(id);


            //전체 카운트
            Map<String, Object> qc_count_total_map = statsDAO.getOne(stats);

            //전체 쿼리 카운트
            int totalQcCount = (int) qc_count_total_map.get("query_qc");

            /**
             *
             * 어제 날짜를 셋팅후
             * 어제 날짜까지의 qc_count
             */
            stats.setYesterdayDate(getPreviousDate(getTodayDateYyyymmdd(), "yesterday"));
            Map<String, Object> qc_count_until_yesterday_map = statsDAO.getOne_query_manager_userquery_count_until_yesterday(stats);
            int qcCountUntilYesterday = (int) qc_count_until_yesterday_map.get("query_count");


            //오늘 증가한 qc_count
            int todaysQcCount = totalQcCount - qcCountUntilYesterday;

            stats.setId(id);
            stats.setTodaysQcCount(todaysQcCount);
            stats.setTodaysDate(CommonUtils.getTodayDateYyyymmdd());

            //오늘증가한 쿼리카운트를insert
            statsDAO.insertTodaysQcCountById (stats );


        }

    }
}



// 5초마다 한번
    /*@Scheduled(cron = "0 0 * * * *")// every 5 seconds.*/