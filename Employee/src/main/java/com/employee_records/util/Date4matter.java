package com.employee_records.util;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Date4matter {

    //格式化LocalDate为LocalDateTime
    public static String formatDate(LocalDateTime date){
        // 定义格式化器
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");

        String LocalDateTimeString = formatter.format(date);

        return LocalDateTimeString;
    }

    //格式化字符串类为yyyy-MM-ddTHH:mm:ss类型字符串为yyyy-MM-dd HH:mm:ss
    public static String formatDateNormal(LocalDateTime date){
        String simpleDate = formatDate(date);

        // 解析原始日期字符串
        LocalDateTime dateTime = LocalDateTime.parse(simpleDate);

        // 定义目标格式
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        // 格式化日期
        return dateTime.format(formatter);
    }
}
