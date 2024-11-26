package com.employee_records.dao;

import com.employee_records.pojo.dto.AttendanceDTO;
import com.employee_records.pojo.vo.AttendanceVO;

import java.text.ParseException;
import java.util.List;

public interface AttendanceService {

    /**
     * 添加考勤信息
     * @param attendanceDTO
     * @return
     */
    boolean addAttendanceInfo(AttendanceDTO attendanceDTO);

    /**
     * 删除考勤信息
     * @param attendanceDTO
     * @return
     */
    boolean deleteAttendanceInfo(AttendanceDTO attendanceDTO);

    /**
     * 更新考勤信息
     * @param attendanceDTO
     * @return
     */
    boolean updateAttendanceInfo(AttendanceDTO attendanceDTO);

    /**
     * 根据指定id获取考勤信息
     * @param id
     * @return
     */
    AttendanceVO selectAttendanceById(Long id);

    /**
     * 获取指定考勤信息
     * @param attendanceDTO
     * @return
     */
     List<AttendanceVO> selectAttendanceInfo(AttendanceDTO attendanceDTO) throws ParseException;

    /**
     * 分页查询
     * @param pageNum
     * @param pageSize
     * @return
     */
    List<AttendanceVO> PageAttendanceInfo(int pageNum, int pageSize);

    /**
     * 获取总页数
     * @param pageSize
     * @return
     */
    int getTotalPages(int pageSize);
}
