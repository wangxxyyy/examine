package org.yfcloud.examination.system.user.service;

import org.yfcloud.examination.system.user.model.User;

/**
 * Created by Administrator on 2017/3/17 0017.
 */
public interface UserService {
    User login(String loginName, String password);

    int saveModifyPassword(String id, String newPassword);

    boolean resgter(String name);
}
