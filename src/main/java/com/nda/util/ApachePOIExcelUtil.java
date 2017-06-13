package com.nda.util;


import ch.qos.logback.classic.Logger;
import com.nda.model.Stats;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.DocumentFactoryHelper;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.io.PushbackInputStream;
import java.util.*;


public class ApachePOIExcelUtil {

    private static final String FILE_NAME = "temp002.xls";
    private static final Logger logger = (Logger) LoggerFactory.getLogger(ApachePOIExcelUtil.class);

    /**
     * 엑셀파일로 부터 row를 읽어 List<HashMap> 형태를 반환
     *
     * @param file
     */
    public static List<HashMap> readExcelFile(MultipartFile file) throws Exception {

        List resultArrayList = new ArrayList();

        InputStream pushbackInputstream = new PushbackInputStream(file.getInputStream(), 10000000);

        // For .xlsx
        boolean isMsDoc = DocumentFactoryHelper.hasOOXMLHeader(pushbackInputstream);


        // For .xls
        boolean isOpenOfficeDoc = POIFSFileSystem.hasPOIFSHeader(pushbackInputstream);
        Workbook workbook;


        if (isMsDoc) {//Microsoft excel

            workbook = new XSSFWorkbook(file.getInputStream());
            resultArrayList=processExcelToArrayList(workbook);

        } else if (isOpenOfficeDoc) {//openoffice excel 형태


            workbook = new HSSFWorkbook(file.getInputStream());
            resultArrayList=processExcelToArrayList(workbook);
        }


        return resultArrayList;
    }


    /**
     * excelsheet to arrayList
     * @param workbook
     * @return
     */
    public static List<HashMap> processExcelToArrayList(Workbook workbook) {


        Sheet datatypeSheet = workbook.getSheetAt(0);
        Iterator<Row> iterator = datatypeSheet.iterator();

        int row = 0;
        List resultArrayList=new ArrayList();

        while (iterator.hasNext()) {

            Row currentRow = iterator.next();

            //logger.debug("currentRow-->" + currentRow.getRowNum());
            logger.debug("currentRow-->" + currentRow.getRowNum());
            Iterator<Cell> cellIterator = currentRow.iterator();

            int cellNo = 1;
            HashMap oneRowMap = new HashMap();
            while (cellIterator.hasNext()) {

                logger.debug("cellno-->" + cellNo);

                Cell currentCell = cellIterator.next();


                logger.debug("cellNo:" + cellNo + "-->" + currentCell.getStringCellValue() + "\n");

                if (cellNo == 1) {
                    oneRowMap.put("query_text", currentCell.getStringCellValue());
                } else if (cellNo == 2) {
                    oneRowMap.put("query_response", currentCell.getStringCellValue());
                }

                String currentCellValue = currentCell.getStringCellValue();

                cellNo++;

            }
            logger.debug("currentRow-->" + row);
            row++;

            resultArrayList.add(oneRowMap);
        }

        logger.debug("arrList-->" + resultArrayList.toString());


        return resultArrayList;
    }



    /**
     *
     * 질의문장 convert arrayList to java Excel sheet
     * @param arrList
     * @return
     */
    public static XSSFWorkbook convertArrayListToExcelSheet ( List<Stats> arrList, String startDate, String endDate){
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("질의문장_"+startDate+ "~"+ endDate );

        sheet.setColumnWidth(0, 3000);
        sheet.setColumnWidth(2, 10000);
        sheet.setColumnWidth(1, 7500);
        sheet.setColumnWidth(5, 5000);


        int rowNum = 0;
        for (Stats stats : arrList) {
            Row row = sheet.createRow(rowNum);
            int colNum = 0;


            //id
            Cell cell = row.createCell(colNum++);
            int id = (int) stats.getId();
            cell.setCellValue((int) id);


            //query_text
            cell = row.createCell(colNum++);
            String query_text = (String) stats.getQuery_text();
            cell.setCellValue((String) query_text);

            //query_response
            cell = row.createCell(colNum++);
            String query_response = (String) stats.getQuery_response();
            cell.setCellValue((String) query_response);

            //변경쿼리
            cell = row.createCell(colNum++);
            String query_replace = (String) stats.getQuery_replace();
            cell.setCellValue((String) query_replace);


            //대화도메인
            cell = row.createCell(colNum++);
            String dialogDomain = (String) stats.getDialogDomain();
            cell.setCellValue((String) dialogDomain);


            //기존라우팅
            cell = row.createCell(colNum++);
            String query_route_by_date = (String) stats.getQuery_route();
            cell.setCellValue(CommonUtils.getRouteName(query_route_by_date));


            //변경라우팅
            cell = row.createCell(colNum++);
            String output_route = (String) stats.getOutput_route();
            cell.setCellValue(CommonUtils.getRouteName(output_route));

            //query_type
            cell = row.createCell(colNum++);
            String query_type = (String) stats.getQuery_type();
            cell.setCellValue((String) query_type);


            //query_continuation
            cell = row.createCell(colNum++);
            String query_continuation = (String) stats.getQuery_continuation();
            cell.setCellValue((String) query_continuation);

            //query_work_status
            cell = row.createCell(colNum++);
            String query_work_status_by_date = (String) stats.getQuery_work_status();
            if ( query_work_status_by_date.equals("1")){
                query_work_status_by_date="작업완료";
            }else{
                query_work_status_by_date="미작업";
            }
            cell.setCellValue((String) query_work_status_by_date);

            //일괄블럭.
            //query_blocked
            cell = row.createCell(colNum++);
            int query_blocked = (int) stats.getQuery_blocked();
            String str_query_blocked= "";
            if ( query_blocked==1){
                str_query_blocked="true";
            }else{
                str_query_blocked="false";
            }
            cell.setCellValue((String) str_query_blocked);


            //qm라우팅
            cell = row.createCell(colNum++);
            String qm_output_route = (String) stats.getOutput_route();
            cell.setCellValue(CommonUtils.getRouteName(qm_output_route));


            //worker
            cell = row.createCell(colNum++);
            String worker = (String) stats.getWorker();
            cell.setCellValue((String) worker);


            //qcCount
            cell = row.createCell(colNum++);
            int qcCount = (int) stats.getQc_sum();
            cell.setCellValue((int) qcCount);

            //날짜
            cell = row.createCell(colNum++);
            String pub_date = (String) stats.getPub_date();
            cell.setCellValue((String) pub_date);



            rowNum++;

            System.out.println("export "+ rowNum + "line complete");
        }

        return  workbook;

    }









}