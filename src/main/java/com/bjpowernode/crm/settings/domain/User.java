package com.bjpowernode.crm.settings.domain;

/**
 * Author:李金永
 * 2019/6/28
 */
public class User {
    /*
        关于登录 ：
        需要验证账号和密码是否正确
        User user = select * from  user where loginAct = ? and loginPwd = ? ;
        判断如果 user  为空     说明账号密码正确
            如果  user 不为空   说明账号密码正确
            一旦账号密码正确，需要从user中取出其他相关登录信息，进行进一步的验证

            expirTime:验证失效时间
            lockState;验证锁定状态
            allowIps;验证IP地址

            关于时间:
            在实际项目中，使用字符串表示的时间，有一套约定俗成的规则
            日期  yyyy-MM-dd
            时间  yyyy-MM-dd HH:mm:ss 19位
     */
    private String id;  //主键
    private String loginAct;    //登录账号
    private String name;    //用户真实姓名
    private String loginPwd;    //登录密码
    private String email;   //邮箱
    private String expireTime;  //失效时间    yyyy-MM-dd HH:mm:ss
    private String lockState;   //锁定状态
    private String deptno;  //部门编号
    private String allowIps;    //允许访问的IP地址群
    private String createTime;  //创建时间
    private String createBy;    //创建人
    private String editTime;    //修改时间  yyyy-MM-dd HH:mm:ss
    private String editBy;  //修改人

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLoginAct() {
        return loginAct;
    }

    public void setLoginAct(String loginAct) {
        this.loginAct = loginAct;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLoginPwd() {
        return loginPwd;
    }

    public void setLoginPwd(String loginPwd) {
        this.loginPwd = loginPwd;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(String expireTime) {
        this.expireTime = expireTime;
    }

    public String getLockState() {
        return lockState;
    }

    public void setLockState(String lockState) {
        this.lockState = lockState;
    }

    public String getDeptno() {
        return deptno;
    }

    public void setDeptno(String deptno) {
        this.deptno = deptno;
    }

    public String getAllowIps() {
        return allowIps;
    }

    public void setAllowIps(String allowIps) {
        this.allowIps = allowIps;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getEditTime() {
        return editTime;
    }

    public void setEditTime(String editTime) {
        this.editTime = editTime;
    }

    public String getEditBy() {
        return editBy;
    }

    public void setEditBy(String editBy) {
        this.editBy = editBy;
    }

}
