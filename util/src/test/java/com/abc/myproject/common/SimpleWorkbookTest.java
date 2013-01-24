package com.abc.myproject.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import junit.framework.Assert;

import org.junit.Test;

import com.abc.myproject.common.SimpleWorkbook;
import com.abc.myproject.common.SimpleWorkbook.RowMapper;

public class SimpleWorkbookTest {

    @Test
    public void writeAndRead() {
        SimpleWorkbook workbook = new SimpleWorkbook();
        workbook.createTitleRow("sheet01", "title01", "title02", "title03", "title04", "title05");
        for (short i = 1; i <= (short) 10; i++) {
            workbook.setData("sheet01", i, 0, "row:" + i + ",col:" + 0);

            workbook.setData("sheet01", i, 1, "row:" + i + ",col:" + 1);
            workbook.setData("sheet01", i, 2, i * 2.0f);
            workbook.setData("sheet01", i, 3, i % 2 == 0);
            // if (i % 2 == 0) {
            workbook.setData("sheet01", i, 4, new Date());
            // }
        }
        String filename = "SimpleWorkbookTestFile." + workbook.getExtension();
        try {
            FileOutputStream fos = new FileOutputStream(filename);
            workbook.write(fos);
            fos.close();

            FileInputStream fis = new FileInputStream(filename);
            SimpleWorkbook fileInDisk = SimpleWorkbook.fromStream(fis);
            fis.close();
            List<String> values = fileInDisk.values(new RowMapper<String>() {

                @Override
                public String mapRow(List<String> celValues) {
                    return celValues.get(0) + ";" + celValues.get(1) + ";" + celValues.get(2) + ";" + celValues.get(3)
                            + ";" + celValues.get(4) + ";";
                }
            });
            // for (String v : values) {
            // System.out.println(v);
            // }
            Assert.assertTrue("rows writen and read not equal", values.size() == 11);
            new File(filename).delete();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @Test
    public void mergeWorkbookTest(){
        SimpleWorkbook book1 = createWorkbook("book1", (short)5);
        SimpleWorkbook book2 = createWorkbook("book2", (short)10);
        SimpleWorkbook book3 = createWorkbook("book3", (short)20);
        SimpleWorkbook book = SimpleWorkbook.mergeWorkbook(book1,book2,book3);
        Assert.assertTrue("workbook's sheets is not merged", book.getWb().getNumberOfSheets() == 3);
        Assert.assertTrue("book1 is merged incorrectly", book.getWb().getSheetAt(0).getLastRowNum() == 5);
        Assert.assertTrue("book2 is merged incorrectly", book.getWb().getSheet("book2").getLastRowNum() == 10);
        Assert.assertTrue("book3 is merged incorrectly", book.getWb().getSheet("book3").getLastRowNum() == 20);
    }
    
    private SimpleWorkbook createWorkbook(String sheetName, short totalRow){
        SimpleWorkbook workbook = new SimpleWorkbook();
        for (short i = 0; i < totalRow; i++) {
            workbook.setData(sheetName, i, 0, "row:" + i + ",col:" + 0);
            workbook.setData(sheetName, i, 1, "row:" + i + ",col:" + 1);
            workbook.setData(sheetName, i, 2, i * 2.0f);
            workbook.setData(sheetName, i, 3, i % 2 == 0);
            workbook.setData(sheetName, i, 4, new Date());
        }
        return workbook;
    }
    
    @Test
    public void t() {
        Properties ps = System.getProperties();
        for (Object k : ps.keySet()) {
            System.out.println(k + "******" + ps.get(k));
        }
    }

}
