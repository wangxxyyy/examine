package org.yfcloud.examination.system.user.dao;

import org.yfcloud.examination.system.user.model.User;

public interface UserMapper {
    int deleteByPrimaryKey(String id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    User login(String loginName, String password);

    void saveModifyPassword(String id, String newPassword);

    User resgter(String name);
}