package com.nda.scheduler;

import com.nda.NaverDialogApplication;
import com.nda.dao.StatsDAO;
import com.nda.model.Stats;
import com.nda.util.CommonUtils;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import static com.nda.util.CommonUtils.getPreviousDate;
import static com.nda.util.CommonUtils.getTodayDateYyyymmdd;

/**
 * Created by kyungjoon.go on 2017-05-22.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = NaverDialogApplication.class)
public class ScheduledTasksTest {

    private static final Logger log = LoggerFactory.getLogger(ScheduledTasksTest.class);
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");

    @Autowired
    private StatsDAO statsDAO;


    @Before
    public void setUp() throws Exception {
    }
/* @Scheduled(cron = "*//*5 * *   *  * *")// every 5 seconds.*/


    /**
     * 매일 22시에 실행 (pm 10시)
     */
    @Scheduled(cron = "0 0 22 * * *")
    @Test
    @Transactional
    @Rollback(false)
    public void insertTodaysQueryCount() {
        log.info("The time is now {}", dateFormat.format(new Date()));


        //전체 쿼리데이타 list를 fetch
        List<Map<String, Object>> arrList = statsDAO.getTotalDataList();


        for (Map<String, Object> arrOne : arrList) {

            int id = (int) arrOne.get("id");
            Stats stats = new Stats();
            stats.setId(id);

            //전체 카운트
            Stats queryManagerUserqueryOne = statsDAO.getOne(stats);


            //전체 쿼리 카운트
            String totalQcCount = (String) queryManagerUserqueryOne.getQuery_qc();


            //오늘날짜까지의 query_work_status
            String query_work_status = (String) queryManagerUserqueryOne.getQuery_work_status();


            //오늘까지의 query_route value (0 ,1,2,3) (p1,p2,ae,p5)
            String query_route = (String) queryManagerUserqueryOne.getQuery_route();

            /**
             *
             * 어제 날짜를 셋팅후
             * 어제 날짜까지의 qc_count
             */
            stats.setYesterdayDate(getPreviousDate(getTodayDateYyyymmdd(), "yesterday"));
            Map<String, Object> qc_count_until_yesterday_map = statsDAO.getOne_query_manager_userquery_count_until_yesterday(stats);
            BigDecimal qcCountUntilYesterday = (BigDecimal) qc_count_until_yesterday_map.get("qc_count_sum");


            //오늘 증가한 qc_count
            int todaysQcCount = Integer.parseInt(totalQcCount) - qcCountUntilYesterday.intValue();

            stats.setId(id);
            stats.setTodaysQcCount(todaysQcCount);
            stats.setTodaysDate(CommonUtils.getTodayDateYyyymmdd());

            //오늘날짜의 Query_work_status
            stats.setQuery_work_status(query_work_status);

            //오늘날짜의 Query_route(p1,p2,ae,p5)
            stats.setQuery_route(query_route);

            //오늘증가한 쿼리카운트 insert , 날짜별 query_work_status 를 insert
            statsDAO.insertTodaysQcCountAndQueryWorkStatusByDate(stats);


        }

    }
}