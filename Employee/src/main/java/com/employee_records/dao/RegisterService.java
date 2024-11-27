package com.employee_records.dao;

import com.employee_records.pojo.dto.UserDTO;
import com.employee_records.pojo.vo.AuthenticationVO;

public interface RegisterService {

    /**
     * 获取权限信息
     * @param key
     * @return
     */
    public AuthenticationVO getAuthByKey(String key);


    /**
     * 新增登录用户
     * @param userDTO
     */
    void addUser(UserDTO userDTO);
}
