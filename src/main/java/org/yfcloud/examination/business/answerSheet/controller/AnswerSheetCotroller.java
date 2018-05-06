package org.yfcloud.examination.business.answerSheet.controller;

import org.apache.poi.hssf.usermodel.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.yfcloud.examination.business.answerSheet.model.AnswerSheet;
import org.yfcloud.examination.business.answerSheet.service.AnswerSheetService;
import org.yfcloud.examination.business.test.model.Test;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/6/26 0026.
 */
@Controller
@RequestMapping("/answerSheet")
public class AnswerSheetCotroller {

    @Resource
    AnswerSheetService answerSheetServiceImpl;

    /**
     * 保存答案
     *
     * @param request
     * @param answerSheet
     * @param options
     * @param testIds
     * @return
     */
    @RequestMapping("/saveAnswerSheet")
    @ResponseBody
    public int saveAnswerSheet(HttpServletRequest request, AnswerSheet answerSheet, String options, String testIds, String paperId, String typeIds) {
        int state = 0;
        try {
            HttpSession session = request.getSession();
            Test test = (Test) session.getAttribute("user");
            String answerName = test.getName();
            String createUserId = test.getId();
            state = answerSheetServiceImpl.saveAnswerSheet(options, testIds, paperId, answerName, createUserId, typeIds);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return state;
    }

    //保存解答题分数
    @RequestMapping("/saveAnswerScore")
    @ResponseBody
    public int savesaveAnswerSheet(String answerQuestionsIds, String scores) {
        int state = 0;
        try {
            state = answerSheetServiceImpl.saveAnswerScore(answerQuestionsIds, scores);
        } catch (Exception e) {
            e.printStackTrace();
            state = -1;
        }
        return state;
    }

    @RequestMapping("/index")
    public ModelAndView answerUser() {
        ModelAndView view = new ModelAndView();
        try {
            view.setViewName("answerSheet/answerSheetIndex");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return view;
    }


    //查询出考试成功的人
    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> map(HttpServletRequest request, String answerName) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            int page = Integer.parseInt(request.getParameter("page"));
            int rows = Integer.parseInt(request.getParameter("rows"));
            Map<String, Object> param = new HashMap<String, Object>();
            param.put("start", (page - 1) * rows);
            param.put("rows", rows);
            param.put("answerName", answerName);
            List<AnswerSheet> list = answerSheetServiceImpl.getList(param);
            int count = answerSheetServiceImpl.getCount(param);
            result.put("rows", list);
            result.put("total", count);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    //下载考试成功人数据
    @RequestMapping("/download")
    public void download(HttpServletResponse response,HttpServletRequest request) {
        int type = Integer.parseInt(request.getParameter("type"));
        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("考试成绩表");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow(0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

        //创建列
        HSSFCell titleCell = row.createCell(0);
        titleCell.setCellValue("姓名");
        titleCell.setCellStyle(style);
        titleCell = row.createCell(1);
        titleCell.setCellValue("总分");
        titleCell.setCellStyle(style);
        if(type==0){
            int options = Integer.parseInt(request.getParameter("option"));
            //查出数据库内容写入Excle
            List<AnswerSheet> list = answerSheetServiceImpl.getAnswerSheetList(options);
            for(int i=0;i<list.size();i++){
                AnswerSheet answerSheet = list.get(i);
                row = sheet.createRow(i + 1);
                row.createCell(0).setCellValue(answerSheet.getAnswerName());
                row.createCell(1).setCellValue(answerSheet.getTotalScore());
            }
        }else {
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            //查出数据库内容写入Excle
            List<AnswerSheet> list = answerSheetServiceImpl.getAnswerSheetList(startTime,endTime);
            for(int i=0;i<list.size();i++){
                AnswerSheet answerSheet = list.get(i);
                row = sheet.createRow(i + 1);
                row.createCell(0).setCellValue(answerSheet.getAnswerName());
                row.createCell(1).setCellValue(answerSheet.getTotalScore());
            }
        }
          //输出Excel文件
        OutputStream output= null;
        try {
            output = response.getOutputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }
        response.reset();
        response.setHeader("Content-disposition", "attachment; filename=students.xls");
        response.setContentType("application/msexcel");
        try {
            wb.write(output);
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            output.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
