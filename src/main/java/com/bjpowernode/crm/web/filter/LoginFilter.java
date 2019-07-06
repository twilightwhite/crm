package com.bjpowernode.crm.web.filter;

import com.bjpowernode.crm.settings.domain.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Author:李金永
 * 2019/6/30
 */
public class LoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        System.out.println("执行判断有没有 登录过 的   过滤器");
        /*
            从request中去session，从session中取user
            判断user是否为null
            如果不为null，说明登录过，请求放行即可
            如果为null，说明没有登录过，重定向到登录页面

         */
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        String path = request.getServletPath();
        //如果是这两个资源路径，不需要拦截
        if ("/login.jsp".equals(path) || "/settings/user/login.do".equals(path)){
            chain.doFilter(req, resp);
        }else {
            User user = (User) request.getSession().getAttribute("user");
            if (user != null) {
                //如果user不为null  说明登录过   请求放行
                chain.doFilter(req, resp);
            } else {
                //user为null  表示没有登录过  重定向到登录页
            /*
                不论是转发还是重定向  使用的一定是绝对路径
                传统绝对路径的写法：  /项目名/具体资源路径...

                转发： 使用的是一种特殊的绝对路径写法，前面不加   /项目名   这种路径也叫内部路径
                    /具体资源路径.../...
                重定向：
                    使用传统的绝对路径写法      /项目名/具体资源路径...

                request.getContextPath():
                  /当前项目的项目名
             */
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
        }
    }
}
