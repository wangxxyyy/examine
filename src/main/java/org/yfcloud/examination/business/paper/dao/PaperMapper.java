package org.yfcloud.examination.business.paper.dao;

import org.yfcloud.examination.business.paper.model.Paper;

import java.util.List;
import java.util.Map;

public interface PaperMapper {
    int deleteByPrimaryKey(String id);

    int insert(Paper record);

    int insertSelective(Paper record);

    Paper selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Paper record);

    int updateByPrimaryKey(Paper record);

    List<Paper> getList(Map<String, Object> param);

    int getCount(Map<String, Object> param);

    Paper getPaper();

    List<Paper> list();

    Paper getPapers(String name);
}