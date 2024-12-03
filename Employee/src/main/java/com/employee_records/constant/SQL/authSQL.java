package com.employee_records.constant.SQL;

public class authSQL {
    //根据邀请码查询是否具有注册权限
    public static final String GET_AUTH_BY_KEY = "select * from user_auth where secretKey = ?";

    //更新权限信息
    public static final String UPDATE_AUTH = "update user_auth set user_id = ? where id = ?";

    //删除权限信息
    public static final String DELETE_AUTH_BY_ID = "delete from user_auth where id = ?";
}
