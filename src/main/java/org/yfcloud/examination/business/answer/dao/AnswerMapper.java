package org.yfcloud.examination.business.answer.dao;

import org.yfcloud.examination.business.answer.model.Answer;

import java.util.List;

public interface AnswerMapper {
    int deleteByPrimaryKey(String id);

    int insert(Answer record);

    int insertSelective(Answer record);

    Answer selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Answer record);

    int updateByPrimaryKey(Answer record);

    List<Answer> getById(String id);

    void deleteById(String id);

    void deleteAnwerById(String questionId);

    List<Answer> getAnswerByquestinosId(String quetisonId);

    Answer getRadioAnswerByquestinosId(String quetisonIdss);

}