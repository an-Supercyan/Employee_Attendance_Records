package com.employee_records.servlet;

import com.employee_records.dao.RegisterService;
import com.employee_records.dao.impl.RegisterServiceImpl;
import com.employee_records.pojo.dto.UserDTO;
import com.employee_records.pojo.vo.AuthenticationVO;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

@Slf4j
public class RegisterServlet extends HttpServlet {
    private RegisterService registerService;


    // TODO 注册时的校验，校验邀请码是否正确，根据数据库中验证码对应的identity进行身份验证，若为1则为管理员用户，若为2则为普通用户

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");

        UserDTO userDTO = new UserDTO();
        userDTO.setUserName(new String(req.getParameter("username").getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8));
        userDTO.setPassWordFir(new String(req.getParameter("password").getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8));
        userDTO.setSecretKey(new String(req.getParameter("secretKey").getBytes(StandardCharsets.ISO_8859_1),StandardCharsets.UTF_8));

        //判断用户填写的邀请码是否正确
        registerService = new RegisterServiceImpl();
        AuthenticationVO authenticationVO = registerService.getAuthByKey(userDTO.getSecretKey());

        if (!authenticationVO.getAuthentication().equals("1")){
            log.info("用户密钥不正确，注册失败！！！");
            RequestDispatcher dispatcher = req.getRequestDispatcher("/loginErro.jsp");
            dispatcher.forward(req,resp);
        }
        registerService.addUser(userDTO);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }


}
