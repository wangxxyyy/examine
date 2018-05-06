package org.yfcloud.examination.system.home.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.yfcloud.examination.business.answer.service.AnswerService;
import org.yfcloud.examination.business.paper.model.Paper;
import org.yfcloud.examination.business.paper.service.PaperService;
import org.yfcloud.examination.business.questions.model.Questions;
import org.yfcloud.examination.business.questions.service.QuestionsService;
import org.yfcloud.examination.business.test.model.Test;
import org.yfcloud.examination.system.menu.model.Menu;
import org.yfcloud.examination.system.menu.service.MenuService;
import org.yfcloud.examination.system.user.model.User;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/3/17 0017.
 */
@Controller
@RequestMapping("/home")
public class HomeController {

    @Resource
    MenuService menuServiceImpl;

    @Resource
    QuestionsService questionsServiceImpl;

    @Resource
    AnswerService answerServiceImpl;

    @Resource
    PaperService paperServiceImpl;

    @RequestMapping("/index")
    public ModelAndView login(HttpServletRequest request,Menu menu){
        ModelAndView view = new ModelAndView();
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            List<Menu> menuList = menuServiceImpl.getListMenu(menu);
            view.addObject("menuList",menuList);
            view.addObject("user",user);
            view.setViewName("main");

        }catch (Exception e){
            e.printStackTrace();
        }
        return view;
    }
    @RequestMapping("/examinationIndex")
    public ModelAndView ExaminationIndex(HttpServletRequest request){
        ModelAndView view = new ModelAndView();
        try {
           HttpSession session = request.getSession();
           User user = (User) session.getAttribute("user");
           List<Questions> questions = questionsServiceImpl.getByUserId(user.getId());
 //        Questions questions = questionsServiceImpl.getByUserId(user.getId());
 //        List<Answer> answersList = answerServiceImpl.getByQuestionId(questions.getId());
           view.addObject("questions",questions);
           view.addObject("user",user);
           view.setViewName("index");
        }catch (Exception e){
            e.printStackTrace();
        }
        return  view;
    }

    @RequestMapping("/testIndex")
    public ModelAndView testIndex(HttpServletRequest request){
        ModelAndView view = new ModelAndView();
        try {
            HttpSession session = request.getSession();
            Test test = (Test) session.getAttribute("user");

            //查出最新一套试卷
            Paper paper = paperServiceImpl.getPaper();
            String questionIds = paper.getQuestionsId();
            String [] questionsArray = questionIds.split(",");
            List<Questions> questionsRadioList = new ArrayList<Questions>();
            List<Questions> questionsAnswerList = new ArrayList<Questions>();
            List<Questions> questionsCheckboxList = new ArrayList<Questions>();
            for(int i=0;i<questionsArray.length;i++){
                String questionId = questionsArray[i];
                Questions questionRadio = questionsServiceImpl.getQuestionsById(questionId);
                Questions questionsAnswer = questionsServiceImpl.getAnswerById(questionId);
                Questions questionsCheckbox = questionsServiceImpl.getCheckboxById(questionId);
                if(questionRadio!=null){
                    questionsRadioList.add(questionRadio);
                }
                if(questionsAnswer!=null) {
                    questionsAnswerList.add(questionsAnswer);
                }
                if(questionsCheckbox!=null){
                    questionsCheckboxList.add(questionsCheckbox);
                }
            }
            view.addObject("user",test);
            view.addObject("questionsRadioList",questionsRadioList);
            view.addObject("questionsAnswerList",questionsAnswerList);
            view.addObject("questionsCheckboxList",questionsCheckboxList);
            view.addObject("paper",paper);
            view.setViewName("test/mainIndex");
        }catch (Exception e){
            e.printStackTrace();
        }
        return view;
    }

}
