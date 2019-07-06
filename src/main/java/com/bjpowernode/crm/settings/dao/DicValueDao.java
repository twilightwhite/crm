package com.bjpowernode.crm.settings.dao;

import com.bjpowernode.crm.settings.domain.DicValue;

import java.util.List;

/**
 * Author:李金永
 * 2019/7/6
 */
public interface DicValueDao {
    List<DicValue> getListByCode(String code);
}
