package org.yfcloud.examination.business.questions.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.yfcloud.examination.business.answer.model.Answer;

import java.util.Date;
import java.util.List;

public class Questions {
    private String id;

    private Integer itemNumber;

    private String testContent;

    private String subject;

    private String itemDifficulty;

    private String creatUserId;

    private Integer state;

    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date createDate;

    private List<Answer> answer;

    private Integer questionsType;

    private String title;

    public List<Answer> getAnswer() {
        return answer;
    }

    public void setAnswer(List<Answer> answer) {
        this.answer = answer;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Integer getQuestionsType() {
        return questionsType;
    }

    public void setQuestionsType(Integer questionsType) {
        this.questionsType = questionsType;
    }


    public Integer getItemNumber() {
        return itemNumber;
    }

    public void setItemNumber(Integer itemNumber) {
        this.itemNumber = itemNumber;
    }


    public String getTestContent() {
        return testContent;
    }

    public void setTestContent(String testContent) {
        this.testContent = testContent == null ? null : testContent.trim();
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject == null ? null : subject.trim();
    }

    public String getItemDifficulty() {
        return itemDifficulty;
    }

    public void setItemDifficulty(String itemDifficulty) {
        this.itemDifficulty = itemDifficulty == null ? null : itemDifficulty.trim();
    }

    public String getCreatUserId() {
        return creatUserId;
    }

    public void setCreatUserId(String creatUserId) {
        this.creatUserId = creatUserId == null ? null : creatUserId.trim();
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}