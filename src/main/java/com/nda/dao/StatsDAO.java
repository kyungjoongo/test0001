package com.nda.dao;

import com.nda.model.JqGridObject;
import com.nda.model.Stats;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
public class StatsDAO {

    @Autowired
    @Qualifier("firstSqlSessionTemplate")
    private SqlSession sqlSession;


    /*@Autowired
    @Qualifier("secondSqlSessionTemplate")
    private SqlSession secondSqlSession;*/


    public List<Stats> getList(Stats stats) {

        //멀티플dialogDomain Setting
        String[] arrDialogDomain = stats.getDialogDomains().split(",");
        stats.setArrDialogDomain(arrDialogDomain);
        List<Stats> arrList = new ArrayList<>();
        try {
            arrList = sqlSession.selectList("StatsMapper.getList", stats);
        } catch (Exception e) {
            e.printStackTrace();
        }


        List resultList = new ArrayList();

        for (Stats statsOne : arrList) {

            String query_text = (String) statsOne.getQuery_text();
            String query_response = (String) statsOne.getQuery_response();
            String query_text_and_response = query_text + ";" + query_response;

            statsOne.setQuery_text_and_response(query_text_and_response);

            resultList.add(statsOne);
        }

        return resultList;
    }


    public Stats getOne(Stats stats) {


        Stats statsOne = sqlSession.selectOne("StatsMapper.getOne", stats);
        String query_text = (String) statsOne.getQuery_text();
        String query_response = (String) statsOne.getQuery_response();
        String query_text_and_response = query_text + ";" + query_response;

        statsOne.setQuery_text_and_response(query_text_and_response);


        return statsOne;
    }


    public List<Stats> getListForExport(Stats stats) {

        //멀티플dialogDomain Setting
        String[] arrDialogDomain = stats.getDialogDomains().split(",");
        stats.setArrDialogDomain(arrDialogDomain);
        List<Stats> arrList = new ArrayList<>();

        arrList = sqlSession.selectList("StatsMapper.getListTest", stats);


        List resultList = new ArrayList();

        for (Stats statsOne : arrList) {

            String query_text = (String) statsOne.getQuery_text();
            String query_response = (String) statsOne.getQuery_response();
            String query_text_and_response = query_text + ";" + query_response;

            statsOne.setQuery_text_and_response(query_text_and_response);

            resultList.add(statsOne);
        }

        return resultList;
    }


    public List<Stats> getQueryControlHistoryList(Stats stats) {

        //멀티플dialogDomain Setting
        String[] arrDialogDomain = stats.getDialogDomains().split(",");
        stats.setArrDialogDomain(arrDialogDomain);

        List<Stats> arrList = sqlSession.selectList("StatsMapper.getQueryControlHistoryList", stats);

        List resultList = new ArrayList();

        for (Stats statsOne : arrList) {

            String query_text = (String) statsOne.getQuery_text();
            String query_response = (String) statsOne.getQuery_response();
            String query_text_and_response = query_text + ";" + query_response;

            statsOne.setQuery_text_and_response(query_text_and_response);

            resultList.add(statsOne);
        }

        return resultList;
    }

    public int getQueryControlHistoryListTotalCount(Stats stats) {

        int count = sqlSession.selectOne("StatsMapper.getQueryControlHistoryListTotalCount", stats);
        return count;
    }


    public int getListTotalCount(Stats jqGridObject) {

        int count = sqlSession.selectOne("StatsMapper.getListTotalCount", jqGridObject);
        return count;
    }

    public int getListTotalCount() {

        int count = sqlSession.selectOne("StatsMapper.getListTotalCount");
        return count;
    }


    public List<String> getQueryType() {

        //query_type
        List<String> arrList = sqlSession.selectList("StatsMapper.getQueryType");

        List arrList2 = new ArrayList();
        for (String qType : arrList) {

            if (StringUtils.isNotEmpty(qType)) {
                arrList2.add(qType);
            }
        }

        return arrList2;
    }

    /**
     * 어제 날짜 qc_count를 fetch
     *
     * @param stats
     * @return
     */
    public Map<String, Object> getOne_query_manager_userquery_count_until_yesterday(Stats stats) {
        Map<String, Object> resultOne = sqlSession.selectOne("StatsMapper.getOne_query_manager_userquery_count_until_yesterday", stats);

        return resultOne;
    }


    public List<Map<String, Object>> getTotalDataList(HashMap paramMap) {

        List<Map<String, Object>> arrList = sqlSession.selectList("StatsMapper.getListAll", paramMap);
        return arrList;
    }

    public List<Map<String, Object>> getTotalDataList() {

        List<Map<String, Object>> arrList = sqlSession.selectList("StatsMapper.getListAll");
        return arrList;
    }


    public int insertTodaysQcCountAndQueryWorkStatusByDate(Stats stats) {


        int result = sqlSession.insert("StatsMapper.insertTodaysQcCountAndQueryWorkStatusByDate", stats);

        return result;

    }


    public int insertList(List<HashMap> excelDataList) {

        int result = 0;
        for (HashMap elementOne : excelDataList) {

            String query_text = (String) elementOne.get("query_text");
            String query_response = (String) elementOne.get("query_response");

            if (StringUtils.isEmpty(query_text)) {
                query_text = "";
            }

            if (StringUtils.isEmpty(query_response)) {
                query_response = "";
            }

            Map paramMap = new HashMap();
            paramMap.put("query_text", query_text);
            paramMap.put("query_response", query_response);

            result += sqlSession.insert("StatsMapper.insertOne", paramMap);
        }
        return result;
    }

    public int deleteList(String[] ids) {

        int result = 0;
        for (String id : ids) {
            result = sqlSession.delete("StatsMapper.deleteOne", id);
        }

        return result;
    }

    //updateData
    public int updateOne(String query_text, String query_response, String id) {

        int result = 0;
        Map paramMap = new HashMap();
        paramMap.put("query_text", query_text);
        paramMap.put("query_response", query_response);
        paramMap.put("id", id);

        result = sqlSession.update("StatsMapper.updateOne", paramMap);

        return result;
    }


    public List getQueryTypeCount() {
        List arrList = sqlSession.selectList("StatsMapper.getQueryTypeCount");
        return arrList;
    }

    //getActionType
    public List getActionType() {
        List arrList = sqlSession.selectList("StatsMapper.getActionType");
        return arrList;
    }


    public List getDialogDomain() {
        List<String> arrList = sqlSession.selectList("StatsMapper.getDialogDomain");

        List<String> arrList2 = new ArrayList();
        for (String dialogDomainOne : arrList) {

            if (StringUtils.isNotEmpty(dialogDomainOne)) {
                arrList2.add(dialogDomainOne);
            }
        }

        return arrList2;

    }

    public List getQueryReplace() {
        List<String> arrList = sqlSession.selectList("StatsMapper.getQueryReplace");

        List<String> arrList2 = new ArrayList();
        for (String arrOne : arrList) {

            if (StringUtils.isNotEmpty(arrOne)) {
                arrList2.add(arrOne);
            }
        }

        return arrList2;

    }


    public int insertTest001(Stats stats) {


        int result = sqlSession.insert("StatsMapper.insertTest001", stats);

        return result;

    }


}