package com.bjpowernode.settings.user.test;

import com.bjpowernode.crm.utils.MD5Util;

/**
 * Author:李金永
 * 2019/6/28
 */
public class Test1 {
    public static void main(String[] args) {
        System.out.println(123);
        /*
            关于MD5加密方式
         */
        String str = "ASD1235";
        str = MD5Util.getMD5(str);
        System.out.println(str);
    }
}
