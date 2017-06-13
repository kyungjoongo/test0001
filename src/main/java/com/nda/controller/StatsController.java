package com.nda.controller;

import ch.qos.logback.classic.Logger;
import com.nda.dao.StatsDAO;
import com.nda.model.Stats;
import com.nda.util.ApachePOIExcelUtil;
import com.nda.util.CSVUtils;
import com.nda.util.CommonUtils;
import net.minidev.json.JSONValue;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/stats")
public class StatsController {

    private static final Logger logger = (Logger) LoggerFactory.getLogger(StatsController.class);

    @Autowired
    private StatsDAO statsDAO;

    @RequestMapping("/_list")
    public String _list(Model model,
                        @RequestParam(value = "name", required = false, defaultValue = "World") String name) {

        return "/stats/_list";
    }


    @RequestMapping("/list3")
    public String list3(Model model,
                        @RequestParam(value = "name", required = false, defaultValue = "World") String name) {
        return "/stats/list3";
    }


    @RequestMapping("/list")
    public String list(Model model,
                       @RequestParam(value = "name", required = false, defaultValue = "World") String name) {

        List<String> queryType = statsDAO.getQueryType();
        model.addAttribute("quertType", queryType);

        List<String> dialogDomain = statsDAO.getDialogDomain();
        model.addAttribute("dialogDomain", dialogDomain);

        List<String> query_replace = statsDAO.getQueryReplace();
        model.addAttribute("query_replace", query_replace);

        return "/stats/list";
    }


    @RequestMapping("/historyList")
    public String historyList(Model model,
                              @RequestParam(value = "name", required = false, defaultValue = "World") String name) {
        List<String> queryType = statsDAO.getQueryType();
        model.addAttribute("quertType", queryType);


        List<String> actionType = statsDAO.getActionType();
        model.addAttribute("actionType", actionType);


        List<String> dialogDomain = statsDAO.getDialogDomain();
        model.addAttribute("dialogDomain", dialogDomain);

        List<String> query_replace = statsDAO.getQueryReplace();
        model.addAttribute("query_replace", query_replace);
        return "/stats/historyList";
    }

    @RequestMapping("/historyList2")
    public String historyList2(Model model,
                               @RequestParam(value = "name", required = false, defaultValue = "World") String name) {

        return "/stats/historyList2";
    }

    @SuppressWarnings({"unchecked", "rawtypes"})
    @RequestMapping(value = "/getList")
    public @ResponseBody
    String getList(
            @ModelAttribute Stats stats
    ) throws JsonGenerationException, JsonMappingException, IOException {


        if (stats.getSearchColumn().equals("query_text_and_response")) {
            stats.setSortColumn("query_text");
        }

        if (stats.getSortColumn().equals("query_text_and_response")) {
            stats.setSortColumn("query_text");
        }



        String pub_date = this.setPreviusPubDate(stats.getPub_date());

        int startNo = (stats.getPage() - 1) * stats.getRows();

        stats.setStartNo(startNo);
        stats.setPub_date(pub_date);
        HashMap map = new HashMap();
        try {
            List<Stats> arrList = statsDAO.getList(stats);
            int totalCount = statsDAO.getListTotalCount(stats);

            map.put("page", stats.getPage());
            map.put("arrList", arrList);
            //totalCounts
            map.put("records", totalCount);

            //total pages
            map.put("total", Math.ceil(Double.parseDouble(String.valueOf(totalCount)) / stats.getRows()));
        } catch (Exception e) {
            e.printStackTrace();
            ;
        }

        return JSONValue.toJSONString(map);

    }



    @SuppressWarnings({"unchecked", "rawtypes"})
    @RequestMapping(value = "/getHistoryList")
    public @ResponseBody
    String getHistoryList(
            @ModelAttribute Stats stats
    ) throws JsonGenerationException, JsonMappingException, IOException {


        if (stats.getSearchColumn().equals("query_text_and_response")) {
            stats.setSortColumn("query_text");
        }

        if (stats.getSortColumn().equals("query_text_and_response")) {
            stats.setSortColumn("query_text");
        }

        String pub_date = this.setPreviusPubDate(stats.getPub_date());

        int startNo = (stats.getPage() - 1) * stats.getRows();

        stats.setStartNo(startNo);
        stats.setPub_date(pub_date);

        List<Stats> arrList = statsDAO.getQueryControlHistoryList(stats);
        int totalCount = statsDAO.getQueryControlHistoryListTotalCount(stats);

        HashMap map = new HashMap();
        map.put("page", stats.getPage());
        map.put("arrList", arrList);
        //totalCounts
        map.put("records", totalCount);

        //total pages
        map.put("total", Math.ceil(Double.parseDouble(String.valueOf(totalCount)) / stats.getRows()));

        return JSONValue.toJSONString(map);

    }


    @RequestMapping("/detail")
    public String detail(Model model,
                         @ModelAttribute Stats stats) {

        Stats resultStatsOne= statsDAO.getOne(stats);
        model.addAttribute("result", resultStatsOne);



        return "/stats/detail";
    }






    public static String setPreviusPubDate(String pub_date) {

        if (pub_date.equals("today")) {
            pub_date = CommonUtils.getTodayDateYyyymmdd();
        } else if (pub_date.equals("week")) {

            String todayDate = CommonUtils.getTodayDateYyyymmdd();
            pub_date = CommonUtils.getPreviousDate(todayDate, "week");
        } else if (pub_date.equals("month")) {

            String todayDate = CommonUtils.getTodayDateYyyymmdd();
            pub_date = CommonUtils.getPreviousDate(todayDate, "month");
        } else if (pub_date.equals("year")) {

            String todayDate = CommonUtils.getTodayDateYyyymmdd();
            pub_date = CommonUtils.getPreviousDate(todayDate, "year");
        }

        return pub_date;

    }

