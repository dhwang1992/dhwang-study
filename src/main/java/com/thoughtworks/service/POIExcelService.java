package com.thoughtworks.service;

import com.alibaba.fastjson.JSON;
import lombok.*;

import java.io.IOException;
import java.util.Date;

public class POIExcelService {

    public static void main(String[] args) throws IOException {
//        FileInputStream excelFile = new FileInputStream(new File("1123.xlsx"));
//        Workbook workbook = new XSSFWorkbook(excelFile);
//        Sheet datatypeSheet = workbook.getSheetAt(1);
//        Iterator<Row> iterator = datatypeSheet.iterator();
//        while (iterator.hasNext()) {
//
//            Row currentRow = iterator.next();
//            Iterator<Cell> cellIterator = currentRow.iterator();
//
//            System.out.print("INSERT INTO \"MCC\"(\"CODE\", \"NAME\") VALUES(");
//            while (cellIterator.hasNext()) {
//
//                Cell currentCell = cellIterator.next();
//                //getCellTypeEnum shown as deprecated for version 3.15
//                //getCellTypeEnum ill be renamed to getCellType starting from version 4.0
//                if (currentCell.getCellType() == Cell.CELL_TYPE_STRING) {
//                    System.out.print("'"+currentCell.getStringCellValue() + "'");
//                } else if (currentCell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
//                    int value = (int)currentCell.getNumericCellValue();
//                    System.out.print("'" + value + "' ,");
//                }
//
//            }
//            System.out.println(");");
//
//        }
        String jsonString = "{\"a\": \"1\",\"b\": \"2\", \"c\": \"3\"}";
        A a = JSON.parseObject(jsonString, A.class);
        System.out.println(a);

    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder(toBuilder = true)
    @ToString
    public static  class A {
        private String a;

        private String b;
    }
}
