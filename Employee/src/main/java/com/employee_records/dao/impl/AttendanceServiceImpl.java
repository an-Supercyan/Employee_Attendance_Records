package com.employee_records.dao.impl;

import com.employee_records.constant.SQL.attendanceSQL;
import com.employee_records.dao.AttendanceService;
import com.employee_records.pojo.dto.AttendanceDTO;

import com.employee_records.pojo.vo.AttendanceVO;
import com.employee_records.util.Date4matter;
import com.employee_records.util.Druid;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class AttendanceServiceImpl implements AttendanceService {
    private static final Logger logger = LoggerFactory.getLogger(AttendanceServiceImpl.class);

    @Override
    public boolean addAttendanceInfo(AttendanceDTO attendanceDTO) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int rows = 0;
        Date date = new Date(System.currentTimeMillis());
        try {
            connection = Druid.getConnection();
            preparedStatement = connection.prepareStatement(attendanceSQL.INSERT);
            preparedStatement.setString(1, attendanceDTO.getEmployeeName());
            preparedStatement.setString(2, attendanceDTO.getDepartment());
            preparedStatement.setInt(3, attendanceDTO.getRequiredHours());
            preparedStatement.setDate(4, date);
            preparedStatement.setInt(5, attendanceDTO.getTotalHours());
            preparedStatement.setInt(6, attendanceDTO.getOverTimeHours());
            preparedStatement.setInt(7, attendanceDTO.getAbsenceCount());
            preparedStatement.setDate(8, date);
            preparedStatement.setDate(9, date);
            preparedStatement.setDate(10, date);
            rows = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Druid.destroy(connection, preparedStatement, null);
        }
        if (rows > 0) {
            logger.info("数据库插入考勤信息成功");
            return true;
        }
        return false;
    }

    @Override
    public boolean deleteAttendanceInfo(AttendanceDTO attendanceDTO) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int rows = 0;
        try {
            connection = Druid.getConnection();
            preparedStatement = connection.prepareStatement(attendanceSQL.DELETE_BY_ID);
            preparedStatement.setLong(1,attendanceDTO.getId());
            rows = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Druid.destroy(connection, preparedStatement, null);
        }
        if (rows > 0) {
            return true;
        }
        return false;
    }

    @Override
    public boolean updateAttendanceInfo(AttendanceDTO attendanceDTO) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int rows = 0;
        try {
            connection = Druid.getConnection();
            preparedStatement = connection.prepareStatement(attendanceSQL.UPDATE_BY_ID);
            // TODO 考勤信息更新
            preparedStatement.setString(1,attendanceDTO.getEmployeeName());
            preparedStatement.setString(2,attendanceDTO.getDepartment());
            preparedStatement.setString(3, attendanceDTO.getPunchTime());
            preparedStatement.setInt(4,attendanceDTO.getTotalHours());
            preparedStatement.setInt(5,attendanceDTO.getAbsenceCount());
            preparedStatement.setDate(6,new Date(System.currentTimeMillis()));
            preparedStatement.setLong(7,attendanceDTO.getId());
            rows = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Druid.destroy(connection, preparedStatement, null);
        }
        if (rows > 0) {
            return true;
        }
        return false;
    }

    @Override
    public AttendanceVO selectAttendanceById(Long id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        AttendanceVO attendanceVO = null;
        try {
            connection = Druid.getConnection();
            preparedStatement = connection.prepareStatement(attendanceSQL.SELECT_BY_ID);
            preparedStatement.setLong(1, id);
            rs = preparedStatement.executeQuery();
            attendanceVO = new AttendanceVO();
            if(rs.next()) {
                attendanceVO.setEmployeeName(rs.getString("employee_name"));
                attendanceVO.setId(rs.getLong("id"));
                attendanceVO.setDepartment(rs.getString("dept_name"));
                //格式化日期
                attendanceVO.setPunchTime(Date4matter.formatDate(rs.getTimestamp("punch_time").toLocalDateTime()));
                attendanceVO.setTotalHours(rs.getInt("total_hours"));
                attendanceVO.setAbsenceCount(rs.getInt("absence_count"));
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            Druid.destroy(connection, preparedStatement, rs);
        }
        return attendanceVO;
    }

    @Override
    public List<AttendanceVO> selectAttendanceInfo(AttendanceDTO attendanceDTO) throws ParseException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        List<AttendanceVO> attendanceVOS = null;
        String f1, f2, f3 = "";
        f1 = (StringUtils.isNotEmpty(attendanceDTO.getEmployeeName())) ? "a" : "";
        f2 = (StringUtils.isNotEmpty(attendanceDTO.getDepartment())) ? "b" : "";
        //根据入职时间进行员工查询
        f3 = (StringUtils.isNotEmpty(attendanceDTO.getEntryTime())) ? "c" : "";
        //将由get方式获取的字符串日期转化为日期格式
        java.sql.Date entryTime = null;
        if (StringUtils.isNotEmpty(attendanceDTO.getEntryTime())) {
            String Date = attendanceDTO.getEntryTime();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            entryTime = new java.sql.Date(dateFormat.parse(Date).getTime());
        }
        try {
            connection = Druid.getConnection();
            switch (f1 + f2 + f3) {
                case "":
                    preparedStatement = connection.prepareStatement(attendanceSQL.SELECT_ATTENDANCE);
                    break;
                case "a":
                    preparedStatement = connection.prepareStatement(attendanceSQL.SELECT_ATTENDANCE + " where " + attendanceSQL.EMPLOYEE_NAME);
                    preparedStatement.setString(1, "%" + attendanceDTO.getEmployeeName() + "%");
                    break;
                case "ab":
                    preparedStatement = connection.prepareStatement(attendanceSQL.SELECT_ATTENDANCE + " where " + attendanceSQL.EMPLOYEE_NAME + " and " + attendanceSQL.DEPARTMENT);
                    preparedStatement.setString(1, "%" + attendanceDTO.getEmployeeName() + "%");
                    preparedStatement.setString(2, "%" + attendanceDTO.getDepartment() + "%");
                    break;
                case "abc":
                    preparedStatement = connection.prepareStatement(attendanceSQL.SELECT_ATTENDANCE + " where " + attendanceSQL.EMPLOYEE_NAME + " and " + attendanceSQL.DEPARTMENT + " and " + attendanceSQL.ENTRY_DATE);
                    preparedStatement.setString(1, "%" + attendanceDTO.getEmployeeName() + "%");
                    preparedStatement.setString(2, "%" + attendanceDTO.getDepartment() + "%");
                    preparedStatement.setDate(3, entryTime);
                    break;
                case "b":
                    preparedStatement = connection.prepareStatement(attendanceSQL.SELECT_ATTENDANCE + " where " + attendanceSQL.DEPARTMENT);
                    preparedStatement.setString(1, "%" + attendanceDTO.getDepartment() + "%");
                    break;
                case "bc":
                    preparedStatement = connection.prepareStatement(attendanceSQL.SELECT_ATTENDANCE + " where " + attendanceSQL.DEPARTMENT + " and " + attendanceSQL.ENTRY_DATE);
                    preparedStatement.setString(1, "%" + attendanceDTO.getDepartment() + "%");
                    preparedStatement.setDate(2, entryTime);
                    break;
                case "c":
                    preparedStatement = connection.prepareStatement(attendanceSQL.SELECT_ATTENDANCE + " where " + attendanceSQL.ENTRY_DATE);
                    preparedStatement.setDate(1, entryTime);
                    break;
                case "ac":
                    preparedStatement = connection.prepareStatement(attendanceSQL.SELECT_ATTENDANCE + " where " + attendanceSQL.ENTRY_DATE + " and " + attendanceSQL.EMPLOYEE_NAME);
                    preparedStatement.setDate(1, entryTime);
                    preparedStatement.setString(2, "%" + attendanceDTO.getEmployeeName() + "%");
                    break;
                default:
                    logger.error("员工考勤系统模块功能路径错误");
                    break;
            }
            rs = preparedStatement.executeQuery();
            attendanceVOS = new ArrayList<>();
            while (rs.next()) {
                AttendanceVO attendanceVO = new AttendanceVO();
                attendanceVO.setId(rs.getLong("id"));
                attendanceVO.setEmployeeName(new String(rs.getString("employee_name").getBytes(StandardCharsets.UTF_8)));
                attendanceVO.setDepartment(new String(rs.getString("dept_name").getBytes(StandardCharsets.UTF_8)));
                attendanceVO.setPunchTime(Date4matter.formatDateNormal(rs.getTimestamp("punch_time").toLocalDateTime()));
                attendanceVO.setTotalHours(rs.getInt("total_hours"));
                attendanceVO.setAbsenceCount(rs.getInt("absence_count"));
                attendanceVO.setEntryTime(Date4matter.formatDateNormal(rs.getTimestamp("entry_time").toLocalDateTime()));
                attendanceVO.setRequiredHours(rs.getInt("required_hours"));
                attendanceVO.setOverTimeHours(rs.getInt("over_time_hours"));
                attendanceVOS.add(attendanceVO);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            Druid.destroy(connection, preparedStatement, rs);
        }
        return attendanceVOS;
    }

    @Override
    public List<AttendanceVO> PageAttendanceInfo(int pageNum, int pageSize) {
        logger.info("获取分页参数第{}页,页面大小为{}", pageNum, pageSize);
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<AttendanceVO> attendanceVOS = null;
        ResultSet rs = null;
        try {
            connection = Druid.getConnection();
            preparedStatement = connection.prepareStatement(attendanceSQL.PAGE_ATTENDANCE);
            preparedStatement.setInt(1, pageSize);
            preparedStatement.setInt(2, (pageNum - 1) * pageSize);
            rs = preparedStatement.executeQuery();
            attendanceVOS = new ArrayList<>();
            while (rs.next()) {
                AttendanceVO attendanceVO = new AttendanceVO();
                attendanceVO.setEmployeeName(rs.getString("employee_name"));
                attendanceVO.setId(rs.getLong("id"));
                attendanceVO.setDepartment(rs.getString("dept_name"));
                //获取数据库中DateTime类型的数据
                attendanceVO.setPunchTime(Date4matter.formatDateNormal(rs.getTimestamp("punch_time").toLocalDateTime()));
                attendanceVO.setTotalHours(rs.getInt("total_hours"));
                attendanceVO.setAbsenceCount(rs.getInt("absence_count"));
                attendanceVOS.add(attendanceVO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Druid.destroy(connection, preparedStatement, rs);
        }
        return attendanceVOS;
    }

    @Override
    public int getTotalPages(int pageSize) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        int total = 0;
        try {
            connection = Druid.getConnection();
            statement = connection.prepareStatement("SELECT COUNT(*) as count FROM attendance");
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                total = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Druid.destroy(connection, statement, resultSet);
        }
        //返回页数
        return (int) Math.ceil(total / (double) pageSize);
    }
}
