package com.employee_records.pojo.entity;


import lombok.*;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Authentication {
    private Long id;
    private String auth;
    private String identity;
    private String secretKey;
}
