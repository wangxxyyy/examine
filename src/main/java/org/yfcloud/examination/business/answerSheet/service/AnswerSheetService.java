package org.yfcloud.examination.business.answerSheet.service;

import org.yfcloud.examination.business.answerSheet.model.AnswerSheet;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/6/26 0026.
 */

public interface AnswerSheetService {
    int saveAnswerSheet(String options, String testIds,String paperId,String answerName,String createUserId,String typeIds);

    AnswerSheet getAnswerIsCorrect(String answerQuestionsId);

    int saveAnswerScore(String answerQuestionsIds, String scores);

    List<AnswerSheet> getList(Map<String, Object> param);

    int getCount(Map<String, Object> param);

    List<AnswerSheet> getAnswerSheetList(int options);

    List<AnswerSheet> getAnswerSheetList(String startTime, String endTime);
}
