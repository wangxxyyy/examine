package org.yfcloud.examination.business.questions.service;

import org.yfcloud.examination.business.questions.model.Questions;

import java.util.List;

/**
 * Created by Administrator on 2017/3/19 0019.
 */
public interface QuestionsService {
    int saveQuestions(Questions questions,String options);

    List<Questions> getByUserId(String id);

    List<Questions> getList(Integer itemNumber, String testConent);

    void deleteById(String id);

    Questions getQuestionsById(String questionId);

    Questions getCheckboxById(String questionId);

    List<Questions> getRadionQuestion();

    List<Questions> getCheckboxQuestion();

    List<Questions> getAnswerQuestion();

    List<Questions> getQuestionList(int type);

    Questions getAnswerById(String questionId);

    int saveTimer(String subject, int radioNumber, int radioSumScore, int checkboxNumber, int checkSumScore, int answerNumber,
                  int answerSumScore, String itemDiffcult, String createUserId, String time);
}
