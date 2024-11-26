package com.employee_records.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import com.alibaba.druid.pool.DruidDataSourceFactory;

public class Druid{
	private static DataSource dataSource;
	private static Connection conn;
	static {
		try {
	        // 获取加载配置文件的对象
	        Properties properties = new Properties();
	        // 获取类的类加载器
	        ClassLoader classLoader = Druid.class.getClassLoader();
	        // 获取config.properties配置文件资源输入流
	        InputStream inputStream = classLoader.getResourceAsStream("application.properties");
	        // 加载配置文件
	        properties.load(inputStream);
	        // 获取连接池对象
	        dataSource = DruidDataSourceFactory.createDataSource(properties);
			System.out.println(dataSource);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	/**
	 * 获取连接对象
	 */
	public static Connection getConnection() {
		try {
			conn = dataSource.getConnection();
		} catch(SQLException se) {
			se.printStackTrace();
		}
	    return conn;
	}

	/**
	 * 释放资源
	 */
	public static void destroy(Connection conn, PreparedStatement pStatement, ResultSet res) {
		try {
			if(res != null) {
				res.close();
			}
			if(pStatement != null) {
				pStatement.close();
			}
			if(conn != null) {
				conn.close();
			}
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
}
