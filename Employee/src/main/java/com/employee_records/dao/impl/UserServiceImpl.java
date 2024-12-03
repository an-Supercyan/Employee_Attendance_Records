package com.employee_records.dao.impl;

import com.employee_records.constant.SQL.userSQL;
import com.employee_records.dao.UserService;
import com.employee_records.pojo.entity.User;
import com.employee_records.util.Druid;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserServiceImpl implements UserService {
    public User getUserByName(String name) {
        User user = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        try {
            connection = Druid.getConnection();
            preparedStatement = connection.prepareStatement(userSQL.GET_USER_BY_USERNAME);
            preparedStatement.setString(1, name);
            rs = preparedStatement.executeQuery();
            if (rs.next()){
                user = new User();
                user.setId(rs.getLong("id"));
                user.setUserName(rs.getString("name"));
                user.setPassWord(rs.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Druid.destroy(connection, preparedStatement, rs);
        }
        return user;
    }

    @Override
    public void addUser(User user) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = Druid.getConnection();
            preparedStatement = connection.prepareStatement(userSQL.ADD_USER);
            preparedStatement.setString(1, user.getUserName());
            preparedStatement.setString(2, user.getPassWord());
            preparedStatement.setLong(3, user.getAuthId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Druid.destroy(connection, preparedStatement,null);
        }
    }
}
