package com.employee_records.servlet;

import com.employee_records.dao.UserService;
import com.employee_records.dao.impl.UserServiceImpl;
import com.employee_records.pojo.entity.User;
import com.employee_records.util.JwtUtil;

import org.apache.commons.codec.digest.DigestUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;


@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
    private UserService userService;
    private static final Logger logger = LoggerFactory.getLogger(AtdanBackServlet.class);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");

        //清除上次登录生成的cookie
        Cookie[] cookies = req.getCookies();
        if(cookies != null){
            for (Cookie cookie : cookies) {
                cookie.setPath("/");
                cookie.setValue("");
                cookie.setMaxAge(0);
                resp.addCookie(cookie);
            }
        }



        userService=new UserServiceImpl();
        //beta版本utf-8全局编码需要进行如下设置，从jsp表单获取数据时需要的数据时需要进行字符转码(因为tomcat统一编码时按照ISO_8859_1编译的也就是Latin_1)
        String username = new String(req.getParameter("username").getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        String password = new String(req.getParameter("password").getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

        logger.info("用户名信息{}",username);
        logger.info("密码信息{}",password);

        User user = userService.getUserByName(username);

        if(user == null){
            RequestDispatcher dispatcher = req.getRequestDispatcher("/loginErro.jsp");
            dispatcher.forward(req,resp);
            return;
        }

        //进行md5加密判断而不是直接使用明文密码
        String PS = DigestUtils.md5Hex(password);
        if(!PS.equals(user.getPassWord())){
            RequestDispatcher dispatcher = req.getRequestDispatcher("/loginErro.jsp");
            dispatcher.forward(req,resp);
            return;
        }

        Map<String,Object> claim = new HashMap<>();
        claim.put("userId",user.getId());
        claim.put("userName",user.getUserName());
        claim.put("password",user.getPassWord());
        String jwt = JwtUtil.generateJwt(claim);
        //将生成的jwt令牌存放在cookie中
        Cookie cookie = new Cookie("token",jwt);
        //设置cookie有效时间为24小时
        cookie.setMaxAge(3600*24);
        //设置cookie的作用路径(设置为全局可使用)
        cookie.setPath("/");
        //将cookie设置作为响应信息返回给页面
        resp.addCookie(cookie);

        resp.sendRedirect(req.getContextPath()+ "/index.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
}
