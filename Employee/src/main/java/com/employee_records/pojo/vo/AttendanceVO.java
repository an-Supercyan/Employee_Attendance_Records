package com.employee_records.pojo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AttendanceVO {
    private Long id;
    private String employeeName;
    private String department;
    private Integer requiredHours;
    private String punchTime;
    private Integer totalHours;
    private Integer overTimeHours;
    private Integer absenceCount;
    private String entryTime;
}
