package org.yfcloud.examination.business.paper.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.yfcloud.examination.business.answerSheet.model.AnswerSheet;
import org.yfcloud.examination.business.answerSheet.service.AnswerSheetService;
import org.yfcloud.examination.business.paper.model.Paper;
import org.yfcloud.examination.business.paper.service.PaperService;
import org.yfcloud.examination.business.questions.model.Questions;
import org.yfcloud.examination.business.questions.service.QuestionsService;
import org.yfcloud.examination.business.test.model.Test;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2017/5/1 0001.
 */
@Controller
@RequestMapping("/paper")
public class PaperController {

    @Resource
    PaperService paperServiceImpl;

    @Resource
    QuestionsService questionsServiceImpl;

    @Resource
    AnswerSheetService answerSheetServiceImpl;


    @RequestMapping("/index")
    public ModelAndView paperIndex(){
        ModelAndView view = new ModelAndView();
        try {
            view.setViewName("paper/paperIndex");
        }catch (Exception e){
            e.printStackTrace();
        }
        return view;
    }

    //模态窗口跳转
    @RequestMapping("/questionSelect")
    public ModelAndView questionSelect(int type){
        ModelAndView view = new ModelAndView();
        try {
            view.addObject("type",type);
            view.setViewName("paper/paperSelect");
        }catch (Exception e){
            e.printStackTrace();
        }
        return view;
    }

    //保存试卷
    @RequestMapping("/savePaper")
    @ResponseBody
    public int savePaper(HttpServletRequest request,String subject,String time,int radioNumber,int radioSumScore,int checkboxNumber,
                         int checkSumScore, int answerNumber,int answerSumScore,String questionIds,String itemDiffculty ){
        int state = 0;
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        time = df.format(new Date());
        try {
            HttpSession session = request.getSession();
            Test user = (Test) session.getAttribute("user");
            String createUserId = user.getId();
            state = paperServiceImpl.savePaper(createUserId,subject,time,radioNumber,radioSumScore,checkboxNumber,
                    checkSumScore,answerNumber,answerSumScore,questionIds,itemDiffculty);

        }catch (Exception e){
            e.printStackTrace();
        }
        return state;
    }

    //删除试卷
    @RequestMapping("/deletePaper")
    @ResponseBody
    public int deletePaper(Paper paper){
        String id = paper.getId();
        String questionId = paper.getQuestionsId();
        int state = 0;
        try{
            paperServiceImpl.deletePaper(id,questionId);
            state = 1;
        }catch (Exception e){
            e.printStackTrace();
            state = -1;
        }
        return state;
    }
    //查询试卷
    @RequestMapping("/listPaper")
    @ResponseBody
    public Map<String,Object> list(HttpServletRequest request, Paper paper){
        Map<String,Object> result = new HashMap<String,Object>();
        try {
//            int page = Integer.parseInt(request.getParameter("page"));
//            int rows = Integer.parseInt(request.getParameter("rows"));
            int page = 0;
            int rows = 10;
            String subject = "编程";
            Map<String,Object> param = new HashMap<String,Object>();
            param.put("start", (page-1)*rows);
            param.put("rows", rows);
            param.put("subject",subject);
            List<Paper> PaperList = paperServiceImpl.getPaperList(param);
            int count = paperServiceImpl.getPaperCount(param);

            result.put("rows" ,PaperList);
            result.put("total",count);

        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }


    //查询出所有试卷
    @RequestMapping("/listSubject")
    @ResponseBody
    public List<Paper> list(){
        List<Paper> paperList = null;
        try {
            paperList = paperServiceImpl.List();
        }catch (Exception e){
            e.printStackTrace();
        }
        return paperList;
    }


    //解答题评分页面跳转
        @RequestMapping("/answerScoreIndex")
    public ModelAndView answerScore(String name) {
        ModelAndView view = new ModelAndView();
        view.setViewName("answerScore/answerScoreIndex");
        return  view;
    }

    //根据阅卷人选的科目查出对应解答题
    @RequestMapping("/answerScore")
    @ResponseBody
    public Map<String,Object> map(String name){
        Map<String,Object> resultMap = new HashMap<String,Object>();
        Paper paper = paperServiceImpl.getPapers(name);
        String questions = paper.getQuestionsId();
        String [] arrayQuestions = questions.split(",");
        List<Questions> questionsAnswerList = new ArrayList<Questions>();
        List<AnswerSheet> answerSheetList = new ArrayList<AnswerSheet>();
        for (int i=0;i<arrayQuestions.length;i++) {
            String answerQuestionsId = arrayQuestions[i];
            Questions questionsAnswer = questionsServiceImpl.getAnswerById(answerQuestionsId);
            AnswerSheet answerSheet = answerSheetServiceImpl.getAnswerIsCorrect(answerQuestionsId);
            questionsAnswerList.add(questionsAnswer);
            answerSheetList.add(answerSheet);
        }
        resultMap.put("questionsAnswerList",questionsAnswerList);
        resultMap.put("answerSheetList",answerSheetList);
        return resultMap;
    }
}
