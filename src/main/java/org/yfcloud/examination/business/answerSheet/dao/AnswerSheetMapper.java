package org.yfcloud.examination.business.answerSheet.dao;

import org.yfcloud.examination.business.answerSheet.model.AnswerSheet;

import java.util.List;
import java.util.Map;

public interface AnswerSheetMapper {
    int deleteByPrimaryKey(String id);

    int insert(AnswerSheet record);

    int insertSelective(AnswerSheet record);

    AnswerSheet selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(AnswerSheet record);

    int updateByPrimaryKey(AnswerSheet record);

    AnswerSheet getAnswerIsCorrect(String answerQuestionsId);

    void saveAnswerScore(String answerQuestionsId, String score);

    List<AnswerSheet> getList(Map<String, Object> param);

    int getCount(Map<String, Object> param);

    List<AnswerSheet> getAnswerSheetList();

    List<AnswerSheet> getPoorList();

    List<AnswerSheet> getDifferenceList();

    List<AnswerSheet> getSecondaryList();

    List<AnswerSheet> getGoodList();

    List<AnswerSheet> getExcellent();

    List<AnswerSheet> getAnswerSheetLists(String startTime, String endTime);
}