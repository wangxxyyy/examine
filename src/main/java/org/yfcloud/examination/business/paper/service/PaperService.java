package org.yfcloud.examination.business.paper.service;

import org.yfcloud.examination.business.paper.model.Paper;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/5/1 0001.
 */
public interface PaperService {

    void deletePaper(String id,String questionId);

    List<Paper> getPaperList(Map<String, Object> param);

    int getPaperCount(Map<String, Object> param);

    Paper getPaper();

    List<Paper> List();

    Paper getPapers(String name);

    int savePaper(String createUserId, String subject, String time, int radioNumber, int radioSumScore, int checkboxNumber, int checkSumScore, int answerNumber, int answerSumScore, String questionIds,String itemDiffculty);
}
