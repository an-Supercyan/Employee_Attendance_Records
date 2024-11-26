package com.employee_records.pojo.vo;

public class AuthenticationVO {

    private String Authentication;
    private String identity;

    public AuthenticationVO() {
    }

    public AuthenticationVO(String authentication, String identity) {
        Authentication = authentication;
        this.identity = identity;
    }

    public String getAuthentication() {
        return Authentication;
    }

    public void setAuthentication(String authentication) {
        Authentication = authentication;
    }

    public String getIdentity() {
        return identity;
    }

    public void setIdentity(String identity) {
        this.identity = identity;
    }
}
