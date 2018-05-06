package org.yfcloud.examination.business.test.dao;

import org.yfcloud.examination.business.test.model.Test;

import java.util.List;

public interface TestMapper {
    int deleteByPrimaryKey(String id);

    int insert(Test record);

    int insertSelective(Test record);

    Test selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Test record);

    int updateByPrimaryKey(Test record);

    Test login(String name, String password, int number);

    List<Test> getCollegeList();
}