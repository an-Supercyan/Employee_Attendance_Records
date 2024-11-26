package com.employee_records.pojo.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Attendance {
    private Long id;
    private String employeeName;
    private String deptName;
    private Integer requiredHours;
    private String punchTime;
    private Integer totalHours;
    private Integer overTimeHours;
    private Integer absenceCount;
    private String entryTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
