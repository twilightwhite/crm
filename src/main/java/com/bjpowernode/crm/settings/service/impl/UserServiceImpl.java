package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.exception.LoginException;
import com.bjpowernode.crm.settings.dao.UserDao;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.SqlSessionUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Author:李金永
 * 2019/6/28
 */
public class UserServiceImpl implements UserService {
    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);
    @Override
    public User login(String loginAct, String loginPwd, String ip) throws LoginException {
        Map<String,String> map = new HashMap<>();
        map.put("loginAct",loginAct);
        map.put("loginPwd",loginPwd);
        User user = userDao.login(map);
        if (user == null){
            //进入到if块  说明账号密码不正确
            throw  new LoginException("账号或密码不正确");
        }
        //如果程序执行到这一行，说明if没执行，说明user不为空，说明账号密码正确
        //验证其他信息
        //验证失效时间
        String expireTime = user.getExpireTime();
        if (expireTime.compareTo(DateTimeUtil.getSysTime())<0){
            throw  new LoginException("账号已失效，请联系管理员");
        }
        //验证锁定状态
        String lockState = user.getLockState();
        if ("0".equals(lockState)){
            throw  new LoginException("账号已锁定");
        }
        //验证IP地址
        String allowIps = user.getAllowIps();
        if (!allowIps.contains(ip)){
            throw  new LoginException("ip地址受限");
        }
        //如果程序走到此处，说明程序没有抛出任何异常，登录成功，返回user对象
        return user;
    }

    @Override
    public List<User> getUserList() {
        List<User> uList = userDao.getUserList();
        return uList;
    }
}
