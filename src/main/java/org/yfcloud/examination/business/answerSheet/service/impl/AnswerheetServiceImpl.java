package org.yfcloud.examination.business.answerSheet.service.impl;

import org.springframework.stereotype.Service;
import org.yfcloud.examination.business.answer.dao.AnswerMapper;
import org.yfcloud.examination.business.answer.model.Answer;
import org.yfcloud.examination.business.answerSheet.dao.AnswerSheetMapper;
import org.yfcloud.examination.business.answerSheet.model.AnswerSheet;
import org.yfcloud.examination.business.answerSheet.service.AnswerSheetService;
import org.yfcloud.examination.business.paper.dao.PaperMapper;
import org.yfcloud.examination.common.CommonUtil;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/6/26 0026.
 */
@Service
public class AnswerheetServiceImpl implements AnswerSheetService{

    @Resource
    AnswerMapper answerMapper;

    @Resource
    PaperMapper paperMapper;

    @Resource
    AnswerSheetMapper answerSheetMapper;

    @Override
    public int saveAnswerSheet(String options, String testIds,String paperId,String answerName,String createUserId,String typeIds) {
        String [] questionsIds = testIds.split(",");
        String [] optionses = options.split(",");
        String [] typeIdes = typeIds.split(",");
        AnswerSheet answerSheet = new AnswerSheet();
        for(int k=0;k<optionses.length;k++){
            String quetisonIdss = questionsIds[k];
            String optionss = optionses[k];
            int  typeIdess = Integer.parseInt(typeIdes[k]);

            //单选题
            if(typeIdess==0) {
                answerSheet.setQuestionsId(quetisonIdss);
                answerSheet.setAnswerName(answerName);
                answerSheet.setCreateUserId(createUserId);
                answerSheet.setPaperId(paperId);
                answerSheet.setExamineeAnswer(optionss);
                answerSheet.setCreateDate(new Date());
                answerSheet.setId(CommonUtil.getUUID());

                //查询试题正确答案
                Answer answer = answerMapper.getRadioAnswerByquestinosId(quetisonIdss);
                String correctAnswers = answer.getOptions();
                answerSheet.setIsCorrect(correctAnswers);
                if(correctAnswers.equals(optionss)){
                    answerSheet.setTotalScore(5);
                }else {
                    answerSheet.setTotalScore(0);
                }
                answerSheetMapper.insertSelective(answerSheet);
            }

            //多选题
            if(typeIdess==2){
                answerSheet.setQuestionsId(quetisonIdss);
                answerSheet.setAnswerName(answerName);
                answerSheet.setCreateUserId(createUserId);
                answerSheet.setPaperId(paperId);
                answerSheet.setExamineeAnswer(optionss);
                answerSheet.setId(CommonUtil.getUUID());
                answerSheet.setCreateDate(new Date());
                String correctAnswers = "";

                //查询正确答案
                List<Answer> answers = answerMapper.getAnswerByquestinosId(quetisonIdss);
                for(int i=0;i<answers.size();i++){
                    correctAnswers += answers.get(i).getOptions();
                }
                 answerSheet.setIsCorrect(correctAnswers);

                //判断多选题每题得分
                String answersd ="";
                String optionsd ="";
                String [] ans = correctAnswers.split("");
                String [] option = optionss.split("");
                answersd = String.join(",",ans);
                optionsd = String.join(",",option);
                String [] correctAnswersd = answersd.split(",");
                String [] optionesd = optionsd.split(",");

                //标准答案有两个逻辑判断
                if(correctAnswersd.length==2){
                    //答题人答的一个答案逻辑判断
                  if(optionesd.length==1){
                      if(correctAnswersd[0].equals(optionesd[0])){
                          answerSheet.setTotalScore(4);
                      }else if(correctAnswersd[1].equals(optionesd[0])){
                          answerSheet.setTotalScore(4);
                      }else{
                          answerSheet.setTotalScore(0);
                      }
                  }

                  //答题人答的两个答案逻辑判断
                  if(optionesd.length==2){
                    if(optionss.equals(correctAnswers)){
                        answerSheet.setTotalScore(10);
                    }else {
                        answerSheet.setTotalScore(0);
                    }
                  }

                  //答题人答的3个答案逻辑判断
                    if(optionesd.length==3){
                      answerSheet.setTotalScore(0);
                    }
                }

                //标准答案有三个逻辑判断
                if(correctAnswersd.length==3){
                    //答题人只答一个答案逻辑判断
                   if(optionesd.length==1){
                       if(correctAnswersd[0].equals(optionesd[0])){
                           answerSheet.setTotalScore(3);
                       }else if(correctAnswersd[1].equals(optionesd[0])){
                           answerSheet.setTotalScore(3);
                       }else if(correctAnswersd[2].equals(optionesd[0])){
                           answerSheet.setTotalScore(3);
                       }else {
                           answerSheet.setTotalScore(0);
                       }
                   }
                   //答题人只答两个答案逻辑判断
                    if(optionesd.length==2){
                        if(correctAnswersd[0].equals(optionesd[0])&&correctAnswersd[1].equals(optionesd[1])){
                            answerSheet.setTotalScore(6);
                        }else if(correctAnswersd[1].equals(optionesd[0])&&correctAnswersd[2].equals(optionesd[1])){
                            answerSheet.setTotalScore(6);
                        }else if(correctAnswersd[0].equals(optionesd[0])&&correctAnswersd[2].equals(optionesd[1])){
                            answerSheet.setTotalScore(6);
                        }else {
                            answerSheet.setTotalScore(0);
                        }
                    }
                    //答题人答三个答案逻辑判断
                    if(optionesd.length==3){
                        if(correctAnswersd[0].equals(optionesd[0])&&correctAnswersd[1].equals(optionesd[1])
                                &&correctAnswersd[2].equals(optionesd[2])){
                            answerSheet.setTotalScore(10);
                        }else {
                            answerSheet.setTotalScore(0);
                        }
                    }
                }

                //标准答案有四个逻辑判断
                if(correctAnswersd.length==4){
                    //答题人答一个答案逻辑判断
                    if(optionesd.length==1){
                        if(correctAnswersd[0].equals(optionesd[0])){
                            answerSheet.setTotalScore(2);
                        }else if(correctAnswersd[1].equals(optionesd[0])){
                            answerSheet.setTotalScore(2);
                        }else if (correctAnswersd[2].equals(optionesd[0])){
                            answerSheet.setTotalScore(2);
                        }else if(correctAnswersd[3].equals(optionesd[0])){
                            answerSheet.setTotalScore(2);
                        }else {
                            answerSheet.setTotalScore(0);
                        }
                    }
                    //答题人答两个答案逻辑判断
                    if(optionesd.length==2){
                        if(correctAnswersd[0].equals(optionesd[0])&&correctAnswersd[1].equals(optionesd[1])){
                            answerSheet.setTotalScore(4);
                        }else if(correctAnswersd[0].equals(optionesd[0])&&correctAnswersd[2].equals(optionesd[1])){
                            answerSheet.setTotalScore(4);
                        }else if(correctAnswersd[0].equals(optionesd[0])&&correctAnswersd[3].equals(optionesd[1])){
                            answerSheet.setTotalScore(4);
                        }else if(correctAnswersd[1].equals(optionesd[0])&&correctAnswersd[2].equals(optionesd[1])){
                            answerSheet.setTotalScore(4);
                        }else if(correctAnswersd[1].equals(optionesd[0])&&correctAnswersd[3].equals(optionesd[1])){
                            answerSheet.setTotalScore(4);
                        }else if(correctAnswersd[2].equals(optionesd[0])&&correctAnswersd[3].equals(optionesd[1])){
                            answerSheet.setTotalScore(4);
                        }
                        else {
                            answerSheet.setTotalScore(0);
                        }
                    }

                    //答题人答三个逻辑判断
                    if(optionesd.length==3){
                       if(correctAnswersd[0].equals(optionesd[0])&&correctAnswersd[1].equals(optionesd[1])&&
                               correctAnswersd[2].equals(optionesd[2])){
                           answerSheet.setTotalScore(6);
                       }else if(correctAnswersd[0].equals(optionesd[0])&&correctAnswersd[1].equals(optionesd[1])&&
                               correctAnswersd[3].equals(optionesd[2])){
                           answerSheet.setTotalScore(6);
                       }else if(correctAnswersd[1].equals(optionesd[0])&&correctAnswersd[2].equals(optionesd[1])&&
                               correctAnswersd[3].equals(optionesd[2])){
                           answerSheet.setTotalScore(6);
                       }else {
                           answerSheet.setTotalScore(0);
                       }
                    }

                    //答题人答四个逻辑判断
                    if(optionesd.length==4){
                        if(correctAnswersd[0].equals(optionesd[0])&&correctAnswersd[1].equals(optionesd[1])&&
                                correctAnswersd[2].equals(optionesd[2])&&correctAnswersd[3].equals(optionesd[3])){
                            answerSheet.setTotalScore(10);
                        }else {
                            answerSheet.setTotalScore(0);
                        }
                    }

                    //答题人答五个逻辑判断
                    if(optionesd.length==5){
                        answerSheet.setTotalScore(0);
                    }
                }
                answerSheetMapper.insertSelective(answerSheet);
            }

            //解答题
            if(typeIdess==1) {
                answerSheet.setIsCorrect(null);
                answerSheet.setTotalScore(null);
                answerSheet.setQuestionsId(quetisonIdss);
                answerSheet.setAnswerName(answerName);
                answerSheet.setCreateUserId(createUserId);
                answerSheet.setPaperId(paperId);
                answerSheet.setExamineeAnswer(optionss);
                answerSheet.setId(CommonUtil.getUUID());
                answerSheet.setCreateDate(new Date());
                answerSheetMapper.insertSelective(answerSheet);
            }
        }
        return 1;
    }

