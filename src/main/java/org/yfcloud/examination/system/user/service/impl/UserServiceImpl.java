package org.yfcloud.examination.system.user.service.impl;

import org.springframework.stereotype.Service;
import org.yfcloud.examination.system.user.dao.UserMapper;
import org.yfcloud.examination.system.user.model.User;
import org.yfcloud.examination.system.user.service.UserService;

import javax.annotation.Resource;

/**
 * Created by Administrator on 2017/3/17 0017.
 */
@Service
public class UserServiceImpl implements UserService{

    @Resource
    UserMapper userMapper;

    //登录用户
    @Override
    public User login(String loginName, String password) {
        User user = userMapper.login(loginName,password);
        return user;
    }

    //修改密码
    @Override
    public int saveModifyPassword(String id, String newPassword) {
        userMapper.saveModifyPassword(id ,newPassword);
        return 1;
    }

    @Override
    public boolean resgter(String name) {
       User _user =  userMapper.resgter(name);
       if(_user==null){
           return true ;
       }else {
           return false;
       }
    }
}
