package com.employee_records.constant.SQL;

public class attendanceSQL {
    public static final String INSERT = "insert into attendance (employee_name, dept_name, required_hours, punch_time, total_hours, over_time_hours, absence_count, create_time, update_time, entry_time) VALUES (?,?,?,?,?,?,?,?,?,?)";

    public static final String DELETE_BY_ID = "delete from attendance where id = ?";

    public static final String UPDATE_BY_ID =  "update attendance set employee_name = ?, dept_name = ?,  punch_time = ?, total_hours = ?, absence_count = ?, update_time = ? where id = ?";

    public static final String SELECT_BY_ID = "select * from attendance where id = ?";

    public static final String SELECT_ATTENDANCE = "select * from attendance";

    public static final String PAGE_ATTENDANCE = "select * from attendance Limit ? offset ? ";

    public static final String EMPLOYEE_NAME = "employee_name like ? ";

    public static final String DEPARTMENT = "dept_name like ? ";

    public static final String ENTRY_DATE = "entry_time < ?";
}
