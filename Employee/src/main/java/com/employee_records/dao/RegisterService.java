package com.employee_records.dao;

import com.employee_records.pojo.dto.AuthenticationDTO;
import com.employee_records.pojo.dto.UserDTO;
import com.employee_records.pojo.entity.Authentication;
import com.employee_records.pojo.vo.AuthenticationVO;

public interface RegisterService {

    /**
     * 获取权限信息
     *
     * @param key
     * @return
     */
    AuthenticationVO getAuthByKey(String key);

    /**
     * 注册后更新对应权限信息
     * @param authenticationDTO
     */
    boolean updateAuth(AuthenticationDTO authenticationDTO);
}
