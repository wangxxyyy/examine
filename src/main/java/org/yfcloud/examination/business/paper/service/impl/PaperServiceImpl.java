package org.yfcloud.examination.business.paper.service.impl;

import org.springframework.stereotype.Service;
import org.yfcloud.examination.business.answer.dao.AnswerMapper;
import org.yfcloud.examination.business.paper.dao.PaperMapper;
import org.yfcloud.examination.business.paper.model.Paper;
import org.yfcloud.examination.business.paper.service.PaperService;
import org.yfcloud.examination.business.questions.dao.QuestionsMapper;
import org.yfcloud.examination.business.questions.model.Questions;
import org.yfcloud.examination.common.CommonUtil;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/5/1 0001.
 */
@Service
public class PaperServiceImpl implements PaperService {

    @Resource
    PaperMapper paperMapper;

    @Resource
    QuestionsMapper questionsMapper;

    @Resource
    AnswerMapper answerMapper;



    //删除试卷
    @Override
    public void deletePaper(String id,String questionId) {
        //先删除下面试题
        questionsMapper.deleteQuestionsById(questionId);
        //在删除试题下面的答案
        answerMapper.deleteAnwerById(questionId);
        //在删除试题
        paperMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Paper> getPaperList(Map<String, Object> param) {

    /*    List<Paper> paperList =  paperMapper.getList(param);
        for(int i=0;i<paperList.size();i++){
            Paper paper = paperList.get(i);
            String questionsId = paper.getQuestionsId();
            String [] questionsArray = questionsId.split(",");
            List<Questions> questionsList = new ArrayList<Questions>();
            for(String questionId:questionsArray){
                Questions questions = questionsMapper.getByQuestionsId(questionId);
                questionsList.add(questions);
            }
            paper.setQuestions(questionsList);
        }*/

        List<Paper> paperList = paperMapper.getList(param);
        for(int i=0;i<paperList.size();i++){
            Paper paper = paperList.get(i);
            String questionIds = paper.getQuestionsId();
            String [] questionsArray = questionIds.split(",");
            List<Questions> questionsList = new ArrayList<Questions>();
            for(int j=0;j<questionsArray.length;j++){
                String questionsId = questionsArray[j];
                Questions questions = questionsMapper.getByQuestionsId(questionsId);
                questionsList.add(questions);
            }
            paper.setQuestions(questionsList);
        }
        return paperList;
    }

    @Override
    public int getPaperCount(Map<String, Object> param) {
        return  paperMapper.getCount(param);
    }

    //查出最新一套试卷
    @Override
    public Paper getPaper() {
        return  paperMapper.getPaper();
    }

    @Override
    public List<Paper> List() {
        return paperMapper.list();
    }


    @Override
    public Paper getPapers(String name) {
        return paperMapper.getPapers(name);
    }

    //保存试卷
    @Override
    public int savePaper(String createUserId, String subject, String time, int radioNumber, int radioSumScore,
                         int checkboxNumber, int checkSumScore, int answerNumber, int answerSumScore, String questionIds,
                         String itemDiffculty) {
        Paper paper = new Paper();
        /*String [] questionId = questionIds.split(",");
        for(int i=0;i<questionId.length;i++){
            String quesId = questionId[i];
            paper.setQuestionsId(quesId);
        }*/
        paper.setQuestionsId(questionIds);
        paper.setId(CommonUtil.getUUID());
        paper.setCreateDate(new Date());
        paper.setRadioNumber(radioNumber);
        paper.setRadioScore(radioSumScore);
        paper.setCreateUserId(createUserId);
        paper.setItemDiffculty(itemDiffculty);
        paper.setAnswerNumber(answerNumber);
        paper.setAnswerScore(answerSumScore);
        paper.setSubject(subject);
        paper.setTime(time);
        paper.setCheckboxNumber(checkboxNumber);
        paper.setCheckboxScore(checkSumScore);
        paperMapper.insertSelective(paper);
        return 1;
    }
}
