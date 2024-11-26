package com.employee_records.dao.impl;

import com.employee_records.dao.RegisterService;
import com.employee_records.pojo.dto.UserDTO;
import com.employee_records.pojo.vo.AuthenticationVO;
import com.employee_records.util.Druid;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegisterServiceImpl implements RegisterService {
    public static final String GET_AUTH_BY_KEY = "select * from user_auth where secretKey = ?";
    public static final String ADD_USER = "insert into users (name, password) VALUES(?,?) ";

    public AuthenticationVO getAuthByKey(String key) {
        AuthenticationVO authenticationVO = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        try {

            connection = Druid.getConnection();
            preparedStatement = connection.prepareStatement(GET_AUTH_BY_KEY);
            preparedStatement.setString(1, key);
            rs = preparedStatement.executeQuery();
            if (rs.next()) {
                authenticationVO.setAuthentication(rs.getString("authentication"));
                authenticationVO.setIdentity(rs.getString("identity"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Druid.destroy(connection, preparedStatement, rs);
        }
        return authenticationVO;
    }

    @Override
    public void addUser(UserDTO userDTO) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = Druid.getConnection();
            preparedStatement = connection.prepareStatement(ADD_USER);
            preparedStatement.setString(1, userDTO.getUserName());
            preparedStatement.setString(2, userDTO.getPassWordFir());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Druid.destroy(connection, preparedStatement,null);
        }
    }
}
