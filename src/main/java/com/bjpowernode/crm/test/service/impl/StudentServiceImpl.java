package com.bjpowernode.crm.test.service.impl;

import com.bjpowernode.crm.test.dao.StudentDao;
import com.bjpowernode.crm.test.domain.Student;
import com.bjpowernode.crm.test.service.StudentService;
import com.bjpowernode.crm.utils.SqlSessionUtil;
import com.bjpowernode.crm.vo.PaginationVo;

import java.util.List;
import java.util.Map;

/**
 * Author:李金永
 * 2019/7/1
 */
public class StudentServiceImpl implements StudentService {
    private StudentDao studentDao = SqlSessionUtil.getSqlSession().getMapper(StudentDao.class);

    @Override
    public PaginationVo<Student> getByStudentList(Map<String, Object> map) {
        List<Student> list = studentDao.getStudent(map);
        int total = studentDao.getTotal(map);

        PaginationVo<Student> vo = new PaginationVo<Student>();
        vo.setDataList(list);
        vo.setTotal(total);
        return vo;
    }
}
