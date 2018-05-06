package org.yfcloud.examination.system.menu.service;

import org.yfcloud.examination.system.menu.model.Menu;

import java.util.List;

/**
 * Created by Administrator on 2017/3/18 0018.
 */
public interface MenuService {
    int saveOrUpdateMenu(Menu menu);

    List<Menu> getListMenu(Menu menu);
}