    //查出答卷人答的解答题答案
    @Override
    public AnswerSheet getAnswerIsCorrect(String answerQuestionsId) {
        return answerSheetMapper.getAnswerIsCorrect(answerQuestionsId);
    }


    //保存解答题分数
    @Override
    public int saveAnswerScore(String answerQuestionsIds, String scores) {
        String [] answerQuestionsIdes = answerQuestionsIds.split(",");
        String [] scorees = scores.split(",");
        AnswerSheet answerSheet = new AnswerSheet();
        for (int i=0;i<answerQuestionsIdes.length;i++){
            String answerQuestionsId = answerQuestionsIdes[i];
            String score = scorees[i];
            answerSheetMapper.saveAnswerScore(score,answerQuestionsId);
        }
        return 1;
    }

    //查询答题成功的人
    @Override
    public List<AnswerSheet> getList(Map<String, Object> param) {
        List<AnswerSheet> list = answerSheetMapper.getList(param);
        return list;
    }

    //查询答题成功人的总数
    @Override
    public int getCount(Map<String, Object> param) {
        return answerSheetMapper.getCount(param);
    }

    //查询考试成功的人
    @Override
    public List<AnswerSheet> getAnswerSheetList(int options) {

        //60分以下查询
        List<AnswerSheet> list = null;
        if (options == 1) {
            list = answerSheetMapper.getPoorList();
        }

        //60--70分查询
        if(options == 2){
            list = answerSheetMapper.getDifferenceList();
        }

        //71--79分查询
        if(options == 3){
            list = answerSheetMapper.getSecondaryList();
        }

        //80--90分查询
        if(options ==4){
            list = answerSheetMapper.getGoodList();
        }

        //91--100
        if (options ==5){
            list = answerSheetMapper.getExcellent();
        }
        return list;
    }

    //按照时间段查询
    @Override
    public List<AnswerSheet> getAnswerSheetList(String startTime, String endTime) {
        return answerSheetMapper.getAnswerSheetLists(startTime,endTime);
    }
}
