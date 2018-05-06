package org.yfcloud.examination.business.test.service;

import org.yfcloud.examination.business.test.model.Test;

import java.util.List;

/**
 * Created by Administrator on 2017/5/21 0021.
 */
public interface TestService {

    List<Test> list();

    Test login(Test test);
}
