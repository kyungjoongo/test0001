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
    public String list(Model model,
                       @RequestParam(value = "name", required = false, defaultValue = "World") String name) {

        return "/stats/_list";
    }

    @RequestMapping("/list")
    public String list2(Model model,
                        @RequestParam(value = "name", required = false, defaultValue = "World") String name) {


        List<String> queryType = statsDAO.getQueryType();

        model.addAttribute("quertType",queryType );


        return "/stats/list";
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

        stats.setSearchWord(this.makeLikeWord(stats.getSearchWord()));

        String pub_date = this.setPreviusPubDate(stats.getPub_date());

        int startNo = (stats.getPage() - 1) * stats.getRows();

        stats.setStartNo(startNo);
        stats.setPub_date(pub_date);

        List<Stats> arrList = statsDAO.getList(stats);
        int totalCount = statsDAO.getListTotalCount(stats);

        HashMap map = new HashMap();
        map.put("page", stats.getPage());
        map.put("arrList", arrList);
        //totalCounts
        map.put("records", totalCount);

        //total pages
        map.put("total", Math.ceil(Double.parseDouble(String.valueOf(totalCount)) / stats.getRows()));

        return JSONValue.toJSONString(map);

    }

    public static String makeLikeWord(String word){

        if (StringUtils.isNotEmpty(word)) {
            word = "%" + word + "%";
        }

        return word;
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
            ,@ModelAttribute Stats stats
    ) {

        String outputFileName = "NaverDialogAppStatsExcelExport" + CommonUtils.getTodayDate();
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Set-Cookie", " fileDownload=true; path=/");
        response.setHeader("Content-Disposition", "attachment; filename=" + outputFileName + ".xls");

        Map<String, String> resultMap = new HashMap<String, String>();
        List<Stats> resultList = new ArrayList();


        if (stats.getSearchColumn().equals("query_text_and_response")) {
            stats.setSortColumn("query_text");
        }

        stats.setSearchWord(this.makeLikeWord(stats.getSearchWord()));


        try {

            resultList = statsDAO.getList(stats);

            XSSFWorkbook workbook = ApachePOIExcelUtil.convertArrayListToExcelSheet(resultList, stats.getStartDate(), stats.getEndDate());

            workbook.write(response.getOutputStream()); // Write workbook to response.
            workbook.close();

        } catch (Exception e) {
            e.printStackTrace();

        }
    }


    /**
     * CSV (Comma seperate values ) export
     *
     * @param response
     * @throws Exception
     */
    @RequestMapping("/exportToCsv")
    public void exportToCsv(HttpServletResponse response
            ,@ModelAttribute Stats stats
    ) throws Exception {

        String outputFileName = "NaverDialogAppStatsCVSExport" + CommonUtils.getTodayDate();
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Set-Cookie", " fileDownload=true; path=/");
        response.setHeader("Content-Disposition", "attachment; filename=" + outputFileName + ".CSV");


        if (stats.getSearchColumn().equals("query_text_and_response")) {
            stats.setSortColumn("query_text");
        }

        stats.setSearchWord(this.makeLikeWord(stats.getSearchWord()));

        try {


            OutputStream outputStream = response.getOutputStream();
            List<Stats> arrList = statsDAO.getList(stats);

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


}
