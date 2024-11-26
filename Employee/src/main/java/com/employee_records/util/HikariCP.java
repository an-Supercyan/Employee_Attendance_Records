package com.employee_records.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class HikariCP {
    private static DataSource dataSource;
    private static Connection connection;

    static {
        try {
            // 创建配置对象
            Properties properties = new Properties();
            // 设置数据库连接的基本信息
            ClassLoader classLoader = HikariCP.class.getClassLoader();
            //获取Hikari数据库连接池配置
            InputStream inputStream = classLoader.getResourceAsStream("hikari.properties");
             if (inputStream == null) {
                throw new RuntimeException("hikari.properties file not found");
            }
             properties.load(inputStream);
            //设置Hikari数据库连接池配置
            HikariConfig config = new HikariConfig(properties);
            //创建连接池对象
            dataSource = new HikariDataSource(config);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
public static HikariDataSource getDataSource() {
        return (HikariDataSource) dataSource;
    }
    public static Connection getConnection() {

        try {
            connection = dataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public static void destroy(Connection connection, PreparedStatement preparedStatement, ResultSet resultSet) {

        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}