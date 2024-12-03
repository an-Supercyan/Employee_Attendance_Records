package com.employee_records.servlet;

import com.employee_records.dao.RegisterService;
import com.employee_records.dao.UserService;
import com.employee_records.dao.impl.RegisterServiceImpl;
import com.employee_records.dao.impl.UserServiceImpl;
import com.employee_records.pojo.dto.AuthenticationDTO;
import com.employee_records.pojo.dto.UserDTO;
import com.employee_records.pojo.entity.User;
import com.employee_records.pojo.vo.AuthenticationVO;

import com.google.gson.Gson;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;

@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(RegisterServlet.class);
    private RegisterService registerService;
    private UserService userService;
    private Integer status;
    // TODO 注册时的校验，校验邀请码是否正确，根据数据库中验证码对应的identity进行身份验证，若为1则为管理员用户，若为2则为普通用户


    @Override
    public void init() throws ServletException {
        registerService = new RegisterServiceImpl();
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        req.setCharacterEncoding("utf-8");
        //设置响应编码(必须，主要是将数据库中查询到的数据以UTF-8的形式进行返回)
        resp.setCharacterEncoding("utf-8");
        logger.info("请求方式：" + req.getMethod());
        logger.info("请求路径：" + req.getServletPath());

        //读取前端POST请求传输的字节流(获取json格式的数据)
        BufferedReader reader = new BufferedReader(new InputStreamReader(req.getInputStream()));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        //将json格式的数据通过反射转换为Java对象
        reader.close();
        Gson gson = new Gson();
        UserDTO userDTO = gson.fromJson(sb.toString(), UserDTO.class);
        //判断用户填写的邀请码是否正确
        System.out.println("用户注册信息"+userDTO);

        AuthenticationVO authenticationVO = registerService.getAuthByKey(userDTO.getSecretKeyId());

        logger.info("用户密钥信息：" + authenticationVO);

        if (authenticationVO == null|| authenticationVO.getUserId() != 0L) {
            logger.info("用户密钥不正确或已被使用，注册失败！！！");
            //注册失败返回状态码0给前端
            status = 0;
            String json = gson.toJson(status);
            PrintWriter out =resp.getWriter();
            out.write(json);
            out.flush();
            return;
        }else if(authenticationVO.getAuth()==1){
            logger.info("有新的管理员加入到系统的维护工作");
        }else {
            logger.info("员工注册注册");
        }

        //添加注册用户信息
        User user = new User();
        String password = DigestUtils.md5Hex(userDTO.getPassWord());
        user.setUserName(userDTO.getUserName());
        user.setPassWord(password);
        user.setAuthId(authenticationVO.getId());
        userService.addUser(user);

        long userId = userService.getUserByName(user.getUserName()).getId();

        //更新权限信息(更新邀请码使用状态)
        AuthenticationDTO authenticationDTO =new AuthenticationDTO();
        authenticationDTO.setId(authenticationVO.getId());
        authenticationDTO.setUserId(userId);
        registerService.updateAuth(authenticationDTO);

        //注册成功返回状态码1给前端
        status = 1;
        String json = gson.toJson(status);
        PrintWriter out =resp.getWriter();
        out.write(json);
        out.flush();
    }
}
