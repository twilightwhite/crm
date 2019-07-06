package com.bjpowernode.crm.web.listener;

import com.bjpowernode.crm.settings.service.DicService;
import com.bjpowernode.crm.settings.service.impl.DicServiceImpl;
import com.bjpowernode.crm.utils.ServiceFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Author:李金永
 * 2019/7/6
 */
public class SystemInitListenner implements ServletContextListener {
    /*
        该方法是用来监听上下文域对象创建的方法、
        当上下文域对象创建了，则立即执行该方法
        反过来讲，该方法还有一个功能就是  验证上下文域对象的生命周期   当方法执行了说明上下文域对象创建了

        参数  event
            该参数可以取得我们监听的域对象，
            例如我们现在监听的是上下文域对象，那么我们就可以通过event来取得上下文域对象
     */
    @Override
    public void contextInitialized(ServletContextEvent event) {
        System.out.println("上下文域对象创建了");
        ServletContext application = event.getServletContext();
        System.out.println("从监听器中取出上下文域对象" + application);

        //处理数据字典
        DicService ds = (DicService) ServiceFactory.getService(new DicServiceImpl());
        /*
            从业务层取得多个 dvlist
            map.put("code1",dvlist1);
            map.put("code2",dvlist2);
            ...


         */
        System.out.println("服务器缓存处理数据字典开始");
        Map<String,Object> map = ds.getAllDicValue();
        Set<String> set = map.keySet();
        for (String key : set){
            application.setAttribute(key,map.get(key));
        }
        System.out.println("服务器缓存处理数据字典结束");

    }
}
