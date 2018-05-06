
package org.yfcloud.examination.business.timer.controller;

import org.yfcloud.examination.business.questions.service.QuestionsService;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2017/9/8 0008.
 */

public class TimerController {

    @Resource
    QuestionsService questionsServiceImpl;

    public int saveTimer(){
        String subject = "编程";
        String itemDiffcult = "中级";
        int state = 0;
        int radioNumber = 3;
        int radioSumScore = 30;
        int checkboxNumber = 3;
        int checkSumScore = 30;
        int answerNumber = 2;
        int answerSumScore = 40;
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        String time = df.format(new Date());
        try{
            String createUserId = "123456";
            state = questionsServiceImpl.saveTimer(subject,radioNumber,radioSumScore,checkboxNumber,checkSumScore,
                    answerNumber,answerSumScore,itemDiffcult,createUserId,time );
        }catch (Exception e){
            e.printStackTrace();
        }
        return state;
    }
}