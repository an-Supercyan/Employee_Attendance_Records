package com.employee_records.dao.impl;



import com.employee_records.constant.SQL.authSQL;
import com.employee_records.constant.SQL.userSQL;
import com.employee_records.dao.LogoutService;
import com.employee_records.util.Druid;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
public class LogoutServiceImpl implements LogoutService {
    @Override
    public boolean deleteUserById(long id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int row = 0;
        try {
            connection = Druid.getConnection();
            preparedStatement = connection.prepareStatement(userSQL.DELETE_USER_BY_ID);
            preparedStatement.setLong(1,id);
            row = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            Druid.destroy(connection, preparedStatement, null);
        }
        if(row>0){
            return true;
        }
        return false;
    }

    @Override
    public boolean deleteAuthById(long id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int row = 0;
        try {
            connection = Druid.getConnection();
            preparedStatement = connection.prepareStatement(authSQL.DELETE_AUTH_BY_ID);
            preparedStatement.setLong(1,id);
            row = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            Druid.destroy(connection, preparedStatement, null);
        }
        if(row>0){
            return true;
        }
        return false;
    }
}
