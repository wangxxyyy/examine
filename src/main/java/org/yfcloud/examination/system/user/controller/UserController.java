package org.yfcloud.examination.system.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.yfcloud.examination.system.user.model.User;
import org.yfcloud.examination.system.user.service.UserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 2017/3/17 0017.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    UserService userServiceImpl;


    //退出用户
    @RequestMapping("/quitHome")
    public ModelAndView quitHome(HttpServletRequest request){
        ModelAndView view =  new ModelAndView();
        HttpSession session = request.getSession();
        session.removeAttribute("user");
        view.setViewName("login");
        return view;
    }



    //登录用户
    @RequestMapping("/login")
    @ResponseBody
    public int login(HttpServletRequest request , User user ) {
        String LoginName = user.getLoginName();
        String password = user.getLoginPassword();
        int state = 0;
        try {
            if(LoginName!=null&&!"".equals(LoginName)
                    &&password!=null&&!"".equals(password)){
                User loginUser = userServiceImpl.login(LoginName,password);
                if(loginUser!=null){
                    HttpSession session = request.getSession();
                    session.setAttribute("user",loginUser);
                    state = 1;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            state = -1;
        }
        return state;
    }

    //修改密码
    @RequestMapping("/saveModifyPassword")
    @ResponseBody
    public int saveModifyPassword(HttpServletRequest request,String oldPassword,String newPassword) {
        int state = 0;
        try {
            HttpSession session = request.getSession();
            User loginUser = (User) session.getAttribute("user");
            if(loginUser.getLoginPassword().equals(oldPassword)){
                state = userServiceImpl.saveModifyPassword(loginUser.getId(),newPassword);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return state;
    }


    //验证登录跳转
    @RequestMapping("/verification")
    public ModelAndView verification(){
        ModelAndView view = new ModelAndView();
        try {
            view.setViewName("verification");
        }catch (Exception e){

        }
        return view;
    }

    //验证用户名是否重复
    @RequestMapping("/resgter")
    @ResponseBody
    public boolean resgter(String name){
        return userServiceImpl.resgter(name);
    }
}
