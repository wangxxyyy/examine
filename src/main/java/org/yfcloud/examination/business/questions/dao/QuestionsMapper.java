package org.yfcloud.examination.business.questions.dao;

import org.yfcloud.examination.business.questions.model.Questions;

import java.util.List;

public interface QuestionsMapper {
    int deleteByPrimaryKey(String id);

    int insert(Questions record);

    int insertSelective(Questions record);

    Questions selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Questions record);

    int updateByPrimaryKey(Questions record);

    List<Questions> getByUsersId(String id);

    List<Questions> getByItemNumber(Integer itemNumber, String testConent);

    void deleteQuestionsById(String questionId);

    Questions getByQuestionsId(String questionId);

    Questions getAnswerById(String questionId);

    Questions getCheckboxById(String questionId);

    List<Questions> getRadioList();

    List<Questions> getCheckboxList();

    List<Questions> getAnswerList();

    List<Questions> getQuestionByType(int type);

    List<Questions> getRadioQuestionId();

    List<Questions> getCheckboxQuestionId();

    List<Questions> getAnswerQuestionId();
}