    /**
     * import excel event
     *
     * @param multipartFile
     * @return
     */
    @PostMapping("/importExcel")
    public @ResponseBody
    String importExcel(@RequestParam("file") MultipartFile multipartFile) {


        Map<String, String> resultMap = new HashMap<String, String>();

        try {


            List excelDataList = ApachePOIExcelUtil.readExcelFile(multipartFile);
            int insertResult = statsDAO.insertList(excelDataList);
            ModelAndView mav = new ModelAndView();
            mav.addObject("message", "업로드성공!");
            mav.setViewName("redirect:" + "/nda/list2");

            if (insertResult > 0) {
                resultMap.put("result", "Excel Import 성공");
            } else {
                resultMap.put("result", "Excel Import 실패");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("result", e.getMessage());
        } finally {

            return JSONValue.toJSONString(resultMap);
        }

    }


    /**
     * Export and download file
     *
     * @param response
     */
    @RequestMapping("/exportToExcel")
    public void exportToExcel(HttpServletResponse response
            , @ModelAttribute Stats stats
    ) throws Exception {

        String outputFileName = "NaverDialogAppStatsExcelExport" + CommonUtils.getTodayDate();
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Set-Cookie", " fileDownload=true; path=/");
        response.setHeader("Content-Disposition", "attachment; filename=" + outputFileName + ".xls");

        Map<String, String> resultMap = new HashMap<String, String>();
        List<Stats> resultList = new ArrayList();


        if (stats.getSearchColumn().equals("query_text_and_response")) {
            stats.setSortColumn("query_text");
        }


        resultList = statsDAO.getList(stats);

        XSSFWorkbook workbook = ApachePOIExcelUtil.convertArrayListToExcelSheet(resultList, stats.getStartDate(), stats.getEndDate());

        workbook.write(response.getOutputStream()); // Write workbook to response.
        workbook.close();


    }


    /**
     * CSV (Comma seperate values ) export
     *
     * @param response
     * @throws Exception
     */
    @RequestMapping("/exportToCsv")
    public void exportToCsv(HttpServletResponse response
            , @ModelAttribute Stats stats
    ) {

        String outputFileName = "NaverDialogAppStatsCVSExport" + CommonUtils.getTodayDate();
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Set-Cookie", " fileDownload=true; path=/");
        response.setHeader("Content-Disposition", "attachment; filename=" + outputFileName + ".CSV");


        if (stats.getSearchColumn().equals("query_text_and_response")) {
            stats.setSortColumn("query_text");
        }


        try {


            OutputStream outputStream = response.getOutputStream();
            List arrList = statsDAO.getList(stats);

            String outputResult = CSVUtils.makeCSVString(arrList, stats.getStartDate(), stats.getEndDate());

            outputStream.write(outputResult.getBytes());
            outputStream.flush();
            outputStream.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }

    }


    @PostMapping("/delete")
    public @ResponseBody
    String delete(@RequestParam(value = "rowIds", required = false) String rowIds, Model model

    ) {

        String[] arrId = rowIds.split(",");
        Map<String, Object> map = new HashMap<String, Object>();

        logger.debug("ids-->" + arrId.toString());
        int result = statsDAO.deleteList(arrId);


        if (result > 0) {
            map.put("result", "삭제성공");
        } else {
            map.put("result", "삭제실패");
        }


        return JSONValue.toJSONString(map);
    }


    @PostMapping("/update")
    public @ResponseBody
    String update(@RequestParam(value = "rowId", required = false) String rowId,
                  @RequestParam(value = "query_text", required = false) String query_text,
                  @RequestParam(value = "query_response", required = false) String query_response,
                  Model model

    ) {


        Map<String, Object> map = new HashMap<String, Object>();
        int result = statsDAO.updateOne(query_text, query_response, rowId);

        if (result > 0) {
            model.addAttribute("message", "수정성공");
        } else {
            model.addAttribute("message", "수정실패");
        }

        map.put("result", result);
        return JSONValue.toJSONString(map);
    }


    @RequestMapping("/getQueryTypeCount")
    public @ResponseBody
    String getQueryTypeCount() throws JsonGenerationException, JsonMappingException, IOException {
        List arrList = statsDAO.getQueryTypeCount();
        return JSONValue.toJSONString(arrList);
    }


    @RequestMapping("/getActionType")
    public @ResponseBody
    String getActionType() throws JsonGenerationException, JsonMappingException, IOException {
        List arrList = statsDAO.getActionType();
        return JSONValue.toJSONString(arrList);
    }



    @RequestMapping("/getDialogDomain")
    public @ResponseBody
    String getDialogDomain() throws JsonGenerationException, JsonMappingException, IOException {
        List arrList = statsDAO.getDialogDomain();
        return JSONValue.toJSONString(arrList);
    }


    @RequestMapping("/getQueryReplace")
    public @ResponseBody
    String getQueryReplace() throws JsonGenerationException, JsonMappingException, IOException {
        List arrList = statsDAO.getQueryReplace();
        return JSONValue.toJSONString(arrList);
    }


    @RequestMapping("/queryTypeGraph")
    public String queryTypeGraph() {


        return "/stats/queryTypeGraph";
    }


    @RequestMapping("/queryTypePieChart")
    public String queryTypePieChart() {


        return "/stats/queryTypePieChart";
    }


}
