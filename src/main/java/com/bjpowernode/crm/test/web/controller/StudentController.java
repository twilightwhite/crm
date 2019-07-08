package com.bjpowernode.crm.test.web.controller;

import com.bjpowernode.crm.test.domain.Student;
import com.bjpowernode.crm.test.service.StudentService;
import com.bjpowernode.crm.test.service.impl.StudentServiceImpl;
import com.bjpowernode.crm.utils.PrintJson;
import com.bjpowernode.crm.utils.ServiceFactory;
import com.bjpowernode.crm.vo.PaginationVo;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Author:李金永
 * 2019/7/8
 */
public class StudentController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest requst, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("进入到学生控制器");
        String path = requst.getServletPath();
        if ("/test/getByStudentList.do".equals(path)){
            getByStudentList(requst,response);
        }
    }

    private void getByStudentList(HttpServletRequest requst, HttpServletResponse response) {
        System.out.println("学生列表  结合分页查询 + 条件查询");
        String name = requst.getParameter("name");
        String sex = requst.getParameter("sex");
        String address = requst.getParameter("address");
        String phone = requst.getParameter("phone");
        String pageNoStr = requst.getParameter("pageNo");
        String pageSizeStr = requst.getParameter("pageSize");
        int pageNo = Integer.valueOf(pageNoStr);
        int pageSize = Integer.valueOf(pageSizeStr);
        int skipCount = (pageNo - 1) * pageSize;
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("name", name);
        map.put("sex", sex);
        map.put("address", address);
        map.put("phone", phone);
        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);
        StudentService ss = (StudentService) ServiceFactory.getService(new StudentServiceImpl());
        PaginationVo<Student> vo = ss.getByStudentList(map);
        PrintJson.printJsonObj(response, ss);
    }
}
