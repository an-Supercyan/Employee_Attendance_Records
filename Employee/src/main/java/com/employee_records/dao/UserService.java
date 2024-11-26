package com.employee_records.dao;


import com.employee_records.pojo.entity.User;

public interface UserService {
         User getUserByName(String userName);
}
