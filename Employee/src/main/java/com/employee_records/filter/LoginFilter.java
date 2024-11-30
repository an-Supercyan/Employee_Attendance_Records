package com.employee_records.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.logging.Logger;

import com.employee_records.util.JwtUtil;
import org.apache.commons.lang3.StringUtils;//导入StringUtils工具类

@WebFilter(urlPatterns = "/*")
public class LoginFilter extends HttpFilter {
    private static final Logger logger = Logger.getLogger(LoginFilter.class.getName());

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        //利用登录校验过滤器实现请求响应时的全局编码设置
        /*servletRequest.setCharacterEncoding("UTF-8");
        servletResponse.setCharacterEncoding("UTF-8");
*/
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String url = request.getRequestURL().toString();
        if(url.contains("login")||url.contains("Login")||url.contains("Register")||url.contains("register")||url.equals("http://localhost:8080/Employee_war_exploded/")){
            filterChain.doFilter(request,response);
            return;
        }

        Cookie[] cookies = request.getCookies();
        //cookies为空直接跳转到错误页面
        if (cookies==null || cookies.length<1){
            RequestDispatcher dispatcher = request.getRequestDispatcher("/erro.jsp");
            dispatcher.forward(request,response);
            return;
        }

        String jwt = null;
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("token")) {
                    jwt = new String(cookie.getValue().getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
                    logger.info("jwt令牌：" + jwt);
                    break;
                }
            }

        //jwt令牌不能为空，若为空则跳转到erro页面
        if(StringUtils.isEmpty(jwt)){
            RequestDispatcher dispatcher = request.getRequestDispatcher("/erro.jsp");
            dispatcher.forward(request,response);
            return;
        }

        //解析jwt令牌，判断是否合法不合法跳转到erro页面
        try {
            JwtUtil.parseJWT(jwt);
        } catch (Exception e) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/erro.jsp");
            dispatcher.forward(request,response);
            return;
        }
        filterChain.doFilter(request,response);
    }
}
