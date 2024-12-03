package com.employee_records.servlet;

import com.employee_records.dao.LogoutService;
import com.employee_records.dao.UserService;
import com.employee_records.dao.impl.LogoutServiceImpl;
import com.employee_records.dao.impl.UserServiceImpl;
import com.employee_records.pojo.dto.UserDTO;
import com.employee_records.pojo.entity.User;
import com.google.gson.Gson;
import org.apache.commons.codec.digest.DigestUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.charset.StandardCharsets;

// TODO 账户注销功能 只需要实现账户的删除即可 需在业务层新建一个LogoutService接口进行实现(要求使用POST方式请求)
@WebServlet("/Logout")
public class LogoutServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(LogoutServlet.class);
    private UserService userService;
    private LogoutService logoutService;
    private Integer status;


    @Override
    public void init() throws ServletException {
        logoutService = new LogoutServiceImpl();
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
        // TODO 业务逻辑方面需要实现用户名与密码在数据库中的校验(若有一个错误则统一返回状态值status = 0),存在则删除该用户数据，返回状态码1
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


        logger.info("用户名信息{}",userDTO.getUserName());
        logger.info("密码信息{}",userDTO.getPassWord());

        User user = userService.getUserByName(userDTO.getUserName());

        if(user == null){
            status = 0;
            String json = gson.toJson(status);
            PrintWriter out =resp.getWriter();
            out.write(json);
            out.flush();
            return;
        }

        //进行md5加密判断而不是直接使用明文密码
        String PS = DigestUtils.md5Hex(userDTO.getPassWord());

        if(!PS.equals(user.getPassWord())){
            status = 0;
            String json = gson.toJson(status);
            PrintWriter out =resp.getWriter();
            out.write(json);
            out.flush();
        } else {
            logoutService.deleteUserById(user.getId());
            //清除最近一次登录生成的token
            Cookie[] cookies = req.getCookies();
            if(cookies != null){
                for (Cookie cookie : cookies) {
                    cookie.setPath("/");
                    cookie.setValue("");
                    cookie.setMaxAge(0);
                    resp.addCookie(cookie);
                }
            }

            //删除账户对应的密钥信息
            logoutService.deleteAuthById(user.getAuthId());

            //返回注销成功状态码给前端
            status = 1;
            String json = gson.toJson(status);
            PrintWriter out =resp.getWriter();
            out.write(json);
            out.flush();
        }

    }
}
