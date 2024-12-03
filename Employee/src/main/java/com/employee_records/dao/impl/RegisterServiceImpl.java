package com.employee_records.dao.impl;

import com.employee_records.constant.SQL.authSQL;
import com.employee_records.dao.RegisterService;

import com.employee_records.pojo.dto.AuthenticationDTO;
import com.employee_records.pojo.entity.Authentication;
import com.employee_records.pojo.vo.AuthenticationVO;
import com.employee_records.util.Druid;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegisterServiceImpl implements RegisterService {

    public AuthenticationVO getAuthByKey(String key) {
        AuthenticationVO authenticationVO = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        try {

            connection = Druid.getConnection();
            preparedStatement = connection.prepareStatement(authSQL.GET_AUTH_BY_KEY);
            preparedStatement.setString(1, key);
            rs = preparedStatement.executeQuery();
            if (rs.next()) {
                authenticationVO = new AuthenticationVO();
                authenticationVO.setId(rs.getLong("id"));
                authenticationVO.setAuth(rs.getInt("auth"));
                authenticationVO.setIdentity(rs.getString("identity"));
                authenticationVO.setUserId(rs.getLong("user_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Druid.destroy(connection, preparedStatement, rs);
        }
        return authenticationVO;
    }

    @Override
    public boolean updateAuth(AuthenticationDTO authenticationDTO) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int row = 0;
        try {
            connection = Druid.getConnection();
            preparedStatement = connection.prepareStatement(authSQL.UPDATE_AUTH);
            preparedStatement.setLong(1, authenticationDTO.getUserId());
            preparedStatement.setLong(2, authenticationDTO.getId());
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
