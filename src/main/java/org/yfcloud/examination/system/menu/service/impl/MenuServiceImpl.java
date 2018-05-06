package org.yfcloud.examination.system.menu.service.impl;

import org.springframework.stereotype.Service;
import org.yfcloud.examination.common.CommonUtil;
import org.yfcloud.examination.system.menu.dao.MenuMapper;
import org.yfcloud.examination.system.menu.model.Menu;
import org.yfcloud.examination.system.menu.service.MenuService;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2017/3/18 0018.
 */
@Service
public class MenuServiceImpl implements MenuService {
    @Resource
    MenuMapper menuMapper;

    @Override
    public int saveOrUpdateMenu(Menu menu) {
        if(menu.getId()!=null&&!"".equals(menu.getId())){
            menuMapper.updateByPrimaryKeySelective(menu);
        }else{
            menu.setCreateDate(new Date());
            menu.setId(CommonUtil.getUUID());
            menuMapper.insertSelective(menu);
        }
        return 1;
    }

    @Override
    public List<Menu> getListMenu(Menu menu) {
        List<Menu> list  = menuMapper.getListMenu(menu);
        return list;
    }
}
