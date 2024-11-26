package com.employee_records.dao;

import com.employee_records.pojo.dto.UserDTO;
import com.employee_records.pojo.vo.AuthenticationVO;

public interface RegisterService {
    //获取授权信息
    public AuthenticationVO getAuthByKey(String key);

    void addUser(UserDTO userDTO);
}
