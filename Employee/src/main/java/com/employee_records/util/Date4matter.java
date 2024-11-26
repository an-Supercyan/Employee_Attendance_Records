package com.employee_records.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Date4matter {
    public static  String  formatDate(LocalDateTime date){
        // 定义格式化器
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");

        String LocalDateTimeString = formatter.format(date);

        return LocalDateTimeString;
    }
}
