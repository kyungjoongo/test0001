package com.nda.temp;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ApachePOIExcelWrite_test {

    private static final String FILE_NAME = "c://temp//MyFirstExcel.xlsx";

    public static void main(String[] args) {

        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("Datatypes in Java");


        List<HashMap> arrList = new ArrayList();

        HashMap map1 = new HashMap();
        map1.put("id", 1);
        map1.put("name", "kyungjoon");
        map1.put("pasword", "1114");
        arrList.add(map1);

        HashMap map2 = new HashMap();
        map2.put("id", 2);
        map2.put("name", "kyungjoon2");
        map2.put("pasword", "1115");
        arrList.add(map2);

        HashMap map3 = new HashMap();
        map3.put("id", 3);
        map3.put("name", "kyungjoon333");
        map3.put("pasword", "1116");
        arrList.add(map3);

        System.out.println(arrList.toString());


        Map<String, Object[]> data = new HashMap<String, Object[]>();
        data.put("7", new Object[]{7d, "Sonya", "75K", "SALES", "Rupert"});
        data.put("8", new Object[]{8d, "Kris", "85K", "SALES", "Rupert"});
        data.put("9", new Object[]{9d, "Dave", "90K", "SALES", "Rupert"});


        Object[][] datatypes = {
                {"Datatype", "Type", "Size(in bytes)"},
                {"int", "Primitive", 2},
                {"float", "Primitive", 4},
                {"double", "Primitive", 8},
                {"char", "Primitive", 1},
                {"String", "Non-Primitive", "No fixed size"}
        };

        int rowNum = 0;
        System.out.println("Creating excel");

        for (Object[] datatype : datatypes) {
            Row row = sheet.createRow(rowNum++);
            int colNum = 0;
            for (Object field : datatype) {
                Cell cell = row.createCell(colNum++);

                //스트링인경우
                if (field instanceof String) {
                    cell.setCellValue((String) field);

                    //인티저인경우.
                } else if (field instanceof Integer) {
                    cell.setCellValue((Integer) field);
                }
            }
        }

        try {
            FileOutputStream outputStream = new FileOutputStream(FILE_NAME);
            workbook.write(outputStream);
            workbook.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("Done");
    }
}