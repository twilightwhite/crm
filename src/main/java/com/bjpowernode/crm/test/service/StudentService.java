package com.bjpowernode.crm.test.service;


import com.bjpowernode.crm.test.domain.Student;
import com.bjpowernode.crm.vo.PaginationVo;

import java.util.List;
import java.util.Map;

/**
 * Author:李金永
 * 2019/7/1
 */
public interface StudentService {

    PaginationVo<Student> getByStudentList(Map<String, Object> map);
}
