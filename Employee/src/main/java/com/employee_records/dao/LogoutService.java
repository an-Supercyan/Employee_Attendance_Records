package com.employee_records.dao;

public interface LogoutService {

    /**
     * 根据用户id删除用户
     * @param id
     * @return
     */
    boolean deleteUserById(long id);

    /**
     * 根据用户id删除对应密钥
     * @param id
     * @return
     */
    boolean deleteAuthById(long id);
}
