package org.yfcloud.examination.business.questions.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.yfcloud.examination.business.questions.model.Questions;
import org.yfcloud.examination.business.questions.service.QuestionsService;
import org.yfcloud.examination.system.user.model.User;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/3/19 0019.
 */
@Controller
@RequestMapping("/questions")
public class QuestionsController {

    @Resource
    QuestionsService questionsServiceImpl;

    @RequestMapping("/index")
    public ModelAndView index(HttpServletRequest request){
        ModelAndView view = new ModelAndView();
        try{
            view.setViewName("questions/questionsIndex");
        }catch (Exception e){
            e.printStackTrace();
        }
        return view;
    }

    //保存试题或者更新试题
    @RequestMapping("/saveQuestions")
    @ResponseBody
    public int saveQuestions(HttpServletRequest request, Questions questions,String options){
        int state = 0;
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try{
            questions.setCreatUserId(user.getId());
            state = questionsServiceImpl.saveQuestions(questions,options);
        }catch (Exception e){
            e.printStackTrace();
        }
        return state;
    }

    //通过试题编号或者试题名称查询
    @RequestMapping("/list")
    @ResponseBody
    public List<Questions> list(Questions questions) {
        Integer itemNumber = questions.getItemNumber();
        String testConent = questions.getTestContent();
        List<Questions> list = null;
        try {
            list = questionsServiceImpl.getList(itemNumber,testConent);
        }catch (Exception e){
            e.printStackTrace();
        }
          return list;
    }


    //通过id删除
    @RequestMapping("/delete")
    @ResponseBody
    public int deleteQuestions(Questions questions){
        String id = questions.getId();
        int state = 0;
        try {
            questionsServiceImpl.deleteById(id);
            state = 1;
        }catch (Exception e){
            e.printStackTrace();
            state = -1;
        }
        return state;
    }

    //添加试卷查出单选题
    @RequestMapping("/listRadioQuestion")
    @ResponseBody
    public Map<String,Object> listRadioQuestion(){
        Map<String,Object> result  = new HashMap<String,Object>();
        List<Questions> radioQuestionList = questionsServiceImpl.getRadionQuestion();
        result.put("radioQuestionList",radioQuestionList);
        return result;
    }

    //添加试卷查出多选题
    @RequestMapping("/listCheckboxQuestion")
    @ResponseBody
    public Map<String,Object> listCheckboxQuestion(){
        Map<String,Object> result = new HashMap<String,Object>();
        List<Questions> checkboxQuestionList = questionsServiceImpl.getCheckboxQuestion();
        result.put("checkboxQuestionList",checkboxQuestionList);
        return result;
    }

    //添加试卷查出解答题
    @RequestMapping("/listAnswerQuestion")
    @ResponseBody
    public Map<String,Object> listAnswerQuestion(){
        Map<String,Object> result = new HashMap<String,Object>();
        List<Questions> answerQuestionList = questionsServiceImpl.getAnswerQuestion();
        result.put("answerQuestionList",answerQuestionList);
        return result;
    }

    //查出试题
    @RequestMapping("/listQuestion")
    @ResponseBody
    public List<Questions> list(int type){
        List<Questions> list = null;
        try{
            list = questionsServiceImpl.getQuestionList(type);
        }catch (Exception e){
            e.printStackTrace();
        }
        return  list;
    }
}
