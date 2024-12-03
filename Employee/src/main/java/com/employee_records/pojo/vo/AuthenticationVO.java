package com.employee_records.pojo.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AuthenticationVO {
    private Long id;
    private int Auth;
    private String identity;
    private long userId;
}
