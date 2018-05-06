package org.yfcloud.examination.business.paper.model;

import org.yfcloud.examination.business.questions.model.Questions;

import java.util.Date;
import java.util.List;

public class Paper {
    private String id;

    private String questionsId;

    private String subject;

    private String itemDiffculty;

    private Integer radioScore;

    private Integer checkboxScore;

    private Integer answerScore;

    private Integer radioNumber;

    private Integer checkboxNumber;

    private Integer answerNumber;

    private String time;

    private Date createDate;

    private String createUserId;

    private Integer state;

    private List<Questions> questions;

    public List<Questions> getQuestions() {
        return questions;
    }

    public void setQuestions(List<Questions> questions) {
        this.questions = questions;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getQuestionsId() {
        return questionsId;
    }

    public void setQuestionsId(String questionsId) {
        this.questionsId = questionsId == null ? null : questionsId.trim();
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject == null ? null : subject.trim();
    }

    public String getItemDiffculty() {
        return itemDiffculty;
    }

    public void setItemDiffculty(String itemDiffculty) {
        this.itemDiffculty = itemDiffculty == null ? null : itemDiffculty.trim();
    }

    public Integer getRadioScore() {
        return radioScore;
    }

    public void setRadioScore(Integer radioScore) {
        this.radioScore = radioScore;
    }

    public Integer getCheckboxScore() {
        return checkboxScore;
    }

    public void setCheckboxScore(Integer checkboxScore) {
        this.checkboxScore = checkboxScore;
    }

    public Integer getAnswerScore() {
        return answerScore;
    }

    public void setAnswerScore(Integer answerScore) {
        this.answerScore = answerScore;
    }

    public Integer getRadioNumber() {
        return radioNumber;
    }

    public void setRadioNumber(Integer radioNumber) {
        this.radioNumber = radioNumber;
    }

    public Integer getCheckboxNumber() {
        return checkboxNumber;
    }

    public void setCheckboxNumber(Integer checkboxNumber) {
        this.checkboxNumber = checkboxNumber;
    }

    public Integer getAnswerNumber() {
        return answerNumber;
    }

    public void setAnswerNumber(Integer answerNumber) {
        this.answerNumber = answerNumber;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time == null ? null : time.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(String createUserId) {
        this.createUserId = createUserId == null ? null : createUserId.trim();
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }
}