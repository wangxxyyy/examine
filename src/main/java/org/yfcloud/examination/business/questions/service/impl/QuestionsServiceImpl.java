package org.yfcloud.examination.business.questions.service.impl;

import org.springframework.stereotype.Service;
import org.yfcloud.examination.business.answer.dao.AnswerMapper;
import org.yfcloud.examination.business.answer.model.Answer;
import org.yfcloud.examination.business.paper.dao.PaperMapper;
import org.yfcloud.examination.business.paper.model.Paper;
import org.yfcloud.examination.business.questions.dao.QuestionsMapper;
import org.yfcloud.examination.business.questions.model.Questions;
import org.yfcloud.examination.business.questions.service.QuestionsService;
import org.yfcloud.examination.common.CommonUtil;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2017/3/19 0019.
 */
@Service
public class QuestionsServiceImpl implements QuestionsService{

    @Resource
    QuestionsMapper questionsMapper;

    @Resource
    AnswerMapper answerMapper;

    @Resource
    PaperMapper paperMapper;


    //保存或者更新试题
    @Override
    public int  saveQuestions(Questions questions, String options ) {
        if(questions.getId()!=null&&!"".equals(questions.getId())){
            questionsMapper.updateByPrimaryKeySelective(questions);
        }else {
            questions.setId(CommonUtil.getUUID());
            String [] optiones = options.split(";");
            for(int i=0;i<optiones.length;i++){
                String  answers = optiones[i];
                String [] anweres = answers.split(",");
                Answer answer = new Answer();
                if(anweres.length>0){
                    answer.setOptions(anweres[0]!=null?anweres[0]:"");
                    answer.setOptinosContent(anweres[1]!=null?anweres[1]:"");
                    answer.setIsCorrect(String.valueOf(anweres[2]!=null?anweres[2]:""));
                }
                answer.setId(CommonUtil.getUUID());
                answer.setCreateUserId(questions.getCreatUserId());
                answer.setQuestionsId(questions.getId());
                answer.setCreateDate(new Date());
                answer.setQuestionsId(questions.getId());
                answerMapper.insertSelective(answer);
            }

            questions.setCreateDate(new Date());
            questionsMapper.insertSelective(questions);
        }
        return 1;

    }

    @Override
    public List<Questions> getByUserId(String id) {
        List<Questions> questionsList = questionsMapper.getByUsersId(id);
        return  questionsList;
    }

    //查出试题和答案
    @Override
    public List<Questions> getList(Integer itemNumber, String testConent) {
        List<Questions> list = questionsMapper.getByItemNumber(itemNumber,testConent);
        return list;
    }

    //通过id删除
    @Override
    public void deleteById(String id) {
        answerMapper.deleteById(id);
        questionsMapper.deleteByPrimaryKey(id);
    }



    //查出单选题
    @Override
    public Questions getQuestionsById(String questionId) {
        Questions questions = questionsMapper.getByQuestionsId(questionId);
        return questions;
    }

    //查出解答题
    @Override
    public Questions getAnswerById(String questionId) {
        Questions questionsAnswer = questionsMapper.getAnswerById(questionId);

            return questionsAnswer;

    }

    /*查出每月最后一天生成的试题，并保存*/
    @Override
    public int saveTimer(String subject, int radioNumber, int radioSumScore, int checkboxNumber, int checkSumScore,
                         int answerNumber, int answerSumScore,  String itemDiffcult, String createUserId, String time) {
        //随机查出单选题
        String quesId = "";
        String questionId = "";
        String radioId = "";
        String checkboxId = "";
        String answerId = "";
        Paper paper = new Paper();
        List<Questions> radioQuestionIds = questionsMapper.getRadioQuestionId();
       for(int i=0;i<radioQuestionIds.size();i++){
           Questions radioQuestionId = radioQuestionIds.get(i);
           radioId += radioQuestionId.getId()+",";
       }
       //随机查出多选题
       List<Questions> checkboxQuestionIds = questionsMapper.getCheckboxQuestionId();
        for(int i=0;i<checkboxQuestionIds.size();i++){
            Questions checkboxQuestionId = checkboxQuestionIds.get(i);
            checkboxId += checkboxQuestionId.getId()+",";
        }

       //随机查出解答题
        List<Questions> answerQuestionIds = questionsMapper.getAnswerQuestionId();
        for(int i=0;i<answerQuestionIds.size();i++){
            Questions answerQuestionId = answerQuestionIds.get(i);
            answerId += answerQuestionId.getId()+",";
        }
        quesId = radioId + checkboxId + answerId;
        questionId = quesId.substring(0,quesId.length()-1);
        paper.setQuestionsId(questionId);
        paper.setId(CommonUtil.getUUID());
        paper.setTime(time);
        paper.setCreateUserId(createUserId);
        paper.setCreateDate(new Date());
        paper.setItemDiffculty(itemDiffcult);
        paper.setRadioNumber(radioNumber);
        paper.setRadioScore(radioSumScore);
        paper.setCheckboxNumber(checkboxNumber);
        paper.setCheckboxScore(checkSumScore);
        paper.setAnswerNumber(answerNumber);
        paper.setAnswerScore(answerSumScore);
        paper.setSubject(subject);
        paperMapper.insertSelective(paper);
        return 1;
    }


    @Override
    public Questions getCheckboxById(String questionId) {
        Questions questionsCheckbox = questionsMapper.getCheckboxById(questionId);
        return questionsCheckbox;
    }

    //添加试卷查出单选题
    @Override
    public List<Questions> getRadionQuestion() {
        List<Questions> radioQuestionList = questionsMapper.getRadioList();
        return radioQuestionList;
    }

    //添加试卷查出多选题
    @Override
    public List<Questions> getCheckboxQuestion() {
        List<Questions> checkboxQuestionList = questionsMapper.getCheckboxList();
        return checkboxQuestionList;
    }

    //添加试卷查出解答题
    @Override
    public List<Questions> getAnswerQuestion() {
        List<Questions> answerQuestionList = questionsMapper.getAnswerList();
        return answerQuestionList;
    }


    //添加试卷查出试题
    @Override
    public List<Questions> getQuestionList(int type) {
        List<Questions> list = questionsMapper.getQuestionByType(type);
        return list;
    }
}

