package com.employee_records.servlet;

import com.alibaba.druid.support.json.JSONUtils;
import com.employee_records.dao.AttendanceService;
import com.employee_records.dao.impl.AttendanceServiceImpl;
import com.employee_records.pojo.dto.AttendanceDTO;
import com.employee_records.pojo.vo.AttendanceVO;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;

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

/**
 * 编辑数据回显Servlet类
 */
@Slf4j
@WebServlet("/Back")
public class AtdanBackServlet extends HttpServlet {

    private AttendanceService attendanceService;
    private AttendanceDTO attendanceDTO;
    private AttendanceVO attendanceVO;

    @Override
    public void init() throws ServletException {
        attendanceService = new AttendanceServiceImpl();
        attendanceDTO = new AttendanceDTO();
        attendanceVO = new AttendanceVO();
    }

    /**
     * 实现编辑数据时的数据回显
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("utf-8");

        //获取Axios传递的json格式数据
        BufferedReader reader = new BufferedReader(new InputStreamReader(req.getInputStream()));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        reader.close();
        Gson gson = new Gson();
        attendanceDTO = gson.fromJson(sb.toString(), AttendanceDTO.class);

        System.out.println(attendanceDTO.toString());
        attendanceVO = attendanceService.selectAttendanceById(attendanceDTO.getId());
        System.out.println(attendanceVO.toString());

        //定义Json格式的字符串，响应给前端Ajax请求
        String json = gson.toJson(attendanceVO);
        PrintWriter out = resp.getWriter();
        //将JSON格式对象转化为JSON形式字符串输出
        out.print(json);
        //确保输出流都被输入到客户端
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
