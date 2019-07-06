package com.bjpowernode.crm.settings.dao;

import com.bjpowernode.crm.settings.domain.User;

import java.util.List;
import java.util.Map;

/**
 * Author:李金永
 * 2019/6/28
 */
public interface UserDao {

    User login(Map<String, String> map);

    List<User> getUserList();
}
