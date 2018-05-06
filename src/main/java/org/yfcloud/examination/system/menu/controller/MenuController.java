package org.yfcloud.examination.system.menu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.yfcloud.examination.system.menu.model.Menu;
import org.yfcloud.examination.system.menu.service.MenuService;
import org.yfcloud.examination.system.user.model.User;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Administrator on 2017/3/18 0018.
 */
@Controller
@RequestMapping("/menu")
public class MenuController {

    @Resource
    MenuService menuServiceImpl;

    //具体子菜单跳转
    @RequestMapping("/index")
    public ModelAndView index(HttpServletRequest request){
        ModelAndView view = new ModelAndView();
        try{
            view.setViewName("menu/menuIndex");
        }catch (Exception e){
            e.printStackTrace();
        }
        return view;
    }

    //添加更新菜单
    @RequestMapping("/saveOrUpdateMenu")
    @ResponseBody
    public int saveOrUpdateMenu(Menu menu,HttpServletRequest request){
        int state = 0;
        try{
            HttpSession session =  request.getSession();
            User user = (User) session.getAttribute("user");
            menu.setCreateUserId(user.getId());
            state = menuServiceImpl.saveOrUpdateMenu(menu);
        }catch (Exception e){
            e.printStackTrace();
        }
        return state;
    }

    //查出菜单列表
    @RequestMapping("/list")
    @ResponseBody
    public List<Menu> list(Menu menu){
        List<Menu> list = null;
        try{
            list = menuServiceImpl.getListMenu(menu);
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }

}
