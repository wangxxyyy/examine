package org.yfcloud.examination.business.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.yfcloud.examination.business.test.model.Test;
import org.yfcloud.examination.business.test.service.TestService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Administrator on 2017/5/22 0022.
 */
@Controller
@RequestMapping("/test")
public class    TestController {

    @Resource
    TestService testServiceImpl;


    @RequestMapping("/index")
    public ModelAndView login(){
        ModelAndView view = new ModelAndView();
        try {
            view.setViewName("examination/examinationIndex");
        }catch (Exception e){
            e.printStackTrace();
        }
        return view;
    }
    @RequestMapping("/login")
    @ResponseBody
    public int loginExamination(HttpServletRequest request, Test test){
        String name = test.getName();
        String password = test.getPassword();
        int state = 0;
        try{
            if(name!=null&&!"".equals(name)
                    &&password!=null&&!"".equals(password)){
                Test loginUser = testServiceImpl.login(test);
                if(loginUser!=null){
                    HttpSession session = request.getSession();
                    session.setAttribute("user",loginUser);
                    state = 1;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            state = -1;
        }
        return state;
    }

    @RequestMapping("/listCollege")
    @ResponseBody
    public List<Test> list(){
        List<Test> list = null;
        try{
            list = testServiceImpl.list();
        }catch (Exception e){
            e.printStackTrace();
        }
         return list;
    }
}
