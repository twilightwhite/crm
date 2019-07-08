package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Clue;

/**
 * Author:李金永
 * 2019/7/6
 */
public interface ClueService {
    boolean save(Clue c);

    Clue detail(String id);
}
