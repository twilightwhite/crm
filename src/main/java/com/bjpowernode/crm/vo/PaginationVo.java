package com.bjpowernode.crm.vo;

import java.util.List;

/**
 * Author:李金永
 * 2019/7/3
 */
public class PaginationVo<T> {
    private int total;
    private List<T> dataList;

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<T> getDataList() {
        return dataList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }
}
