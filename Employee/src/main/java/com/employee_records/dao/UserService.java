package com.employee_records.dao;


import com.employee_records.pojo.entity.User;

public interface UserService {
    /**
     * 根据用户名获取用户
     * @param userName
     * @return
     */
         User getUserByName(String userName);

}
