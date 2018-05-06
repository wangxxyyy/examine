package org.yfcloud.examination.business.test.service.impl;

import org.springframework.stereotype.Service;
import org.yfcloud.examination.business.test.dao.TestMapper;
import org.yfcloud.examination.business.test.model.Test;
import org.yfcloud.examination.business.test.service.TestService;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/21 0021.
 */
@Service
public class TestServiceImpl implements TestService {

    @Resource
    TestMapper testMapper;

    @Override
    public List<Test> list() {
        List<Test> list = testMapper.getCollegeList();
        return list;
    }

    @Override
    public Test login(Test test) {
        String name = test.getName();
        String password = test.getPassword();
        int number = test.getNumber();
        Test loginUser = testMapper.login(name,password,number);
        return loginUser;
    }
}
