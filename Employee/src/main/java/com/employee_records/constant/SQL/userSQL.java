package com.employee_records.constant.SQL;

public class userSQL {
    //根据用户名查询用户
    public static final String GET_USER_BY_USERNAME = "select * from users where name = ? ";

    // 根据id删除用户
    public static final String DELETE_USER_BY_ID = "delete from users where id = ?";

    // 新增用户
    public static final String ADD_USER = "insert into users (name, password,auth_id) VALUES(?,?,?) ";
}
