package com.bjpowernode.crm.test.dao;


import com.bjpowernode.crm.test.domain.Student;

import java.util.List;
import java.util.Map;

/**
 * Author:李金永
 * 2019/7/1
 */
public interface StudentDao {

    List<Student> getStudent(Map<String, Object> map);

    int getTotal(Map<String, Object> map);
}
